-- MODULESCRIPT: InspectController
-- Original Path: game.BAC - 52212.Controllers.InspectController
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = game:GetService("TextService")
local v_u_7 = game:GetService("Lighting")
local v8 = game:GetService("Players")
local v_u_9 = game:GetService("HttpService")
require(v_u_2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v10 = require(v_u_2.Shared.Janitor)
local v_u_11 = require(v_u_2.Controllers.MenuSceneController)
local v_u_12 = require(v_u_2.Controllers.CaseSceneController)
local v_u_13 = require(v_u_2.Controllers.CameraController)
local v_u_14 = require(v_u_2.Controllers.InputController)
local v_u_15 = require(v_u_2.Controllers.DataController)
local v_u_16 = require(v_u_2.Classes.WeaponComponent.Classes.Viewmodel)
local v_u_17 = require(v_u_2.Components.Common.InterfaceAnimations.ActivateButton)
local v_u_18 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_19 = require(v_u_2.Database.Components.Libraries.Collections)
local v20 = require(v_u_2.Components.Common.GetUserPlatform)
local v_u_21 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_22 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_23 = require(v_u_2.Shared.CloseButtonRegistry)
local v_u_24 = require(v_u_2.Database.Security.Router)
local v_u_25 = require(v_u_2.Interface.MenuState)
local v_u_26 = require(v_u_2.Database.Custom.Constants)
local v_u_27 = v8.LocalPlayer
local v_u_28 = v_u_27:WaitForChild("PlayerGui")
local v29 = v20()
local v_u_30 = table.find(v29, "Mobile")
if v_u_30 then
    v_u_30 = #v29 <= 1
end
local v_u_31 = workspace.CurrentCamera
local v_u_32 = nil
local v_u_33 = v_u_2.Assets.Lighting
local v_u_34 = v_u_2.Database.Custom.GameStats.Maps
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = nil
local v_u_41 = nil
local v_u_42 = nil
local v_u_43 = false
local v_u_44 = nil
local v_u_45 = nil
local v_u_46 = nil
local v_u_47 = {}
local v_u_48 = v10.new()
local v_u_49 = "Weapon"
local v_u_50 = false
local v_u_51 = v_u_26.DEFAULT_CAMERA_FOV
local v_u_52 = false
local v_u_53 = Vector2.zero
local v_u_54 = 40
local v_u_55 = 40
local v_u_56 = 0
local v_u_57 = 0
local v_u_58 = 0
local v_u_59 = 0
local v_u_60 = {
    ["WEAPON_NAME_NO_COLLECTION_POSITION"] = UDim2.fromScale(0.5, 0.04),
    ["WEAPON_NAME_NO_COLLECTION_SIZE"] = UDim2.fromScale(0.317, 0.054),
    ["WEAPON_NAME_COLLECTION_POSITION"] = UDim2.fromScale(0.541, 0.03),
    ["WEAPON_NAME_COLLECTION_SIZE"] = UDim2.fromScale(0.243, 0.054),
    ["RARITY_FRAME_NO_COLLECTION_POSITION"] = UDim2.fromScale(0.5, 0.08),
    ["RARITY_FRAME_COLLECTION_POSITION"] = UDim2.fromScale(0.5, 0.143)
}
local v_u_61 = {}
local v_u_62 = nil
local v_u_63 = nil
local v_u_64 = 1
local function v_u_73()
    -- upvalues: (copy) v_u_34, (ref) v_u_41, (copy) v_u_7, (copy) v_u_15, (copy) v_u_27
    local v65 = workspace:FindFirstChild("Map")
    if v65 then
        local v66 = v65:GetAttribute("MapName")
        if v66 and typeof(v66) == "string" then
            local v67 = v_u_34:FindFirstChild(v66)
            if v67 and v67:IsA("ModuleScript") then
                local v68 = require(v67)
                if v68.Lighting then
                    local v69 = v68.Lighting.Properties
                    if v69 then
                        v_u_41 = v69.GlobalShadows
                        v_u_7.Ambient = v69.Ambient
                        v_u_7.Brightness = v69.Brightness
                        v_u_7.ColorShift_Bottom = v69.ColorShift_Bottom
                        v_u_7.ColorShift_Top = v69.ColorShift_Top
                        v_u_7.EnvironmentDiffuseScale = v69.EnvironmentDiffuseScale
                        v_u_7.EnvironmentSpecularScale = v69.EnvironmentSpecularScale
                        v_u_7.GlobalShadows = v69.GlobalShadows
                        v_u_7.OutdoorAmbient = v69.OutdoorAmbient
                        v_u_7.ShadowSoftness = v69.ShadowSoftness
                        v_u_7.ClockTime = v69.ClockTime
                        v_u_7.GeographicLatitude = v69.GeographicLatitude
                        v_u_7.ExposureCompensation = v69.ExposureCompensation
                    end
                    for _, v70 in ipairs(v_u_7:GetChildren()) do
                        if v70.Name ~= "Menu" then
                            v70:Destroy()
                        end
                    end
                    local v71 = v68.Lighting.Assets
                    if v71 then
                        for _, v72 in ipairs(v71:GetChildren()) do
                            v72:Clone().Parent = v_u_7
                        end
                    end
                    if v_u_15.Get(v_u_27, "Settings.Video.Presets.Global Shadows") ~= false then
                        if v_u_41 ~= nil then
                            v_u_7.GlobalShadows = v_u_41
                        end
                    else
                        v_u_7.GlobalShadows = false
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
    else
        return
    end
end
local function v_u_81(p74)
    -- upvalues: (copy) v_u_33, (copy) v_u_34, (ref) v_u_41, (copy) v_u_7, (copy) v_u_15, (copy) v_u_27
    local v75 = v_u_33:FindFirstChild(p74) or v_u_33:FindFirstChild("Menu")
    if v75 then
        local v76 = v_u_34:FindFirstChild(p74)
        if v76 and v76:IsA("ModuleScript") then
            local v77 = require(v76)
            if v77.Lighting and v77.Lighting.Properties then
                local v78 = v77.Lighting.Properties
                v_u_41 = v78.GlobalShadows
                v_u_7.Ambient = v78.Ambient
                v_u_7.Brightness = v78.Brightness
                v_u_7.ColorShift_Bottom = v78.ColorShift_Bottom
                v_u_7.ColorShift_Top = v78.ColorShift_Top
                v_u_7.EnvironmentDiffuseScale = v78.EnvironmentDiffuseScale
                v_u_7.EnvironmentSpecularScale = v78.EnvironmentSpecularScale
                v_u_7.GlobalShadows = v78.GlobalShadows
                v_u_7.OutdoorAmbient = v78.OutdoorAmbient
                v_u_7.ShadowSoftness = v78.ShadowSoftness
                v_u_7.ClockTime = v78.ClockTime
                v_u_7.GeographicLatitude = v78.GeographicLatitude
                v_u_7.ExposureCompensation = v78.ExposureCompensation
            end
        end
        for _, v79 in ipairs(v_u_7:GetChildren()) do
            if v79.Name ~= "Menu" then
                v79:Destroy()
            end
        end
        for _, v80 in ipairs(v75:GetChildren()) do
            v80:Clone().Parent = v_u_7
        end
        if v_u_15.Get(v_u_27, "Settings.Video.Presets.Global Shadows") ~= false then
            if v_u_41 ~= nil then
                v_u_7.GlobalShadows = v_u_41
            end
        else
            v_u_7.GlobalShadows = false
        end
    else
        return
    end
end
local function v_u_86()
    -- upvalues: (ref) v_u_32, (copy) v_u_2
    local v82
    if v_u_32 then
        v82 = v_u_32
    else
        local v83 = v_u_2:FindFirstChild("Assets")
        if v83 then
            v_u_32 = v83:WaitForChild("InspectScenes", 10)
        end
        v82 = v_u_32
    end
    if v82 then
        local v84 = {}
        for _, v85 in ipairs(v82:GetChildren()) do
            if v85:IsA("Model") then
                table.insert(v84, v85)
            end
        end
        if #v84 > 0 then
            return v84[math.random(1, #v84)]
        else
            return nil
        end
    else
        return nil
    end
end
local function v_u_93()
    -- upvalues: (ref) v_u_44, (ref) v_u_46, (ref) v_u_57, (ref) v_u_56, (ref) v_u_38
    if v_u_44 and v_u_46 then
        local v87 = v_u_46:FindFirstChild("WeaponPart")
        if v87 then
            local v88 = CFrame.Angles(0, -1.5707963267948966, 0)
            local v89 = v_u_57
            local v90 = v_u_56
            local v91 = CFrame.Angles(0, math.rad(v89), (math.rad(v90)))
            if v_u_38 then
                local v92 = v_u_44:GetPivot():ToObjectSpace(v_u_38.WorldCFrame)
                v_u_44:PivotTo(v87.CFrame * v91 * v88 * v92:Inverse())
            else
                v_u_44:PivotTo(v87.CFrame * v91 * v88)
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_96()
    -- upvalues: (ref) v_u_61
    local v94 = {}
    for _, v95 in pairs(v_u_61) do
        table.insert(v94, v95)
    end
    if #v94 >= 2 then
        return (v94[1] - v94[2]).Magnitude
    else
        return nil
    end
end
local function v_u_101()
    -- upvalues: (copy) v_u_25, (ref) v_u_43, (copy) v_u_11
    v_u_25.EnterInspect()
    local v97 = v_u_25.GetMenuFrame()
    if v97 then
        v_u_43 = v_u_11.IsActive()
        if v_u_43 then
            v_u_11.HideMenuScene(true)
            v_u_11.SetMusicVolumeMultiplier(0.5, 0.5)
        end
        v_u_25.SetBlurEnabled(false)
        v97.BackgroundTransparency = 1
        local v98 = v97:FindFirstChild("Pattern")
        if v98 then
            v98.Visible = false
        end
        local v99 = v97:FindFirstChild("Top")
        if v99 then
            v99.Visible = false
        end
        for _, v100 in ipairs(v97:GetChildren()) do
            if v100:IsA("Frame") and v100.Name ~= "Top" then
                if v100.Name == "Inspect" or v100.Name == "InspectFrame" then
                    v100.Visible = true
                else
                    v100.Visible = false
                end
            end
        end
    end
end
local function v_u_113()
    -- upvalues: (copy) v_u_25, (copy) v_u_17, (copy) v_u_23, (copy) v_u_1, (copy) v_u_15, (copy) v_u_27, (copy) v_u_24
    local v102 = v_u_25.GetMenuFrame()
    if v102 then
        local v103 = v102:FindFirstChild("Inspect") or v102:FindFirstChild("InspectFrame")
        if v103 then
            local v104 = v103:FindFirstChild("Bottom")
            if v104 then
                local v105 = v104:FindFirstChild("Close")
                if v105 and v105:IsA("GuiButton") then
                    v_u_17(v105)
                    v_u_23.Add(v103, v105, function()
                        -- upvalues: (ref) v_u_1
                        v_u_1.HideInspect()
                    end)
                end
                local v106 = v103:FindFirstChild("MobileButtons")
                if v106 then
                    local v107 = v106:FindFirstChild("Inspect")
                    if v107 and v107:IsA("TextButton") then
                        v_u_17(v107)
                        v107.MouseButton1Click:Connect(function()
                            -- upvalues: (ref) v_u_1
                            v_u_1.PlayInspectAnimation()
                        end)
                        local v108 = v_u_15.Get(v_u_27, "MobileButtons")
                        if v108 and v108.Inspect then
                            local v109 = v108.Inspect
                            if v109.Position and v109.Size then
                                v107.Position = UDim2.fromScale(v109.Position.X, v109.Position.Y)
                                v107.Size = UDim2.fromScale(v109.Size.X, v109.Size.Y)
                            end
                        end
                    end
                    v106.Visible = false
                end
                local v110 = v104:FindFirstChild("Charm")
                if v110 then
                    local v111 = v110:FindFirstChild("Next")
                    if v111 and v111:IsA("GuiButton") then
                        v_u_17(v111)
                        v111.MouseButton1Click:Connect(function()
                            -- upvalues: (ref) v_u_1
                            v_u_1.CycleCharmPosition()
                        end)
                    end
                    local v112 = v110:FindFirstChild("Confirm")
                    if v112 and v112:IsA("GuiButton") then
                        v_u_17(v112)
                        v112.MouseButton1Click:Connect(function()
                            -- upvalues: (ref) v_u_24
                            v_u_24.broadcastRouter("ConfirmCharmAttachment")
                        end)
                    end
                end
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_119()
    -- upvalues: (copy) v_u_25, (ref) v_u_50, (ref) v_u_49, (copy) v_u_30
    local v114 = v_u_25.GetMenuFrame()
    if v114 then
        local v115 = v114:FindFirstChild("Inspect") or v114:FindFirstChild("InspectFrame")
        if v115 then
            local v116 = v115:FindFirstChild("MobileButtons")
            if v116 then
                local v117 = v116:FindFirstChild("Inspect")
                if v117 then
                    local v118 = v_u_50
                    if v118 then
                        if v_u_49 == "Viewmodel" then
                            v118 = v_u_30
                        else
                            v118 = false
                        end
                    end
                    v116.Visible = v118
                    v117.Visible = v118
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
end
local function v_u_124()
    -- upvalues: (copy) v_u_25, (copy) v_u_24
    local v120 = v_u_25.GetMenuFrame()
    if v120 then
        local v121 = v120:FindFirstChild("Inspect") or v120:FindFirstChild("InspectFrame")
        if v121 then
            local v122 = v121:FindFirstChild("Bottom")
            if v122 then
                local v123 = v122:FindFirstChild("Charm")
                if v123 then
                    v123.Visible = v_u_24.broadcastRouter("HasPendingCharmAttachment") or false
                end
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_128(p125)
    -- upvalues: (copy) v_u_18
    if p125.Type == "Weapon" or (p125.Type == "Melee" or p125.Type == "Glove") then
        return true
    end
    if p125.Name then
        local v126, v127 = pcall(v_u_18, p125.Name)
        if v126 and (v127 and v127.Class) then
            return (v127.Class == "Weapon" or v127.Class == "Melee") and true or v127.Class == "Glove"
        end
    end
    return false
end
local function v_u_133()
    -- upvalues: (ref) v_u_35, (ref) v_u_36, (ref) v_u_37
    if v_u_35 then
        if v_u_35.IsPlaying then
            v_u_35:Stop(0)
        end
        v_u_35:Destroy()
        v_u_35 = nil
    end
    if v_u_36 then
        v_u_36:Destroy()
        v_u_36 = nil
    end
    if v_u_37 and v_u_37.Animation then
        local v_u_129 = v_u_37.Animation.Animator
        if v_u_129 then
            local v_u_130 = Instance.new("Animation")
            v_u_130.AnimationId = "rbxassetid://135926544677482"
            local v131, v132 = pcall(function()
                -- upvalues: (copy) v_u_129, (copy) v_u_130
                return v_u_129:LoadAnimation(v_u_130)
            end)
            if v131 and v132 then
                v_u_36 = v_u_130
                v_u_35 = v132
                if v_u_35 then
                    if v_u_37 and v_u_37.Animation then
                        v_u_37.Animation:stopAnimations()
                    end
                    if v_u_35.IsPlaying then
                        v_u_35:Stop(0)
                    end
                    v_u_35.TimePosition = 0
                    v_u_35:Play(0, 1, 1)
                end
            else
                v_u_130:Destroy()
                return
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_138(p134, p135)
    -- upvalues: (copy) v_u_21
    local v136 = (not p135 or (p135 == "" or not p135)) and "Vanilla" or p135
    if v_u_21.GetSkinInformation(p134, v136) then
        return v136
    elseif v_u_21.GetSkinInformation(p134, "Vanilla") then
        return "Vanilla"
    elseif v_u_21.GetSkinInformation(p134, "Default") then
        return "Default"
    else
        local v137 = v_u_21.GetAllSkinsForWeapon(p134)
        if v137 and (v137[1] and v137[1].skin) then
            return v137[1].skin
        else
            return v136
        end
    end
end
local function v_u_141()
    -- upvalues: (copy) v_u_21
    for _, v139 in ipairs({
        "FAMAS",
        "AK-47",
        "M4A1-S",
        "Glock-18",
        "USP-S"
    }) do
        local v140 = v_u_21.GetBaseWeaponModel(v139, "Camera")
        if v140 then
            v140:Destroy()
            return v139
        end
    end
    return "FAMAS"
end
local function v_u_148(p142)
    if p142 and p142.Model then
        local v143 = p142.Model:FindFirstChild("Stats")
        if v143 then
            local v144 = v143:FindFirstChild("Default")
            if v144 then
                local v145 = v144.Value
                if typeof(v145) == "Vector3" then
                    local v146 = v145.Y
                    local v147 = v145.Z
                    v144.Value = Vector3.new(0.05, v146, v147)
                end
            end
        end
    else
        return
    end
end
local function v_u_165(p149)
    -- upvalues: (ref) v_u_46, (copy) v_u_21, (ref) v_u_44, (ref) v_u_38
    if v_u_46 then
        local v150 = v_u_46:FindFirstChild("WeaponPart")
        if v150 then
            local v151 = nil
            local v152 = p149.Type == "Glove"
            local v153 = p149.Type == "Charm"
            local v154 = p149.Type == "Badge"
            if v152 then
                local v155 = v_u_21.GetGloves(p149.Name, p149.Skin, p149.Float)
                if v155 then
                    if v155:IsA("BasePart") then
                        v151 = Instance.new("Model")
                        v151.Name = p149.Name
                        v155.Parent = v151
                        v151.PrimaryPart = v155
                    else
                        v151 = v155
                    end
                end
            elseif v153 then
                v151 = v_u_21.GetCharmModel(p149.Skin, p149.Pattern or 1) or v151
            elseif v154 then
                v151 = v_u_21.GetBadgeModel(p149.Skin) or v151
            else
                v151 = v_u_21.GetCharacterModel(p149.Name, p149.Skin, p149.Float, p149.StatTrack, p149.NameTag, p149.Charm, p149.Stickers)
            end
            if v151 then
                v151.Name = "InspectWeapon"
                v_u_44 = v151
                v_u_38 = v151:FindFirstChild("InspectPivot", true)
                if v_u_38 then
                    warn((("[InspectController]: Found InspectPivot at %*"):format((v_u_38:GetFullName()))))
                else
                    warn((("[InspectController]: No InspectPivot found for %*"):format(p149.Name)))
                end
                local v156 = v151:FindFirstChild("CharmBase", true)
                for _, v157 in ipairs(v151:GetDescendants()) do
                    if v157:IsA("BasePart") then
                        local v158
                        if v156 then
                            v158 = v157:IsDescendantOf(v156)
                        else
                            v158 = v156
                        end
                        v157.CastShadow = false
                        if v153 then
                            if v151.PrimaryPart == v157 then
                                v157.CanCollide = false
                                v157.CanQuery = false
                                v157.CanTouch = false
                                v157.Anchored = true
                            else
                                v157.CanCollide = false
                                v157.CanQuery = false
                                v157.CanTouch = false
                                v157.Anchored = false
                            end
                        elseif v158 then
                            v157.Anchored = false
                        else
                            v157.CanCollide = v157:IsA("MeshPart") and true or false
                            v157.CanQuery = false
                            v157.CanTouch = false
                            v157.Anchored = true
                        end
                    end
                end
                if v152 and (p149.Name == "T Glove" or p149.Name == "CT Glove") then
                    local v159 = {}
                    for _, v160 in ipairs(v151:GetChildren()) do
                        if v160:IsA("BasePart") then
                            table.insert(v159, v160)
                        end
                    end
                    if #v159 >= 2 then
                        local v161 = v151:FindFirstChild("RightGlove") or v159[1]
                        for _, v162 in ipairs(v159) do
                            if v162 ~= v161 then
                                v162:Destroy()
                            end
                        end
                    end
                end
                v151.Parent = v_u_46
                local v163 = CFrame.Angles(0, -1.5707963267948966, 0)
                if v_u_38 then
                    local v164 = v151:GetPivot():ToObjectSpace(v_u_38.WorldCFrame)
                    v151:PivotTo(v150.CFrame * v163 * v164:Inverse())
                else
                    v151:PivotTo(v150.CFrame * v163)
                end
            else
                warn(("[InspectController]: Failed to get model for \"%*\""):format(p149.Name), p149)
                return
            end
        else
            warn("[InspectController]: Inspect scene missing WeaponPart")
            return
        end
    else
        return
    end
end
local function v_u_187(p_u_166)
    -- upvalues: (ref) v_u_35, (ref) v_u_36, (ref) v_u_37, (ref) v_u_40, (copy) v_u_14, (copy) v_u_27, (copy) v_u_18, (copy) v_u_11, (copy) v_u_9, (copy) v_u_24, (ref) v_u_64, (copy) v_u_141, (copy) v_u_138, (copy) v_u_16, (copy) v_u_31, (copy) v_u_148, (copy) v_u_133
    if v_u_35 then
        if v_u_35.IsPlaying then
            v_u_35:Stop(0)
        end
        v_u_35:Destroy()
        v_u_35 = nil
    end
    if v_u_36 then
        v_u_36:Destroy()
        v_u_36 = nil
    end
    if v_u_37 then
        v_u_37:destroy()
        v_u_37 = nil
    end
    if v_u_40 then
        v_u_40:Destroy()
        v_u_40 = nil
    end
    v_u_14.enableGroup("Gameplay")
    local v167 = v_u_27:GetAttribute("Team") == "Counter-Terrorists" and "CT" or "T"
    local v168
    if p_u_166 then
        if p_u_166.Type == "Glove" then
            v168 = true
        elseif p_u_166.Name then
            local v169, v170 = pcall(v_u_18, p_u_166.Name)
            if v169 and (v170 and v170.Class) then
                v168 = v170.Class == "Glove"
            else
                v168 = false
            end
        else
            v168 = false
        end
    else
        v168 = false
    end
    local v171 = v_u_11.CreateStandaloneCharacter(v167)
    if v171 then
        if v168 then
            local v172 = {
                ["Name"] = p_u_166.Name,
                ["Skin"] = p_u_166.Skin,
                ["Float"] = p_u_166.Float
            }
            if p_u_166._id and p_u_166._id ~= "" then
                v172.SkinIdentifier = p_u_166._id
            end
            v171:SetAttribute("EquippedGloves", v_u_9:JSONEncode(v172))
        end
        v_u_40 = v171
        local v173 = p_u_166.Charm
        if v_u_24.broadcastRouter("HasPendingCharmAttachment") and type(v173) == "table" then
            v173 = {
                ["_id"] = v173._id
            }
            local v174 = v_u_64
            v173.Position = tostring(v174)
        end
        local v_u_175 = {
            ["Player"] = v_u_27,
            ["Character"] = v171,
            ["StatTrack"] = p_u_166.StatTrack,
            ["Stickers"] = p_u_166.Stickers,
            ["NameTag"] = p_u_166.NameTag,
            ["Float"] = p_u_166.Float,
            ["Charm"] = v173
        }
        local v176 = p_u_166.Name
        local v177 = p_u_166.Skin
        local v178 = false
        local v_u_179
        if v168 then
            v176 = v_u_141()
            v178 = true
            v_u_179 = "Stock"
        else
            v_u_179 = v_u_138(v176, v177)
        end
        v_u_175.ViewmodelCameraWeapon = v176
        v_u_175.ViewmodelHideWeaponGeometry = v178
        local v180, v181 = pcall(function()
            -- upvalues: (ref) v_u_16, (copy) v_u_175, (copy) p_u_166, (copy) v_u_179
            return v_u_16.new(v_u_175, p_u_166.Name, v_u_179)
        end)
        local v182
        if v180 and v181 then
            v182 = nil
        else
            v182 = v181
            v181 = nil
        end
        if v181 then
            v_u_37 = v181
            if v_u_37 then
                v_u_37:equip(v168)
                if v_u_37.Model then
                    if v_u_37.Model.Parent ~= v_u_31 then
                        v_u_37.Model.Parent = v_u_31
                    end
                    if v_u_37.Hidden then
                        v_u_37:unhide()
                    end
                    if v168 then
                        v_u_148(v_u_37)
                    end
                    if v168 then
                        v_u_133()
                    end
                    task.defer(function()
                        -- upvalues: (ref) v_u_37
                        if v_u_37 and v_u_37.Model then
                            for _, v183 in ipairs(v_u_37.Model:GetDescendants()) do
                                if v183:IsA("BasePart") then
                                    v183.CastShadow = false
                                    if v183.Name ~= "HumanoidRootPart" and (v183.Name ~= "ViewmodelLight" and (v183.Name ~= "MuzzlePart" and v183.Name ~= "MuzzlePartL")) and v183.Name ~= "MuzzlePartR" then
                                        local v184 = v183:GetAttribute("HiddenTransparency")
                                        if v184 == nil then
                                            v184 = nil
                                        else
                                            v183:SetAttribute("HiddenTransparency", nil)
                                        end
                                        local v185
                                        if v184 == nil then
                                            v185 = v183:GetAttribute("_CaseScenePrevTransparency")
                                            if v185 == nil then
                                                v185 = v184
                                            else
                                                v183:SetAttribute("_CaseScenePrevTransparency", nil)
                                            end
                                        else
                                            v185 = v184
                                        end
                                        local v186
                                        if v185 == nil then
                                            v186 = v183:GetAttribute("_InspectPrevTransparency")
                                            if v186 == nil then
                                                v186 = v185
                                            else
                                                v183:SetAttribute("_InspectPrevTransparency", nil)
                                            end
                                        else
                                            v186 = v185
                                        end
                                        if v186 == nil then
                                            if v183.Transparency >= 1 and (v183.Name == "Right Arm" or v183.Name == "Left Arm") then
                                                v183.Transparency = 0
                                            end
                                        else
                                            v183.Transparency = v186
                                        end
                                    end
                                elseif v183:IsA("SurfaceGui") then
                                    if v183:GetAttribute("_InspectPrevSurfaceGuiEnabled") then
                                        v183.Enabled = true
                                        v183:SetAttribute("_InspectPrevSurfaceGuiEnabled", nil)
                                    end
                                    if v183:GetAttribute("_CaseScenePrevSurfaceGuiEnabled") then
                                        v183.Enabled = true
                                        v183:SetAttribute("_CaseScenePrevSurfaceGuiEnabled", nil)
                                    end
                                    if not v183.Enabled then
                                        v183.Enabled = true
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        else
            warn(("[InspectController]: Failed to create viewmodel (%* | %*)"):format(v176, v_u_179), v182)
            if v_u_35 then
                if v_u_35.IsPlaying then
                    v_u_35:Stop(0)
                end
                v_u_35:Destroy()
                v_u_35 = nil
            end
            if v_u_36 then
                v_u_36:Destroy()
                v_u_36 = nil
            end
            if v_u_37 then
                v_u_37:destroy()
                v_u_37 = nil
            end
            if v_u_40 then
                v_u_40:Destroy()
                v_u_40 = nil
            end
            v_u_14.enableGroup("Gameplay")
        end
    else
        warn("[InspectController]: Failed to create standalone character for viewmodel")
        return
    end
end
local function v_u_194(p188)
    -- upvalues: (ref) v_u_39, (copy) v_u_18, (ref) v_u_49, (ref) v_u_44, (ref) v_u_38, (ref) v_u_35, (ref) v_u_36, (ref) v_u_37, (ref) v_u_40, (copy) v_u_14, (copy) v_u_119, (copy) v_u_165, (ref) v_u_55, (copy) v_u_187, (copy) v_u_51
    local v189 = v_u_39
    if v189 then
        local v190
        if v189 then
            if v189.Type == "Glove" then
                v190 = true
            elseif v189.Name then
                local v191, v192 = pcall(v_u_18, v189.Name)
                if v191 and (v192 and v192.Class) then
                    v190 = v192.Class == "Glove"
                else
                    v190 = false
                end
            else
                v190 = false
            end
        else
            v190 = false
        end
        local v193 = v190 and p188 == "Weapon" and "Viewmodel" or p188
        if v_u_49 == v193 then
            return
        else
            if v_u_49 == "Weapon" then
                if v_u_44 then
                    v_u_44:Destroy()
                    v_u_44 = nil
                end
                v_u_38 = nil
            elseif v_u_49 == "Viewmodel" then
                if v_u_35 then
                    if v_u_35.IsPlaying then
                        v_u_35:Stop(0)
                    end
                    v_u_35:Destroy()
                    v_u_35 = nil
                end
                if v_u_36 then
                    v_u_36:Destroy()
                    v_u_36 = nil
                end
                if v_u_37 then
                    v_u_37:destroy()
                    v_u_37 = nil
                end
                if v_u_40 then
                    v_u_40:Destroy()
                    v_u_40 = nil
                end
                v_u_14.enableGroup("Gameplay")
            end
            v_u_49 = v193
            v_u_119()
            if v193 == "Weapon" then
                v_u_165(v189)
                v_u_55 = 40
                v_u_14.enableGroup("Gameplay")
            elseif v193 == "Viewmodel" then
                v_u_14.disableGroup("Gameplay")
                v_u_187(v189)
                v_u_55 = v_u_51
            end
        end
    else
        return
    end
end
local function v_u_208(p195, p196, p197)
    -- upvalues: (ref) v_u_49, (copy) v_u_5
    local v198 = p196:FindFirstChild("HoverFrame")
    local v199 = p196:FindFirstChild("SelectFrame")
    local v200 = p196:FindFirstChild("ImageLabel")
    local v201
    if v_u_49 == p195 then
        v201 = p195 ~= "Info"
    else
        v201 = false
    end
    if v201 then
        local v202 = {
            ["BackgroundTransparency"] = 1
        }
        if v198 then
            v_u_5:Create(v198, TweenInfo.new(0.2), v202):Play()
        end
        local v203 = {
            ["BackgroundTransparency"] = 0
        }
        if v199 then
            v_u_5:Create(v199, TweenInfo.new(0.2), v203):Play()
        end
        if v200 then
            local v204 = {
                ["ImageColor3"] = Color3.fromRGB(0, 0, 0)
            }
            if v200 then
                v_u_5:Create(v200, TweenInfo.new(0.2), v204):Play()
                return
            end
        end
    else
        local v205 = {
            ["BackgroundTransparency"] = 1
        }
        if v199 then
            v_u_5:Create(v199, TweenInfo.new(0.2), v205):Play()
        end
        if v200 then
            local v206 = {
                ["ImageColor3"] = Color3.fromRGB(255, 255, 255)
            }
            if v200 then
                v_u_5:Create(v200, TweenInfo.new(0.2), v206):Play()
            end
        end
        local v207 = {
            ["BackgroundTransparency"] = p197 and 0 or 1
        }
        if v198 then
            v_u_5:Create(v198, TweenInfo.new(0.2), v207):Play()
        end
    end
end
local function v_u_213(p209, p210)
    -- upvalues: (copy) v_u_208
    for v211, v212 in pairs(p209) do
        if v212 and v212:IsA("GuiButton") then
            v_u_208(v211, v212, v211 == p210)
        end
    end
end
local function v_u_224(p214, p215)
    -- upvalues: (copy) v_u_31, (copy) v_u_6
    local v216 = v_u_31.ViewportSize.Y * 0.025
    local v217 = math.floor(v216)
    local v218 = math.min(v217, 32)
    local v219 = math.max(8, v218)
    local v220 = Enum.Font.Gotham
    local v221 = 0
    for _, v222 in ipairs(p215) do
        if v222 and (v222:IsA("TextLabel") and v222.Text ~= "") then
            v222.TextScaled = false
            local v223 = v_u_6:GetTextSize(v222.Text:gsub("<[^>]*>", ""), v219, v220, Vector2.new((1 / 0), (1 / 0)))
            if v221 < v223.X then
                v221 = v223.X
            end
            v222.TextSize = v219
            v222.TextWrapped = false
        end
    end
    if v221 > 0 then
        p214.Size = UDim2.new(0.05, v221, p214.Size.Y.Scale, p214.Size.Y.Offset)
    end
end
local function v_u_248(p225, p226, p227)
    -- upvalues: (copy) v_u_21, (copy) v_u_224
    local v_u_228 = p225:FindFirstChild("Information")
    if v_u_228 then
        if p227 then
            local v229 = v_u_228.Parent.AbsolutePosition.X
            local v230 = p227.AbsolutePosition.X + p227.AbsoluteSize.X / 2 - v229
            v_u_228.Position = UDim2.new(0, v230 + v_u_228.AbsoluteSize.X / 2, v_u_228.Position.Y.Scale, v_u_228.Position.Y.Offset)
        end
        v_u_228.Visible = true
        local v231 = v_u_21.GetSkinInformation(p226.Name, p226.Skin)
        local v232 = "Factory New"
        if v231 then
            v232 = v_u_21.GetWearNameForFloat(v231, p226.Float or 0) or v232
        end
        local v233 = p226.Type == "Charm"
        local v_u_234 = v_u_228:FindFirstChild("Exterior")
        if v_u_234 then
            if v233 then
                v_u_234.Visible = false
            else
                v_u_234.Visible = true
                v_u_234.RichText = true
                v_u_234.Text = ("<b><font color=\"rgb(175,175,175)\">Exterior</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format(v232)
            end
        end
        local v_u_235 = v_u_228:FindFirstChild("Tradeable")
        if v_u_235 then
            v_u_235.RichText = true
            v_u_235.Text = ("<b><font color=\"rgb(175,175,175)\">Tradeable</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format(p226.IsTradeable and "Yes" or "No")
        end
        local v_u_236 = v_u_228:FindFirstChild("Serial")
        if v_u_236 then
            v_u_236.RichText = true
            local v237
            if p226.Serial then
                local v238 = p226.Serial
                v237 = "#" .. tostring(v238)
            else
                v237 = "N/A"
            end
            v_u_236.Text = ("<b><font color=\"rgb(175,175,175)\">Serial</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format(v237)
        end
        local v_u_239 = v_u_228:FindFirstChild("Pattern")
        if v_u_239 then
            if p226.Type == "Charm" then
                v_u_239.Visible = true
                v_u_239.RichText = true
                local v240 = p226.Pattern or 0
                v_u_239.Text = ("<b><font color=\"rgb(175,175,175)\">Pattern</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format((tostring(v240)))
            else
                v_u_239.Visible = false
            end
        end
        local v_u_241 = v_u_228:FindFirstChild("Float")
        if v_u_241 then
            if v233 then
                v_u_241.Visible = false
            else
                v_u_241.Visible = true
                v_u_241.RichText = true
                v_u_241.Text = ("<b><font color=\"rgb(175,175,175)\">Float</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format((string.format("%.14f", p226.Float or 0)))
            end
        end
        task.defer(function()
            -- upvalues: (copy) v_u_234, (copy) v_u_235, (copy) v_u_236, (copy) v_u_239, (copy) v_u_241, (ref) v_u_224, (copy) v_u_228
            local v242 = {}
            if v_u_234 and v_u_234.Visible then
                local v243 = v_u_234
                table.insert(v242, v243)
            end
            if v_u_235 then
                local v244 = v_u_235
                table.insert(v242, v244)
            end
            if v_u_236 then
                local v245 = v_u_236
                table.insert(v242, v245)
            end
            if v_u_239 and v_u_239.Visible then
                local v246 = v_u_239
                table.insert(v242, v246)
            end
            if v_u_241 and v_u_241.Visible then
                local v247 = v_u_241
                table.insert(v242, v247)
            end
            v_u_224(v_u_228, v242)
        end)
    end
end
local function v_u_253()
    -- upvalues: (copy) v_u_25, (copy) v_u_28
    if v_u_25.IsCaseSceneActive() then
        return true
    end
    if v_u_25.GetScreenBeforeCaseScene() == "Store" then
        return true
    end
    if v_u_25.GetCurrentScreen() == "Store" then
        return true
    end
    local v249 = v_u_28:FindFirstChild("MainGui")
    if v249 then
        local v250 = v249:FindFirstChild("Menu")
        local v251 = v250 and v250:FindFirstChild("Store")
        if v251 then
            local v252 = v251:FindFirstChild("CaseContent")
            if v252 and v252:GetAttribute("WasVisibleBeforeInspect") == true then
                return true
            end
        end
    end
    return false
end
local function v_u_259(p_u_254, p_u_255, p_u_256, p_u_257)
    -- upvalues: (copy) v_u_48, (copy) v_u_208, (ref) v_u_39, (copy) v_u_253, (copy) v_u_248, (ref) v_u_49, (copy) v_u_194, (copy) v_u_213
    v_u_48:Add(p_u_254.MouseEnter:Connect(function()
        -- upvalues: (ref) v_u_208, (copy) p_u_255, (copy) p_u_254, (copy) p_u_257, (ref) v_u_39, (ref) v_u_253, (ref) v_u_248
        v_u_208(p_u_255, p_u_254, true)
        if p_u_255 == "Info" and (p_u_257 and v_u_39) and (not v_u_253() and v_u_39.Type ~= "Badge") then
            v_u_248(p_u_257, v_u_39, p_u_254)
        end
    end), "Disconnect", "InspectButton_Enter_" .. p_u_255)
    v_u_48:Add(p_u_254.MouseLeave:Connect(function()
        -- upvalues: (ref) v_u_208, (copy) p_u_255, (copy) p_u_254, (copy) p_u_257
        v_u_208(p_u_255, p_u_254, false)
        local v258 = p_u_255 == "Info" and (p_u_257 and p_u_257:FindFirstChild("Information"))
        if v258 then
            v258.Visible = false
        end
    end), "Disconnect", "InspectButton_Leave_" .. p_u_255)
    if p_u_255 == "Info" then
        v_u_48:Add(p_u_254.Activated:Connect(function()
            -- upvalues: (copy) p_u_257, (ref) v_u_39, (ref) v_u_253, (ref) v_u_248, (copy) p_u_254
            if p_u_257 and (v_u_39 and (not v_u_253() and v_u_39.Type ~= "Badge")) then
                v_u_248(p_u_257, v_u_39, p_u_254)
            end
        end), "Disconnect", "InspectButton_Activated_Info")
    else
        v_u_48:Add(p_u_254.MouseButton1Click:Connect(function()
            -- upvalues: (ref) v_u_49, (copy) p_u_255, (ref) v_u_194, (ref) v_u_213, (copy) p_u_256
            if v_u_49 ~= p_u_255 then
                v_u_194(p_u_255)
                v_u_213(p_u_256, p_u_255)
            end
        end), "Disconnect", "InspectButton_Click_" .. p_u_255)
    end
end
local function v_u_274(p260, p261)
    -- upvalues: (copy) v_u_128, (copy) v_u_18, (copy) v_u_253, (copy) v_u_208, (copy) v_u_259
    local v262 = p260:FindFirstChild("Bottom")
    if v262 then
        v262 = v262:FindFirstChild("Frame")
    end
    if v262 then
        local v263 = v_u_128(p261)
        local v264
        if p261 then
            if p261.Type == "Glove" then
                v264 = true
            elseif p261.Name then
                local v265, v266 = pcall(v_u_18, p261.Name)
                if v265 and (v266 and v266.Class) then
                    v264 = v266.Class == "Glove"
                else
                    v264 = false
                end
            else
                v264 = false
            end
        else
            v264 = false
        end
        local v267 = {
            ["Info"] = v262:FindFirstChild("Info"),
            ["Viewmodel"] = v262:FindFirstChild("Viewmodel"),
            ["Weapon"] = v262:FindFirstChild("Weapon")
        }
        local v268 = v_u_253()
        local v269 = p261.Type == "Badge"
        for v270, v271 in pairs(v267) do
            if v271 and v271:IsA("GuiButton") then
                if v270 == "Info" then
                    local v272 = not v268
                    if v272 then
                        v272 = not v269
                    end
                    v271.Visible = v272
                elseif v270 == "Weapon" then
                    local v273
                    if v263 then
                        v273 = not v264
                    else
                        v273 = v263
                    end
                    v271.Visible = v273
                else
                    v271.Visible = v263
                end
                v_u_208(v270, v271, false)
                v_u_259(v271, v270, v267, p260)
            end
        end
    end
end
local function v_u_283(p275, p276)
    -- upvalues: (copy) v_u_19, (copy) v_u_60
    if p276 then
        p276 = p276.collection
    end
    local v277
    if p276 then
        v277 = v_u_19.GetCollectionByName(p276)
    else
        v277 = p276
    end
    local v278 = v277 ~= nil
    local v279 = p275:FindFirstChild("CollectionName")
    if v279 and v279:IsA("TextLabel") then
        v279.Visible = v278
        v279.Text = p276 or ""
    end
    local v280 = p275:FindFirstChild("CollectionIcon")
    if v280 and v280:IsA("ImageLabel") then
        v280.Image = v277 and v277.imageAssetId or ""
        v280.Visible = v278
    end
    local v281 = p275:FindFirstChild("WeaponName")
    if v281 and v281:IsA("TextLabel") then
        v281.Position = v278 and v_u_60.WEAPON_NAME_COLLECTION_POSITION or v_u_60.WEAPON_NAME_NO_COLLECTION_POSITION
        v281.Size = v278 and v_u_60.WEAPON_NAME_COLLECTION_SIZE or v_u_60.WEAPON_NAME_NO_COLLECTION_SIZE
        v281.TextXAlignment = v278 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center
    end
    local v282 = p275:FindFirstChild("Rarity")
    if v282 and v282:IsA("Frame") then
        v282.Position = v278 and v_u_60.RARITY_FRAME_COLLECTION_POSITION or v_u_60.RARITY_FRAME_NO_COLLECTION_POSITION
    end
end
local function v_u_305(p284)
    -- upvalues: (copy) v_u_28, (copy) v_u_274, (copy) v_u_253, (copy) v_u_21, (copy) v_u_283, (copy) v_u_22
    local v285 = v_u_28:FindFirstChild("MainGui")
    if v285 then
        local v286 = v285:FindFirstChild("Menu")
        if v286 then
            local v287 = v286:FindFirstChild("Inspect") or v286:FindFirstChild("InspectFrame")
            if v287 then
                v_u_274(v287, p284)
                local v288 = v_u_253() and v287:FindFirstChild("Information")
                if v288 then
                    v288.Visible = false
                end
                local v289 = v_u_21.GetSkinInformation(p284.Name, p284.Skin)
                local v290 = v287:FindFirstChild("WeaponName")
                if v290 and v290:IsA("TextLabel") then
                    local v291 = v289 and v289.type == "Melee" and "\226\152\133 " or ""
                    local v292 = " | " .. p284.Skin
                    local v293 = v292 and v292 == "Vanilla" and "" or v292
                    v290.Text = v291 .. p284.Name .. v293
                end
                if v289 then
                    v_u_283(v287, v289)
                    local v294 = v287:FindFirstChild("Rarity")
                    local v295 = v294 and (v294:IsA("Frame") and v289.rarity) and v_u_22[v289.rarity]
                    if v295 then
                        v294.BackgroundColor3 = v295.Color
                    end
                end
                local v296 = v287:FindFirstChild("Description")
                if v296 then
                    local v297 = p284.StatTrack
                    local v298 = typeof(v297) == "number" and true or p284.StatTrack == true
                    local v299 = v296:FindFirstChild("Top")
                    if v299 then
                        v299.Visible = v298
                    end
                    local v300 = v296:FindFirstChild("Middle")
                    if v300 then
                        v300.Visible = v298
                        local v301 = v298 and v300:FindFirstChild("KillTrack")
                        if v301 then
                            local v302 = p284.StatTrack
                            v301.Text = ("KillTrack\226\132\162 Confirmed Kills: %*"):format(typeof(v302) ~= "number" and 0 or p284.StatTrack)
                        end
                    end
                    local v303 = v296:FindFirstChild("Bottom")
                    if v303 then
                        local v304 = v303:FindFirstChild("Description")
                        if v304 and v289 then
                            v304.Text = v289.description or ""
                        end
                    end
                end
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_309()
    -- upvalues: (ref) v_u_47, (copy) v_u_31, (ref) v_u_37
    v_u_47 = {}
    for _, v306 in ipairs(v_u_31:GetChildren()) do
        if v306:IsA("Model") and (v306.Name ~= "InspectScene" and (not v_u_37 or v_u_37.Model ~= v306)) then
            for _, v307 in ipairs(v306:GetDescendants()) do
                if v307:IsA("BasePart") then
                    if v307.Transparency < 1 then
                        v307:SetAttribute("_InspectPrevTransparency", v307.Transparency)
                        v307.Transparency = 1
                    end
                elseif v307:IsA("SurfaceGui") then
                    if v307.Enabled then
                        v307:SetAttribute("_InspectPrevSurfaceGuiEnabled", true)
                        v307.Enabled = false
                    end
                elseif v307:IsA("Texture") and v307.Transparency < 1 then
                    v307:SetAttribute("_InspectPrevTransparency", v307.Transparency)
                    v307.Transparency = 1
                end
            end
            local v308 = v_u_47
            table.insert(v308, v306)
        end
    end
end
local function v_u_314()
    -- upvalues: (ref) v_u_47
    for _, v310 in ipairs(v_u_47) do
        if v310 and v310.Parent then
            for _, v311 in ipairs(v310:GetDescendants()) do
                if v311:IsA("BasePart") then
                    local v312 = v311:GetAttribute("_InspectPrevTransparency")
                    if v312 ~= nil then
                        v311.Transparency = v312
                        v311:SetAttribute("_InspectPrevTransparency", nil)
                    end
                elseif v311:IsA("SurfaceGui") then
                    if v311:GetAttribute("_InspectPrevSurfaceGuiEnabled") ~= nil then
                        v311.Enabled = true
                        v311:SetAttribute("_InspectPrevSurfaceGuiEnabled", nil)
                    end
                elseif v311:IsA("Texture") then
                    local v313 = v311:GetAttribute("_InspectPrevTransparency")
                    if v313 == nil then
                        v311.Transparency = 0.3
                    else
                        v311.Transparency = v313
                        v311:SetAttribute("_InspectPrevTransparency", nil)
                    end
                end
            end
        end
    end
    v_u_47 = {}
end
local function v_u_329()
    -- upvalues: (copy) v_u_25, (ref) v_u_43, (copy) v_u_11
    local v315 = v_u_25.GetMenuFrame()
    if v315 and v315.Visible then
        local v316 = v315:FindFirstChild("Inspect") or v315:FindFirstChild("InspectFrame")
        if v316 and v316:IsA("GuiObject") then
            local v317 = v316:FindFirstChild("MobileButtons")
            v316.Visible = false
            if v317 then
                v317.Visible = false
            end
        end
        local v318 = v_u_25.GetScreenBeforeInspect()
        local v319 = v_u_43
        v_u_43 = false
        v_u_25.ExitInspect()
        if v319 then
            v_u_11.ShowMenuScene()
            v_u_11.SetMusicVolumeMultiplier(1, 0.5)
        end
        local v320 = v315:FindFirstChild("Top")
        if v320 then
            v320.Visible = true
        end
        if v318 then
            local v321 = v315:FindFirstChild(v318)
            if v321 then
                for _, v322 in ipairs(v315:GetChildren()) do
                    if v322:IsA("Frame") and (v322.Name ~= "Top" and (v322.Name ~= v318 and (v322.Name ~= "Inspect" and v322.Name ~= "InspectFrame"))) then
                        v322.Visible = false
                    end
                end
                v321.Visible = true
                if v_u_25.IsCaseSceneActive() and v318 == "Store" then
                    v_u_25.SetBlurEnabled(false)
                    v315.BackgroundTransparency = 1
                    local v323 = v315:FindFirstChild("Pattern")
                    if v323 then
                        v323.Visible = false
                        return
                    end
                else
                    local v324
                    if v318 == "Dashboard" then
                        v324 = false
                    else
                        v324 = v318 ~= "Play"
                    end
                    v_u_25.SetBlurEnabled(v324)
                    v315.BackgroundTransparency = v324 and 0.15 or 1
                    local v325 = v315:FindFirstChild("Pattern")
                    if v325 then
                        v325.Visible = not v324
                        return
                    end
                end
            end
        else
            for _, v326 in ipairs(v315:GetChildren()) do
                if v326:IsA("Frame") and (v326.Name ~= "Top" and (v326.Name ~= "Dashboard" and (v326.Name ~= "Inspect" and v326.Name ~= "InspectFrame"))) then
                    v326.Visible = false
                end
            end
            local v327 = v315:FindFirstChild("Dashboard")
            if v327 then
                v327.Visible = true
            end
            v_u_25.SetBlurEnabled(false)
            v315.BackgroundTransparency = 1
            local v328 = v315:FindFirstChild("Pattern")
            if v328 then
                v328.Visible = true
            end
        end
    else
        v_u_43 = false
        v_u_25.ExitInspect()
    end
end
function v_u_1.ShowInspect(p330)
    -- upvalues: (ref) v_u_50, (copy) v_u_1, (copy) v_u_24, (ref) v_u_63, (ref) v_u_64, (ref) v_u_39, (ref) v_u_49, (copy) v_u_18, (copy) v_u_101, (copy) v_u_309, (copy) v_u_124, (copy) v_u_305, (ref) v_u_42, (copy) v_u_329, (ref) v_u_46, (ref) v_u_45, (copy) v_u_81, (copy) v_u_2, (copy) v_u_73, (copy) v_u_14, (copy) v_u_187, (copy) v_u_165, (ref) v_u_56, (ref) v_u_57, (ref) v_u_58, (ref) v_u_59, (ref) v_u_54, (copy) v_u_51, (ref) v_u_55, (copy) v_u_31, (copy) v_u_13, (copy) v_u_48, (copy) v_u_4, (copy) v_u_3, (ref) v_u_37, (copy) v_u_93, (ref) v_u_52, (ref) v_u_53, (copy) v_u_27, (ref) v_u_61, (ref) v_u_62, (copy) v_u_96, (ref) v_u_44, (ref) v_u_38, (copy) v_u_119
    if v_u_50 then
        v_u_1.HideInspect()
    end
    if v_u_24.broadcastRouter("HasPendingCharmAttachment") then
        v_u_63 = p330
        v_u_64 = 1
    else
        v_u_63 = nil
    end
    v_u_39 = p330
    local v331
    if p330 then
        if p330.Type == "Glove" then
            v331 = true
        elseif p330.Name then
            local v332, v333 = pcall(v_u_18, p330.Name)
            if v332 and (v333 and v333.Class) then
                v331 = v333.Class == "Glove"
            else
                v331 = false
            end
        else
            v331 = false
        end
    else
        v331 = false
    end
    v_u_49 = v331 and "Viewmodel" or "Weapon"
    v_u_101()
    v_u_309()
    v_u_124()
    v_u_305(p330)
    if v_u_42 then
        if v_u_42 and v_u_42.Parent ~= workspace then
            v_u_42.Parent = workspace
        end
        v_u_46 = v_u_42
        if v_u_45 then
            v_u_81(v_u_45)
        end
        local v_u_334
        if v_u_46 then
            v_u_334 = v_u_46:FindFirstChild("CamPart")
        else
            v_u_334 = nil
        end
        if v_u_334 then
            local v335
            if v_u_46 then
                v335 = v_u_46:FindFirstChild("WeaponPart")
            else
                v335 = nil
            end
            if v335 then
                if v_u_49 == "Viewmodel" then
                    v_u_14.disableGroup("Gameplay")
                    v_u_187(p330)
                else
                    v_u_14.enableGroup("Gameplay")
                    v_u_165(p330)
                end
                v_u_56 = 0
                v_u_57 = 0
                v_u_58 = 0
                v_u_59 = 0
                if v_u_49 == "Viewmodel" then
                    v_u_54 = v_u_51
                    v_u_55 = v_u_51
                else
                    v_u_54 = 40
                    v_u_55 = 40
                end
                v_u_31.CameraType = Enum.CameraType.Scriptable
                v_u_31.CFrame = v_u_334.CFrame
                v_u_31.Focus = v_u_334.CFrame
                v_u_13.updateCameraFOV(v_u_49 ~= "Viewmodel" and 40 or v_u_51)
                v_u_13.setForceLockOverride("Inspect", true)
                v_u_48:Add(v_u_4.RenderStepped:Connect(function(p336)
                    -- upvalues: (ref) v_u_54, (ref) v_u_55, (ref) v_u_46, (copy) v_u_334, (ref) v_u_31, (ref) v_u_13, (ref) v_u_49, (ref) v_u_3, (ref) v_u_59, (ref) v_u_58, (ref) v_u_37, (ref) v_u_56, (ref) v_u_57, (ref) v_u_93
                    local v337 = p336 * 8
                    local v338 = math.min(1, v337)
                    v_u_54 = v_u_54 + (v_u_55 - v_u_54) * v338
                    if v_u_46 and v_u_334 then
                        v_u_31.CameraType = Enum.CameraType.Scriptable
                        v_u_31.CFrame = v_u_334.CFrame
                        v_u_31.Focus = v_u_334.CFrame
                        v_u_31.FieldOfView = v_u_13.clampFOV(v_u_54)
                    end
                    if v_u_49 == "Weapon" and v_u_3.GamepadEnabled then
                        local v339 = v_u_3:GetLastInputType()
                        local v340 = v_u_3:GetGamepadState((v339 == Enum.UserInputType.Gamepad1 or (v339 == Enum.UserInputType.Gamepad2 or (v339 == Enum.UserInputType.Gamepad3 or v339 == Enum.UserInputType.Gamepad4))) and v339 and v339 or Enum.UserInputType.Gamepad1)
                        if v340 then
                            for _, v341 in pairs(v340) do
                                if v341.KeyCode == Enum.KeyCode.Thumbstick2 then
                                    local v342 = Vector2.new(v341.Position.X, v341.Position.Y)
                                    if v342.Magnitude > 0.1 then
                                        local v343 = Vector2.new(v342.X * 0.5 * 60 * p336 * 4.75, v342.Y * 0.5 * 60 * p336 * 4.75)
                                        v_u_59 = v_u_59 + v343.X * 0.5
                                        v_u_58 = v_u_58 + v343.Y * 0.5
                                        local v344 = v_u_58
                                        v_u_58 = math.clamp(v344, -80, 80)
                                    end
                                elseif v341.KeyCode == Enum.KeyCode.ButtonR2 then
                                    if v341.Position.Z > 0.1 then
                                        local v345 = -v341.Position.Z * 2 * 30 * p336 * 0.55
                                        if v_u_49 ~= "Viewmodel" then
                                            local v346 = v_u_55 - v345 * 2
                                            v_u_55 = math.clamp(v346, 20, 70)
                                        end
                                    end
                                elseif v341.KeyCode == Enum.KeyCode.ButtonL2 and v341.Position.Z > 0.1 then
                                    local v347 = v341.Position.Z * 2 * 30 * p336 * 0.55
                                    if v_u_49 ~= "Viewmodel" then
                                        local v348 = v_u_55 - v347 * 2
                                        v_u_55 = math.clamp(v348, 20, 70)
                                    end
                                end
                            end
                        end
                    end
                    if v_u_49 == "Viewmodel" and v_u_37 then
                        v_u_37:render(p336)
                    elseif v_u_49 == "Weapon" then
                        local v349 = p336 * 10
                        local v350 = math.min(1, v349)
                        v_u_56 = v_u_56 + (v_u_58 - v_u_56) * v350
                        v_u_57 = v_u_57 + (v_u_59 - v_u_57) * v350
                        v_u_93()
                    end
                end), "Disconnect", "CameraUpdate")
                v_u_48:Add(v_u_3.InputBegan:Connect(function(p351, _)
                    -- upvalues: (ref) v_u_52, (ref) v_u_53, (ref) v_u_14, (ref) v_u_27, (ref) v_u_1, (ref) v_u_61, (ref) v_u_62, (ref) v_u_96
                    if p351.UserInputType == Enum.UserInputType.MouseButton1 then
                        v_u_52 = true
                        v_u_53 = Vector2.new(p351.Position.X, p351.Position.Y)
                    end
                    local v352 = v_u_14.getActionKeybinds("Inspect")
                    if table.find(v352, p351.KeyCode) then
                        if v_u_27:GetAttribute("IsPlayerChatting") then
                            return
                        end
                        v_u_1.PlayInspectAnimation()
                    end
                    if p351.UserInputType == Enum.UserInputType.Touch then
                        v_u_61[p351] = Vector2.new(p351.Position.X, p351.Position.Y)
                        local v353 = 0
                        for _ in pairs(v_u_61) do
                            v353 = v353 + 1
                        end
                        if v353 == 1 then
                            v_u_52 = true
                            v_u_53 = Vector2.new(p351.Position.X, p351.Position.Y)
                        end
                        v_u_62 = v_u_96()
                    end
                end), "Disconnect", "InputBegan")
                v_u_48:Add(v_u_3.InputChanged:Connect(function(p354, _)
                    -- upvalues: (ref) v_u_52, (ref) v_u_53, (ref) v_u_59, (ref) v_u_58, (ref) v_u_61, (ref) v_u_96, (ref) v_u_62, (ref) v_u_49, (ref) v_u_55
                    if p354.UserInputType == Enum.UserInputType.MouseMovement and v_u_52 then
                        local v355 = Vector2.new(p354.Position.X, p354.Position.Y)
                        local v356 = v355 - v_u_53
                        v_u_59 = v_u_59 + v356.X * 0.5
                        v_u_58 = v_u_58 + v356.Y * 0.5
                        local v357 = v_u_58
                        v_u_58 = math.clamp(v357, -80, 80)
                        v_u_53 = v355
                    end
                    if p354.UserInputType == Enum.UserInputType.Touch then
                        local v358 = Vector2.new(p354.Position.X, p354.Position.Y)
                        v_u_61[p354] = v358
                        local v359 = 0
                        for _ in pairs(v_u_61) do
                            v359 = v359 + 1
                        end
                        if v359 == 1 and v_u_52 then
                            local v360 = v358 - v_u_53
                            v_u_59 = v_u_59 + v360.X * 0.5
                            v_u_58 = v_u_58 + v360.Y * 0.5
                            local v361 = v_u_58
                            v_u_58 = math.clamp(v361, -80, 80)
                            v_u_53 = v358
                        end
                        if v359 >= 2 then
                            local v362 = v_u_96()
                            if v362 and v_u_62 then
                                local v363 = (v362 - v_u_62) * 0.01
                                if v_u_49 ~= "Viewmodel" then
                                    local v364 = v_u_55 - v363 * 2
                                    v_u_55 = math.clamp(v364, 20, 70)
                                end
                            end
                            v_u_62 = v362
                        end
                    end
                    if p354.UserInputType == Enum.UserInputType.MouseWheel then
                        local v365 = p354.Position.Z
                        if v_u_49 == "Viewmodel" then
                            return
                        end
                        local v366 = v_u_55 - v365 * 2
                        v_u_55 = math.clamp(v366, 20, 70)
                    end
                end), "Disconnect", "InputChanged")
                v_u_48:Add(v_u_3.InputEnded:Connect(function(p367, _)
                    -- upvalues: (ref) v_u_52, (ref) v_u_61, (ref) v_u_62, (ref) v_u_96
                    if p367.UserInputType == Enum.UserInputType.MouseButton1 then
                        v_u_52 = false
                    end
                    if p367.UserInputType == Enum.UserInputType.Touch then
                        v_u_61[p367] = nil
                        local v368 = 0
                        for _ in pairs(v_u_61) do
                            v368 = v368 + 1
                        end
                        if v368 == 0 then
                            v_u_52 = false
                        end
                        v_u_62 = v_u_96()
                    end
                end), "Disconnect", "InputEnded")
                v_u_48:Add(function()
                    -- upvalues: (ref) v_u_44, (ref) v_u_46, (ref) v_u_42, (ref) v_u_2, (ref) v_u_52, (ref) v_u_61, (ref) v_u_62, (ref) v_u_56, (ref) v_u_57, (ref) v_u_58, (ref) v_u_59, (ref) v_u_54, (ref) v_u_55, (ref) v_u_38
                    if v_u_44 then
                        v_u_44:Destroy()
                        v_u_44 = nil
                    end
                    if v_u_46 and v_u_46 == v_u_42 then
                        v_u_46.Parent = v_u_2
                        v_u_46 = nil
                    elseif v_u_46 then
                        v_u_46:Destroy()
                        v_u_46 = nil
                    end
                    v_u_52 = false
                    v_u_61 = {}
                    v_u_62 = nil
                    v_u_56 = 0
                    v_u_57 = 0
                    v_u_58 = 0
                    v_u_59 = 0
                    v_u_54 = 40
                    v_u_55 = 40
                    v_u_38 = nil
                end, true, "InspectCleanup")
                v_u_50 = true
                v_u_119()
            else
                warn("[InspectController]: Inspect scene missing WeaponPart")
                if v_u_46 then
                    v_u_46.Parent = v_u_2
                    v_u_46 = nil
                end
                v_u_73()
                v_u_329()
            end
        else
            warn("[InspectController]: Inspect scene missing CamPart")
            if v_u_46 then
                v_u_46.Parent = v_u_2
                v_u_46 = nil
            end
            v_u_73()
            v_u_329()
            return
        end
    else
        warn("[InspectController]: No preloaded inspect scene available")
        v_u_329()
        return
    end
end
function v_u_1.HideInspect(p369)
    -- upvalues: (ref) v_u_50, (copy) v_u_48, (ref) v_u_35, (ref) v_u_36, (ref) v_u_37, (ref) v_u_40, (copy) v_u_14, (ref) v_u_44, (ref) v_u_38, (copy) v_u_25, (copy) v_u_12, (copy) v_u_73, (copy) v_u_31, (copy) v_u_13, (copy) v_u_26, (copy) v_u_329, (ref) v_u_43, (copy) v_u_314, (ref) v_u_47, (ref) v_u_63, (ref) v_u_64, (copy) v_u_119
    if v_u_50 then
        v_u_48:Cleanup()
        if v_u_35 then
            if v_u_35.IsPlaying then
                v_u_35:Stop(0)
            end
            v_u_35:Destroy()
            v_u_35 = nil
        end
        if v_u_36 then
            v_u_36:Destroy()
            v_u_36 = nil
        end
        if v_u_37 then
            v_u_37:destroy()
            v_u_37 = nil
        end
        if v_u_40 then
            v_u_40:Destroy()
            v_u_40 = nil
        end
        v_u_14.enableGroup("Gameplay")
        if v_u_44 then
            v_u_44:Destroy()
            v_u_44 = nil
        end
        v_u_38 = nil
        if v_u_25.IsCaseSceneActive() then
            v_u_12.ApplyCaseSceneLighting()
        else
            v_u_73()
        end
        v_u_31.CameraType = Enum.CameraType.Custom
        v_u_13.updateCameraFOV(v_u_26.DEFAULT_CAMERA_FOV)
        v_u_13.setForceLockOverride("Inspect", false)
        if p369 then
            v_u_25.ExitInspect()
            v_u_43 = false
        else
            v_u_329()
        end
        if v_u_25.IsCaseSceneActive() then
            v_u_47 = {}
        else
            v_u_314()
        end
        v_u_63 = nil
        v_u_64 = 1
        v_u_50 = false
        v_u_119()
    end
end
function v_u_1.IsActive()
    -- upvalues: (ref) v_u_50
    return v_u_50
end
function v_u_1.ToggleInspect(p370)
    -- upvalues: (ref) v_u_50, (copy) v_u_1
    if v_u_50 then
        v_u_1.HideInspect()
    elseif p370 then
        v_u_1.ShowInspect(p370)
    end
end
function v_u_1.CycleCharmPosition()
    -- upvalues: (ref) v_u_50, (ref) v_u_63, (ref) v_u_64, (copy) v_u_1
    if v_u_50 and v_u_63 then
        v_u_64 = v_u_64 % 4 + 1
        local v371 = v_u_64
        v_u_1.RefreshWeaponWithCharm((tostring(v371)))
    end
end
function v_u_1.RefreshWeaponWithCharm(p372)
    -- upvalues: (ref) v_u_50, (ref) v_u_46, (ref) v_u_63, (ref) v_u_56, (ref) v_u_57, (ref) v_u_58, (ref) v_u_59, (ref) v_u_49, (ref) v_u_44, (copy) v_u_21, (ref) v_u_38, (copy) v_u_93, (ref) v_u_37, (ref) v_u_40
    if v_u_50 and (v_u_46 and v_u_63) then
        local v373 = v_u_46
        local v374 = v_u_63
        if v373:FindFirstChild("WeaponPart") then
            local v375 = v_u_56
            local v376 = v_u_57
            local v377 = v_u_58
            local v378 = v_u_59
            local v379 = v374.Charm
            local v380 = type(v379) == "table" and {
                ["_id"] = v379._id,
                ["Position"] = p372
            } or p372
            if v_u_49 == "Weapon" then
                if v_u_44 then
                    v_u_44:Destroy()
                    v_u_44 = nil
                end
                local v381 = v_u_21.GetCharacterModel(v374.Name, v374.Skin, v374.Float, v374.StatTrack, v374.NameTag, v380, v374.Stickers)
                if not v381 then
                    warn((("[InspectController]: Failed to refresh weapon model for charm position %*"):format(p372)))
                    return
                end
                v381.Name = "InspectWeapon"
                v_u_44 = v381
                v_u_38 = v381:FindFirstChild("InspectPivot", true)
                local v382 = v381:FindFirstChild("CharmBase", true)
                for _, v383 in ipairs(v381:GetDescendants()) do
                    if v383:IsA("BasePart") then
                        local v384
                        if v382 then
                            v384 = v383:IsDescendantOf(v382)
                        else
                            v384 = v382
                        end
                        v383.CastShadow = false
                        if v384 then
                            v383.Anchored = false
                        else
                            v383.CanCollide = v383:IsA("MeshPart") and true or false
                            v383.CanQuery = false
                            v383.CanTouch = false
                            v383.Anchored = true
                        end
                    end
                end
                v381.Parent = v373
                v_u_56 = v375
                v_u_57 = v376
                v_u_58 = v377
                v_u_59 = v378
                v_u_93()
            end
            if v_u_37 and v_u_40 then
                v_u_37.Charm = v380
                v_u_37:construct(v_u_40, nil)
            end
        end
    else
        return
    end
end
function v_u_1.GetCurrentCharmPosition()
    -- upvalues: (ref) v_u_64
    return v_u_64
end
function v_u_1.PlayInspectAnimation()
    -- upvalues: (ref) v_u_49, (ref) v_u_37, (ref) v_u_39, (copy) v_u_18, (ref) v_u_35
    if v_u_49 == "Viewmodel" and v_u_37 then
        local v385 = v_u_39
        local v386
        if v385 then
            if v385.Type == "Glove" then
                v386 = true
            elseif v385.Name then
                local v387, v388 = pcall(v_u_18, v385.Name)
                if v387 and (v388 and v388.Class) then
                    v386 = v388.Class == "Glove"
                else
                    v386 = false
                end
            else
                v386 = false
            end
        else
            v386 = false
        end
        if v386 then
            if v_u_35 then
                if v_u_37 and v_u_37.Animation then
                    v_u_37.Animation:stopAnimations()
                end
                if v_u_35.IsPlaying then
                    v_u_35:Stop(0)
                end
                v_u_35.TimePosition = 0
                v_u_35:Play(0, 1, 1)
            end
        elseif v_u_37.Animation then
            v_u_37.Animation:stopAnimations()
            v_u_37.Animation:play("Idle")
            v_u_37.Animation:play("Inspect")
        end
    else
        return
    end
end
function v_u_1.Initialize()
    -- upvalues: (copy) v_u_15, (copy) v_u_27, (copy) v_u_7, (ref) v_u_41, (copy) v_u_86, (ref) v_u_45, (ref) v_u_42, (copy) v_u_2, (copy) v_u_3, (ref) v_u_50, (copy) v_u_1, (copy) v_u_24, (ref) v_u_64
    v_u_15.CreateListener(v_u_27, "Settings.Video.Presets.Global Shadows", function()
        -- upvalues: (ref) v_u_15, (ref) v_u_27, (ref) v_u_7, (ref) v_u_41
        if v_u_15.Get(v_u_27, "Settings.Video.Presets.Global Shadows") ~= false then
            if v_u_41 ~= nil then
                v_u_7.GlobalShadows = v_u_41
            end
        else
            v_u_7.GlobalShadows = false
        end
    end)
    local v389 = v_u_86()
    if v389 then
        v_u_45 = v389.Name
        v_u_42 = v389
        if v_u_42 then
            v_u_42.Name = "InspectScene"
            v_u_42.Parent = v_u_2
        end
    else
        warn("[InspectController]: No inspect scene found to preload in ReplicatedStorage.Assets.InspectScenes")
    end
    v_u_3.InputBegan:Connect(function(p390, p391)
        -- upvalues: (ref) v_u_50, (ref) v_u_1
        if not p391 then
            if p390.KeyCode == Enum.KeyCode.Escape and v_u_50 then
                v_u_1.HideInspect()
            end
        end
    end)
    v_u_27.CharacterAdded:Connect(function()
        -- upvalues: (ref) v_u_50, (ref) v_u_1
        if v_u_50 then
            v_u_1.HideInspect()
        end
    end)
    v_u_24.observerRouter("WeaponInspect", function(p392, p393, p394, p395, p396, p397, p398, p399, p400, p401, p402, p403)
        -- upvalues: (ref) v_u_2, (ref) v_u_1
        if not require(v_u_2.Controllers.EndScreenController).IsActive() then
            local v404 = {
                ["_id"] = p401 or "inspect_" .. p392 .. "_" .. p393,
                ["Name"] = p392,
                ["Skin"] = p393,
                ["Float"] = p394,
                ["StatTrack"] = p395,
                ["NameTag"] = p396,
                ["Charm"] = p397,
                ["Stickers"] = p398,
                ["Type"] = p399,
                ["Pattern"] = p400,
                ["Serial"] = p402,
                ["IsTradeable"] = p403
            }
            v_u_1.ShowInspect(v404)
        end
    end)
    v_u_24.observerRouter("WeaponInspectClose", function()
        -- upvalues: (ref) v_u_1
        v_u_1.HideInspect()
    end)
    v_u_24.observerRouter("WeaponInspectCloseForGameEnd", function()
        -- upvalues: (ref) v_u_1
        v_u_1.HideInspect(true)
    end)
    v_u_24.observerRouter("IsInspectActive", function()
        -- upvalues: (ref) v_u_1
        return v_u_1.IsActive()
    end)
    v_u_24.observerRouter("GetCurrentCharmPosition", function()
        -- upvalues: (ref) v_u_64
        return v_u_64
    end)
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_113
    v_u_113()
end
return v_u_1
