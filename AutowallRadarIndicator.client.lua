--!strict
--[[
    AutowallRadarIndicator.client.lua

    Standalone LocalScript for Roblox experiences.
    Features:
    - Autowall indicator that evaluates multi-layer penetration.
    - Weapon-aware penetration/damage/hitchance from gun database modules.
    - Triggerbot (optional) gated by autowall, hitchance, and minimum damage.
    - Top-down local radar panel.

    Install:
    1) Place this LocalScript in StarterPlayer > StarterPlayerScripts.
    2) Tune CONFIG values.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LOCAL_PLAYER = Players.LocalPlayer
local CAMERA = Workspace.CurrentCamera

local CONFIG = {
    MaxAutowallDistance = 240,
    MaxLayers = 4,
    ThicknessStep = 0.2,
    MaxSingleObjectThicknessProbe = 40,
    RadarRange = 180,
    RadarSize = Vector2.new(190, 190),
    RadarPosition = UDim2.fromOffset(24, 24),
    RadarHotkey = Enum.KeyCode.RightBracket,
    ShowTeammates = true,
    ShowHealthText = true,
    UseTeamColor = true,

    TriggerEnabledByDefault = false,
    DefaultMinDamage = 20,
    DefaultHitChance = 50,
}

local MATERIAL_RESISTANCE: {[Enum.Material]: number} = {
    [Enum.Material.Plastic] = 0.8,
    [Enum.Material.Wood] = 0.7,
    [Enum.Material.WoodPlanks] = 0.65,
    [Enum.Material.Glass] = 0.4,
    [Enum.Material.Neon] = 0.75,
    [Enum.Material.Metal] = 1.35,
    [Enum.Material.DiamondPlate] = 1.5,
    [Enum.Material.Concrete] = 1.25,
    [Enum.Material.Brick] = 1.1,
    [Enum.Material.Rock] = 1.4,
}

local WEAPON_DEFAULT = {
    PenetrationBudget = 8,
    WallbangMultiplier = 1,
    BaseDamage = 34,
    Range = 1200,
    RangeModifier = 0.98,
    SpreadMin = 0.25,
    SpreadMax = 2,
    FireRate = 0.1,
}

local weaponCache: {[string]: {[string]: any}} = {}
local uiState = {
    TriggerEnabled = CONFIG.TriggerEnabledByDefault,
    MinDamage = CONFIG.DefaultMinDamage,
    HitChance = CONFIG.DefaultHitChance,
}

local function clamp(n: number, minN: number, maxN: number): number
    return math.max(minN, math.min(maxN, n))
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

local function makeParams(ignoreList: {Instance}): RaycastParams
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = ignoreList
    params.IgnoreWater = true
    return params
end

local function pointInsidePart(part: BasePart, point: Vector3): boolean
    local lp = part.CFrame:PointToObjectSpace(point)
    local h = part.Size * 0.5
    return math.abs(lp.X) <= h.X and math.abs(lp.Y) <= h.Y and math.abs(lp.Z) <= h.Z
end

local function estimateThicknessAlongRay(part: BasePart, entryPoint: Vector3, direction: Vector3): number
    local dir = direction.Unit
    local probe = entryPoint + dir * 0.05
    local traveled = 0

    while traveled < CONFIG.MaxSingleObjectThicknessProbe do
        if not pointInsidePart(part, probe) then
            return traveled
        end
        traveled += CONFIG.ThicknessStep
        probe += dir * CONFIG.ThicknessStep
    end

    return CONFIG.MaxSingleObjectThicknessProbe
end

local function getCrosshairRay(maxDistance: number): (Vector3, Vector3)
    local viewport = CAMERA.ViewportSize
    local r = CAMERA:ViewportPointToRay(viewport.X * 0.5, viewport.Y * 0.5)
    return r.Origin, r.Direction.Unit * maxDistance
end

local function findWeaponModule(toolName: string): ModuleScript?
    local root = ReplicatedStorage:FindFirstChild("Database")
    if not root then
        return nil
    end
    local custom = root:FindFirstChild("Custom")
    if not custom then
        return nil
    end
    local weapons = custom:FindFirstChild("Weapons")
    if not weapons then
        return nil
    end

    local exact = weapons:FindFirstChild(toolName)
    if exact and exact:IsA("ModuleScript") then
        return exact
    end

    local lookup = string.lower(toolName)
    for _, child in ipairs(weapons:GetChildren()) do
        if child:IsA("ModuleScript") and string.lower(child.Name) == lookup then
            return child
        end
    end
    return nil
