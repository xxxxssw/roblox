-- MODULESCRIPT: MovementSounds
-- Original Path: game.BAC - 52212.Controllers.SoundController.MovementSounds
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_4 = v3.LocalPlayer
local v_u_5 = require(v2.Classes.Sound)
local v_u_6 = require(v2.Shared.Janitor)
local v_u_7 = require(v2.Database.Security.Router)
local v_u_8 = require(v2.Components.Common.VFXLibary.CreateImpact.Components.Materials)
local v_u_9 = require(v2.Components.Common.GetRayIgnore)
local v_u_10 = require(v2.Components.Common.VFXLibary.FlashEffect)
local v_u_11 = {
    ["Concrete"] = "LandingConcrete",
    ["Brick"] = "LandingConcrete",
    ["Cobblestone"] = "LandingConcrete",
    ["Basalt"] = "LandingConcrete",
    ["Limestone"] = "LandingConcrete",
    ["Pavement"] = "LandingConcrete",
    ["Asphalt"] = "LandingConcrete",
    ["Rock"] = "LandingConcrete",
    ["Slate"] = "LandingConcrete",
    ["Granite"] = "LandingConcrete",
    ["Marble"] = "LandingConcrete",
    ["Pebble"] = "LandingConcrete",
    ["CeramicTiles"] = "LandingConcrete",
    ["Ground"] = "LandingDirt",
    ["Mud"] = "LandingDirt",
    ["Glass"] = "LandingGlass",
    ["Gravel"] = "LandingGravel",
    ["Rubber"] = "LandingRubber",
    ["Plastic"] = "LandingRubber",
    ["Sand"] = "LandingSand",
    ["Snow"] = "LandingSand",
    ["Grass"] = "LandingGrass",
    ["LeafyGrass"] = "LandingGrass",
    ["Metal"] = "LandingMetal",
    ["DiamondPlate"] = "LandingMetal",
    ["CorrodedMetal"] = "LandingMetal",
    ["Corroded Metal"] = "LandingMetal",
    ["Wood"] = "LandingConcrete",
    ["WoodPlanks"] = "LandingConcrete",
    ["Fabric"] = "LandingDirt",
    ["Carpet"] = "LandingDirt",
    ["Cardboard"] = "LandingDirt"
}
local v_u_12 = nil
local v_u_13 = RaycastParams.new()
v_u_13.FilterType = Enum.RaycastFilterType.Exclude
v_u_13.IgnoreWater = true
local function v_u_24(p14, p15, p16)
    -- upvalues: (copy) v_u_9, (copy) v_u_13
    local v17 = v_u_9()
    if not table.find(v17, p14) then
        table.insert(v17, p14)
    end
    v_u_13.FilterDescendantsInstances = v17
    local v18 = p15.Position
    for _, v19 in ipairs({
        Vector3.new(0, 0, 0),
        Vector3.new(0.8, 0, 0),
        Vector3.new(-0.8, 0, 0),
        Vector3.new(0, 0, 0.8),
        Vector3.new(0, 0, -0.8)
    }) do
        local v20 = v18 + v19
        local v21 = workspace:Raycast(v20, Vector3.new(0, -3.1, 0), v_u_13)
        if v21 and v21.Normal.Y > 0.7 then
            return v21.Material.Name
        end
    end
    if p16 then
        local v22 = p16:GetState()
        local v23 = p16.FloorMaterial
        if ((v22 == Enum.HumanoidStateType.Running or v22 == Enum.HumanoidStateType.RunningNoPhysics) and true or v22 == Enum.HumanoidStateType.Landed) and v23 ~= Enum.Material.Air then
            return v23.Name
        end
    end
    return "Air"
end
local function v_u_29(p25, p26, p27)
    -- upvalues: (ref) v_u_12, (copy) v_u_8
    if not v_u_12 or (p26 == "" or p26 == "Air") then
        return nil
    end
    local v28 = v_u_8[p26] or "Ground"
    if not v_u_12.Sounds or v_u_12.Sounds:FindFirstChild(v28) then
        return v_u_12:play({
            ["Parent"] = p25,
            ["Name"] = v28
        }, p27)
    end
    warn(string.format("[FloorSound] Missing sound for category: \'%s\' (material: %s)", v28, p26))
    return nil
