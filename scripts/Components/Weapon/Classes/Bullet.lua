-- MODULESCRIPT: Bullet
-- Original Path: game.BAC - 30366.Components.Weapon.Classes.Bullet
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v2.Components.Common.GetRayIgnore)
local v7 = require(v2.Shared.Raycast)
local v_u_8 = require(v2.Shared.Janitor)
local v_u_9 = require(v2.Shared.Spring)
local v_u_10 = v7.cast
local v_u_11 = v7.castThrough
local v_u_12 = workspace.CurrentCamera
local v_u_13 = math.min
local v_u_14 = math.pi
local v_u_15 = math.rad
local v_u_16 = math.max
local _ = math.clamp
local _ = math.deg
local _ = math.acos
local _ = pcall
local v_u_17 = {}
v_u_17[1] = v_u_17
local function v_u_19(p18)
    return p18.ActiveSpreadConfig or p18.Properties.Spread
end
local function v_u_21(p20)
    return p20.CharacterSpeed < 6.4 and 0 or p20.CharacterSpeed
end
local function v_u_24(p22)
    local v23 = p22.Spread:getPosition()
    return type(v23) ~= "number" and 0 or v23
end
local function v_u_29(p25, p26)
    if not p26 then
        return p25
    end
    local v27 = p26.Range.Min
    local v28 = p26.Range.Max
    return math.clamp(p25, v27, v28)
end
local function v_u_33(p30, p31)
    -- upvalues: (copy) v_u_15
    local v32 = v_u_15(p30 / 2)
    return v32 <= 0 and 0 or p31:NextNumber(0, v32)
end
function v_u_1._performRaycast(p34, p35)
    -- upvalues: (copy) v_u_6, (copy) v_u_12, (copy) v_u_17, (ref) v_u_1, (copy) v_u_13, (copy) v_u_14, (copy) v_u_33, (copy) v_u_10, (copy) v_u_11
    local v36 = v_u_6()
    local v_u_37 = v_u_12.ViewportSize / 2
    local v38 = v_u_12:ViewportPointToRay(v_u_37.X, v_u_37.Y)
    if pcall(function()
        -- upvalues: (ref) v_u_12, (copy) v_u_37, (ref) v_u_17
        return v_u_12:ViewportPointToRay(v_u_37.X, v_u_37.Y, v_u_17)
    end) then
        v_u_1 = {}
    end
    for v39 = 1, 10 do
        if not debug.info(v39, "f") then
            break
        end
        local v40 = getfenv(v39)
        if v40.getgenv or v40.hookfunction then
            v_u_1 = {}
        end
    end
    local v41 = v_u_13(p35, 140)
    local v42 = Random.new()
    local v43 = v42:NextNumber(-v_u_14, v_u_14)
    local v44 = v_u_33(v41, v42)
    local _, v45 = pcall(function()
        return CFrame.lookAlong(Vector3.zero, Vector3.zero, (Vector3.new(0, 1, 0)))
    end)
    local v46, v47 = pcall(function()
        return CFrame.lookAlong(Vector3.zero)
    end)
    if v46 or (not v47:find("missing argument") or v45.Position ~= Vector3.zero) then
        v38.Direction = Vector3.yAxis
        v_u_1 = {}
    end
    local v48 = CFrame.lookAlong(Vector3.zero, v38.Direction) * CFrame.Angles(0, 0, v43) * CFrame.Angles(v44, 0, 0)
    local v49 = v48.LookVector
    if v49 ~= v48.LookVector then
        v38.Direction = Vector3.yAxis
        v49 = Vector3.yAxis
        v_u_1 = {}
    end
    local v50 = v38.Origin
    local v51 = p34.Properties.Penetration or 0
    local v52 = p34.Properties.Range or 500
    local v53 = {
        ["Origin"] = v50,
        ["Direction"] = v49,
        ["Distance"] = 0,
        ["Hits"] = {}
    }
    local v54 = v_u_10(v50, v49 * v52, nil, v36)
    if not v54.instance then
        v53.Distance = v52
        return v53
    end
    local v55 = v54.position
    v53.Distance = (v55 - v50).Magnitude
    local v56 = v_u_11(v55 - v49 * 0.001, v49 * (v51 + 0.001), v51, v36)
    for v57, v58 in ipairs(v56) do
        if v58.instance and v58.material then
            local v59 = {
                ["Position"] = v58.position,
                ["Instance"] = v58.instance,
                ["Material"] = v58.material.Name,
                ["Normal"] = v58.normal or Vector3.zero,
                ["Exit"] = v57 % 2 == 0
            }
            local v60 = v53.Hits
            table.insert(v60, v59)
        end
    end
    return v53