end

local function normalizeWeaponData(raw: {[string]: any}): {[string]: any}
    local spreadRange = raw.Spread and raw.Spread.Range
    local minSpread = WEAPON_DEFAULT.SpreadMin
    local maxSpread = WEAPON_DEFAULT.SpreadMax
    if typeof(spreadRange) == "NumberRange" then
        minSpread = spreadRange.Min
        maxSpread = spreadRange.Max
    end

    local torsoDamage = WEAPON_DEFAULT.BaseDamage
    if type(raw.DamagePerPart) == "table" then
        torsoDamage = raw.DamagePerPart.Torso or raw.DamagePerPart.Arms or torsoDamage
    end

    local penetration = tonumber(raw.Penetration) or 0.5
    local wallbangMultiplier = tonumber(raw.WallbangMultiplier) or WEAPON_DEFAULT.WallbangMultiplier

    return {
        PenetrationBudget = math.max(1, penetration * 16 * wallbangMultiplier),
        WallbangMultiplier = wallbangMultiplier,
        BaseDamage = torsoDamage,
        Range = tonumber(raw.Range) or WEAPON_DEFAULT.Range,
        RangeModifier = tonumber(raw.RangeModifier) or WEAPON_DEFAULT.RangeModifier,
        SpreadMin = minSpread,
        SpreadMax = maxSpread,
        FireRate = tonumber(raw.FireRate) or WEAPON_DEFAULT.FireRate,
        Raw = raw,
    }
end

local function getEquippedTool(character: Model?): Tool?
    if not character then
        return nil
    end
    local tool = character:FindFirstChildOfClass("Tool")
    return tool
end

local function getWeaponInfo(character: Model?): ({[string]: any}, string, Tool?)
    local tool = getEquippedTool(character)
    if not tool then
        return WEAPON_DEFAULT, "Unarmed", nil
    end

    if weaponCache[tool.Name] then
        return weaponCache[tool.Name], tool.Name, tool
    end

    local moduleScript = findWeaponModule(tool.Name)
    if not moduleScript then
        weaponCache[tool.Name] = WEAPON_DEFAULT
        return WEAPON_DEFAULT, tool.Name, tool
    end

    local ok, data = pcall(require, moduleScript)
    if not ok or type(data) ~= "table" then
        weaponCache[tool.Name] = WEAPON_DEFAULT
        return WEAPON_DEFAULT, tool.Name, tool
    end

    local normalized = normalizeWeaponData(data)
    weaponCache[tool.Name] = normalized
    return normalized, tool.Name, tool
end

local function materialResistance(material: Enum.Material): number
    return MATERIAL_RESISTANCE[material] or 1
end

local function estimateHitChance(weapon: {[string]: any}, distance: number, penetratedStuds: number, layerCount: number): number
    local spread = weapon.SpreadMin + (weapon.SpreadMax - weapon.SpreadMin) * clamp(distance / math.max(weapon.Range, 1), 0, 1)
    local spreadPenalty = spread * 18
    local distancePenalty = (distance / math.max(weapon.Range, 1)) * 40
    local penetrationPenalty = penetratedStuds * 2.5 + layerCount * 8
    local chance = 100 - spreadPenalty - distancePenalty - penetrationPenalty
    return clamp(chance, 0, 100)
end

local function estimateDamage(weapon: {[string]: any}, distance: number, penetratedStuds: number): number
    local rangeSteps = distance / 500
    local distanceMult = weapon.RangeModifier ^ rangeSteps
    local penetrationMult = clamp(1 - penetratedStuds * 0.06, 0.1, 1)
    return weapon.BaseDamage * distanceMult * penetrationMult
end