end
local function v_u_39(p30, p31, p32, p33, p34)
    -- upvalues: (copy) v_u_24, (copy) v_u_10, (copy) v_u_11, (copy) v_u_29, (copy) v_u_7
    local v35 = tick()
    if v35 - p30.LastFloorSoundTime >= 0.1 then
        p30.LastFloorSoundTime = v35
        local v36 = p30.Player:GetAttribute("IsCrouching")
        local v37 = p34 or v_u_24(p32, p31, p33)
        local v38 = (v36 and 0.4 or 1) * (p30.IsLocalPlayer and v_u_10.GetAudioFadeMultiplier() or 1)
        v_u_29(p31, v_u_11[v37] or "LandingConcrete", v38)
        if p30.IsLocalPlayer then
            v_u_7.broadcastRouter("UpdatePlayerNoiseCone", "Landing", p31.Position, v37, v36)
        end
    end
end
function v_u_1.SetCharacter(p_u_40, p41)
    -- upvalues: (copy) v_u_24
    p_u_40.Janitor:Cleanup()
    if p41 then
        local v42 = p41:WaitForChild("HumanoidRootPart", 5)
        local v43 = p41:FindFirstChildOfClass("Humanoid")
        if not v43 then
            local v44 = tick()
            repeat
                task.wait(0.1)
                v43 = p41:FindFirstChildOfClass("Humanoid")
            until v43 or tick() - v44 > 5
        end
        if v43 and (v42 and p41.Parent) then
            p_u_40.PrimaryPart = v42
            p_u_40.Humanoid = v43
            p_u_40.Character = p41
            p_u_40.TimePassed = 0.25
            p_u_40.IsAirborne = v_u_24(p41, v42, v43) == "Air"
            p_u_40.AirborneStartTime = not p_u_40.IsAirborne and 0 or tick()
            p_u_40.PeakAirborneVelocityY = not p_u_40.IsAirborne and 0 or v42.AssemblyLinearVelocity.Y
            p_u_40.Janitor:Add(v43.StateChanged:Connect(function(p45, p46)
                -- upvalues: (copy) p_u_40
                p_u_40:OnStateChanged(p45, p46)
            end))
        end
    else
        local v47 = p_u_40.CurrentFootstepSound
        if v47 and v47.Playing then
            v47:Stop()
        end
        p_u_40.CurrentFootstepSound = nil
        p_u_40.PrimaryPart = nil
        p_u_40.TimePassed = 0.25
        p_u_40.Character = nil
        p_u_40.Humanoid = nil
        p_u_40.IsAirborne = false
        p_u_40.AirborneStartTime = 0
        p_u_40.PeakAirborneVelocityY = 0
        return
    end
end
function v_u_1.OnStateChanged(p48, p49, p50)
    -- upvalues: (copy) v_u_39, (copy) v_u_24, (copy) v_u_10, (copy) v_u_29, (copy) v_u_7
    local v51 = p48.PrimaryPart
    local v52 = p48.Character
    local v53 = p48.Humanoid
    if v53 and (v51 and v52) then
        if p50 == Enum.HumanoidStateType.Jumping or p50 == Enum.HumanoidStateType.Freefall then
            local v54 = p48.CurrentFootstepSound
            if v54 and v54.Playing then
                v54:Stop()
            end
            p48.CurrentFootstepSound = nil
        end
        if p49 == Enum.HumanoidStateType.Freefall or p50 == Enum.HumanoidStateType.Landed then
            p48.IsAirborne = false
            p48.AirborneStartTime = 0
            p48.PeakAirborneVelocityY = 0
            v_u_39(p48, v51, v52, v53)
        elseif p50 == Enum.HumanoidStateType.Jumping then
            local v55 = tick()
            if v55 - p48.LastFloorSoundTime < 0.1 then
                return
            end
            p48.LastFloorSoundTime = v55
            local v56 = p48.Player:GetAttribute("IsCrouching")
            local v57 = v_u_24(v52, v51, v53)
            local v58 = (v56 and 0.4 or 1) * (p48.IsLocalPlayer and v_u_10.GetAudioFadeMultiplier() or 1)
            v_u_29(v51, "Jump", v58)
            v_u_29(v51, v57, v58)
            if p48.IsLocalPlayer then
                v_u_7.broadcastRouter("UpdatePlayerNoiseCone", "Jump", v51.Position, v57, v56)
            end
        end
    else
        warn("[FloorSound] Character validation failed in OnStateChanged")
        return
    end
