-- MODULESCRIPT: TeamSelection
-- Original Path: game.BAC - 17285.Interface.Screens.Gameplay.Middle.TeamSelection
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = require(v_u_2.Controllers.EndScreenController)
local v_u_6 = require(v_u_2.Controllers.SpectateController)
local v_u_7 = require(v_u_2.Controllers.CameraController)
local v_u_8 = require(v_u_2.Database.Components.GameState)
local v_u_9 = require(v_u_2.Components.Common.GetTimerFormat)
local v_u_10 = require(v_u_2.Components.Common.GetUserPlatform)
local v_u_11 = require(v_u_2.Packages.Observers)
local v_u_12 = require(v_u_2.Database.Security.Remotes)
local v_u_13 = require(v_u_2.Interface.MenuState)
local v_u_14 = v_u_4.LocalPlayer
local v_u_15 = false
local v_u_16 = 0
local v_u_17 = nil
local v_u_18 = nil
local function v_u_23(p19, p20)
    -- upvalues: (copy) v_u_4
    local v21 = 0
    for _, v22 in ipairs(v_u_4:GetPlayers()) do
        if v22 ~= p20 and v22:GetAttribute("Team") == p19 then
            v21 = v21 + 1
        end
    end
    return v21
end
local function v_u_28(p24, p25)
    -- upvalues: (copy) v_u_23
    if workspace:GetAttribute("VIPDisableTeamLimitEnabled") == true then
        return (p25 == "Counter-Terrorists" or p25 == "Terrorists") and true or p25 == "Spectators"
    end
    local v26 = v_u_23("Counter-Terrorists", p24)
    local v27 = v_u_23("Terrorists", p24)
    if p25 == "Terrorists" then
        if v27 < v26 then
            return true
        end
    elseif p25 == "Counter-Terrorists" and v26 < v27 then
        return true
    end
    return p25 == "Spectators" and true or v26 == v27
end
local v_u_29 = ColorSequence.new(Color3.fromRGB(32, 32, 32))
local v_u_30 = {}
local v_u_31 = {}
local function v_u_34(p32, p33)
    if p32 and p32:IsA("Frame") then
        p32.BackgroundColor3 = p33 == "Counter-Terrorists" and Color3.fromRGB(109, 121, 140) or Color3.fromRGB(131, 111, 66)
        p32.Player.UIStroke.Color = p33 == "Counter-Terrorists" and Color3.fromRGB(50, 56, 65) or Color3.fromRGB(94, 85, 54)
        p32.Player.Avatar.ImageColor3 = Color3.fromRGB(138, 138, 138)
    end
end
local function v_u_43()
    -- upvalues: (copy) v_u_23, (ref) v_u_17, (copy) v_u_30, (copy) v_u_31, (copy) v_u_29, (copy) v_u_34
    local v35 = workspace:GetAttribute("VIPDisableTeamLimitEnabled") == true
    local v36 = v_u_23("Counter-Terrorists")
    local v37 = v_u_23("Terrorists")
    for _, v38 in ipairs({ "Counter-Terrorists", "Terrorists" }) do
        local v39 = v_u_17:FindFirstChild(v38)
        if v39 then
            if not v_u_30[v38] then
                v_u_30[v38] = {
                    ["TeamTransparency"] = v39.Team.TextTransparency,
                    ["PlayersTransparency"] = v39.Players.TextTransparency,
                    ["UIGradient"] = v39.UIGradient.Color,
                    ["IconOutline"] = v39.Icon.Outline.ImageTransparency,
                    ["IconTeam"] = v39.Icon.Team.ImageTransparency,
                    ["IconTeamIcon"] = v39.Icon.Team.Icon.ImageTransparency
                }
            end
            local v40 = not v35
            if v40 then
                if v38 == "Counter-Terrorists" and v37 < v36 then
                    v40 = true
                elseif v38 == "Terrorists" then
                    v40 = v36 < v37
                else
                    v40 = false
                end
            end
            v_u_31[v38] = v40
            local v41 = v_u_30[v38]
            v39.Team.TextTransparency = v40 and 0.5 or v41.TeamTransparency
            v39.Players.TextTransparency = v40 and 0.5 or v41.PlayersTransparency
            v39.UIGradient.Color = v40 and v_u_29 or v41.UIGradient
            v39.Icon.Outline.ImageTransparency = v40 and 0.4 or v41.IconOutline
            v39.Icon.Team.ImageTransparency = v40 and 0.4 or v41.IconTeam
            v39.Icon.Team.Icon.ImageTransparency = v40 and 0.4 or v41.IconTeamIcon
            for _, v42 in ipairs(v39.Container:GetChildren()) do
                if v40 then
                    v_u_34(v42, v38)
                end
            end
        end
    end