local function runAutowallTrace()
    local character = LOCAL_PLAYER.Character
    if not character then
        return {
            ready = false,
            text = "AWALL: NO CHARACTER",
            hitChance = 0,
            damage = 0,
            weaponName = "None",
            fireRate = WEAPON_DEFAULT.FireRate,
            tool = nil,
        }
    end

    local weapon, weaponName, tool = getWeaponInfo(character)
    local origin, rayVec = getCrosshairRay(CONFIG.MaxAutowallDistance)
    local dir = rayVec.Unit

    local penBudget = weapon.PenetrationBudget
    local penetratedStuds = 0
    local layers = 0
    local traveled = 0

    local currentOrigin = origin
    local remainingDistance = CONFIG.MaxAutowallDistance
    local ignoreList = { character }
    local params = makeParams(ignoreList)

    for _ = 1, CONFIG.MaxLayers + 4 do
        if remainingDistance <= 0 then
            break
        end

        local hit = Workspace:Raycast(currentOrigin, dir * remainingDistance, params)
        if not hit then
            break
        end

        local instance = hit.Instance
        if not instance or not instance:IsA("BasePart") then
            break
        end

        local segment = (hit.Position - currentOrigin).Magnitude
        traveled += segment
        remainingDistance -= segment

        local model = instance:FindFirstAncestorOfClass("Model")
        local hitPlayer = if model then Players:GetPlayerFromCharacter(model) else nil

        if hitPlayer and isEnemy(hitPlayer) then
            local damage = estimateDamage(weapon, traveled, penetratedStuds)
            local chance = estimateHitChance(weapon, traveled, penetratedStuds, layers)
            local ready = damage >= uiState.MinDamage and chance >= uiState.HitChance

            local tag = ready and "READY" or "NO FIRE"
            local text = string.format(
                "AWALL %s [%s] DMG~%d HC~%d%% L:%d PEN:%.1f/%.1f",
                tag,
                weaponName,
                math.floor(damage + 0.5),
                math.floor(chance + 0.5),
                layers,
                penetratedStuds,
                weapon.PenetrationBudget
            )

            return {
                ready = ready,
                text = text,
                hitChance = chance,
                damage = damage,
                weaponName = weaponName,
                fireRate = weapon.FireRate,
                tool = tool,
                targetPlayer = hitPlayer,
            }
        end

        if layers >= CONFIG.MaxLayers then
            return {
                ready = false,
                text = string.format("AWALL BLOCKED [%s] TOO MANY LAYERS", weaponName),
                hitChance = 0,
                damage = 0,
                weaponName = weaponName,
                fireRate = weapon.FireRate,
                tool = tool,
            }
        end

        local thickness = estimateThicknessAlongRay(instance, hit.Position, dir)
        local effective = thickness * materialResistance(instance.Material)

        penBudget -= effective
        penetratedStuds += effective
        layers += 1

        if penBudget < 0 then
            return {
                ready = false,
                text = string.format("AWALL BLOCKED [%s] PEN %.1f/%.1f", weaponName, penetratedStuds, weapon.PenetrationBudget),
                hitChance = 0,
                damage = 0,
                weaponName = weaponName,
                fireRate = weapon.FireRate,
                tool = tool,
            }
        end

        currentOrigin = hit.Position + dir * (thickness + 0.1)
        remainingDistance -= thickness

        table.insert(ignoreList, instance)
        params = makeParams(ignoreList)
    end

    return {
        ready = false,
        text = string.format("AWALL: NO TARGET [%s]", weaponName),
        hitChance = 0,
        damage = 0,
        weaponName = weaponName,
        fireRate = weapon.FireRate,
        tool = tool,
    }
end

