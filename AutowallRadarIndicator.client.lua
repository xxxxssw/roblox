--!strict
--[[
    AutowallRadarIndicator.client.lua

    Standalone LocalScript for Roblox experiences.
    - Autowall indicator (center-screen): estimates whether your current weapon can penetrate
      one or more surfaces and still damage an enemy behind cover.
    - Radar panel: top-down local awareness radar for player positions.

    Install:
    1) Place this LocalScript in StarterPlayer > StarterPlayerScripts.
    2) Adjust CONFIG and WEAPON_PROFILES below for your game.

    Notes:
    - This script is intentionally self-contained (no external modules required).
    - Uses only standard Roblox APIs.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LOCAL_PLAYER = Players.LocalPlayer
local CAMERA = Workspace.CurrentCamera

local CONFIG = {
    MaxAutowallDistance = 240,
    MaxLayers = 4, -- maximum objects the trace can penetrate
    ThicknessStep = 0.2,
    MaxSingleObjectThicknessProbe = 40,
    FallbackMinDamage = 18,
    RadarRange = 180,
    RadarSize = Vector2.new(190, 190),
    RadarPosition = UDim2.fromOffset(24, 24),
    ShowTeammates = true,
    ShowHealthText = true,
    UseTeamColor = true,
    RadarHotkey = Enum.KeyCode.RightBracket,
}

local WEAPON_PROFILES = {
    Default = {
        MaxPenetration = 8,
        BaseDamage = 34,
        DistanceFalloffPerStud = 0.07,
        PenetrationDamageLossPerStud = 2.1,
    },
    Pistol = {
        MaxPenetration = 5,
        BaseDamage = 30,
        DistanceFalloffPerStud = 0.08,
        PenetrationDamageLossPerStud = 2.6,
    },
    SMG = {
        MaxPenetration = 7,
        BaseDamage = 28,
        DistanceFalloffPerStud = 0.09,
        PenetrationDamageLossPerStud = 2.2,
    },
    Rifle = {
        MaxPenetration = 12,
        BaseDamage = 36,
        DistanceFalloffPerStud = 0.07,
        PenetrationDamageLossPerStud = 1.8,
    },
    Sniper = {
        MaxPenetration = 16,
        BaseDamage = 80,
        DistanceFalloffPerStud = 0.05,
        PenetrationDamageLossPerStud = 1.4,
    },
    Shotgun = {
        MaxPenetration = 3,
        BaseDamage = 55,
        DistanceFalloffPerStud = 0.2,
        PenetrationDamageLossPerStud = 4.5,
    },
}

local MATERIAL_RESISTANCE: {[Enum.Material]: number} = {
    [Enum.Material.Plastic] = 0.85,
    [Enum.Material.Wood] = 0.75,
    [Enum.Material.WoodPlanks] = 0.7,
    [Enum.Material.Glass] = 0.45,
    [Enum.Material.Neon] = 0.7,
    [Enum.Material.Metal] = 1.35,
    [Enum.Material.DiamondPlate] = 1.5,
    [Enum.Material.Concrete] = 1.25,
    [Enum.Material.Brick] = 1.15,
    [Enum.Material.Rock] = 1.4,
}

local function clamp(n: number, minN: number, maxN: number): number
    return math.max(minN, math.min(maxN, n))
end

local gui = Instance.new("ScreenGui")
gui.Name = "AutowallRadarGui"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = LOCAL_PLAYER:WaitForChild("PlayerGui")

local indicatorFrame = Instance.new("Frame")
indicatorFrame.Name = "AutowallIndicator"
indicatorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
indicatorFrame.Position = UDim2.fromScale(0.5, 0.58)
indicatorFrame.Size = UDim2.fromOffset(360, 38)
indicatorFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
indicatorFrame.BackgroundTransparency = 0.2
indicatorFrame.BorderSizePixel = 0
indicatorFrame.Parent = gui

local indicatorStroke = Instance.new("UIStroke")
indicatorStroke.Thickness = 2
indicatorStroke.Color = Color3.fromRGB(255, 60, 60)
indicatorStroke.Parent = indicatorFrame

local indicatorLabel = Instance.new("TextLabel")
indicatorLabel.Name = "Label"
indicatorLabel.BackgroundTransparency = 1
indicatorLabel.Size = UDim2.fromScale(1, 1)
indicatorLabel.Font = Enum.Font.GothamBold
indicatorLabel.TextScaled = true
indicatorLabel.Text = "AWALL: BLOCKED"
indicatorLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
indicatorLabel.Parent = indicatorFrame