end
local function v_u_45(p_u_44)
    -- upvalues: (copy) v_u_3
    p_u_44.MouseEnter:Connect(function()
        -- upvalues: (ref) v_u_3, (copy) p_u_44
        v_u_3:Create(p_u_44, TweenInfo.new(0.1), {
            ["BackgroundTransparency"] = 0.85
        }):Play()
    end)
    p_u_44.MouseLeave:Connect(function()
        -- upvalues: (ref) v_u_3, (copy) p_u_44
        v_u_3:Create(p_u_44, TweenInfo.new(0.1), {
            ["BackgroundTransparency"] = 1
        }):Play()
    end)
end
function v_u_1.ToggleTeamSelection()
    -- upvalues: (copy) v_u_5, (ref) v_u_17, (copy) v_u_1
    if v_u_5.IsActive() then
        return
    elseif v_u_17.Visible then
        v_u_1.closeFrame()
    else
        v_u_1.openFrame()
    end
end
function v_u_1.openFrame()
    -- upvalues: (copy) v_u_5, (copy) v_u_13, (ref) v_u_17, (ref) v_u_18, (copy) v_u_2, (copy) v_u_7, (ref) v_u_15, (copy) v_u_14, (copy) v_u_10, (copy) v_u_43
    if v_u_5.IsActive() then
        return
    elseif v_u_13.IsCaseSceneActive() or v_u_13.IsInspectActive() then
        return
    elseif not v_u_17.Visible then
        local v46 = v_u_18.Menu.Visible and v_u_13.GetCurrentScreen()
        if v46 and (v46 == "Loadout" or (v46 == "Inventory" or (v46 == "Modes" or v46 == "Settings")) or v46 == "Store") then
            local v47 = v_u_18.Menu:FindFirstChild(v46)
            if v47 and v47.Visible then
                return
            end
        end
        local v48 = require(v_u_2.Controllers.MenuSceneController)
        if v48.IsActive() then
            v48.HideMenuScene(true, false)
        end
        if v_u_18.Menu.Visible then
            v_u_7.setForceLockOverride("Menu", false)
            v_u_13.SetBlurEnabled(false)
        end
        local v49 = v_u_18.Gameplay.Middle:FindFirstChild("BuyMenu")
        v_u_15 = v49 and v49.Visible or false
        if v_u_15 then
            require(v_u_2.Interface.Screens.Gameplay.Middle.BuyMenu).closeFrame()
        end
        v_u_7.setForceLockOverride("TeamSelection", true)
        if not v_u_14:GetAttribute("IsSpectating") then
            v_u_7.setPerspective(true, true)
        end
        v_u_18.Gameplay.Bottom.Visible = false
        v_u_18.Gameplay.Top.Visible = true
        v_u_18.Gameplay.Visible = true
        v_u_18.Menu.Visible = false
        for _, v50 in ipairs(v_u_18.Gameplay.Middle:GetChildren()) do
            local v51 = table.find(v_u_10(), "Mobile")
            if v50.Name == "Chat" then
                v50.Visible = not v51
            elseif v50.Name == "MobileButtons" then
                local v52 = v_u_14.Character
                if v52 and v52:IsDescendantOf(workspace) then
                    v50.Visible = v51
                else
                    v50.Visible = false
                end
            else
                v50.Visible = v50.Name == "Notification" and true or v50.Name == "TeamSelection"
            end
        end
        v_u_43()
    end
end
function v_u_1.closeFrame()
    -- upvalues: (copy) v_u_7, (copy) v_u_14, (ref) v_u_17, (ref) v_u_18, (copy) v_u_10, (ref) v_u_15, (copy) v_u_2
    v_u_7.setForceLockOverride("TeamSelection", false)
    if v_u_14.Character then
        v_u_7.setForceLockOverride("Menu", false)
    end
    if not v_u_14:GetAttribute("IsSpectating") then
        v_u_7.setPerspective(true, false)
    end
    v_u_17.Visible = false
    v_u_18.Gameplay.Middle.Crosshair.Visible = true
    v_u_18.Gameplay.Top.Visible = true
    v_u_18.Gameplay.Bottom.Visible = true
    local v53 = table.find(v_u_10(), "Mobile")
    local v54 = v_u_14.Character
    local v55 = v_u_14:GetAttribute("IsSpectating") == true
    for _, v56 in ipairs(v_u_18.Gameplay.Middle:GetChildren()) do
        local v57
        if v54 then
            v57 = v54:IsDescendantOf(workspace)
        else
            v57 = v54
        end
        local v58 = v56.Name
        if v58 == "Chat" then
            v56.Visible = not v53
        elseif v58 == "MobileButtons" then
            local v59
            if v53 then
                v59 = v57 or (v55 or false)
            else
                v59 = false
            end
            v56.Visible = v59
        elseif v58 == "Votekick" then
            v56.Visible = v56:GetAttribute("IsVoteKickActive") == true
        elseif v58 == "Notification" then
            v56.Visible = true
        elseif v58 == "SessionStats" then
            v56.Visible = not v53
        elseif v58 == "Radar" or v58 == "Crosshair" then
            v56.Visible = v57
        else
            v56.Visible = false
        end
    end
    if v_u_15 then
        local v60 = require(v_u_2.Interface.Screens.Gameplay.Middle.BuyMenu)
        v_u_15 = false
        v60.openFrame()
    end
