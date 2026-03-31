-- MODULESCRIPT: FlashEffect
-- Original Path: game.BAC - 15337.Components.Common.VFXLibary.FlashEffect
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Lighting")
local v_u_5 = game:GetService("Workspace")
local v_u_6 = game:GetService("RunService")
local v_u_7 = v2.LocalPlayer
local v_u_8 = v_u_7:WaitForChild("PlayerGui")
local v_u_9 = v_u_5.CurrentCamera
local v_u_10 = v_u_5:WaitForChild("Debris")
local v_u_11 = require(v1.Controllers.CaptureController)
local v_u_12 = require(v1.Classes.Sound)
local v_u_13 = Color3.new(1, 1, 1)
local v_u_14 = RaycastParams.new()
v_u_14.CollisionGroup = "Barriers"
v_u_14.FilterType = Enum.RaycastFilterType.Exclude
v_u_14.IgnoreWater = true
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = nil
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = nil
local v_u_26 = nil
local v_u_27 = nil
local v_u_28 = 0
local v_u_29 = nil
local function v_u_32(p30, ...)
    -- upvalues: (copy) v_u_7
    local v31 = v_u_7:GetAttribute("DebugFlashbang")
    if typeof(v31) ~= "boolean" and true or v31 then
        warn(("[FlashDBG][Client] " .. p30):format(...))
    end
end
local function v_u_33()
    -- upvalues: (ref) v_u_18, (ref) v_u_19, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_22, (ref) v_u_20, (ref) v_u_21, (ref) v_u_25, (ref) v_u_26, (ref) v_u_27
    if v_u_18 then
        v_u_18:Cancel()
        v_u_18 = nil
    end
    if v_u_19 then
        v_u_19:Cancel()
        v_u_19 = nil
    end
    if v_u_15 then
        v_u_15:Destroy()
        v_u_15 = nil
        v_u_16 = nil
    end
    if v_u_17 then
        v_u_17:Destroy()
        v_u_17 = nil
    end
    if v_u_22 then
        v_u_22:Cancel()
        v_u_22 = nil
    end
    if v_u_20 then
        v_u_20:Destroy()
        v_u_20 = nil
        v_u_21 = nil
    end
    v_u_25 = nil
    v_u_26 = nil
    v_u_27 = nil
end
local function v_u_36()
    -- upvalues: (copy) v_u_13, (copy) v_u_8
    local v34 = Instance.new("ScreenGui")
    v34.Name = "FlashbangEffect"
    v34.DisplayOrder = 999
    v34.IgnoreGuiInset = true
    v34.ResetOnSpawn = false
    local v35 = Instance.new("Frame")
    v35.Name = "FlashOverlay"
    v35.Size = UDim2.new(1, 0, 1, 0)
    v35.Position = UDim2.new(0, 0, 0, 0)
    v35.BackgroundColor3 = v_u_13
    v35.BackgroundTransparency = 1
    v35.BorderSizePixel = 0
    v35.ZIndex = 999
    v35.Parent = v34
    v34.Parent = v_u_8
    return v34, v35
end
local function v_u_47(p37)
    -- upvalues: (ref) v_u_28, (ref) v_u_25, (ref) v_u_26, (ref) v_u_27, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (copy) v_u_36, (copy) v_u_4, (ref) v_u_18, (ref) v_u_19, (copy) v_u_3, (copy) v_u_33
    task.wait(0.05)
    while v_u_28 == p37 do
        local v38 = v_u_25
        local v39 = v_u_26
        local v40 = v_u_27
        if not (v38 and (v39 and v40)) then
            break
        end
        local v41 = os.clock()
        if v38 <= v41 then
            break
        end
        local v42 = v_u_15
        local v43 = v_u_16
        local v44 = v_u_17
        if not (v42 and v43) then
            v42, v43 = v_u_36()
            v_u_15 = v42
            v_u_16 = v43
        end
        if not v44 then
            v44 = Instance.new("ColorCorrectionEffect")
            v44.Name = "FlashbangColorCorrection"
            v44.Brightness = 0
            v44.Contrast = 0
            v44.Saturation = 0
            v44.TintColor = Color3.new(1, 1, 1)
            v44.Parent = v_u_4
            v_u_17 = v44
        end
        if v41 < v39 then
            if v_u_18 then
                v_u_18:Cancel()
                v_u_18 = nil
            end
            if v_u_19 then
                v_u_19:Cancel()
                v_u_19 = nil
            end
            v43.BackgroundTransparency = 1 - v40
            v44.Brightness = v40
            v44.Saturation = -v40
            task.wait()
        else
            local v45 = v38 - v41
            if v45 <= 0 then
                break
            end
            if v_u_18 then
                v_u_18:Cancel()
                v_u_18 = nil
            end
            if v_u_19 then
                v_u_19:Cancel()
                v_u_19 = nil
            end
            v_u_18 = v_u_3:Create(v43, TweenInfo.new(v45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["BackgroundTransparency"] = 1
            })
            v_u_19 = v_u_3:Create(v44, TweenInfo.new(v45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Brightness"] = 0,
                ["Saturation"] = 0
            })
            v_u_18:Play()
            v_u_19:Play()
            while v_u_28 == p37 do
                local v46 = os.clock()
                if v38 <= v46 or v_u_26 and v46 < v_u_26 then
                    break
                end
                task.wait(0.05)
            end
        end
    end
    if v_u_28 == p37 then
        v_u_33()
    end