local function buildUi()
    local gui = Instance.new("ScreenGui")
    gui.Name = "AutowallRadarGui"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = LOCAL_PLAYER:WaitForChild("PlayerGui")

    local indicator = Instance.new("TextLabel")
    indicator.Name = "AutowallIndicator"
    indicator.AnchorPoint = Vector2.new(0.5, 0.5)
    indicator.Position = UDim2.fromScale(0.5, 0.58)
    indicator.Size = UDim2.fromOffset(430, 36)
    indicator.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    indicator.BackgroundTransparency = 0.2
    indicator.BorderSizePixel = 0
    indicator.Font = Enum.Font.GothamBold
    indicator.TextScaled = true
    indicator.TextColor3 = Color3.fromRGB(255, 120, 120)
    indicator.Text = "AWALL: WAIT"
    indicator.Parent = gui

    local indicatorStroke = Instance.new("UIStroke")
    indicatorStroke.Thickness = 2
    indicatorStroke.Color = Color3.fromRGB(255, 60, 60)
    indicatorStroke.Parent = indicator

    local radarRoot = Instance.new("Frame")
    radarRoot.Name = "Radar"
    radarRoot.Size = UDim2.fromOffset(CONFIG.RadarSize.X, CONFIG.RadarSize.Y)
    radarRoot.Position = CONFIG.RadarPosition
    radarRoot.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    radarRoot.BackgroundTransparency = 0.2
    radarRoot.BorderSizePixel = 0
    radarRoot.Parent = gui

    local radarStroke = Instance.new("UIStroke")
    radarStroke.Thickness = 2
    radarStroke.Color = Color3.fromRGB(100, 160, 255)
    radarStroke.Parent = radarRoot

    local radarTitle = Instance.new("TextLabel")
    radarTitle.BackgroundTransparency = 1
    radarTitle.Position = UDim2.fromOffset(8, 6)
    radarTitle.Size = UDim2.fromOffset(100, 18)
    radarTitle.TextXAlignment = Enum.TextXAlignment.Left
    radarTitle.Font = Enum.Font.GothamBold
    radarTitle.TextSize = 13
    radarTitle.TextColor3 = Color3.fromRGB(180, 210, 255)
    radarTitle.Text = "RADAR"
    radarTitle.Parent = radarRoot

    local radarBlips = Instance.new("Frame")
    radarBlips.Name = "Blips"
    radarBlips.BackgroundTransparency = 1
    radarBlips.Size = UDim2.fromScale(1, 1)
    radarBlips.Parent = radarRoot

    local triggerPanel = Instance.new("Frame")
    triggerPanel.Name = "TriggerPanel"
    triggerPanel.Size = UDim2.fromOffset(260, 118)
    triggerPanel.Position = UDim2.new(0, 24, 1, -142)
    triggerPanel.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    triggerPanel.BackgroundTransparency = 0.2
    triggerPanel.BorderSizePixel = 0
    triggerPanel.Parent = gui

    local panelStroke = Instance.new("UIStroke")
    panelStroke.Thickness = 2
    panelStroke.Color = Color3.fromRGB(180, 130, 255)
    panelStroke.Parent = triggerPanel

    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Position = UDim2.fromOffset(8, 6)
    title.Size = UDim2.fromOffset(180, 20)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    title.TextColor3 = Color3.fromRGB(230, 200, 255)
    title.Text = "AUTOWALL TRIGGER"
    title.Parent = triggerPanel

    local triggerToggle = Instance.new("TextButton")
    triggerToggle.Size = UDim2.fromOffset(76, 22)
    triggerToggle.Position = UDim2.fromOffset(174, 5)
    triggerToggle.BackgroundColor3 = Color3.fromRGB(90, 35, 120)
    triggerToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    triggerToggle.Font = Enum.Font.GothamBold
    triggerToggle.TextSize = 12
    triggerToggle.Parent = triggerPanel

    local minDamageLabel = Instance.new("TextLabel")
    minDamageLabel.BackgroundTransparency = 1
    minDamageLabel.Position = UDim2.fromOffset(10, 40)
    minDamageLabel.Size = UDim2.fromOffset(240, 18)
    minDamageLabel.TextXAlignment = Enum.TextXAlignment.Left
    minDamageLabel.Font = Enum.Font.Gotham
    minDamageLabel.TextSize = 12
    minDamageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    minDamageLabel.Parent = triggerPanel

    local hitChanceLabel = Instance.new("TextLabel")
    hitChanceLabel.BackgroundTransparency = 1
    hitChanceLabel.Position = UDim2.fromOffset(10, 76)
    hitChanceLabel.Size = UDim2.fromOffset(240, 18)
    hitChanceLabel.TextXAlignment = Enum.TextXAlignment.Left
    hitChanceLabel.Font = Enum.Font.Gotham
    hitChanceLabel.TextSize = 12
    hitChanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    hitChanceLabel.Parent = triggerPanel

    local function updatePanelText()
        triggerToggle.Text = uiState.TriggerEnabled and "ON" or "OFF"
        minDamageLabel.Text = string.format("Min Damage: %d  (Left/Right)", uiState.MinDamage)
        hitChanceLabel.Text = string.format("Hit Chance: %d%% (Down/Up)", uiState.HitChance)
    end

    triggerToggle.MouseButton1Click:Connect(function()
        uiState.TriggerEnabled = not uiState.TriggerEnabled
        updatePanelText()
    end)

    updatePanelText()

    return {
        Gui = gui,
        Indicator = indicator,
        IndicatorStroke = indicatorStroke,
        RadarRoot = radarRoot,
        RadarBlips = radarBlips,
        UpdatePanelText = updatePanelText,
    }
