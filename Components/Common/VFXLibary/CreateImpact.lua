-- MODULESCRIPT: CreateImpact
-- Original Path: game.BAC - 15337.Components.Common.VFXLibary.CreateImpact
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HttpService")
local v_u_3 = game:GetService("Players")
local v_u_4 = game:GetService("Debris")
require(v1.Database.Custom.Types)
local v_u_5 = require(v1.Classes.Sound)
local v_u_6 = require(v1.Shared.DebugFlags)
local v_u_7 = require(v1.Components.Common.VFXLibary.FlashEffect)
local v_u_8 = require(script.Components.Materials)
local v_u_9 = v1:WaitForChild("Assets"):WaitForChild("Impacts")
local v_u_10 = workspace:WaitForChild("Debris")
local function v_u_14(p11, p12)
    if p12 ~= "Blood Splatter" or not (p11 and p11:IsA("BasePart")) then
        return false
    end
    local v13 = string.lower(p11.Name)
    return (v13 == "head" or (v13 == "headhitbox" or (v13 == "hitboxhead" or v13 == "headhb"))) and true or string.find(v13, "head", 1, true) ~= nil
end
return function(p15, p16, p17, p18, p19, p20, p21, _, p22, p23, p24)
    -- upvalues: (copy) v_u_9, (copy) v_u_8, (copy) v_u_14, (copy) v_u_3, (copy) v_u_2, (copy) v_u_7, (copy) v_u_6, (copy) v_u_5, (copy) v_u_10, (copy) v_u_4
    local v25 = v_u_9:FindFirstChild(v_u_8[p16] or p16)
    if v25 then
        if p15 then
            local v26 = v25.Name
            if v_u_14(p15, p16) or p23 ~= nil then
                v26 = "Headshot"
                local v27 = false
                if not p20 then
                    if p23 == nil then
                        local v28 = p15:FindFirstAncestorOfClass("Model")
                        if v28 and (v28:FindFirstChildOfClass("Humanoid") and v28:IsDescendantOf(workspace)) then
                            local v29 = v_u_3:GetPlayerFromCharacter(v28)
                            if v29 and v29:IsDescendantOf(v_u_3) then
                                local v30 = nil
                                local v_u_31 = v29:GetAttribute("Armor")
                                local v32
                                if typeof(v_u_31) == "string" and v_u_31 ~= "" then
                                    local v33
                                    v33, v32 = pcall(function()
                                        -- upvalues: (ref) v_u_2, (copy) v_u_31
                                        return v_u_2:JSONDecode(v_u_31)
                                    end)
                                    if v33 then
                                        if typeof(v32) ~= "table" then
                                            v32 = v30
                                        end
                                    else
                                        v32 = v30
                                    end
                                else
                                    v32 = v30
                                end
                                if v32 == nil then
                                    v27 = false
                                else
                                    v27 = v32.Type == "Kevlar + Helmet"
                                end
                            end
                        end
                    else
                        v27 = p23 == true
                    end
                end
                if v27 then
                    v25 = v_u_9:FindFirstChild("Helmet Headshot") or v25
                    v26 = "Helmet Headshot"
                end
            end
            if p19 then
                if v_u_6.IsEnabled("WeaponFX") then
                    warn(("[WeaponFX][Client][ImpactSound] skipped (exit shot) material=%s pos=%s"):format(tostring(p16), (tostring(p17))))
                end
            else
                local v34 = v_u_7.IsFlashed()
                local v35 = v34 and 0 or 1
                if v_u_6.IsEnabled("WeaponFX") then
                    warn(("[WeaponFX][Client][ImpactSound] play material=%s sound=%s pos=%s flashed=%s exit=%s melee=%s volumeMult=%s"):format(tostring(p16), tostring(v26), tostring(p17), tostring(v34), tostring(p19), tostring(p20), (tostring(v35))))
                end
                v_u_5.new("Bullet"):PlaySoundAtPosition({
                    ["Position"] = p17,
                    ["Class"] = "Bullet",
                    ["Name"] = v26
                }, nil, v35, p21 == true, p22 == true)
            end
        end
        if (p16 == "Blood Splatter" or not p20) and p24 ~= true then
            local v36 = v25:GetChildren()
            local v37 = v36[math.random(1, #v36)]:Clone()
            v37.CollisionGroup = "Debris"
            v37.CanCollide = false
            v37.CanQuery = false
            v37.CanTouch = false
            v37.Anchored = true
            v37.CFrame = CFrame.new(p17, p17 + p18) + p18 * 0.1
            v37.Parent = v_u_10
            v37.Transparency = 1
            for _, v_u_38 in ipairs(v37:GetDescendants()) do
                if v_u_38:IsA("ParticleEmitter") then
                    task.delay(v_u_38:GetAttribute("EmitDelay") or 0, function()
                        -- upvalues: (copy) v_u_38
                        v_u_38:Emit(v_u_38:GetAttribute("EmitCount") or 1)
                    end)
                end
            end
            v_u_4:AddItem(v37, 5)
        end
    end
end