end
local function v_u_58(p48, p49, p50)
    if p49.Magnitude <= 0 then
        return 0, 0, 0, "zero_direction", 0
    end
    local v51 = 3 - p50 * 0.01309090909090909
    if v51 <= 0 then
        return 0, 0, v51, "zero_strength", 0
    end
    local v52 = p48:Dot(p49.Unit)
    local v53 = math.clamp(v52, -1, 1)
    local v54, v55, v56
    if v53 >= 0.6 then
        v54 = v51 * 2.5
        v55 = v51 * 1.25
        v56 = "front"
    elseif v53 >= 0.3 then
        v54 = v51 * 1.75
        v55 = v51 * 0.8
        v56 = "side_front"
    elseif v53 >= -0.2 then
        v54 = v51 * 1
        v55 = v51 * 0.5
        v56 = "side_back"
    else
        v54 = v51 * 0.5
        v55 = v51 * 0.25
        v56 = "back"
    end
    local v57 = v54 <= 0 and 0 or v55 / v54
    return v54 / 1.4, v53, v51, v56, v57
end
local v_u_59 = { -0.5, 0, 0.5 }
local v_u_60 = nil
local function v_u_74(p61, p62)
    -- upvalues: (copy) v_u_10, (copy) v_u_7, (ref) v_u_60, (copy) v_u_5, (copy) v_u_14, (copy) v_u_59
    local v63 = { v_u_10 }
    local v64 = v_u_7.Character
    if v64 then
        table.insert(v63, v64)
    end
    local v65 = not v_u_60 and v_u_5:FindFirstChild("Map")
    if v65 then
        v_u_60 = v65:FindFirstChild("Barriers")
    end
    local v66 = v_u_60
    if v66 then
        table.insert(v63, v66)
    end
    v_u_14.FilterDescendantsInstances = v63
    for _, v67 in ipairs(v_u_59) do
        for _, v68 in ipairs(v_u_59) do
            for _, v69 in ipairs(v_u_59) do
                local v70 = p61 + Vector3.new(v67, v68, v69)
                local v71 = p62 - v70
                local v72 = v71.Magnitude
                if v72 < 0.1 then
                    return true
                end
                local v73 = v_u_5:Raycast(v70, v71, v_u_14)
                if not v73 or v73.Distance >= v72 - 0.5 then
                    return true
                end
            end
        end
    end
    return false
