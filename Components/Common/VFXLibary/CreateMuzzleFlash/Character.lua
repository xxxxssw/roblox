-- MODULESCRIPT: Character
-- Original Path: game.BAC - 15337.Components.Common.VFXLibary.CreateMuzzleFlash.Character
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("Debris")
require(v1.Database.Custom.Types)
local v_u_4 = require(v1.Shared.DebugFlags)
local v_u_5 = require(v1.Components.Common.GetWeaponProperties)
local v_u_6 = require(v1.Components.Common.VFXLibary.CreateZeusBeam)
local v_u_7 = v1:WaitForChild("Assets"):WaitForChild("MuzzleFlashes")
local v_u_8 = workspace:WaitForChild("Debris")
function executeMuzzleFlash(p9, p10, p11)
    -- upvalues: (copy) v_u_5, (copy) v_u_7, (copy) v_u_8, (copy) v_u_3
    local v12 = v_u_5(p10)
    if v12 then
        local v13 = p11 or v12.MuzzleType
        if not v13 then
            return nil
        end
        local v14 = v_u_7.Character:FindFirstChild(v13)
        local v15
        if v14 then
            v15 = v14:Clone()
            v15.CollisionGroup = "Debris"
            v15.CanCollide = false
            v15.CanQuery = false
            v15.CanTouch = false
            v15.Anchored = false
        else
            v15 = nil
        end
        if v15 then
            debug.profilebegin("firstparent")
            v15.Parent = v_u_8
            debug.profileend()
            local v16 = Instance.new("WeldConstraint")
            debug.profilebegin("secondparent")
            v16.Parent = v15
            debug.profileend()
            v15.CFrame = p9.CFrame
            v16.Part0 = p9
            v16.Part1 = v15
            for _, v_u_17 in ipairs(v15:GetDescendants()) do
                if v_u_17:IsA("ParticleEmitter") then
                    task.delay(v_u_17:GetAttribute("EmitDelay") or 0, function()
                        -- upvalues: (copy) v_u_17
                        v_u_17:Emit(v_u_17:GetAttribute("EmitCount") or 1)
                    end)
                end
            end
            v_u_3:AddItem(v15, 5)
            return p9.Position
        end
    end
    return nil
end
local function v_u_19(p18, ...)
    -- upvalues: (copy) v_u_4
    if v_u_4.IsEnabled("WeaponFX") then
        warn(("[WeaponFX][MuzzleFlash.Character] " .. p18):format(...))
    end
end
local function v_u_37(p_u_20, p_u_21, p_u_22, p_u_23, p_u_24, p_u_25)
    -- upvalues: (copy) v_u_2, (copy) v_u_19, (copy) v_u_5, (copy) v_u_8, (copy) v_u_37, (copy) v_u_6
    local v26 = v_u_2:FindFirstChild(p_u_20)
    if v26 then
        local v27 = v_u_5(p_u_21)
        if v27 then
            if v26.Character then
                local v28 = v_u_8:FindFirstChild(v26.Name .. "_Weapon")
                if v28 then
                    local v29 = v28:FindFirstChild("Interactables")
                    if v29 then
                        local v30 = v29:FindFirstChild("MuzzlePart")
                        if v27.ShootingOptions == "Dual" then
                            v30 = v29:FindFirstChild("MuzzlePart" .. (p_u_22 == "Left" and "L" or "R"))
                        end
                        if v30 then
                            if v27.MuzzleType == "Zeus x27" then
                                v_u_6(v30)
                            end
                            if not p_u_25 then
                                if not executeMuzzleFlash(v30, p_u_21, p_u_23) then
                                    v_u_19("executeMuzzleFlash failed player=%s weapon=%s override=%s attempt=%d", v26.Name, tostring(p_u_21), tostring(p_u_23), p_u_24)
                                end
                            end
                        else
                            v_u_19("missing muzzle part player=%s weapon=%s shootingHand=%s attempt=%d", v26.Name, tostring(p_u_21), tostring(p_u_22), p_u_24)
                            return
                        end
                    else
                        if p_u_24 < 3 then
                            task.delay(0.05, function()
                                -- upvalues: (ref) v_u_37, (copy) p_u_20, (copy) p_u_21, (copy) p_u_22, (copy) p_u_23, (copy) p_u_24, (copy) p_u_25
                                v_u_37(p_u_20, p_u_21, p_u_22, p_u_23, p_u_24 + 1, p_u_25)
                            end)
                        end
                        local v31 = v_u_19
                        local v32 = v26.Name
                        local v33 = p_u_24 < 3
                        v31("missing Interactables on %s_Weapon (retry=%s) player=%s weapon=%s attempt=%d", v32, tostring(v33), v26.Name, tostring(p_u_21), p_u_24)
                        return
                    end
                else
                    if p_u_24 < 3 then
                        task.delay(0.05, function()
                            -- upvalues: (ref) v_u_37, (copy) p_u_20, (copy) p_u_21, (copy) p_u_22, (copy) p_u_23, (copy) p_u_24, (copy) p_u_25
                            v_u_37(p_u_20, p_u_21, p_u_22, p_u_23, p_u_24 + 1, p_u_25)
                        end)
                    end
                    local v34 = v_u_19
                    local v35 = v26.Name
                    local v36 = p_u_24 < 3
                    v34("missing %s_Weapon in Debris (retry=%s) player=%s weapon=%s attempt=%d", v35, tostring(v36), v26.Name, tostring(p_u_21), p_u_24)
                    return
                end
            else
                v_u_19("character missing player=%s weapon=%s attempt=%d", v26.Name, tostring(p_u_21), p_u_24)
                return
            end
        else
            v_u_19("weapon properties missing player=%s weapon=%s attempt=%d", v26.Name, tostring(p_u_21), p_u_24)
            return
        end
    else
        v_u_19("player not found username=%s weapon=%s attempt=%d", tostring(p_u_20), tostring(p_u_21), p_u_24)
        return
    end
end
return function(p38, p39, p40, p41, p42)
    -- upvalues: (copy) v_u_37
    v_u_37(p38, p39, p40, p41, 0, p42)
end
