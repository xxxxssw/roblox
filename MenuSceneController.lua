-- MODULESCRIPT: MenuSceneController
-- Original Path: game.BAC - 21977.Controllers.MenuSceneController
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("Lighting")
local v6 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_7 = require(v_u_2.Packages.Observers)
local v8 = require(v_u_2.Shared.Janitor)
local v_u_9 = require(v_u_2.Controllers.CameraController)
local v_u_10 = require(v_u_2.Controllers.DataController)
local v_u_11 = nil
local v_u_12 = require(v_u_2.Classes.Sound)
local v_u_13 = require(v_u_2.Database.Custom.Constants)
local v_u_14 = v6.LocalPlayer
local v_u_15 = v_u_14:WaitForChild("PlayerGui")
local v_u_16 = workspace.CurrentCamera
local v_u_17 = nil
local v_u_18 = v_u_2.Assets.Lighting
local v_u_19 = v_u_2.Database.Custom.GameStats.Maps
local v_u_20 = v_u_2.Assets.Characters
local v_u_21 = {
    ["CT"] = {
        ["Entrance"] = "rbxassetid://96240248165206",
        ["Idle"] = "rbxassetid://77870220857645"
    },
    ["T"] = {
        ["Entrance"] = "rbxassetid://100747011940776",
        ["Idle"] = "rbxassetid://99540873384647"
    }
}
local v_u_22 = {
    ["CT"] = {
        ["Character"] = "IDF",
        ["Weapon"] = "M4A1-S",
        ["Glove"] = "CT Glove"
    },
    ["T"] = {
        ["Character"] = "Anarchist",
        ["Weapon"] = "AK-47",
        ["Glove"] = "T Glove"
    }
}
local v_u_23 = require(v_u_2.Database.Components.Common.AttachGlovesToCharacter)
local v_u_24 = nil
local v_u_25 = nil
local v_u_26 = nil
local v_u_27 = nil
local v_u_28 = v8.new()
local v_u_29 = false
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = 1
local v_u_33 = nil
local v_u_34 = nil
local function v_u_43()
    -- upvalues: (copy) v_u_19, (ref) v_u_34, (copy) v_u_5, (copy) v_u_10, (copy) v_u_14
    local v35 = workspace:FindFirstChild("Map")
    if v35 then
        local v36 = v35:GetAttribute("MapName")
        if v36 and typeof(v36) == "string" then
            local v37 = v_u_19:FindFirstChild(v36)
            if v37 and v37:IsA("ModuleScript") then
                local v38 = require(v37)
                if v38.Lighting then
                    local v39 = v38.Lighting.Properties
                    if v39 then
                        v_u_34 = v39.GlobalShadows
                        v_u_5.Ambient = v39.Ambient
                        v_u_5.Brightness = v39.Brightness
                        v_u_5.ColorShift_Bottom = v39.ColorShift_Bottom
                        v_u_5.ColorShift_Top = v39.ColorShift_Top
                        v_u_5.EnvironmentDiffuseScale = v39.EnvironmentDiffuseScale
                        v_u_5.EnvironmentSpecularScale = v39.EnvironmentSpecularScale
                        v_u_5.GlobalShadows = v39.GlobalShadows
                        v_u_5.OutdoorAmbient = v39.OutdoorAmbient
                        v_u_5.ShadowSoftness = v39.ShadowSoftness
                        v_u_5.ClockTime = v39.ClockTime
                        v_u_5.GeographicLatitude = v39.GeographicLatitude
                        v_u_5.ExposureCompensation = v39.ExposureCompensation
                    end
                    for _, v40 in ipairs(v_u_5:GetChildren()) do
                        if v40.Name ~= "Menu" then
                            v40:Destroy()
                        end
                    end
                    local v41 = v38.Lighting.Assets
                    if v41 then
                        for _, v42 in ipairs(v41:GetChildren()) do
                            v42:Clone().Parent = v_u_5
                        end
                    end
                    if v_u_10.Get(v_u_14, "Settings.Video.Presets.Global Shadows") ~= false then
                        if v_u_34 ~= nil then
                            v_u_5.GlobalShadows = v_u_34
                        end
                    else
                        v_u_5.GlobalShadows = false
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
local function v_u_51(p44)
    -- upvalues: (copy) v_u_18, (copy) v_u_19, (ref) v_u_34, (copy) v_u_5, (copy) v_u_10, (copy) v_u_14
    local v45 = v_u_18:FindFirstChild(p44)
    if v45 then
        local v46 = v_u_19:FindFirstChild(p44)
        if v46 and v46:IsA("ModuleScript") then
            local v47 = require(v46)
            if v47.Lighting and v47.Lighting.Properties then
                local v48 = v47.Lighting.Properties
                v_u_34 = v48.GlobalShadows
                v_u_5.Ambient = v48.Ambient
                v_u_5.Brightness = v48.Brightness
                v_u_5.ColorShift_Bottom = v48.ColorShift_Bottom
                v_u_5.ColorShift_Top = v48.ColorShift_Top
                v_u_5.EnvironmentDiffuseScale = v48.EnvironmentDiffuseScale
                v_u_5.EnvironmentSpecularScale = v48.EnvironmentSpecularScale
                v_u_5.GlobalShadows = v48.GlobalShadows
                v_u_5.OutdoorAmbient = v48.OutdoorAmbient
                v_u_5.ShadowSoftness = v48.ShadowSoftness
                v_u_5.ClockTime = v48.ClockTime
                v_u_5.GeographicLatitude = v48.GeographicLatitude
                v_u_5.ExposureCompensation = v48.ExposureCompensation
            end
        end
        for _, v49 in ipairs(v_u_5:GetChildren()) do
            if v49.Name ~= "Menu" then
                v49:Destroy()
            end
        end
        for _, v50 in ipairs(v45:GetChildren()) do
            v50:Clone().Parent = v_u_5
        end
        if v_u_10.Get(v_u_14, "Settings.Video.Presets.Global Shadows") ~= false then
            if v_u_34 ~= nil then
                v_u_5.GlobalShadows = v_u_34
            end
        else
            v_u_5.GlobalShadows = false
        end
    else
        warn((("[MenuSceneController]: No lighting found for scene \"%*\""):format(p44)))
        return
    end