end
function v_u_1.Update(p59, p60, p61)
    -- upvalues: (copy) v_u_24, (copy) v_u_39, (copy) v_u_10, (copy) v_u_29, (copy) v_u_7
    local v62 = p59.PrimaryPart
    local v63 = p59.Character
    local v64 = p59.Humanoid
    local v65 = p59.Player
    if v62 and (v63 and (v63.Parent and (v64 and v64.Health > 0))) then
        if p61 and not p59.IsLocalPlayer then
            local v66 = v62.Position.X - p61.X
            local v67 = v62.Position.Y - p61.Y
            local v68 = v62.Position.Z - p61.Z
            if v66 * v66 + v67 * v67 + v68 * v68 > 5625 then
                p59.IsAirborne = false
                p59.AirborneStartTime = 0
                p59.PeakAirborneVelocityY = 0
                return
            end
        end
        local v69 = tick()
        local v70 = v62.AssemblyLinearVelocity
        local v71 = v_u_24(v63, v62, v64)
        if v71 ~= "Air" then
            if p59.IsAirborne then
                local v72 = v69 - p59.AirborneStartTime
                local v73 = p59.PeakAirborneVelocityY
                p59.IsAirborne = false
                p59.AirborneStartTime = 0
                p59.PeakAirborneVelocityY = 0
                if v72 >= 0.08 and v73 <= -2.5 then
                    v_u_39(p59, v62, v63, v64, v71)
                end
            end
        elseif p59.IsAirborne then
            local v74 = p59.PeakAirborneVelocityY
            local v75 = v70.Y
            p59.PeakAirborneVelocityY = math.min(v74, v75)
        else
            p59.IsAirborne = true
            p59.AirborneStartTime = v69
            p59.PeakAirborneVelocityY = v70.Y
        end
        local v76 = v65:GetAttribute("IsCrouching")
        if v65:GetAttribute("IsWalking") or v76 then
            return
        elseif not p59.IsLocalPlayer or v65:GetAttribute("IsSniperScoped") ~= true then
            local v77 = v76 and 3.5 or 7.5
            local v78 = v76 and 0.55 or 0.3
            p59.TimePassed = p59.TimePassed + p60
            if v78 <= p59.TimePassed then
                p59.TimePassed = p59.TimePassed - v78
                if v69 - p59.LastFloorSoundTime < 0.1 then
                    return
                end
                if v77 <= (v70.X * v70.X + v70.Z * v70.Z) ^ 0.5 then
                    p59.LastFloorSoundTime = v69
                    p59.CurrentFootstepSound = v_u_29(v62, v71, (v76 and 0.4 or 1) * (p59.IsLocalPlayer and v_u_10.GetAudioFadeMultiplier() or 1))
                    if p59.IsLocalPlayer then
                        v_u_7.broadcastRouter("UpdatePlayerNoiseCone", "Footstep", v62.Position, v71, v76)
                    end
                end
            end
        end
    else
        return
    end
end
function v_u_1.new(p79)
    -- upvalues: (copy) v_u_1, (copy) v_u_6, (copy) v_u_4, (ref) v_u_12, (copy) v_u_5
    local v80 = v_u_1
    local v81 = setmetatable({}, v80)
    v81.Janitor = v_u_6.new()
    v81.IsLocalPlayer = p79 == v_u_4
    v81.Player = p79
    v81.PrimaryPart = nil
    v81.Character = nil
    v81.Humanoid = nil
    v81.TimePassed = 0.25
    v81.CurrentFootstepSound = nil
    v81.LastFloorSoundTime = 0
    v81.IsAirborne = false
    v81.AirborneStartTime = 0
    v81.PeakAirborneVelocityY = 0
    if not v_u_12 then
        v_u_12 = v_u_5.new("FloorSounds")
    end
    return v81
end
function v_u_1.Destroy(p82)
    p82.Janitor:Destroy()
end
return v_u_1
