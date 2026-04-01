-- MODULESCRIPT: Sound
-- Original Path: game.BAC - 29052.Classes.Sound
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("Players").LocalPlayer
local v_u_5 = require(v2:WaitForChild("Controllers"):WaitForChild("DataController"))
require(script:WaitForChild("Types"))
local v_u_6 = require(v2.Shared.Janitor)
local v_u_7 = v2:FindFirstChild("Sounds") or Instance.new("Folder", v2)
v_u_7.Name = "Sounds"
local v_u_8 = workspace:WaitForChild("Debris")
local function v_u_16(p9)
    local v10 = string.split(p9, ".")
    local v11 = game
    for v12, v_u_13 in ipairs(v10) do
        if v11 and v12 > 1 then
            if v11 == game then
                local v14, v15 = pcall(function()
                    -- upvalues: (copy) v_u_13
                    return game:GetService(v_u_13)
                end)
                v11 = v14 and v15 and v15 or v11:FindFirstChild(v_u_13)
            else
                v11 = v11:FindFirstChild(v_u_13)
            end
            if not v11 then
                error((("Path: \"%*\" does not exist"):format(p9)))
            end
        end
    end
    return v11
end
local function v_u_21(p17, p18, p19)
    local v20 = Instance.new("Sound")
    v20.RollOffMaxDistance = p19.RollOffMaxDistance or 10000
    v20.RollOffMinDistance = p19.RollOffMinDistance or 10
    v20.TimePosition = p19.TimePosition or 0
    v20.RollOffMode = Enum.RollOffMode.Inverse
    v20.Looped = p19.Looped or false
    v20.SoundId = ("rbxassetid://%*"):format(p18)
    v20.Volume = p19.Volume or 0.5
    v20.Name = p17
    return v20