local radarRoot = Instance.new("Frame")
radarRoot.Name = "Radar"
radarRoot.Size = UDim2.fromOffset(CONFIG.RadarSize.X, CONFIG.RadarSize.Y)
radarRoot.Position = CONFIG.RadarPosition
radarRoot.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
radarRoot.BackgroundTransparency = 0.2
radarRoot.BorderSizePixel = 0
radarRoot.Parent = gui

local radarCorner = Instance.new("UICorner")
radarCorner.CornerRadius = UDim.new(0, 8)
radarCorner.Parent = radarRoot

local radarStroke = Instance.new("UIStroke")
radarStroke.Thickness = 2
radarStroke.Color = Color3.fromRGB(100, 160, 255)
radarStroke.Parent = radarRoot

local radarTitle = Instance.new("TextLabel")
radarTitle.BackgroundTransparency = 1
radarTitle.Position = UDim2.fromOffset(8, 6)
radarTitle.Size = UDim2.fromOffset(120, 18)
radarTitle.Font = Enum.Font.GothamBold
radarTitle.TextSize = 13
radarTitle.TextXAlignment = Enum.TextXAlignment.Left
radarTitle.Text = "RADAR"
radarTitle.TextColor3 = Color3.fromRGB(180, 210, 255)
radarTitle.Parent = radarRoot

local radarCenter = Instance.new("Frame")
radarCenter.Name = "CenterDot"
radarCenter.AnchorPoint = Vector2.new(0.5, 0.5)
radarCenter.Position = UDim2.fromScale(0.5, 0.5)
radarCenter.Size = UDim2.fromOffset(6, 6)
radarCenter.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
radarCenter.BorderSizePixel = 0
radarCenter.Parent = radarRoot

local radarContainer = Instance.new("Frame")
radarContainer.Name = "Blips"
radarContainer.BackgroundTransparency = 1
radarContainer.Size = UDim2.fromScale(1, 1)
radarContainer.Parent = radarRoot

local blips: {[Player]: Frame} = {}

local function getCharacterRoot(player: Player): BasePart?
    local character = player.Character
    if not character then
        return nil
    end
    local root = character:FindFirstChild("HumanoidRootPart")
    if root and root:IsA("BasePart") then
        return root
    end
    return nil
end

local function getHumanoid(player: Player): Humanoid?
    local character = player.Character
    if not character then
        return nil
    end
    return character:FindFirstChildOfClass("Humanoid")
end

local function isEnemy(player: Player): boolean
    if player == LOCAL_PLAYER then
        return false
    end
    if LOCAL_PLAYER.Team and player.Team then
        return player.Team ~= LOCAL_PLAYER.Team
    end
    return true
end

local function makeParams(ignoreList: {Instance}): RaycastParams
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = ignoreList
    params.IgnoreWater = true
    return params
end

local function pointInsidePart(part: BasePart, point: Vector3): boolean
    local localPoint = part.CFrame:PointToObjectSpace(point)
    local half = part.Size * 0.5
    return math.abs(localPoint.X) <= half.X and math.abs(localPoint.Y) <= half.Y and math.abs(localPoint.Z) <= half.Z
end

local function estimateThicknessAlongRay(part: BasePart, entryPoint: Vector3, direction: Vector3): number
    local dirUnit = direction.Unit
    local current = entryPoint + dirUnit * 0.05
    local traveled = 0

    while traveled < CONFIG.MaxSingleObjectThicknessProbe do
        if not pointInsidePart(part, current) then
            return traveled
        end

        traveled += CONFIG.ThicknessStep
        current += dirUnit * CONFIG.ThicknessStep
    end

    return CONFIG.MaxSingleObjectThicknessProbe
end

local function getCrosshairRay(maxDistance: number): (Vector3, Vector3)
    local viewport = CAMERA.ViewportSize
    local centerRay = CAMERA:ViewportPointToRay(viewport.X * 0.5, viewport.Y * 0.5)
    return centerRay.Origin, centerRay.Direction.Unit * maxDistance
end

local function inferWeaponClass(toolName: string): string
    local lower = string.lower(toolName)

    if string.find(lower, "awp") or string.find(lower, "sniper") or string.find(lower, "scout") then
        return "Sniper"
    end
    if string.find(lower, "deagle") or string.find(lower, "pistol") or string.find(lower, "usp") or string.find(lower, "glock") then
        return "Pistol"
    end
    if string.find(lower, "smg") or string.find(lower, "mp") or string.find(lower, "p90") or string.find(lower, "mac") then
        return "SMG"
    end
    if string.find(lower, "shotgun") or string.find(lower, "nova") or string.find(lower, "xm") then
        return "Shotgun"
    end

    return "Rifle"