end
local function v_u_65()
    -- upvalues: (copy) v_u_2, (ref) v_u_11, (copy) v_u_15, (copy) v_u_14
    local v52 = require(v_u_2.Interface.MenuState)
    if v_u_11 and v_u_11.IsActive() then
        return false
    end
    if v52.IsInspectActive() then
        return false
    end
    if workspace:FindFirstChild("InspectScene") then
        return false
    end
    local v53 = v_u_15:FindFirstChild("MainGui")
    if v53 then
        local v54 = v53:FindFirstChild("Gameplay")
        if v54 then
            v54 = v54:FindFirstChild("Middle")
        end
        if v54 then
            v54 = v54:FindFirstChild("TeamSelection")
        end
        if v54 and v54.Visible then
            return false
        end
    end
    local v55 = v_u_14:GetAttribute("IsSpectating")
    local v56 = v_u_14:GetAttribute("Team")
    local v57 = require(v_u_2.Database.Components.GameState).GetState()
    if v57 == "Game Ending" or v57 == "Map Voting" then
        if v56 == "Counter-Terrorists" or v56 == "Terrorists" then
            return false
        end
        local v58 = v_u_14.Character
        local v59
        if v58 and v58:IsDescendantOf(workspace) then
            local v60 = v58:FindFirstChild("Humanoid")
            v59 = v60 and v60.Health > 0 and true or false
        else
            v59 = false
        end
        return not v59
    end
    if v56 == "Counter-Terrorists" or v56 == "Terrorists" then
        return false
    end
    local v61 = v_u_14.Character
    local v62
    if v61 and v61:IsDescendantOf(workspace) then
        local v63 = v61:FindFirstChild("Humanoid")
        v62 = v63 and v63.Health > 0 and true or false
    else
        v62 = false
    end
    local v64 = not v62
    if v64 then
        v64 = not v55
    end
    return v64
