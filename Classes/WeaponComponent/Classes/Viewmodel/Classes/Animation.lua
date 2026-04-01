-- MODULESCRIPT: Animation
-- Original Path: game.BAC - 19589.Classes.WeaponComponent.Classes.Viewmodel.Classes.Animation
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = require(v2.Components.Common.GetWeaponProperties)
local v_u_8 = require(v2.Components.Common.VFXLibary.FlashEffect)
local v_u_9 = require(v2.Shared.Janitor)
local v_u_10 = require(v2.Database.Security.Remotes)
local v_u_11 = {
    "7",
    "73",
    "735",
    "7355",
    "73556",
    "735560",
    "7355608"
}
local function v_u_17(p12, p13)
    local v14 = tick()
    local v15 = p12:GetAttribute("LastSoundEventName")
    local v16 = p12:GetAttribute("LastSoundEventTick")
    if v15 == p13 and (type(v16) == "number" and (v14 - v16 >= 0 and v14 - v16 <= 0.02)) then
        return true
    end
    p12:SetAttribute("LastSoundEventName", p13)
    p12:SetAttribute("LastSoundEventTick", v14)
    return false
end
local function v_u_28(p_u_18, p19, p20, p21, p22, p23, p24)
    -- upvalues: (copy) v_u_17, (copy) v_u_8, (copy) v_u_6, (copy) v_u_5, (copy) v_u_10
    if p23 then
        p23 = p23:FindFirstChild(p21)
    end
    if p_u_18.IsDestroyed then
        return
    else
        local v25 = p24.Character
        if v25 then
            if p23 and #p23:GetChildren() > 0 then
                if not v_u_17(p19, p21) then
                    local v_u_26 = p22:play({
                        ["Parent"] = v_u_6,
                        ["Name"] = p21
                    }, (v_u_8.GetAudioFadeMultiplier()))
                    if v_u_26 then
                        p_u_18.ActiveSounds[v_u_26] = p20
                        v_u_26.Ended:Once(function()
                            -- upvalues: (copy) p_u_18, (copy) v_u_26
                            if not p_u_18.IsDestroyed then
                                p_u_18.ActiveSounds[v_u_26] = nil
                            end
                        end)
                    end
                    if v25:FindFirstChild("Head") then
                        local v27 = v25:WaitForChild("Head")
                        if p20 == "Equip" or p20 == "Inspect" then
                            return
                        end
                        if v_u_5 ~= p24 then
                            return
                        end
                        if p21 == "Prepare" and p22.SoundGroupName == "R8 Revolver" then
                            return
                        end
                        v_u_10.Sound.ReplicateSound.Send({
                            ["Parent"] = v27,
                            ["Class"] = p22.SoundGroupName,
                            ["Name"] = p21
                        })
                    end
                end
            else
                return
            end
        else
            return
        end
    end
end
function v_u_1.getAnimation(p29, p30)
    return p29.Animations[p30]
end
function v_u_1.adjustAnimationSpeed(p31, p32, p33)
    local v34 = p31:getAnimation(p32)
    if v34 then
        v34:AdjustSpeed(v34.Length / p33)
    end
end
function v_u_1.play(p35, p36, ...)
    local v37 = p35:getAnimation(p36)
    p35.CurrentAnimation = p36
    if not v37 then
        return nil
    end
    v37:Play(...)
    return v37
end
function v_u_1.stop(p38, p39, p40)
    local v41 = p38:getAnimation(p39)
    if v41 and v41.IsPlaying then
        v41:Stop(p40 or 0)
    end
end
function v_u_1.cancelCrossfade(p42)
    if p42.CrossfadeConnection then
        p42.CrossfadeConnection:Disconnect()
        p42.CrossfadeConnection = nil
    end
    if p42.CrossfadeTempTrack then
        p42.CrossfadeTempTrack:Stop(0)
        p42.CrossfadeTempTrack:Destroy()
        p42.CrossfadeTempTrack = nil
    end
    p42.IsCrossfading = false
end
function v_u_1.isCrossfading(p43)
    return p43.IsCrossfading == true