end
function v_u_1.chooseTeam(p61)
    -- upvalues: (copy) v_u_14, (copy) v_u_1, (copy) v_u_28, (ref) v_u_16, (copy) v_u_12
    if v_u_14:GetAttribute("Team") == p61 then
        v_u_1.closeFrame()
    elseif v_u_28(v_u_14, p61) and tick() - v_u_16 >= 1 then
        v_u_12.TeamSelection.SelectTeam.Send(p61)
        v_u_16 = tick()
    end
end
function v_u_1.createTeamButtonAnimation(p62, p_u_63)
    -- upvalues: (ref) v_u_17, (copy) v_u_31
    local v_u_64 = v_u_17:FindFirstChild(p_u_63)
    if v_u_64 then
        p62.MouseEnter:Connect(function()
            -- upvalues: (ref) v_u_31, (copy) p_u_63, (copy) v_u_64
            if not v_u_31[p_u_63] then
                local v65 = v_u_64.Icon.Outline
                local v66 = p_u_63 == "Counter-Terrorists" and Color3.fromRGB(165, 183, 212)
                if not v66 then
                    if p_u_63 == "Terrorists" then
                        v66 = Color3.fromRGB(219, 199, 126)
                    else
                        v66 = false
                    end
                end
                v65.ImageColor3 = v66
                local v67 = v_u_64.Icon.Team.Icon
                local v68 = p_u_63 == "Counter-Terrorists" and Color3.fromRGB(255, 255, 255)
                if not v68 then
                    if p_u_63 == "Terrorists" then
                        v68 = Color3.fromRGB(255, 255, 255)
                    else
                        v68 = false
                    end
                end
                v67.ImageColor3 = v68
                local v69 = v_u_64.Icon.Team
                local v70 = p_u_63 == "Counter-Terrorists" and Color3.fromRGB(36, 41, 47)
                if not v70 then
                    if p_u_63 == "Terrorists" then
                        v70 = Color3.fromRGB(89, 79, 50)
                    else
                        v70 = false
                    end
                end
                v69.ImageColor3 = v70
                v_u_64.UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.14375), NumberSequenceKeypoint.new(0.318, 1), NumberSequenceKeypoint.new(1, 1) })
                for _, v71 in ipairs(v_u_64.Container:GetChildren()) do
                    if v71:IsA("Frame") then
                        local v72 = p_u_63 == "Counter-Terrorists" and Color3.fromRGB(126, 140, 187)
                        if not v72 then
                            if p_u_63 == "Terrorists" then
                                v72 = Color3.fromRGB(219, 188, 110)
                            else
                                v72 = false
                            end
                        end
                        v71.BackgroundColor3 = v72
                        local v73 = v71.Player.UIStroke
                        local v74 = p_u_63 == "Counter-Terrorists" and Color3.fromRGB(165, 183, 212)
                        if not v74 then
                            if p_u_63 == "Terrorists" then
                                v74 = Color3.fromRGB(219, 199, 126)
                            else
                                v74 = false
                            end
                        end
                        v73.Color = v74
                        v71.Player.Avatar.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end)
        p62.MouseLeave:Connect(function()
            -- upvalues: (ref) v_u_31, (copy) p_u_63, (copy) v_u_64
            if not v_u_31[p_u_63] then
                local v75 = v_u_64.Icon.Outline
                local v76 = p_u_63 == "Counter-Terrorists" and Color3.fromRGB(107, 119, 138)
                if not v76 then
                    if p_u_63 == "Terrorists" then
                        v76 = Color3.fromRGB(127, 115, 73)
                    else
                        v76 = false
                    end
                end
                v75.ImageColor3 = v76
                local v77 = v_u_64.Icon.Team.Icon
                local v78 = p_u_63 == "Counter-Terrorists" and Color3.fromRGB(131, 131, 131)
                if not v78 then
                    if p_u_63 == "Terrorists" then
                        v78 = Color3.fromRGB(182, 182, 182)
                    else
                        v78 = false
                    end
                end
                v77.ImageColor3 = v78
                local v79 = v_u_64.Icon.Team
                local v80 = p_u_63 == "Counter-Terrorists" and Color3.fromRGB(20, 24, 27)
                if not v80 then
                    if p_u_63 == "Terrorists" then
                        v80 = Color3.fromRGB(58, 51, 33)
                    else
                        v80 = false
                    end
                end
                v79.ImageColor3 = v80
                v_u_64.UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.14375), NumberSequenceKeypoint.new(0.183193, 1), NumberSequenceKeypoint.new(1, 1) })
                for _, v81 in ipairs(v_u_64.Container:GetChildren()) do
                    if v81:IsA("Frame") then
                        local v82 = p_u_63 == "Counter-Terrorists" and Color3.fromRGB(109, 121, 140)
                        if not v82 then
                            if p_u_63 == "Terrorists" then
                                v82 = Color3.fromRGB(131, 111, 66)
                            else
                                v82 = false
                            end
                        end
                        v81.BackgroundColor3 = v82
                        local v83 = v81.Player.UIStroke
                        local v84 = p_u_63 == "Counter-Terrorists" and Color3.fromRGB(50, 56, 65)
                        if not v84 then
                            if p_u_63 == "Terrorists" then
                                v84 = Color3.fromRGB(94, 85, 54)
                            else
                                v84 = false
                            end
                        end
                        v83.Color = v84
                        v81.Player.Avatar.ImageColor3 = Color3.fromRGB(138, 138, 138)
                    end
                end
            end
        end)
    end