end
local function v_u_84(p66, p67, p68)
    -- upvalues: (copy) v_u_2, (copy) v_u_10, (copy) v_u_14, (copy) v_u_22, (copy) v_u_23
    local v69 = require(v_u_2.Database.Components.Libraries.Skins)
    local v70 = nil
    local v71 = nil
    local v72 = nil
    if p68 then
        local v73 = p67 == "CT" and "Counter-Terrorists" or "Terrorists"
        v_u_10.WaitForDataLoaded(v_u_14)
        local v74 = v_u_10.Get(v_u_14, "Loadout")
        if v74 and (type(v74) == "table" and v74[v73]) then
            local v75 = v74[v73]
            if v75 and (type(v75) == "table" and v75.Equipped) then
                local v76 = v75.Equipped["Equipped Gloves"]
                if v76 and (v76 ~= "" and type(v76) == "string") then
                    local v77 = v_u_10.Get(v_u_14, "Inventory")
                    if v77 and type(v77) == "table" then
                        for _, v78 in ipairs(v77) do
                            if v78 and v78._id == v76 then
                                v70 = v78.Name
                                v71 = v78.Skin
                                v72 = v78.Float
                                p66:SetAttribute("EquippedGloves", game:GetService("HttpService"):JSONEncode({
                                    ["SkinIdentifier"] = v76
                                }))
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    local v79 = v70 or v_u_22[p67].Glove
    local v80
    if v71 and (v72 and v79) then
        v80 = v69.GetGloves(v79, v71, v72)
    else
        v80 = nil
    end
    local v81 = v80 or v_u_2:WaitForChild("Assets"):WaitForChild("Weapons"):FindFirstChild(v79)
    if v81 then
        local v82 = p66:FindFirstChild("CharacterArmor")
        if not v82 then
            v82 = Instance.new("Folder")
            v82.Name = "CharacterArmor"
            v82.Parent = p66
        end
        local v83
        if v80 then
            v83 = v80:GetChildren()
        else
            if not v81 then
                warn((("[MenuSceneController]: No glove model or folder available for \"%*\""):format(v79)))
                return
            end
            v83 = v81:GetChildren()
        end
        v_u_23(v83, p66, v82)
        if v80 and v80.Name == "" then
            v80:Destroy()
        end
    else
        warn((("[MenuSceneController]: Glove folder not found for \"%*\""):format(v79)))
    end