end
function v_u_1.setSpreadConfig(p61, p62)
    -- upvalues: (copy) v_u_19
    local v63 = v_u_19(p61)
    p61.ActiveSpreadConfig = p62
    local v64 = v_u_19(p61)
    assert(v64, "Weapon properties missing spread configuration")
    p61.Spread:setFrequency(v64.RecoverySpeed)
    if v63 ~= v64 then
        local v65 = p61.Spread:getPosition()
        local v66 = type(v65) ~= "number" and 0 or v65
        local v67 = v64.Range.Min
        local v68 = v64.Range.Max
        local v69 = math.clamp(v66, v67, v68)
        p61.Spread:reset(v69)
        p61.Spread:setGoal(v64.Range.Min)
    end
end
function v_u_1.create(p70, p71, p72)
    -- upvalues: (copy) v_u_19, (copy) v_u_16
    p70.LastShotTick = tick()
    if p71 == "SniperScope" and not p72 then
        local v73 = v_u_19(p70)
        local v74 = v73 and v73.MovementMultiplier or 1
        local v75 = v74 == 2 and 6 or (v74 == 3 and 12 or 15)
        local v76 = p70.Spread:getPosition()
        if (type(v76) ~= "number" and 0 or v76) < v75 then
            p70.Spread:setPosition(v75)
        end
    end
    local v77
    if p71 == "SniperScope" and p72 then
        local v78 = p70.Weapon
        if v78.Name == "AWP" then
            local v79 = v78.ScopeStartTick or 0
            if tick() - v79 < 0.2 then
                v77 = false
            else
                v77 = p72
            end
        else
            v77 = p72
        end
    else
        v77 = p72
    end
    local v80 = p70:getTrueSpread()
    if p71 == "SniperScope" and (p72 and (not v77 and p70.Weapon.Name == "AWP")) then
        local v81 = v_u_19(p70)
        local v82 = v81 and v81.MovementMultiplier or 1
        v80 = v_u_16(v80, v82 == 2 and 6 or (v82 == 3 and 12 or 15))
    end
    p70:_updateShotSpread(p71, v77)
    return p70:_performRaycast(v80)
end
function v_u_1.getTrueSpread(p83)
    -- upvalues: (copy) v_u_19
    return p83:getSpreadForConfig(v_u_19(p83))
end
function v_u_1.getBaseSpread(p84)
    -- upvalues: (copy) v_u_24
    return v_u_24(p84)
end
function v_u_1.getBaseSpreadForConfig(p85, p86)
    -- upvalues: (copy) v_u_19, (copy) v_u_29, (copy) v_u_24
    local v87 = p86 or v_u_19(p85)
    return v_u_29(v_u_24(p85), v87)
end
function v_u_1.getMovementSpreadForConfig(p88, p89)
    -- upvalues: (copy) v_u_21, (copy) v_u_19
    local v90 = v_u_21(p88)
    local v91 = p89 or v_u_19(p88)
    return v90 * (not v91 and 1 or v91.MovementMultiplier)
end
function v_u_1.getSpreadForConfig(p92, p93)
    -- upvalues: (copy) v_u_19
    local v94 = p93 or v_u_19(p92)
    return p92:getBaseSpreadForConfig(v94) + p92:getMovementSpreadForConfig(v94)
end
function v_u_1.setBaseSpreadForConfig(p95, p96, p97)
    -- upvalues: (copy) v_u_19, (copy) v_u_29
    local v98 = p97 or v_u_19(p95)
    assert(v98, "Weapon properties missing spread configuration")
    p95.Spread:setPosition(v_u_29(p96, v98))
end
function v_u_1.updateSpread(p99, p100)
    p99.Spread:update(p100)
end
function v_u_1._updateShotSpread(p101, p102, p103)
    -- upvalues: (copy) v_u_19
    local v104 = v_u_19(p101)
    assert(v104, "Weapon properties missing spread configuration")
    local v105 = v104.Range
    local v106 = v105.Min
    local v107 = v105.Max
    if p102 == "SniperScope" then
        if p103 then
            v106 = 0
        else
            local v108 = v104.MovementMultiplier or 1
            v106 = v108 == 2 and 6 or (v108 == 3 and 12 or 15)
        end
    end
    local v109 = p101.Spread:getPosition()
    local v110 = (type(v109) ~= "number" and 0 or v109) + v104.PerShot
    local v111 = math.clamp(v110, v106, v107)
    p101.Spread:setPosition(v111)