end
function v_u_1.crossfadeRestart(p_u_44, p45, p46)
    -- upvalues: (copy) v_u_3
    local v_u_47 = p46 or 0.25
    p_u_44:cancelCrossfade()
    local v_u_48 = p_u_44:getAnimation(p45)
    if not v_u_48 then
        return nil
    end
    local v49 = v_u_48.WeightCurrent
    if not v_u_48.IsPlaying then
        v_u_48:Play(0, 1, 1)
        return v_u_48
    end
    local v_u_50 = math.max(v49, 0.5)
    local v_u_51 = v_u_48.Animation
    if not v_u_51 then
        v_u_48:Stop(0)
        v_u_48:Play(0, 1, 1)
        return v_u_48
    end
    local v52, v_u_53 = pcall(function()
        -- upvalues: (copy) p_u_44, (copy) v_u_51
        return p_u_44.Animator:LoadAnimation(v_u_51)
    end)
    if not (v52 and v_u_53) then
        v_u_48:Stop(0)
        v_u_48:Play(0, 1, 1)
        return v_u_48
    end
    local v_u_54 = p_u_44.Sound
    local v_u_57 = v_u_53.KeyframeReached:Connect(function(p55)
        -- upvalues: (copy) p_u_44, (copy) v_u_54
        if not p_u_44.IsDestroyed then
            local v56 = v_u_54.Sounds:FindFirstChild(p55)
            if v56 and #v56:GetChildren() > 0 then
                v_u_54:play({
                    ["Parent"] = game:GetService("Players").LocalPlayer.PlayerGui,
                    ["Name"] = p55
                })
            end
        end
    end)
    v_u_53:Play(0, 0.01, 1)
    v_u_53.TimePosition = 0
    p_u_44.CrossfadeTempTrack = v_u_53
    local v_u_58 = tick()
    p_u_44.CurrentAnimation = p45
    p_u_44.IsCrossfading = true
    p_u_44.CrossfadeConnection = v_u_3.RenderStepped:Connect(function()
        -- upvalues: (copy) p_u_44, (copy) v_u_57, (copy) v_u_58, (copy) v_u_47, (copy) v_u_50, (copy) v_u_48, (copy) v_u_53
        if p_u_44.IsDestroyed then
            v_u_57:Disconnect()
            p_u_44:cancelCrossfade()
        else
            local v59 = (tick() - v_u_58) / v_u_47
            local v60 = math.clamp(v59, 0, 1)
            local v61 = v60 * 3 * v60 - v60 * 2 * v60 * v60
            local v62 = v_u_50 * (1 - v61)
            local v63 = math.max(v61, 0.01)
            v_u_48:AdjustWeight(v62, 0)
            v_u_53:AdjustWeight(v63, 0)
            if v60 >= 1 then
                v_u_57:Disconnect()
                local v64 = v_u_53.TimePosition
                v_u_48:Stop(0)
                v_u_48:Play(0, 1, 1)
                v_u_48.TimePosition = v64
                v_u_48:AdjustWeight(1, 0)
                v_u_53:Stop(0)
                v_u_53:Destroy()
                p_u_44.CrossfadeTempTrack = nil
                p_u_44:cancelCrossfade()
            end
        end
    end)
    return v_u_48