end
return {
    ["Flash"] = function(p75)
        -- upvalues: (copy) v_u_32, (copy) v_u_9, (copy) v_u_74, (copy) v_u_58, (ref) v_u_23, (ref) v_u_24, (copy) v_u_12, (copy) v_u_6, (ref) v_u_25, (ref) v_u_29, (ref) v_u_27, (ref) v_u_26, (ref) v_u_21, (ref) v_u_22, (copy) v_u_3, (ref) v_u_20, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (copy) v_u_36, (copy) v_u_4, (ref) v_u_18, (ref) v_u_19, (ref) v_u_28, (copy) v_u_47, (copy) v_u_11, (copy) v_u_8
        local v76 = p75.Position
        local v77 = not p75.Duration and "nil" or string.format("%.3f", p75.Duration)
        local v78 = v_u_32
        local v79 = v76.X
        local v80 = v76.Y
        local v81 = v76.Z
        local v82 = p75.AttackerUserId
        v78("recv pos=(%.2f, %.2f, %.2f) netDuration=%s attacker=%s", v79, v80, v81, v77, (tostring(v82)))
        local v83 = v_u_9.CFrame.Position
        local v84 = v_u_9.CFrame.LookVector
        local v_u_85 = 0
        local v_u_86
        if p75.Duration then
            v_u_86 = p75.Duration
            v_u_32("spectator_duration=%.3f", v_u_86)
        else
            local v87 = v76 - v83
            local v88 = v87.Magnitude
            if v88 > 229.16666666666669 then
                v_u_32("skip=out_of_range distance=%.3f radius=%.3f", v88, 229.16666666666669)
                return
            end
            if not v_u_74(v76, v83) then
                v_u_32("skip=no_los distance=%.3f", v88)
                return
            end
            local v89, v90, v91, v92, v93 = v_u_58(v84, v87, v88)
            v_u_86 = v89
            v_u_85 = v93
            v_u_32("calc distance=%.3f dot=%.3f bucket=%s strength=%.3f duration=%.3f sourceHold=%.3f", v88, v90, v92, v91, v_u_86, v_u_85)
        end
        if v_u_86 < 0.01 then
            v_u_32("skip=below_threshold duration=%.3f threshold=0.010", v_u_86)
        else
            if v_u_23 then
                if v_u_24 then
                    v_u_24:Disconnect()
                    v_u_24 = nil
                end
                if v_u_23.Parent then
                    v_u_23:Stop()
                    v_u_23:Destroy()
                end
                v_u_23 = nil
            end
            local v94 = {
                ["Parent"] = v_u_9,
                ["Name"] = "Flashed"
            }
            local v_u_95 = v_u_12.new("Flashbang"):play(v94)
            if v_u_95 then
                v_u_23 = v_u_95
                local v_u_96 = tick()
                local v_u_97 = v_u_95.Volume
                v_u_24 = v_u_6.Heartbeat:Connect(function()
                    -- upvalues: (copy) v_u_96, (ref) v_u_24, (copy) v_u_95, (ref) v_u_23, (copy) v_u_97
                    local v98 = tick() - v_u_96
                    if v98 >= 4 then
                        if v_u_24 then
                            v_u_24:Disconnect()
                            v_u_24 = nil
                        end
                        if v_u_95 and v_u_95.Parent then
                            v_u_95:Stop()
                            v_u_95:Destroy()
                        end
                        if v_u_23 == v_u_95 then
                            v_u_23 = nil
                            return
                        end
                    else
                        if v_u_95 and v_u_95.Parent then
                            v_u_95.Volume = v_u_97 * (v98 >= 4 and 0 or 1 - v98 * 0.225)
                            return
                        end
                        if not (v_u_95 and v_u_95.Parent) then
                            if v_u_24 then
                                v_u_24:Disconnect()
                                v_u_24 = nil
                            end
                            if v_u_23 == v_u_95 then
                                v_u_23 = nil
                            end
                        end
                    end
                end)
            end
            local function v_u_119()
                -- upvalues: (ref) v_u_25, (ref) v_u_86, (ref) v_u_32, (ref) v_u_85, (ref) v_u_29, (ref) v_u_27, (ref) v_u_26, (ref) v_u_21, (ref) v_u_22, (ref) v_u_3, (ref) v_u_20, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_36, (ref) v_u_4, (ref) v_u_18, (ref) v_u_19, (ref) v_u_28, (ref) v_u_47
                local v99 = os.clock()
                local v100
                if v_u_25 then
                    local v101 = v_u_25 - v99
                    v100 = math.max(0, v101) or 0
                else
                    v100 = 0
                end
                local v102 = v_u_86
                local v103 = math.max(v100, v102)
                local v104 = v103 - 3
                local v105 = math.max(0, v104)
                local v106
                if v103 > 3 then
                    v106 = 1
                else
                    local v107 = (v103 / 3) ^ 0.6
                    v106 = math.clamp(v107, 0, 1)
                end
                v_u_32("apply incoming=%.3f remaining=%.3f result=%.3f holdWindow=%.3f peakAlpha=%.3f sourceHold=%.3f", v_u_86, v100, v103, v105, v106, v_u_85)
                v_u_29 = v99
                v_u_25 = v99 + v103
                v_u_27 = v106
                local v108 = v99 + 0.05 + v105
                local v109 = v_u_25
                local v110 = v_u_26 or 0
                local v111 = math.max(v110, v108)
                v_u_26 = math.min(v109, v111)
                if v_u_86 >= 4 and v_u_21 then
                    if v_u_22 then
                        v_u_22:Cancel()
                        v_u_22 = nil
                    end
                    v_u_21.ImageTransparency = 0
                    local v_u_112 = v_u_3:Create(v_u_21, TweenInfo.new(v103, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["ImageTransparency"] = 1
                    })
                    v_u_22 = v_u_112
                    v_u_112:Play()
                    v_u_112.Completed:Connect(function()
                        -- upvalues: (ref) v_u_20, (ref) v_u_21, (ref) v_u_22, (copy) v_u_112
                        if v_u_20 then
                            v_u_20:Destroy()
                            v_u_20 = nil
                            v_u_21 = nil
                        end
                        if v_u_22 == v_u_112 then
                            v_u_22 = nil
                        end
                    end)
                end
                local v113 = v_u_15
                local v114 = v_u_16
                local v115 = v_u_17
                if not (v113 and v114) then
                    v113, v114 = v_u_36()
                    v_u_15 = v113
                    v_u_16 = v114
                end
                if not v115 then
                    v115 = Instance.new("ColorCorrectionEffect")
                    v115.Name = "FlashbangColorCorrection"
                    v115.Brightness = 0
                    v115.Contrast = 0
                    v115.Saturation = 0
                    v115.TintColor = Color3.new(1, 1, 1)
                    v115.Parent = v_u_4
                    v_u_17 = v115
                end
                if v_u_18 then
                    v_u_18:Cancel()
                    v_u_18 = nil
                end
                if v_u_19 then
                    v_u_19:Cancel()
                    v_u_19 = nil
                end
                local v116 = v_u_3:Create(v114, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["BackgroundTransparency"] = 1 - v106
                })
                local v117 = v_u_3:Create(v115, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Brightness"] = v106,
                    ["Saturation"] = -v106
                })
                v116:Play()
                v117:Play()
                v_u_28 = v_u_28 + 1
                local v_u_118 = v_u_28
                task.spawn(function()
                    -- upvalues: (ref) v_u_47, (copy) v_u_118
                    v_u_47(v_u_118)
                end)
            end
            if v_u_86 >= 4 then
                v_u_11.CaptureScreenshot(function(p120)
                    -- upvalues: (ref) v_u_22, (ref) v_u_20, (ref) v_u_8, (ref) v_u_21, (ref) v_u_25, (ref) v_u_3
                    if v_u_22 then
                        v_u_22:Cancel()
                        v_u_22 = nil
                    end
                    if v_u_20 then
                        if v_u_21 then
                            v_u_21.Image = p120
                            v_u_21.ImageTransparency = 0
                        end
                    else
                        local v121 = Instance.new("ScreenGui")
                        v121.Name = "FlashScreenshot"
                        v121.DisplayOrder = 998
                        v121.IgnoreGuiInset = true
                        v121.ResetOnSpawn = false
                        v121.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                        local v122 = Instance.new("ImageLabel")
                        v122.Name = "ScreenshotImage"
                        v122.Size = UDim2.new(1, 0, 1, 0)
                        v122.Position = UDim2.new(0, 0, 0, 0)
                        v122.BackgroundTransparency = 1
                        v122.BorderSizePixel = 0
                        v122.Image = p120
                        v122.ImageTransparency = 0
                        v122.ScaleType = Enum.ScaleType.Fit
                        v122.ZIndex = 998
                        v122.Parent = v121
                        v121.Parent = v_u_8
                        v_u_20 = v121
                        v_u_21 = v122
                    end
                    if v_u_21 then
                        local v123 = os.clock()
                        local v124
                        if v_u_25 and v123 < v_u_25 then
                            local v125 = v_u_25 - v123
                            v124 = math.max(0, v125)
                        else
                            v124 = 0
                        end
                        local v126 = math.max(v124, 0.01)
                        if v_u_22 then
                            v_u_22:Cancel()
                            v_u_22 = nil
                        end
                        local v_u_127 = v_u_3:Create(v_u_21, TweenInfo.new(v126, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["ImageTransparency"] = 1
                        })
                        v_u_22 = v_u_127
                        v_u_127:Play()
                        v_u_127.Completed:Connect(function()
                            -- upvalues: (ref) v_u_20, (ref) v_u_21, (ref) v_u_22, (copy) v_u_127
                            if v_u_20 then
                                v_u_20:Destroy()
                                v_u_20 = nil
                                v_u_21 = nil
                            end
                            if v_u_22 == v_u_127 then
                                v_u_22 = nil
                            end
                        end)
                    end
                end):catch(function() end)
                task.delay(0.01, function()
                    -- upvalues: (copy) v_u_119
                    v_u_119()
                end)
            else
                v_u_119()
            end
        end
    end,
    ["CancelFlash"] = function()
        -- upvalues: (copy) v_u_32, (ref) v_u_28, (copy) v_u_33, (ref) v_u_29, (ref) v_u_24, (ref) v_u_23
        v_u_32("cancel")
        v_u_28 = v_u_28 + 1
        v_u_33()
        v_u_29 = nil
        if v_u_24 then
            v_u_24:Disconnect()
            v_u_24 = nil
        end
        if v_u_23 and v_u_23.Parent then
            v_u_23:Stop()
            v_u_23:Destroy()
        end
        v_u_23 = nil
    end,
    ["IsFlashed"] = function()
        -- upvalues: (ref) v_u_25
        if v_u_25 then
            return os.clock() < v_u_25
        else
            return false
        end
    end,
    ["GetAudioFadeMultiplier"] = function()
        -- upvalues: (ref) v_u_29
        if not v_u_29 then
            return 1
        end
        local v128 = os.clock() - v_u_29
        if v128 >= 1.5 then
            return 1
        end
        if v128 < 0.5 then
            return 0
        end
        local v129 = (v128 - 0.5) / 1
        return math.clamp(v129, 0, 1)
    end
}