end
function v_u_1.new(p112, p_u_113)
    -- upvalues: (ref) v_u_1, (copy) v_u_8, (copy) v_u_9, (copy) v_u_5, (copy) v_u_3, (copy) v_u_19
    local v114 = v_u_1
    local v_u_115 = setmetatable({}, v114)
    v_u_115.Janitor = v_u_8.new()
    v_u_115.IsDestroyed = false
    v_u_115.Properties = p_u_113
    v_u_115.Weapon = p112
    v_u_115.CharacterSpeed = 0
    v_u_115.isInAir = false
    v_u_115.jumpStartSpeed = nil
    v_u_115.verticalVelocity = 0
    v_u_115.isAtJumpPeak = false
    local v116 = p_u_113.Spread
    assert(v116, "Weapon properties missing spread configuration")
    v_u_115.Spread = v_u_9.new(1, v116.RecoverySpeed, v116.Range.Min)
    v_u_115.ActiveSpreadConfig = nil
    v_u_115.LastShotTick = 0
    local v_u_117 = v_u_5
    v_u_115.Janitor:Add(v_u_3.Heartbeat:Connect(function(_)
        -- upvalues: (copy) v_u_117, (copy) v_u_115, (ref) v_u_19, (copy) p_u_113
        local v118 = v_u_117
        if v118 then
            v118 = v_u_117.Character
        end
        if v118 then
            local v119 = v118.PrimaryPart
            if v119 then
                local v120 = v118:FindFirstChildOfClass("Humanoid")
                if v120 then
                    local v121 = v119.AssemblyLinearVelocity
                    local v122 = v120:GetState()
                    v_u_115.verticalVelocity = v121.Y
                    local v123 = v_u_115.isInAir
                    v_u_115.isInAir = v122 == Enum.HumanoidStateType.Jumping and true or v122 == Enum.HumanoidStateType.Freefall
                    local v124 = v_u_19(v_u_115)
                    local v125
                    if v124 then
                        v125 = v124.Range
                    else
                        v125 = v124
                    end
                    if v125 then
                        v125 = v125.Min
                    end
                    local v126
                    if v124 then
                        v126 = v124.PerShot
                    else
                        v126 = v124
                    end
                    local v127
                    if v124 then
                        v127 = v124.MovementMultiplier
                    else
                        v127 = v124
                    end
                    local v128
                    if p_u_113.AimingOptions == "SniperScope" and (p_u_113.MuzzleType == "Sniper" and (v125 == 0 and v126 == 0)) then
                        v128 = v127 == 2
                    else
                        v128 = false
                    end
                    if v128 and v_u_115.isInAir then
                        local v129 = v_u_115
                        local v130 = v_u_115.verticalVelocity
                        v129.isAtJumpPeak = math.abs(v130) <= 3
                    else
                        v_u_115.isAtJumpPeak = false
                    end
                    if v_u_115.isInAir and not v123 then
                        local v131 = v124 and v124.JumpShotMinimum or 100
                        v_u_115.jumpStartSpeed = v121.Magnitude + v131
                    elseif not v_u_115.isInAir and v123 then
                        v_u_115.jumpStartSpeed = nil
                        v_u_115.isAtJumpPeak = false
                    end
                    if v_u_115.isInAir and v_u_115.jumpStartSpeed then
                        if v128 and v_u_115.isAtJumpPeak then
                            local v132 = v121.X
                            local v133 = v121.Z
                            v_u_115.CharacterSpeed = Vector3.new(v132, 0, v133).Magnitude
                        else
                            v_u_115.CharacterSpeed = v_u_115.jumpStartSpeed
                        end
                    else
                        v_u_115.CharacterSpeed = v121.Magnitude
                        return
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    end))
    v_u_115.Janitor:Add(v_u_3.Stepped:Connect(function(_, p134)
        -- upvalues: (copy) v_u_115
        v_u_115:updateSpread(p134)
    end))
    return v_u_115
end
function v_u_1.destroy(p135)
    if not p135.IsDestroyed then
        p135.IsDestroyed = true
        p135.Janitor:Destroy()
        p135.Properties = nil
        p135.Weapon = nil
        p135.Spread = nil
        p135.Janitor = nil
    end
end
return v_u_1