end

local ui = buildUi()
local blips: {[Player]: Frame} = {}
local lastTriggerFire = 0

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
    blip.Parent = ui.RadarBlips

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = blip

    local info = Instance.new("TextLabel")
    info.Name = "Info"
    info.BackgroundTransparency = 1
    info.Position = UDim2.fromOffset(6, -14)
    info.Size = UDim2.fromOffset(130, 24)
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.Font = Enum.Font.Gotham
    info.TextSize = 11
    info.TextColor3 = Color3.fromRGB(255, 255, 255)
    info.Text = player.Name
    info.Parent = blip

    blips[player] = blip
    return blip
end

local function removeBlip(player: Player)
    local b = blips[player]
    if b then
        b:Destroy()
        blips[player] = nil
    end
end

Players.PlayerRemoving:Connect(removeBlip)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then
        return
    end

    if input.KeyCode == CONFIG.RadarHotkey then
        ui.RadarRoot.Visible = not ui.RadarRoot.Visible
        return
    end

    if input.KeyCode == Enum.KeyCode.Left then
        uiState.MinDamage = math.max(1, uiState.MinDamage - 1)
        ui.UpdatePanelText()
    elseif input.KeyCode == Enum.KeyCode.Right then
        uiState.MinDamage = math.min(100, uiState.MinDamage + 1)
        ui.UpdatePanelText()
    elseif input.KeyCode == Enum.KeyCode.Down then
        uiState.HitChance = math.max(1, uiState.HitChance - 1)
        ui.UpdatePanelText()
    elseif input.KeyCode == Enum.KeyCode.Up then
        uiState.HitChance = math.min(100, uiState.HitChance + 1)
        ui.UpdatePanelText()
    end
end)

local function tryTriggerbot(traceResult)
    if not uiState.TriggerEnabled then
        return
    end
    if not traceResult.ready then
        return
    end

    local tool = traceResult.tool
    if not tool or not tool:IsA("Tool") then
        return
    end

    local now = tick()
    local fireRate = tonumber(traceResult.fireRate) or WEAPON_DEFAULT.FireRate
    if now - lastTriggerFire < fireRate then
        return
    end

    lastTriggerFire = now

    local viewport = CAMERA.ViewportSize
    local mouseX = math.floor(viewport.X * 0.5)
    local mouseY = math.floor(viewport.Y * 0.5)

    -- Simulate an actual MouseButton1 click instead of calling Tool:Activate().
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(mouseX, mouseY, 0, true, game, 0)
        VirtualInputManager:SendMouseButtonEvent(mouseX, mouseY, 0, false, game, 0)
    end)
end

RunService.RenderStepped:Connect(function()
    local localRoot = getCharacterRoot(LOCAL_PLAYER)
    if not localRoot then
        ui.Indicator.Text = "AWALL: NO ROOT"
        ui.Indicator.TextColor3 = Color3.fromRGB(255, 120, 120)
        ui.IndicatorStroke.Color = Color3.fromRGB(255, 60, 60)

        for player in pairs(blips) do
            removeBlip(player)
        end
        return
    end

    local trace = runAutowallTrace()
    ui.Indicator.Text = trace.text

    if trace.ready then
        ui.Indicator.TextColor3 = Color3.fromRGB(110, 255, 140)
        ui.IndicatorStroke.Color = Color3.fromRGB(90, 255, 120)
    else
        ui.Indicator.TextColor3 = Color3.fromRGB(255, 120, 120)
        ui.IndicatorStroke.Color = Color3.fromRGB(255, 60, 60)
    end

    tryTriggerbot(trace)

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

            local nx = clamp(rx / CONFIG.RadarRange, -1, 1)
            local nz = clamp(rz / CONFIG.RadarRange, -1, 1)

            local halfW = CONFIG.RadarSize.X * 0.5
            local halfH = CONFIG.RadarSize.Y * 0.5
            blip.Position = UDim2.fromOffset(halfW + nx * (halfW - 10), halfH + nz * (halfH - 10))

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