end
function v_u_1.crossfadeTo(p_u_65, p66, p67)
    -- upvalues: (copy) v_u_3
    p_u_65:cancelCrossfade()
    local v_u_68 = {}
    local v_u_69 = p67 or 0.25
    for v70, v71 in pairs(p_u_65.Animations) do
        if v71.IsPlaying and (v70 ~= "Idle" and v70 ~= p66) then
            local v72 = {
                ["track"] = v71,
                ["startWeight"] = v71.WeightCurrent
            }
            table.insert(v_u_68, v72)
        end
    end
    local v_u_73 = p_u_65:getAnimation(p66)
    local v_u_74 = p66 == "Idle"
    if not (v_u_73 or v_u_74) then
        return nil
    end
    p_u_65.CurrentAnimation = p66
    p_u_65.IsCrossfading = true
    if v_u_73 and not v_u_74 then
        v_u_73:Play(0, 0, 1)
    end
    local v_u_75 = tick()
    p_u_65.CrossfadeConnection = v_u_3.RenderStepped:Connect(function()
        -- upvalues: (copy) p_u_65, (copy) v_u_75, (copy) v_u_69, (copy) v_u_68, (copy) v_u_73, (copy) v_u_74
        if p_u_65.IsDestroyed then
            p_u_65:cancelCrossfade()
        else
            local v76 = (tick() - v_u_75) / v_u_69
            local v77 = math.clamp(v76, 0, 1)
            local v78 = 1 - v77
            local v79 = v78 * 3 * v78 - v78 * 2 * v78 * v78
            for _, v80 in ipairs(v_u_68) do
                if v80.track then
                    v80.track:AdjustWeight(v80.startWeight * v79, 0)
                end
            end
            if v_u_73 and not v_u_74 then
                v_u_73:AdjustWeight(1 - v79, 0)
            end
            if v77 >= 1 then
                for _, v81 in ipairs(v_u_68) do
                    if v81.track and v81.track.IsPlaying then
                        v81.track:Stop(0)
                    end
                end
                if v_u_74 and v_u_73 then
                    v_u_73:Play(0, 1, 1)
                elseif v_u_73 then
                    v_u_73:AdjustWeight(1, 0)
                end
                p_u_65:cancelCrossfade()
            end
        end
    end)
    return v_u_73
end
function v_u_1.stopAnimations(p82, p83)
    p82:cancelCrossfade()
    for _, v84 in pairs(p82.Animations) do
        if v84.IsPlaying then
            v84:Stop(p83 or 0)
        end
    end
    p82:stopSounds()
end
function v_u_1.stopSounds(p85)
    for v86, v88 in pairs(p85.ActiveSounds) do
        if v88 then
            local v88 = string.find(v88, "Shoot") ~= nil
        end
        if not v88 then
            p85.ActiveSounds[v86] = nil
            if v86 and v86.Parent then
                v86:Destroy()
            end
        end
    end
end
function v_u_1.unregister(p89, p90)
    if p89.Animations[p90] then
        p89.Janitor:Remove("AnimationConnection_" .. p90)
        if p89.Sound and p89.Sound.Sounds then
            for _, v91 in ipairs(p89.Sound.Sounds:GetChildren()) do
                if v91:IsA("Folder") then
                    p89.Janitor:Remove("AnimationMarkerConnection_" .. p90 .. "_" .. v91.Name)
                end
            end
        end
        p89.Janitor:RemoveNoClean("AnimationCleanup_" .. p90)
        if p89.Animations[p90] then
            local v92 = p89.Animations[p90]
            p89.Animations[p90] = nil
            if v92.IsPlaying then
                v92:Stop()
            end
            v92:Destroy()
        end
    end
end
function v_u_1.unregisterGroup(p93, ...)
    for _, v94 in ipairs({ ... }) do
        p93:unregister(v94)
    end
end
function v_u_1.register(p_u_95, p_u_96, p_u_97)
    -- upvalues: (copy) v_u_28
    p_u_95:unregister(p_u_96)
    local v98, v_u_99 = pcall(function()
        -- upvalues: (copy) p_u_95, (copy) p_u_97
        return p_u_95.Animator:LoadAnimation(p_u_97)
    end)
    if v98 then
        p_u_95.Animations[p_u_96] = v_u_99
        local v_u_100 = p_u_95.Sound
        local v_u_101 = v_u_100.Sounds
        local v_u_102 = p_u_95.Player
        local v_u_103 = setmetatable({}, {
            ["__mode"] = "v"
        })
        v_u_103.instance = p_u_95
        p_u_95.Janitor:Add(function()
            -- upvalues: (copy) v_u_103, (copy) p_u_96
            local v104 = v_u_103.instance
            if v104 and not v104.IsDestroyed then
                v104:unregister(p_u_96)
            end
        end, true, "AnimationCleanup_" .. p_u_96)
        local v107 = v_u_99.KeyframeReached:Connect(function(p105)
            -- upvalues: (copy) v_u_103, (ref) v_u_28, (copy) v_u_99, (copy) p_u_96, (copy) v_u_100, (copy) v_u_101, (copy) v_u_102
            local v106 = v_u_103.instance
            if v106 then
                v_u_28(v106, v_u_99, p_u_96, p105, v_u_100, v_u_101, v_u_102)
            end
        end)
        p_u_95.Janitor:Add(v107, "Disconnect", "AnimationConnection_" .. p_u_96)
        if v_u_101 then
            for _, v108 in ipairs(v_u_101:GetChildren()) do
                if v108:IsA("Folder") then
                    local v_u_109 = v108.Name
                    local v111 = v_u_99:GetMarkerReachedSignal(v_u_109):Connect(function()
                        -- upvalues: (copy) v_u_103, (ref) v_u_28, (copy) v_u_99, (copy) p_u_96, (copy) v_u_109, (copy) v_u_100, (copy) v_u_101, (copy) v_u_102
                        local v110 = v_u_103.instance
                        if v110 then
                            v_u_28(v110, v_u_99, p_u_96, v_u_109, v_u_100, v_u_101, v_u_102)
                        end
                    end)
                    p_u_95.Janitor:Add(v111, "Disconnect", "AnimationMarkerConnection_" .. p_u_96 .. "_" .. v_u_109)
                end
            end
        end
    end
