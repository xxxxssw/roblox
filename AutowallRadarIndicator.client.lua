--!strict
--[[
    AutowallRadarIndicator.client.lua

    Standalone LocalScript for Roblox experiences.
    - Autowall indicator (center-screen): shows when a target behind thin cover is likely penetrable.
    - Radar panel: top-down local awareness radar for player positions.

    Install:
    1) Place this LocalScript in StarterPlayer > StarterPlayerScripts.
    2) Adjust CONFIG below for your game.

    Notes:
    - This script is intentionally self-contained (no external modules required).
    - Uses standard Roblox APIs only.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LOCAL_PLAYER = Players.LocalPlayer
local CAMERA = Workspace.CurrentCamera

local CONFIG = {
    MaxPenetrationThickness = 8, -- studs
    MaxAutowallDistance = 220,
    RadarRange = 180, -- studs mapped to radar radius
    RadarSize = Vector2.new(190, 190),
    RadarPosition = UDim2.fromOffset(24, 24),
    ShowTeammates = true,
    ShowHealthText = true,
    UseTeamColor = true,
    RadarHotkey = Enum.KeyCode.RightBracket,
}

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
indicatorFrame.Size = UDim2.fromOffset(280, 34)
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
    local hum = character:FindFirstChildOfClass("Humanoid")
    return hum
end

local function getCrosshairRay(maxDistance: number): (Vector3, Vector3)
    local viewport = CAMERA.ViewportSize
    local originRay = CAMERA:ViewportPointToRay(viewport.X * 0.5, viewport.Y * 0.5)
    return originRay.Origin, originRay.Direction.Unit * maxDistance
end

local function makeParams(excludeCharacter: Model?): RaycastParams
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local filter = {}
    if excludeCharacter then
        table.insert(filter, excludeCharacter)
    end
    params.FilterDescendantsInstances = filter
    params.IgnoreWater = true
    return params
end

local function isEnemy(player: Player): boolean
    if player == LOCAL_PLAYER then
        return false
    end
    if LOCAL_PLAYER.Team ~= nil and player.Team ~= nil then
        return player.Team ~= LOCAL_PLAYER.Team
    end
    return true
end

local function autowallCheck(): (boolean, string)
    local localCharacter = LOCAL_PLAYER.Character
    if not localCharacter then
        return false, "AWALL: NO CHARACTER"
    end

    local origin, direction = getCrosshairRay(CONFIG.MaxAutowallDistance)
    local params = makeParams(localCharacter)

    local firstHit = Workspace:Raycast(origin, direction, params)
    if not firstHit then
        return false, "AWALL: NO COVER"
    end

    if not firstHit.Instance or not firstHit.Instance:IsA("BasePart") then
        return false, "AWALL: INVALID"
    end

    local hitPart = firstHit.Instance
    local hitPosition = firstHit.Position

    -- Move just past the first hit and try to find an enemy behind it.
    local entryToExitProbeOrigin = hitPosition + direction.Unit * 0.1
    local remainingDistance = CONFIG.MaxAutowallDistance - (hitPosition - origin).Magnitude
    if remainingDistance <= 0 then
        return false, "AWALL: BLOCKED"
    end

    local secondHit = Workspace:Raycast(entryToExitProbeOrigin, direction.Unit * remainingDistance, params)
    if not secondHit then
        return false, "AWALL: BLOCKED"
    end

    local thickness = (secondHit.Position - hitPosition).Magnitude
    local penetrable = thickness <= CONFIG.MaxPenetrationThickness

    local enemyBehind = false
    if secondHit.Instance then
        local model = secondHit.Instance:FindFirstAncestorOfClass("Model")
        if model then
            local targetPlayer = Players:GetPlayerFromCharacter(model)
            if targetPlayer and isEnemy(targetPlayer) then
                enemyBehind = true
            end
        end
    end

    if penetrable and enemyBehind then
        return true, string.format("AWALL: READY (%.1fst)", thickness)
    end

    if penetrable then
        return false, string.format("AWALL: PENETRABLE %.1fst", thickness)
    end

    local partName = hitPart.Name
    return false, string.format("AWALL: TOO THICK (%s)", partName)
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

        for player, _ in pairs(blips) do
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

            -- Rotate world delta into local radar space.
            local cosYaw = math.cos(-yaw)
            local sinYaw = math.sin(-yaw)
            local rx = delta.X * cosYaw - delta.Z * sinYaw
            local rz = delta.X * sinYaw + delta.Z * cosYaw

            local range = CONFIG.RadarRange
            local nx = math.clamp(rx / range, -1, 1)
            local nz = math.clamp(rz / range, -1, 1)

            local halfW = CONFIG.RadarSize.X * 0.5
            local halfH = CONFIG.RadarSize.Y * 0.5
            local px = halfW + nx * (halfW - 10)
            local py = halfH + nz * (halfH - 10)

            blip.Position = UDim2.fromOffset(px, py)

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