end
function v_u_1.updatePlayerList(p_u_85, p86)
    -- upvalues: (ref) v_u_17, (copy) v_u_2, (copy) v_u_4, (copy) v_u_31, (copy) v_u_34, (copy) v_u_23, (copy) v_u_43
    local v87 = p_u_85:GetAttribute("Team")
    if v87 == "Counter-Terrorists" or v87 == "Terrorists" then
        local v88 = v_u_17
        local v89 = p_u_85.UserId
        local v90 = v88:FindFirstChild(tostring(v89), true)
        if v90 then
            v90:Destroy()
        end
        local v91 = v_u_2.Assets.UI.TeamSelection:FindFirstChild(v87)
        if v91 and not p86 then
            local v92 = v_u_17:WaitForChild(v87)
            local _, v93 = pcall(function()
                -- upvalues: (ref) v_u_4, (copy) p_u_85
                return v_u_4:GetUserThumbnailAsync(p_u_85.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
            end)
            local v94 = v91:Clone()
            v94.Parent = v92.Container
            v94.Team.Text = p_u_85.DisplayName
            v94.Player.Avatar.Image = v93
            local v95 = p_u_85.UserId
            v94.Name = tostring(v95)
            v94.Visible = true
            if v_u_31[v87] then
                v_u_34(v94, v87)
            end
        end
    else
        local v96 = v_u_17
        local v97 = p_u_85.UserId
        local v98 = v96:FindFirstChild(tostring(v97), true)
        if v98 then
            v98:Destroy()
        end
    end
    v_u_17["Counter-Terrorists"].Players.Text = ("%* Player(s)"):format((v_u_23("Counter-Terrorists")))
    v_u_17.Terrorists.Players.Text = ("%* Player(s)"):format((v_u_23("Terrorists")))
    v_u_43()
end
function v_u_1.Initialize(p99, p100)
    -- upvalues: (ref) v_u_17, (ref) v_u_18, (copy) v_u_11, (copy) v_u_1, (copy) v_u_14, (copy) v_u_8, (copy) v_u_9, (copy) v_u_43
    v_u_17 = p100
    v_u_18 = p99
    v_u_11.observePlayer(function(p_u_101)
        -- upvalues: (ref) v_u_1, (ref) v_u_11, (ref) v_u_14, (ref) v_u_17
        v_u_1.updatePlayerList(p_u_101)
        local v_u_105 = v_u_11.observeAttribute(p_u_101, "Team", function(_)
            -- upvalues: (ref) v_u_1, (copy) p_u_101, (ref) v_u_14, (ref) v_u_17
            v_u_1.updatePlayerList(p_u_101)
            if v_u_14 == p_u_101 then
                v_u_1.closeFrame()
            end
            return function()
                -- upvalues: (ref) v_u_17, (ref) p_u_101
                local v102 = v_u_17
                local v103 = p_u_101.UserId
                local v104 = v102:FindFirstChild(tostring(v103), true)
                if v104 then
                    v104:Destroy()
                end
            end
        end)
        return function()
            -- upvalues: (ref) v_u_1, (copy) p_u_101, (copy) v_u_105
            v_u_1.updatePlayerList(p_u_101, true)
            v_u_105()
        end
    end)
    v_u_11.observeAttribute(v_u_14, "Team", function(_)
        -- upvalues: (ref) v_u_8, (ref) v_u_1
        if v_u_8.GetState() == "Round In Progress" then
            v_u_1.closeFrame()
        end
    end)
    v_u_11.observeAttribute(workspace, "Timer", function(p106)
        -- upvalues: (ref) v_u_17, (ref) v_u_9
        v_u_17.ProgressBar.Timer.Text = v_u_9(p106)
    end)
    v_u_14.CharacterAdded:Connect(function()
        -- upvalues: (ref) v_u_17, (ref) v_u_1
        if v_u_17.Visible then
            v_u_1.closeFrame()
        end
    end)
    v_u_11.observeAttribute(workspace, "VIPDisableTeamLimitEnabled", function()
        -- upvalues: (ref) v_u_43
        v_u_43()
    end)
end
function v_u_1.Start()
    -- upvalues: (ref) v_u_17, (copy) v_u_1, (copy) v_u_45, (copy) v_u_14, (copy) v_u_23, (copy) v_u_12, (copy) v_u_6, (copy) v_u_2, (copy) v_u_7, (ref) v_u_18
    local v107 = v_u_17["Counter-Terrorists"].Button
    local v_u_108 = "Counter-Terrorists"
    v107.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_1, (copy) v_u_108
        v_u_1.chooseTeam(v_u_108)
    end)
    v_u_1.createTeamButtonAnimation(v107, "Counter-Terrorists")
    local v109 = v_u_17.Bottom.Buttons.Spectate
    local v_u_110 = "Spectators"
    v109.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_1, (copy) v_u_110
        v_u_1.chooseTeam(v_u_110)
    end)
    v_u_45(v109)
    local v111 = v_u_17.Terrorists.Button
    local v_u_112 = "Terrorists"
    v111.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_1, (copy) v_u_112
        v_u_1.chooseTeam(v_u_112)
    end)
    v_u_1.createTeamButtonAnimation(v111, "Terrorists")
    v_u_45(v_u_17.Bottom.Buttons.AutoSelect)
    v_u_17.Bottom.Buttons.AutoSelect.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_1, (ref) v_u_14, (ref) v_u_23
        local v113 = v_u_1.chooseTeam
        local v114 = v_u_14
        local v115 = v_u_23("Counter-Terrorists", v114)
        local v116 = v_u_23("Terrorists", v114)
        local v117
        if v115 == v116 then
            local v118 = v114:GetAttribute("Team")
            v117 = v118 == "Counter-Terrorists" and "Terrorists" or (v118 == "Terrorists" and "Counter-Terrorists" or "Terrorists")
        else
            v117 = v115 < v116 and "Counter-Terrorists" or "Terrorists"
        end
        v113(v117)
    end)
    v_u_45(v_u_17.Bottom.Buttons.BackHome)
    v_u_17.Bottom.Buttons.BackHome.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_14, (ref) v_u_1, (ref) v_u_12, (ref) v_u_6, (ref) v_u_2, (ref) v_u_7, (ref) v_u_18
        if v_u_14:GetAttribute("IsSpectating") ~= true then
            local v119 = v_u_14.Character
            local v120
            if v119 and v119:IsDescendantOf(workspace) then
                local v121 = v119:FindFirstChild("Humanoid")
                if v121 == nil then
                    v120 = false
                else
                    v120 = v121.Health > 0
                end
            else
                v120 = false
            end
            if v120 then
                v_u_1.closeFrame()
                return
            end
        end
        local v122 = v_u_14:GetAttribute("Team")
        if v122 and v122 ~= "Spectators" then
            v_u_12.TeamSelection.SelectTeam.Send("Spectators")
        end
        v_u_6.Stop(true, true)
        v_u_1.closeFrame()
        local v123 = require(v_u_2.Interface.Screens.Menu.Top)
        local v124 = require(v_u_2.Controllers.MenuSceneController)
        v_u_7.setForceLockOverride("Menu", true)
        v_u_7.setPerspective(true, true)
        v_u_18.Gameplay.Visible = false
        v_u_18.Gameplay.Bottom.Visible = false
        v_u_18.Menu.Visible = true
        v123.ResetToMainMenu()
        v124.ShowMenuScene()
    end)
end
return v_u_1