end
function v_u_1.construct(p112)
    -- upvalues: (copy) v_u_7
    local v113 = v_u_7(p112.Animation)
    if v113 then
        local v114 = v113.CameraAnimations
        if typeof(v114) == "Instance" and v114:IsA("Folder") then
            for _, v115 in ipairs(v114:GetChildren()) do
                if v115:IsA("Animation") then
                    p112:register(v115.Name, v115)
                end
            end
        end
    else
        return
    end
end
function v_u_1.setModel(p_u_116, p117)
    -- upvalues: (copy) v_u_11, (copy) v_u_5
    if p117 then
        p_u_116.Animation = p117.Name
        p_u_116.Animator = p117:WaitForChild("AnimationController"):WaitForChild("Animator")
        p_u_116:stopAnimations()
        p_u_116:construct()
        if p_u_116.Animation == "C4" then
            local v_u_118 = p117:FindFirstChild("Weapon")
            if v_u_118 then
                v_u_118 = p117.Weapon:FindFirstChild("Interactive")
            end
            if v_u_118 and v_u_118:FindFirstChild("SurfaceGui") then
                v_u_118.SurfaceGui.TextLabel.Text = "*******"
            end
            for _, v119 in pairs(p_u_116.Animations) do
                p_u_116.Janitor:Add(v119.KeyframeReached:Connect(function(p120)
                    -- upvalues: (ref) v_u_11, (copy) v_u_118, (copy) p_u_116, (ref) v_u_5
                    if table.find(v_u_11, p120) then
                        if v_u_118 and v_u_118:FindFirstChild("SurfaceGui") then
                            v_u_118.SurfaceGui.TextLabel.Text = string.rep("*", 7 - #p120) .. p120
                        end
                        p_u_116.Sound:play({
                            ["Parent"] = v_u_5.PlayerGui,
                            ["Name"] = p120
                        })
                    end
                end))
            end
        end
    end
end
function v_u_1.new(_, p121, p122, p123)
    -- upvalues: (copy) v_u_1, (copy) v_u_9
    local v124 = v_u_1
    local v125 = setmetatable({}, v124)
    v125.Janitor = v_u_9.new()
    v125.IsDestroyed = false
    v125.IsCrossfading = false
    v125.CrossfadeConnection = nil
    v125.CrossfadeTempTrack = nil
    v125.Player = p121
    v125.ActiveSounds = {}
    v125.Animations = {}
    v125.CurrentAnimation = nil
    v125.Sound = p123
    if p122 then
        v125:setModel(p122)
    end
    return v125
end
function v_u_1.destroy(p126)
    if not p126.IsDestroyed then
        p126.IsDestroyed = true
        p126:cancelCrossfade()
        p126:stopAnimations()
        local v127 = {}
        for v128, _ in pairs(p126.Animations) do
            table.insert(v127, v128)
        end
        for _, v129 in ipairs(v127) do
            p126:unregister(v129)
        end
        p126:stopSounds()
        table.clear(p126.ActiveSounds)
        table.clear(p126.Animations)
        p126.CurrentAnimation = nil
        p126.Animation = nil
        p126.Animator = nil
        p126.Player = nil
        p126.Sound = nil
        p126.Janitor:Destroy()
        p126.Janitor = nil
    end
end
return v_u_1