end

local function getWeaponStats(character: Model?): ({[string]: number}, string)
    local profile = WEAPON_PROFILES.Default
    local displayName = "Default"

    if character then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool then
            displayName = tool.Name
            local inferred = inferWeaponClass(tool.Name)
            profile = WEAPON_PROFILES[inferred] or WEAPON_PROFILES.Default

            local attrPen = tool:GetAttribute("PenetrationDepth")
            local attrDmg = tool:GetAttribute("BaseDamage")
            local attrFalloff = tool:GetAttribute("DistanceFalloffPerStud")
            local attrPenLoss = tool:GetAttribute("PenetrationDamageLossPerStud")

            if typeof(attrPen) == "number" then
                profile = table.clone(profile)
                profile.MaxPenetration = attrPen
            end
            if typeof(attrDmg) == "number" then
                if profile == WEAPON_PROFILES.Default then
                    profile = table.clone(profile)
                end
                profile.BaseDamage = attrDmg
            end
            if typeof(attrFalloff) == "number" then
                if profile == WEAPON_PROFILES.Default then
                    profile = table.clone(profile)
                end
                profile.DistanceFalloffPerStud = attrFalloff
            end
            if typeof(attrPenLoss) == "number" then
                if profile == WEAPON_PROFILES.Default then
                    profile = table.clone(profile)
                end
                profile.PenetrationDamageLossPerStud = attrPenLoss
            end
        end
    end

    return profile, displayName
end

local function materialResistance(material: Enum.Material): number
    return MATERIAL_RESISTANCE[material] or 1
end

local function autowallCheck(): (boolean, string)
    local localCharacter = LOCAL_PLAYER.Character
    if not localCharacter then
        return false, "AWALL: NO CHARACTER"
    end

    local origin, rayVector = getCrosshairRay(CONFIG.MaxAutowallDistance)
    local dirUnit = rayVector.Unit

    local weaponStats, weaponName = getWeaponStats(localCharacter)
    local penBudget = weaponStats.MaxPenetration
    local baseDamage = weaponStats.BaseDamage

    local traversedDistance = 0
    local penetratedLayers = 0
    local penetratedStuds = 0

    local currentOrigin = origin
    local remainingDistance = CONFIG.MaxAutowallDistance

    local ignoreList = { localCharacter }
    local params = makeParams(ignoreList)

    for _ = 1, CONFIG.MaxLayers + 2 do
        if remainingDistance <= 0 then
            break
        end

        local hit = Workspace:Raycast(currentOrigin, dirUnit * remainingDistance, params)
        if not hit then
            break
        end

        local hitInstance = hit.Instance
        if not hitInstance or not hitInstance:IsA("BasePart") then
            break
        end

        local segmentDistance = (hit.Position - currentOrigin).Magnitude
        traversedDistance += segmentDistance
        remainingDistance -= segmentDistance

        local hitModel = hitInstance:FindFirstAncestorOfClass("Model")
        local hitPlayer = if hitModel then Players:GetPlayerFromCharacter(hitModel) else nil

        if hitPlayer and isEnemy(hitPlayer) then
            local distanceLoss = traversedDistance * weaponStats.DistanceFalloffPerStud
            local penetrationLoss = penetratedStuds * weaponStats.PenetrationDamageLossPerStud
            local predictedDamage = baseDamage - distanceLoss - penetrationLoss

            if predictedDamage >= CONFIG.FallbackMinDamage then
                return true, string.format(
                    "AWALL READY [%s] DMG~%d | LAYERS:%d | PEN:%.1f/%.1f",
                    weaponName,
                    math.floor(predictedDamage + 0.5),
                    penetratedLayers,
                    penetratedStuds,
                    weaponStats.MaxPenetration
                )
            end

            return false, string.format(
                "AWALL LOW DMG [%s] DMG~%d",
                weaponName,
                math.max(0, math.floor(predictedDamage + 0.5))
            )
        end

        if penetratedLayers >= CONFIG.MaxLayers then
            return false, string.format("AWALL BLOCKED [%s] TOO MANY LAYERS", weaponName)
        end

        local thickness = estimateThicknessAlongRay(hitInstance, hit.Position, dirUnit)
        local effectiveThickness = thickness * materialResistance(hitInstance.Material)

        penBudget -= effectiveThickness
        penetratedStuds += effectiveThickness
        penetratedLayers += 1

        if penBudget < 0 then
            return false, string.format(
                "AWALL BLOCKED [%s] %.1f>%.1f",
                weaponName,
                penetratedStuds,
                weaponStats.MaxPenetration
            )
        end

        currentOrigin = hit.Position + dirUnit * (thickness + 0.1)
        remainingDistance -= thickness

        table.insert(ignoreList, hitInstance)
        params = makeParams(ignoreList)
    end

    return false, string.format("AWALL NO TARGET [%s]", weaponName)