end
local function v_u_112(p85, p86, p87)
    -- upvalues: (copy) v_u_2, (copy) v_u_10, (copy) v_u_14, (copy) v_u_22
    local v88 = require(v_u_2.Database.Components.Libraries.Skins)
    local v89 = nil
    local v90 = nil
    local v91 = nil
    local v92 = nil
    if p87 then
        local v93 = p86 == "CT" and "Counter-Terrorists" or "Terrorists"
        local v94 = p86 == "CT" and "M4A1-S" or "AK-47"
        v_u_10.WaitForDataLoaded(v_u_14)
        local v95 = v_u_10.Get(v_u_14, "Loadout")
        local v96 = v_u_10.Get(v_u_14, "Inventory")
        if v95 and (type(v95) == "table" and v95[v93]) then
            local v97 = v95[v93]
            if v97 and (type(v97) == "table" and v97.Loadout) then
                local v98 = v97.Loadout.Rifles
                if v98 and v98.Options then
                    local v99 = v98.Options
                    if type(v99) == "table" and (v96 and type(v96) == "table") then
                        for _, v100 in ipairs(v98.Options) do
                            if v100 and (v100 ~= "" and type(v100) == "string") then
                                for _, v101 in ipairs(v96) do
                                    if v101 and (v101._id == v100 and v101.Name == v94) then
                                        v89 = v101.Name
                                        v90 = v101.Skin
                                        v91 = v101.Float
                                        local _ = v101.StatTrack
                                        v92 = v101.NameTag
                                        break
                                    end
                                end
                                if v89 then
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    local v102 = v89 or v_u_22[p86].Weapon
    if v102 then
        local v103
        if v90 and (typeof(v90) == "string" and (v90 ~= "" and v102)) then
            v103 = v88.GetCharacterModel(v102, v90, v91, nil, v92)
        else
            v103 = nil
        end
        local v104 = v103 or v88.GetBaseWeaponModel(v102, "Character")
        if v104 then
            v104.Name = v102
            local v105 = p85:FindFirstChild("RightHand")
            if v105 then
                if not v104.PrimaryPart then
                    local v106 = v104:FindFirstChild("Weapon")
                    if v106 then
                        v106 = v106:FindFirstChild("Insert")
                    end
                    if not v106 then
                        warn("[MenuSceneController]: Weapon model has no PrimaryPart or Insert")
                        v104:Destroy()
                        return
                    end
                    v104.PrimaryPart = v106
                end
                for _, v107 in ipairs(v104:GetDescendants()) do
                    if v107:IsA("BasePart") then
                        v107.CanCollide = false
                        v107.CanQuery = false
                        v107.CanTouch = false
                        v107.Anchored = false
                        v107.Massless = true
                    end
                end
                v104.Parent = p85
                local v108 = Instance.new("Motor6D")
                v108.Name = "WeaponAttachment"
                v108.Part0 = v105
                v108.Part1 = v104.PrimaryPart
                v108.Parent = v105
                if v102 == "AK-47" then
                    v108.C0 = CFrame.new(-0.251, 0.806, -0.406) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)
                    return v104
                end
                local v109 = v104:FindFirstChild("Properties")
                if v109 then
                    local v110 = v109:FindFirstChild("C0")
                    if v110 then
                        v108.C0 = v110.Value
                    end
                    local v111 = v109:FindFirstChild("C1")
                    if v111 then
                        v108.C1 = v111.Value
                    end
                end
                return v104
            end
            warn("[MenuSceneController]: Character missing RightHand")
            v104:Destroy()
        else
            warn((("[MenuSceneController]: Failed to get weapon model for \"%*\""):format(v102)))
        end
    else
        warn("[MenuSceneController]: No weapon name available")
        return
    end
end
local function v_u_117(p113)
    local v114 = p113:FindFirstChild("Humanoid")
    local v115 = p113:FindFirstChild("HumanoidRootPart")
    for _, v116 in ipairs(p113:GetDescendants()) do
        if v116:IsA("BasePart") then
            v116.CanCollide = false
            v116.CanQuery = false
            v116.CanTouch = false
            v116.Massless = true
        end
    end
    if v114 then
        v114.AutoRotate = false
    end
    if v115 then
        v115.Anchored = true
    end
end
local function v_u_131(p118)
    -- upvalues: (copy) v_u_22, (copy) v_u_21, (copy) v_u_20, (ref) v_u_25, (ref) v_u_26, (ref) v_u_27, (copy) v_u_112, (copy) v_u_84, (copy) v_u_117, (copy) v_u_28, (ref) v_u_29
    local v119 = p118:FindFirstChild("PlayerPart")
    if v119 then
        local v120 = math.random(1, 2) == 1 and "CT" or "T"
        local v121 = v_u_22[v120]
        local v122 = v_u_21[v120]
        local v123 = v_u_20:FindFirstChild(v121.Character)
        if v123 then
            local v124 = v123:Clone()
            v124.Name = "MenuCharacter"
            v_u_25 = v124
            v_u_26 = v120
            v_u_27 = v_u_112(v124, v120, true)
            v_u_84(v124, v120, true)
            v_u_117(v124)
            v124.Parent = p118
            v124:PivotTo(v119.CFrame)
            local v125 = v124:FindFirstChild("Humanoid")
            if v125 then
                local v126 = v125:FindFirstChildOfClass("Animator")
                if not v126 then
                    v126 = Instance.new("Animator")
                    v126.Parent = v125
                end
                local v127 = Instance.new("Animation")
                v127.AnimationId = v122.Entrance
                local v128 = Instance.new("Animation")
                v128.AnimationId = v122.Idle
                local v129 = v126:LoadAnimation(v127)
                local v_u_130 = v126:LoadAnimation(v128)
                v_u_28:Add(v127, "Destroy", "EntranceAnimation")
                v_u_28:Add(v128, "Destroy", "IdleAnimation")
                v_u_28:Add(v129, "Stop", "EntranceTrack")
                v_u_28:Add(v_u_130, "Stop", "IdleTrack")
                v129.Priority = Enum.AnimationPriority.Action
                v129:Play()
                v129.Stopped:Once(function()
                    -- upvalues: (ref) v_u_29, (copy) v_u_130
                    if v_u_29 and v_u_130 then
                        v_u_130.Looped = true
                        v_u_130.Priority = Enum.AnimationPriority.Idle
                        v_u_130:Play()
                    end
                end)
                v_u_28:Add(function()
                    -- upvalues: (ref) v_u_25, (ref) v_u_26, (ref) v_u_27
                    if v_u_25 then
                        v_u_25:Destroy()
                        v_u_25 = nil
                        v_u_26 = nil
                        v_u_27 = nil
                    end
                end, true, "MenuCharacterCleanup")
            else
                warn("[MenuSceneController]: Character missing Humanoid")
            end
        else
            warn((("[MenuSceneController]: Character \"%*\" not found"):format(v121.Character)))
            return
        end
    else
        return
    end