end
function v_u_1.play(p22, p23, p_u_24)
    -- upvalues: (copy) v_u_3, (copy) v_u_16, (copy) v_u_5, (copy) v_u_4
    local v25 = p23.Parent or p23.Path
    local v26 = ("Sound couldn\'t locate sound parent for %*"):format(p23.Name)
    assert(v25, v26)
    if not p22.Sounds then
        return nil
    end
    local v27 = p22.Sounds:FindFirstChild(p23.Name)
    if v27 then
        local v28 = v_u_3:GenerateGUID(false)
        local v29 = p23.Parent
        if p23.Path and not v29 then
            v29 = v_u_16(p23.Path)
        end
        if not v29 then
            return nil
        end
        local v30 = (v_u_5.Get(v_u_4, "Settings.Audio.Audio.Master Volume") or 100) / 100
        local v31 = v27:GetChildren()
        local v_u_32 = v27:WaitForChild((math.random(1, #v31))):Clone()
        v_u_32.Volume = v_u_32.Volume * v30 * (p_u_24 or 1)
        v_u_32.Parent = v29
        v_u_32.Name = v28
        v_u_32:Play()
        local v_u_33 = v_u_32.Volume / (v30 * (p_u_24 or 1))
        v_u_32:SetAttribute("BaseVolume", v_u_33)
        v_u_32:SetAttribute("MasterVolumeMultiplier", v30)
        if p_u_24 then
            v_u_32:SetAttribute("OtherVolumeMultiplier", p_u_24)
        end
        local v_u_38 = v_u_5.CreateListener(v_u_4, "Settings.Audio.Audio.Master Volume", function(p34)
            -- upvalues: (copy) v_u_32, (copy) v_u_33, (copy) p_u_24
            if v_u_32 and v_u_32.Parent then
                local v35 = (p34 or 100) / 100
                local v36 = v_u_32:GetAttribute("BaseVolume") or v_u_33
                local v37 = v_u_32:GetAttribute("OtherVolumeMultiplier") or (p_u_24 or 1)
                v_u_32.Volume = v36 * v35 * v37
                v_u_32:SetAttribute("MasterVolumeMultiplier", v35)
            end
        end)
        v_u_32.Destroying:Once(function()
            -- upvalues: (ref) v_u_38, (ref) v_u_5, (ref) v_u_4
            if v_u_38 then
                v_u_5.RemoveListener(v_u_4, "Settings.Audio.Audio.Master Volume", v_u_38)
                v_u_38 = nil
            end
        end)
        v_u_32.Ended:Once(function()
            -- upvalues: (copy) v_u_32
            v_u_32:Destroy()
        end)
        return v_u_32
    end
end
function v_u_1.playOneTime(p39, p40, p41)
    return p39:play(p40, p41 or 1)
end
function v_u_1.PlaySoundAtPosition(p_u_42, p43, p44, p_u_45, p46, p47)
    -- upvalues: (copy) v_u_8, (copy) v_u_5, (copy) v_u_4, (copy) v_u_3
    if p_u_42.IsDestroyed then
        return
    elseif p_u_42.Sounds then
        local v48 = p_u_42.Sounds:FindFirstChild(p43.Name)
        if v48 then
            local v49 = p_u_42.Janitor:Add(Instance.new("Part"))
            v49.Size = Vector3.new(1, 1, 1)
            v49.Position = p43.Position
            v49.CollisionGroup = "Debris"
            v49.CanCollide = false
            v49.CanTouch = false
            v49.CanQuery = false
            v49.Anchored = true
            v49.Transparency = 1
            v49.Parent = v_u_8
            v49.Name = "Sound"
            local v50 = (v_u_5.Get(v_u_4, "Settings.Audio.Audio.Master Volume") or 100) / 100
            local v51 = p_u_42.Janitor
            local v52 = v48:GetChildren()
            local v_u_53 = v51:Add((v48:WaitForChild((math.random(1, #v52))):Clone()))
            v_u_53.Volume = v_u_53.Volume * v50 * (p_u_45 or 1)
            v_u_53.Name = v_u_3:GenerateGUID(false)
            v_u_53.Parent = v49
            if (p43.Name == "Headshot" and true or p43.Name == "Helmet Headshot") and p46 then
                v_u_53.RollOffMode = Enum.RollOffMode.InverseTapered
                v_u_53.RollOffMaxDistance = 10000
                v_u_53.RollOffMinDistance = 10000
                if p47 then
                    v_u_53.Volume = v_u_53.Volume * 0
                end
            end
            v_u_53:Play()
            local v_u_54 = v_u_53.Volume / (v50 * (p_u_45 or 1))
            v_u_53:SetAttribute("MasterVolumeMultiplier", v50)
            v_u_53:SetAttribute("BaseVolume", v_u_54)
            if p_u_45 then
                v_u_53:SetAttribute("OtherVolumeMultiplier", p_u_45)
            end
            local v_u_59 = v_u_5.CreateListener(v_u_4, "Settings.Audio.Audio.Master Volume", function(p55)
                -- upvalues: (copy) v_u_53, (copy) p_u_42, (copy) v_u_54, (copy) p_u_45
                if v_u_53 and (v_u_53.Parent and not p_u_42.IsDestroyed) then
                    local v56 = (p55 or 100) / 100
                    local v57 = v_u_53:GetAttribute("BaseVolume") or v_u_54
                    local v58 = v_u_53:GetAttribute("OtherVolumeMultiplier") or (p_u_45 or 1)
                    v_u_53.Volume = v57 * v56 * v58
                    v_u_53:SetAttribute("MasterVolumeMultiplier", v56)
                end
            end)
            p_u_42.Janitor:Add(function()
                -- upvalues: (ref) v_u_59, (ref) v_u_5, (ref) v_u_4
                if v_u_59 then
                    v_u_5.RemoveListener(v_u_4, "Settings.Audio.Audio.Master Volume", v_u_59)
                    v_u_59 = nil
                end
            end, true)
            if v_u_53.Looped and p44 then
                p_u_42.Janitor:Add(task.delay(p44, function()
                    -- upvalues: (copy) p_u_42
                    p_u_42:destroy()
                end), true)
            else
                p_u_42.Janitor:Add(v_u_53.Ended:Once(function()
                    -- upvalues: (copy) p_u_42
                    p_u_42:destroy()
                end))
            end
            p_u_42.Janitor:Add(v_u_53.AncestryChanged:Connect(function()
                -- upvalues: (copy) v_u_53, (copy) p_u_42
                if not v_u_53.Parent then
                    p_u_42:destroy()
                end
            end))
        else
            p_u_42:destroy()
        end
    else
        p_u_42:destroy()
        return
    end
end
function v_u_1.createSoundGroup(p60)
    -- upvalues: (ref) v_u_7, (copy) v_u_21
    local v61 = require(p60)
    local v62 = Instance.new("Folder", v_u_7)
    v62.Name = p60.Name
    for v63, v64 in pairs(v61) do
        local v65 = Instance.new("Folder", v62)
        v65.Name = v63
        for v66, v67 in ipairs(v64.Identifiers) do
            v_u_21(v66, v67, v64.Properties).Parent = v65
        end
    end
end
function v_u_1.new(p68)
    -- upvalues: (copy) v_u_1, (copy) v_u_6, (ref) v_u_7
    local v69 = v_u_1
    local v70 = setmetatable({}, v69)
    v70.Janitor = v_u_6.new()
    v70.IsDestroyed = false
    v70.SoundGroupName = p68
    v70.Sounds = v_u_7:WaitForChild(p68, 10)
    return v70
end
function v_u_1.destroy(p71)
    if not p71.IsDestroyed then
        p71.IsDestroyed = true
        p71.Janitor:Destroy()
        p71.SoundGroupName = nil
        p71.Janitor = nil
        p71.Sounds = nil
    end
end
return v_u_1

>> Batch #9 complete. Yielding...