end

local function getOrCreateBlip(player: Player): Frame
    local existing = blips[player]
    if existing then
        return existing
    end

    local blip = Instance.new("Frame")
    blip.Name = player.Name
    blip.AnchorPoint = Vector2.new(0.5, 0.5)
    blip.Size = UDim2.fromOffset(8, 8)
    blip.BorderSizePixel = 0
    blip.BackgroundColor3 = Color3.fromRGB(255, 90, 90)
    blip.Parent = radarContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = blip

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "Info"
    nameLabel.BackgroundTransparency = 1
    nameLabel.Position = UDim2.fromOffset(6, -14)
    nameLabel.Size = UDim2.fromOffset(120, 24)
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextSize = 11
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.Text = player.Name
    nameLabel.Parent = blip

    blips[player] = blip
    return blip
end

local function removeBlip(player: Player)
    local blip = blips[player]
    if blip then
        blip:Destroy()
        blips[player] = nil
    end
end

Players.PlayerRemoving:Connect(removeBlip)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then
        return
    end
    if input.KeyCode == CONFIG.RadarHotkey then
        radarRoot.Visible = not radarRoot.Visible
    end
end)

RunService.RenderStepped:Connect(function()
    local localRoot = getCharacterRoot(LOCAL_PLAYER)
    if not localRoot then
        indicatorLabel.Text = "AWALL: NO ROOT"
        indicatorLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
        indicatorStroke.Color = Color3.fromRGB(255, 60, 60)

        for player in pairs(blips) do
            removeBlip(player)
        end
        return
    end

    local awallReady, awallText = autowallCheck()
    indicatorLabel.Text = awallText

    if awallReady then
        indicatorLabel.TextColor3 = Color3.fromRGB(110, 255, 140)
        indicatorStroke.Color = Color3.fromRGB(90, 255, 120)
    else
        indicatorLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
        indicatorStroke.Color = Color3.fromRGB(255, 60, 60)
    end

    local localPos = localRoot.Position
    local localLook = localRoot.CFrame.LookVector
    local yaw = math.atan2(localLook.X, localLook.Z)

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LOCAL_PLAYER then
            local root = getCharacterRoot(player)
            local hum = getHumanoid(player)

            if not root or not hum or hum.Health <= 0 then
                removeBlip(player)
                continue
            end

            if not CONFIG.ShowTeammates and not isEnemy(player) then
                removeBlip(player)
                continue
            end

            local blip = getOrCreateBlip(player)
            local delta = root.Position - localPos

            local cosYaw = math.cos(-yaw)
            local sinYaw = math.sin(-yaw)
            local rx = delta.X * cosYaw - delta.Z * sinYaw
            local rz = delta.X * sinYaw + delta.Z * cosYaw

            local range = CONFIG.RadarRange
            local nx = clamp(rx / range, -1, 1)
            local nz = clamp(rz / range, -1, 1)

            local halfW = CONFIG.RadarSize.X * 0.5
            local halfH = CONFIG.RadarSize.Y * 0.5
            blip.Position = UDim2.fromOffset(
                halfW + nx * (halfW - 10),
                halfH + nz * (halfH - 10)
            )

            local color = Color3.fromRGB(255, 90, 90)
            if CONFIG.UseTeamColor and player.TeamColor then
                color = player.TeamColor.Color
            elseif not isEnemy(player) then
                color = Color3.fromRGB(90, 170, 255)
            end
            blip.BackgroundColor3 = color

            local info = blip:FindFirstChild("Info")
            if info and info:IsA("TextLabel") then
                if CONFIG.ShowHealthText then
                    info.Text = string.format("%s [%d]", player.DisplayName, math.floor(hum.Health + 0.5))
                else
                    info.Text = player.DisplayName
                end
            end
        end
    end
end)