end
local function v_u_134()
    -- upvalues: (ref) v_u_31, (copy) v_u_10, (copy) v_u_14, (ref) v_u_32
    if v_u_31 and v_u_31.Parent then
        local v132 = (v_u_10.Get(v_u_14, "Settings.Audio.Audio.Main Menu Ambience Volume") or 100) / 100
        local v133 = (v_u_10.Get(v_u_14, "Settings.Audio.Audio.Master Volume") or 100) / 100
        v_u_31.Volume = (v_u_31:GetAttribute("BaseVolume") or v_u_31.Volume) * v132 * v133 * v_u_32
    end
end
function v_u_1.ShowMenuScene()
    -- upvalues: (ref) v_u_29, (copy) v_u_9, (copy) v_u_2, (ref) v_u_17, (ref) v_u_24, (copy) v_u_51, (copy) v_u_43, (copy) v_u_16, (copy) v_u_28, (copy) v_u_3, (copy) v_u_131, (ref) v_u_31, (copy) v_u_10, (copy) v_u_14, (copy) v_u_12, (ref) v_u_30, (copy) v_u_15, (ref) v_u_32
    if v_u_29 then
        v_u_9.updateCameraFOV(50)
        v_u_9.setMouseEnabled(true)
        return
    elseif workspace:FindFirstChild("InspectScene") then
        return
    else
        local v135 = require(v_u_2.Interface.MenuState)
        if v135.IsInspectActive() then
            return
        elseif v135.IsCaseSceneActive() then
            return
        else
            local v136
            if v_u_17 then
                v136 = v_u_17
            else
                local v137 = v_u_2:FindFirstChild("Assets")
                if v137 then
                    v_u_17 = v137:WaitForChild("MenuScenes", 10)
                end
                v136 = v_u_17
            end
            local v138
            if v136 then
                local v139 = v136:GetChildren()
                if #v139 > 0 then
                    v138 = v139[math.random(1, #v139)]
                else
                    v138 = nil
                end
            else
                v138 = nil
            end
            if v138 then
                local v140 = v138:Clone()
                v140.Parent = workspace
                v_u_24 = v140
                v_u_51(v138.Name)
                local v_u_141 = v140:FindFirstChild("CamPart")
                if v_u_141 then
                    v_u_16.CameraType = Enum.CameraType.Scriptable
                    v_u_16.CFrame = v_u_141.CFrame
                    v_u_16.Focus = v_u_141.CFrame
                    v_u_9.updateCameraFOV(50)
                    v_u_9.setMouseEnabled(true)
                    v_u_28:Add(v_u_3.RenderStepped:Connect(function()
                        -- upvalues: (ref) v_u_24, (copy) v_u_141, (ref) v_u_16
                        if v_u_24 and v_u_141 then
                            v_u_16.CFrame = v_u_141.CFrame
                            v_u_16.Focus = v_u_141.CFrame
                        end
                    end), "Disconnect", "CameraUpdate")
                    v_u_28:Add(function()
                        -- upvalues: (ref) v_u_24
                        if v_u_24 then
                            v_u_24:Destroy()
                            v_u_24 = nil
                        end
                    end, true, "MenuSceneCleanup")
                    v_u_29 = true
                    v_u_131(v140)
                    if not (v_u_31 and v_u_31.IsPlaying) then
                        local v142 = (v_u_10.Get(v_u_14, "Settings.Audio.Audio.Main Menu Ambience Volume") or 100) / 100
                        local v143 = v_u_12.new("Main Menu")
                        v_u_30 = v143
                        local v_u_144 = v143:play({
                            ["Name"] = "Main Menu Music",
                            ["Parent"] = v_u_15
                        }, v142)
                        v_u_31 = v_u_144
                        if v_u_144 then
                            local v145 = (v_u_10.Get(v_u_14, "Settings.Audio.Audio.Master Volume") or 100) / 100
                            local v146 = v_u_144.Volume
                            if v142 > 0 and v145 > 0 then
                                v146 = v146 / (v142 * v145) or v146
                            end
                            v_u_144:SetAttribute("BaseVolume", v146)
                            v_u_144:SetAttribute("AmbienceVolumeMultiplier", v142)
                            if v_u_32 ~= 1 then
                                v_u_144.Volume = v_u_144.Volume * v_u_32
                            end
                            v_u_144.Destroying:Once(function()
                                -- upvalues: (ref) v_u_31, (copy) v_u_144
                                if v_u_31 == v_u_144 then
                                    v_u_31 = nil
                                end
                            end)
                        end
                    end
                else
                    warn("[MenuSceneController]: Menu scene missing CamPart")
                    v140:Destroy()
                    v_u_24 = nil
                    v_u_43()
                end
            else
                v_u_9.setMouseEnabled(true)
                return
            end
        end
    end
end
function v_u_1.HideMenuScene(p147, p148)
    -- upvalues: (ref) v_u_29, (copy) v_u_2, (copy) v_u_28, (copy) v_u_43, (copy) v_u_16, (copy) v_u_9, (copy) v_u_13, (ref) v_u_31, (ref) v_u_30
    if v_u_29 then
        if require(v_u_2.Interface.MenuState).IsInspectActive() or workspace:FindFirstChild("InspectScene") then
            p148 = true
            p147 = true
        end
        v_u_28:Cleanup()
        if not p148 then
            v_u_43()
        end
        if not p148 then
            v_u_16.CameraType = Enum.CameraType.Custom
            v_u_9.updateCameraFOV(v_u_13.DEFAULT_CAMERA_FOV)
        end
        v_u_29 = false
        if not p147 then
            if v_u_31 then
                v_u_31:Stop()
                v_u_31 = nil
            end
            if v_u_30 then
                v_u_30:destroy()
                v_u_30 = nil
            end
        end
    end
end
function v_u_1.IsActive()
    -- upvalues: (ref) v_u_29
    return v_u_29
end
function v_u_1.StopMenuMusic()
    -- upvalues: (ref) v_u_31, (ref) v_u_30
    if v_u_31 then
        v_u_31:Stop()
        v_u_31 = nil
    end
    if v_u_30 then
        v_u_30:destroy()
        v_u_30 = nil
    end
end
function v_u_1.IsMusicPlaying()
    -- upvalues: (ref) v_u_31
    local v149
    if v_u_31 == nil then
        v149 = false
    else
        v149 = v_u_31.IsPlaying
    end
    return v149
end
function v_u_1.SetMusicVolumeMultiplier(p150, p151)
    -- upvalues: (ref) v_u_32, (ref) v_u_31, (ref) v_u_33, (copy) v_u_10, (copy) v_u_14, (copy) v_u_4
    v_u_32 = p150
    if v_u_31 then
        if v_u_33 then
            v_u_33:Cancel()
            v_u_33 = nil
        end
        local v152 = v_u_31:GetAttribute("BaseVolume") or 0.1
        local v153 = (v_u_10.Get(v_u_14, "Settings.Audio.Audio.Main Menu Ambience Volume") or 100) / 100
        local v154 = (v_u_10.Get(v_u_14, "Settings.Audio.Audio.Master Volume") or 100) / 100
        local v155 = v152 * v153 * v154 * v_u_32
        if p151 and p151 > 0 then
            local v156 = v_u_4:Create(v_u_31, TweenInfo.new(p151, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Volume"] = v155
            })
            v_u_33 = v156
            v156:Play()
        else
            v_u_31.Volume = v155
        end
    else
        return
    end
end
function v_u_1.ApplyMapLighting()
    -- upvalues: (copy) v_u_43
    v_u_43()
end
function v_u_1.ApplyMenuSceneLighting()
    -- upvalues: (ref) v_u_17, (copy) v_u_2, (copy) v_u_51, (copy) v_u_5
    local v157
    if v_u_17 then
        v157 = v_u_17
    else
        local v158 = v_u_2:FindFirstChild("Assets")
        if v158 then
            v_u_17 = v158:WaitForChild("MenuScenes", 10)
        end
        v157 = v_u_17
    end
    local v159
    if v157 then
        local v160 = v157:GetChildren()
        if #v160 > 0 then
            v159 = v160[math.random(1, #v160)]
        else
            v159 = nil
        end
    else
        v159 = nil
    end
    if v159 then
        v_u_51(v159.Name)
        v_u_5.GlobalShadows = true
    end
end
function v_u_1.GetMenuCharacter()
    -- upvalues: (ref) v_u_25
    return v_u_25
end
function v_u_1.CreateStandaloneCharacter(p161)
    -- upvalues: (copy) v_u_22, (copy) v_u_20, (copy) v_u_2, (copy) v_u_84
    local v162 = p161 or (math.random(1, 2) == 1 and "CT" or "T")
    local v163 = v_u_22[v162]
    local v164 = v_u_20:FindFirstChild(v163.Character)
    if not v164 then
        warn((("[MenuSceneController]: Character \"%*\" not found"):format(v163.Character)))
        return nil
    end
    local v165 = v164:Clone()
    v165.Name = "StandaloneCharacter"
    v165.Parent = v_u_2
    v_u_84(v165, v162, true)
    return v165
end
function v_u_1.Initialize()
    -- upvalues: (copy) v_u_10, (copy) v_u_14, (copy) v_u_5, (ref) v_u_34, (copy) v_u_134, (copy) v_u_65, (copy) v_u_1, (ref) v_u_11, (copy) v_u_2, (copy) v_u_7, (ref) v_u_25, (ref) v_u_26, (ref) v_u_27, (copy) v_u_112, (copy) v_u_84, (copy) v_u_117, (copy) v_u_28
    v_u_10.CreateListener(v_u_14, "Settings.Video.Presets.Global Shadows", function()
        -- upvalues: (ref) v_u_10, (ref) v_u_14, (ref) v_u_5, (ref) v_u_34
        if v_u_10.Get(v_u_14, "Settings.Video.Presets.Global Shadows") ~= false then
            if v_u_34 ~= nil then
                v_u_5.GlobalShadows = v_u_34
            end
        else
            v_u_5.GlobalShadows = false
        end
    end)
    v_u_10.CreateListener(v_u_14, "Settings.Audio.Audio.Main Menu Ambience Volume", v_u_134)
    v_u_10.CreateListener(v_u_14, "Settings.Audio.Audio.Master Volume", v_u_134)
    if v_u_65() then
        v_u_1.ShowMenuScene()
    end
    task.defer(function()
        -- upvalues: (ref) v_u_11, (ref) v_u_2
        if not v_u_11 then
            v_u_11 = require(v_u_2.Controllers.EndScreenController)
        end
    end)
    v_u_14.CharacterAdded:Connect(function(p166)
        -- upvalues: (ref) v_u_1, (ref) v_u_65
        v_u_1.StopMenuMusic()
        v_u_1.HideMenuScene()
        local v167 = p166:FindFirstChildOfClass("Humanoid")
        if not v167 then
            local v168 = tick()
            repeat
                task.wait(0.1)
                v167 = p166:FindFirstChildOfClass("Humanoid")
            until v167 or tick() - v168 > 5
        end
        if v167 then
            v167.Died:Connect(function()
                -- upvalues: (ref) v_u_65, (ref) v_u_1
                task.delay(0.1, function()
                    -- upvalues: (ref) v_u_65, (ref) v_u_1
                    if v_u_65() then
                        v_u_1.ShowMenuScene()
                    end
                end)
            end)
        end
    end)
    v_u_14.CharacterRemoving:Connect(function()
        -- upvalues: (ref) v_u_65, (ref) v_u_1
        task.delay(0.1, function()
            -- upvalues: (ref) v_u_65, (ref) v_u_1
            if v_u_65() then
                v_u_1.ShowMenuScene()
            end
        end)
    end)
    v_u_7.observeAttribute(v_u_14, "IsSpectating", function(p169)
        -- upvalues: (ref) v_u_1, (ref) v_u_65
        if p169 then
            v_u_1.HideMenuScene()
        elseif v_u_65() then
            v_u_1.ShowMenuScene()
        end
        return function()
            -- upvalues: (ref) v_u_65, (ref) v_u_1
            if v_u_65() then
                v_u_1.ShowMenuScene()
            end
        end
    end)
    v_u_7.observeAttribute(v_u_14, "Team", function(p170)
        -- upvalues: (ref) v_u_1, (ref) v_u_65
        if p170 == "Counter-Terrorists" or p170 == "Terrorists" then
            v_u_1.HideMenuScene()
        elseif v_u_65() then
            v_u_1.ShowMenuScene()
        end
        return function()
            -- upvalues: (ref) v_u_65, (ref) v_u_1
            task.delay(0.1, function()
                -- upvalues: (ref) v_u_65, (ref) v_u_1
                if v_u_65() then
                    v_u_1.ShowMenuScene()
                end
            end)
        end
    end)
    local function v_u_175()
        -- upvalues: (ref) v_u_25, (ref) v_u_26, (ref) v_u_27, (ref) v_u_112, (ref) v_u_84, (ref) v_u_117
        if v_u_25 and v_u_26 then
            if v_u_27 and v_u_27.Parent then
                v_u_27:Destroy()
                v_u_27 = nil
            end
            local v171 = v_u_25:FindFirstChild("RightHand")
            local v172 = v171 and v171:FindFirstChild("WeaponAttachment")
            if v172 then
                v172:Destroy()
            end
            local v173 = v_u_25:FindFirstChild("CharacterArmor")
            if v173 then
                for _, v174 in ipairs(v173:GetChildren()) do
                    if v174:IsA("BasePart") and v174:FindFirstChild("GloveAttachment") then
                        v174:Destroy()
                    end
                end
            end
            v_u_27 = v_u_112(v_u_25, v_u_26, true)
            v_u_84(v_u_25, v_u_26, true)
            v_u_117(v_u_25)
        end
    end
    local v_u_176 = v_u_10.CreateListener(v_u_14, "Loadout", function()
        -- upvalues: (copy) v_u_175
        v_u_175()
    end)
    v_u_28:Add(function()
        -- upvalues: (ref) v_u_10, (ref) v_u_14, (copy) v_u_176
        v_u_10.RemoveListener(v_u_14, "Loadout", v_u_176)
    end, true, "LoadoutListener")
    local v177 = require(v_u_2.Database.Components.GameState)
    local v_u_178 = require(v_u_2.Controllers.SpectateController)
    v177.ListenToState(function(_, p179)
        -- upvalues: (ref) v_u_14, (copy) v_u_178, (ref) v_u_65, (ref) v_u_1
        if p179 == "Game Ending" or p179 == "Map Voting" then
            if v_u_14:GetAttribute("IsSpectating") then
                v_u_178.Stop(false, true)
            end
            if v_u_65() then
                v_u_1.ShowMenuScene()
            end
        end
    end)
end
function v_u_1.Start() end
return v_u_1
