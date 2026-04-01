-- MODULESCRIPT: Top
-- Original Path: game.BAC - 20621.Interface.Screens.Menu.Top
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("GuiService")
local v6 = game:GetService("Lighting")
local v7 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_8 = v7.LocalPlayer
local v_u_9 = require(v_u_2.Controllers.CameraController)
local v_u_10 = require(v_u_2.Components.Common.GetUserPlatform)
local v_u_11 = require(v_u_2.Database.Components.GameState)
local v_u_12 = require(v_u_2.Database.Security.Router)
local v_u_13 = require(v_u_2.Packages.Observers)
local v_u_14 = require(v_u_2.Interface.MenuState)
local v_u_15 = require(v_u_2.Interface.Screens.Gameplay.Middle.TeamSelection)
local v_u_16 = workspace.CurrentCamera
local v_u_17 = Instance.new("BlurEffect", v6)
v_u_17.Enabled = false
v_u_17.Name = "Menu"
v_u_17.Size = 20
local v_u_18 = false
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = Color3.fromRGB(255, 255, 255)
local v_u_22 = Color3.fromRGB(150, 220, 239)
local v_u_23 = Color3.fromRGB(175, 175, 175)
local v_u_24 = nil
local v_u_25 = nil
local function v_u_28(p26, p27)
    -- upvalues: (copy) v_u_4
    if p26:IsA("ImageButton") then
        v_u_4:Create(p26, TweenInfo.new(0.15), {
            ["ImageColor3"] = p27
        }):Play()
    elseif p26:IsA("TextButton") then
        v_u_4:Create(p26.TextLabel, TweenInfo.new(0.15), {
            ["TextColor3"] = p27
        }):Play()
    end
end
local function v_u_32(p_u_29)
    -- upvalues: (copy) v_u_21, (ref) v_u_20, (copy) v_u_28, (copy) v_u_12, (copy) v_u_23, (copy) v_u_22
    if p_u_29:IsA("ImageButton") then
        p_u_29.ImageColor3 = v_u_21
    elseif p_u_29:IsA("TextButton") then
        p_u_29.TextLabel.TextColor3 = v_u_21
    end
    p_u_29.MouseLeave:Connect(function()
        -- upvalues: (ref) v_u_20, (copy) p_u_29, (ref) v_u_28, (ref) v_u_21
        if v_u_20 ~= p_u_29 then
            v_u_28(p_u_29, v_u_21)
        end
    end)
    p_u_29.MouseEnter:Connect(function()
        -- upvalues: (ref) v_u_12, (ref) v_u_20, (copy) p_u_29, (ref) v_u_28, (ref) v_u_23
        v_u_12.broadcastRouter("RunInterfaceSound", "UI Highlight")
        if v_u_20 ~= p_u_29 then
            v_u_28(p_u_29, v_u_23)
        end
    end)
    p_u_29.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_20, (copy) p_u_29, (ref) v_u_28, (ref) v_u_22, (ref) v_u_21
        local v30 = v_u_20
        v_u_20 = p_u_29
        if v30 ~= p_u_29 then
            v_u_28(p_u_29, v_u_22)
            if v30 then
                local v31 = v30:FindFirstChild("Alert")
                v_u_28(v30, v_u_21)
                if v31 then
                    v31.Visible = false
                    return
                end
            end
        end
    end)
end
function v_u_1.UpdateBackground(p33)
    -- upvalues: (copy) v_u_2, (copy) v_u_14, (copy) v_u_8, (ref) v_u_25, (copy) v_u_16, (copy) v_u_9
    if require(v_u_2.Controllers.MenuSceneController).IsActive() then
        return
    elseif v_u_14.IsInspectActive() or v_u_14.IsCaseSceneActive() then
        return
    elseif not v_u_8:GetAttribute("IsSpectating") then
        local v34 = v_u_25.Menu.Visible and (not v_u_8.Character and p33:FindFirstChild("Cameras"))
        if v34 then
            local v35 = v34:GetChildren()
            local v36 = v35[1]
            assert(v36, "Current map doesnt contain any cameras.")
            v_u_16.CameraType = Enum.CameraType.Scriptable
            v_u_16.CameraSubject = nil
            local v37 = v35[math.random(1, #v35)]
            v_u_8.ReplicationFocus = v37
            v_u_16.CFrame = v37.CFrame
            v_u_9.updateCameraFOV(80)
        end
    end
end
function v_u_1.ToggleMenu()
    -- upvalues: (copy) v_u_14, (copy) v_u_1, (copy) v_u_11, (ref) v_u_25, (copy) v_u_9, (copy) v_u_8, (copy) v_u_15, (ref) v_u_19
    if v_u_14.IsInspectActive() or v_u_14.IsCaseSceneActive() then
        return
    else
        if workspace:FindFirstChild("Map") then
            v_u_1.UpdateBackground(workspace:FindFirstChild("Map"))
        end
        local v38 = v_u_11.GetState()
        if v38 and (v38 ~= "Map Voting" and v38 ~= "Game Ending") then
            if v_u_25.Menu.Visible then
                v_u_9.setForceLockOverride("Menu", false)
                if not v_u_8:GetAttribute("IsSpectating") then
                    v_u_9.setPerspective(true, false)
                end
                v_u_14.SetBlurEnabled(false)
                v_u_25.Gameplay.Visible = true
                v_u_25.Gameplay.Top.Visible = true
                v_u_25.Menu.Visible = false
                v_u_14.SetScreen(nil)
            else
                if v_u_25.Gameplay.Middle.TeamSelection.Visible then
                    v_u_15.closeFrame()
                end
                v_u_9.setForceLockOverride("Menu", true)
                if not v_u_8:GetAttribute("IsSpectating") then
                    v_u_9.setPerspective(true, true)
                end
                v_u_25.Gameplay.Visible = false
                v_u_25.Menu.Visible = true
                if v_u_8.Character then
                    v_u_1.openFrame("GameDashboard")
                end
                if v_u_19 and v_u_19.Name ~= "Dashboard" then
                    v_u_14.SetBlurEnabled(true)
                end
            end
        else
            return
        end
    end
end
function v_u_1.openFrame(p39)
    -- upvalues: (copy) v_u_2, (copy) v_u_14, (copy) v_u_12, (ref) v_u_25, (copy) v_u_11, (copy) v_u_9, (ref) v_u_19, (copy) v_u_8, (copy) v_u_10, (ref) v_u_18
    local v40 = v_u_2:GetAttribute("Environment")
    if v_u_14.IsInspectActive() then
        return
    elseif v_u_14.IsCaseSceneActive() then
        return
    elseif p39 == "Store" and v40 ~= "Production" then
        v_u_12.broadcastRouter("RunInterfaceSound", "UI Store Click")
        return
    else
        local v41
        if p39 == "Dashboard" then
            v41 = false
        else
            v41 = p39 ~= "Play"
        end
        v_u_14.SetBlurEnabled(v41)
        local v42 = v_u_25.Menu:FindFirstChild("Pattern")
        v_u_25.Menu.BackgroundTransparency = v41 and 0.15 or 1
        if v42 then
            v42.Visible = not v41
        end
        if p39 == "Play" then
            local v43 = v_u_11.GetState()
            local v44 = require(v_u_2.Controllers.EndScreenController)
            if v43 and (v43 ~= "Game Ending" or not v44.IsActive()) then
                local v45 = nil
                v_u_12.broadcastRouter("RunInterfaceSound", "UI Play Click")
                v_u_9.resetForceLockOverride()
                v_u_9.setPerspective(true, false)
                if v_u_19 and v_u_19.Name ~= "Dashboard" then
                    v_u_19.Visible = false
                    local v46 = v_u_25.Menu:FindFirstChild("Dashboard")
                    if v46 then
                        v46.Visible = true
                        v_u_19 = v46
                    end
                end
                v_u_25.Gameplay.Bottom.Visible = false
                v_u_25.Gameplay.Top.Visible = true
                v_u_25.Gameplay.Visible = true
                v_u_25.Menu.Visible = false
                v_u_14.SetScreen(nil)
                local v47
                if v43 == "Map Voting" then
                    v47 = "EndScreen"
                else
                    local v48 = v_u_8:GetAttribute("Team")
                    v47 = (not v_u_8.Character or (not v48 or v48 == "Spectators")) and "TeamSelection" or v45
                end
                if v47 then
                    v_u_9.setForceLockOverride(v47, true)
                    v_u_9.setPerspective(true, true)
                    for _, v49 in ipairs(v_u_25.Gameplay.Middle:GetChildren()) do
                        if v49.Name == "Chat" then
                            v49.Visible = not table.find(v_u_10(), "Mobile")
                        else
                            v49.Visible = (v49.Name == "Notification" or v49.Name == "Votekick" and v49:GetAttribute("IsVoteKickActive") == true) and true or v49.Name == v47
                        end
                    end
                    return
                end
                v_u_25.Gameplay.Middle.SessionStats.Visible = table.find(v_u_10(), "Mobile") == nil
                v_u_25.Gameplay.Middle.TeamSelection.Visible = false
                v_u_25.Gameplay.Middle.Crosshair.Visible = true
                v_u_25.Gameplay.Top.Visible = true
                v_u_25.Gameplay.Bottom.Visible = true
                if v_u_8.Character then
                    v_u_9.setPerspective(true, false)
                    return
                end
            end
            return
        else
            local v50 = v_u_25.Menu:FindFirstChild(p39)
            if v50 and v50 ~= v_u_19 then
                v50.Visible = true
                if v_u_19 then
                    v_u_19.Visible = false
                end
                v_u_19 = v50
                local v51 = v_u_14.SetScreen
                local v52
                if p39 == "Dashboard" or (p39 == "Inventory" or (p39 == "Loadout" or (p39 == "Modes" or (p39 == "Settings" or (p39 == "Store" or p39 == "GameDashboard"))))) then
                    v52 = p39
                else
                    v52 = nil
                end
                v51(v52)
            end
            if v_u_18 then
                v_u_12.broadcastRouter("RunInterfaceSound", (("UI %* Click"):format(p39)))
            else
                v_u_18 = p39 == "Dashboard"
            end
        end
    end
end
function v_u_1.CloseTeamSelection()
    -- upvalues: (ref) v_u_25, (copy) v_u_17, (copy) v_u_1
    v_u_25.Gameplay.Middle.TeamSelection.Visible = false
    v_u_25.Gameplay.Middle.Crosshair.Visible = true
    v_u_25.Gameplay.Top.Visible = true
    v_u_25.Gameplay.Bottom.Visible = true
    if v_u_17.Enabled then
        v_u_1.UpdateBackground(workspace:FindFirstChild("Map"))
    end
end
local v_u_53 = {
    "Inventory",
    "Loadout",
    "Play",
    "Store",
    "Modes"
}
local function v_u_57(p54)
    -- upvalues: (ref) v_u_24, (ref) v_u_20, (copy) v_u_28, (copy) v_u_22, (copy) v_u_21, (copy) v_u_5, (copy) v_u_12
    if v_u_24 and v_u_24.Buttons then
        local v55 = v_u_24.Buttons:FindFirstChild(p54)
        if v55 and v55:IsA("GuiButton") then
            local v56 = v_u_20
            v_u_20 = v55
            v_u_28(v_u_20, v_u_22)
            if v56 and v56 ~= v_u_20 then
                v_u_28(v56, v_u_21)
            end
            v_u_5.SelectedObject = v55
            v_u_12.broadcastRouter("RunInterfaceSound", "UI Highlight")
        end
    else
        return
    end
end
local function v_u_61(p58)
    -- upvalues: (ref) v_u_24, (copy) v_u_1, (ref) v_u_20, (copy) v_u_28, (copy) v_u_22, (copy) v_u_21, (copy) v_u_5, (copy) v_u_12
    if v_u_24 and v_u_24.Buttons then
        local v59 = v_u_24.Buttons:FindFirstChild(p58)
        if v59 and v59:IsA("GuiButton") then
            v_u_1.openFrame(p58)
            local v60 = v_u_20
            v_u_20 = v59
            v_u_28(v_u_20, v_u_22)
            if v60 and v60 ~= v_u_20 then
                v_u_28(v60, v_u_21)
            end
            v_u_5.SelectedObject = v59
            v_u_12.broadcastRouter("RunInterfaceSound", "UI Highlight")
        end
    else
        return
    end
end
local function v_u_65()
    -- upvalues: (ref) v_u_25, (copy) v_u_14
    if not v_u_25 then
        return false
    end
    local v62 = v_u_14.GetCurrentScreen()
    if not (v_u_25.Menu.Visible and v62) then
        return false
    end
    if v62 ~= "Loadout" and (v62 ~= "Inventory" and (v62 ~= "Modes" and v62 ~= "Settings")) and v62 ~= "Store" then
        return false
    end
    local v63 = v_u_25.Menu:FindFirstChild(v62)
    local v64
    if v63 == nil then
        v64 = false
    else
        v64 = v63.Visible
    end
    return v64
end
function v_u_1.ResetToMainMenu()
    -- upvalues: (copy) v_u_14, (copy) v_u_65, (ref) v_u_25, (ref) v_u_19, (ref) v_u_20, (copy) v_u_28, (copy) v_u_21, (ref) v_u_24, (copy) v_u_22
    if v_u_14.IsInspectActive() or v_u_14.IsCaseSceneActive() then
        return
    elseif not v_u_65() then
        for _, v66 in ipairs(v_u_25.Menu:GetChildren()) do
            if v66:IsA("Frame") and (v66.Name ~= "Top" and v66.Name ~= "Dashboard") then
                v66.Visible = false
            end
        end
        local v67 = v_u_25.Menu:FindFirstChild("Dashboard")
        if v67 then
            v67.Visible = true
            v_u_19 = v67
        end
        local v68 = v_u_25.Menu:FindFirstChild("Top")
        if v68 then
            v68.Visible = true
        end
        v_u_14.SetBlurEnabled(false)
        v_u_25.Menu.BackgroundTransparency = 1
        local v69 = v_u_25.Menu:FindFirstChild("Pattern")
        if v69 then
            v69.Visible = true
        end
        v_u_14.SetScreen("Dashboard")
        if v_u_20 then
            v_u_28(v_u_20, v_u_21)
        end
        v_u_20 = v_u_24.Other.Dashboard
        v_u_28(v_u_20, v_u_22)
    end
end
function v_u_1.Initialize(p70, p71)
    -- upvalues: (ref) v_u_25, (ref) v_u_24, (copy) v_u_32, (copy) v_u_1
    v_u_25 = p70
    v_u_24 = p71
    for _, v_u_72 in ipairs(v_u_24.Other:GetChildren()) do
        if v_u_72:IsA("ImageButton") then
            v_u_32(v_u_72)
            v_u_72.MouseButton1Click:Connect(function()
                -- upvalues: (ref) v_u_1, (copy) v_u_72
                v_u_1.openFrame(v_u_72.Name)
            end)
        end
    end
    for _, v_u_73 in ipairs(v_u_24.Buttons:GetChildren()) do
        if v_u_73:IsA("TextButton") then
            v_u_32(v_u_73)
            v_u_73.MouseButton1Click:Connect(function()
                -- upvalues: (ref) v_u_1, (copy) v_u_73
                v_u_1.openFrame(v_u_73.Name)
            end)
        end
    end
    if workspace:FindFirstChild("Map") then
        v_u_1.UpdateBackground(workspace:FindFirstChild("Map"))
    end
    workspace.ChildAdded:Connect(function(p74)
        -- upvalues: (ref) v_u_1
        if p74.Name == "Map" then
            task.delay(0.25, v_u_1.UpdateBackground, p74)
        end
    end)
end
function v_u_1.Start()
    -- upvalues: (ref) v_u_20, (ref) v_u_24, (copy) v_u_28, (copy) v_u_22, (ref) v_u_25, (copy) v_u_9, (copy) v_u_8, (copy) v_u_3, (copy) v_u_14, (copy) v_u_53, (copy) v_u_57, (copy) v_u_61, (copy) v_u_5, (copy) v_u_1, (copy) v_u_21, (copy) v_u_12, (ref) v_u_19, (copy) v_u_13, (copy) v_u_11, (copy) v_u_2, (copy) v_u_65
    v_u_20 = v_u_24.Other.Dashboard
    v_u_28(v_u_20, v_u_22)
    local v75 = v_u_25.Menu:FindFirstChild("Pattern")
    v_u_25.Menu.BackgroundTransparency = 1
    if v75 then
        v75.Visible = false
    end
    if v_u_25.Menu.Visible then
        v_u_9.setForceLockOverride("Menu", true)
    end
    local v76 = v_u_8:GetAttribute("Team")
    local v77 = v76 == "Counter-Terrorists" and true or v76 == "Terrorists"
    if not (v_u_8.Character or v77) then
        if not v_u_9.isForceLockOverrideActive() then
            v_u_9.setForceLockOverride("Menu", true)
        end
        if not v_u_25.Menu.Visible then
            v_u_25.Menu.Visible = true
        end
    end
    v_u_3.InputBegan:Connect(function(p78, _)
        -- upvalues: (ref) v_u_25, (ref) v_u_14, (ref) v_u_8, (ref) v_u_20, (ref) v_u_53, (ref) v_u_57, (ref) v_u_61
        if not (v_u_25 and v_u_25.Menu.Visible) then
            return
        end
        if v_u_14.IsInspectActive() or v_u_14.IsCaseSceneActive() then
            return
        end
        if v_u_8:GetAttribute("IsPlayerChatting") then
            return
        end
        local v79
        if p78.UserInputType == Enum.UserInputType.Gamepad1 then
            v79 = p78.KeyCode == Enum.KeyCode.ButtonL1
        else
            v79 = false
        end
        local v80
        if p78.UserInputType == Enum.UserInputType.Gamepad1 then
            v80 = p78.KeyCode == Enum.KeyCode.ButtonR1
        else
            v80 = false
        end
        if not (v79 or v80) then
            return
        end
        local v81 = v_u_20 and v_u_20.Name or nil
        for _, v83 in ipairs(v_u_53) do
            if v83 == v81 then
                goto l26
            end
        end
        local v83 = "Play"
        ::l26::
        local v84
        if v79 then
            local v85 = table.find(v_u_53, v83)
            if v85 then
                local v86 = #v_u_53
                v84 = v_u_53[(v85 - 2 + v86) % v86 + 1]
            else
                v84 = nil
            end
        else
            local v87 = table.find(v_u_53, v83)
            if v87 then
                v84 = v_u_53[v87 % #v_u_53 + 1]
            else
                v84 = nil
            end
        end
        if v84 then
            if v84 == "Play" then
                v_u_57("Play")
                return
            end
            v_u_61(v84)
        end
    end)
    v_u_3.InputBegan:Connect(function(p88, _)
        -- upvalues: (ref) v_u_25, (ref) v_u_14, (ref) v_u_8, (ref) v_u_24, (ref) v_u_5, (ref) v_u_1
        if v_u_25 and v_u_25.Menu.Visible then
            if v_u_14.IsInspectActive() or v_u_14.IsCaseSceneActive() then
                return
            elseif v_u_8:GetAttribute("IsPlayerChatting") then
                return
            elseif p88.UserInputType == Enum.UserInputType.Gamepad1 then
                if p88.KeyCode == Enum.KeyCode.ButtonA then
                    local v89 = v_u_24 and v_u_24.Buttons
                    if v89 then
                        v89 = v_u_24.Buttons:FindFirstChild("Play")
                    end
                    if v89 then
                        local v90 = v_u_5.SelectedObject
                        if v90 == v89 or v90 and v90:IsDescendantOf(v89) then
                            v_u_1.openFrame("Play")
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
    end)
    v_u_1.openFrame("Dashboard")
    v_u_5:GetPropertyChangedSignal("SelectedObject"):Connect(function()
        -- upvalues: (ref) v_u_25, (ref) v_u_14, (ref) v_u_24, (ref) v_u_5, (ref) v_u_53, (ref) v_u_20, (ref) v_u_28, (ref) v_u_22, (ref) v_u_21, (ref) v_u_12
        if not (v_u_25 and v_u_25.Menu.Visible) then
            return
        end
        if v_u_14.IsInspectActive() or v_u_14.IsCaseSceneActive() then
            return
        end
        if not (v_u_24 and v_u_24.Buttons) then
            return
        end
        local v91 = v_u_5.SelectedObject
        if not v91 then
            return
        end
        local v92 = nil
        for _, v93 in ipairs(v_u_53) do
            local v94 = v_u_24.Buttons:FindFirstChild(v93)
            if v94 and (v94:IsA("GuiButton") and (v91 == v94 or v91:IsDescendantOf(v94))) then
                v92 = v94
                break
            end
        end
        local v95
        if v92 or not v_u_24.Other then
            v95 = v92
        else
            v95 = v_u_24.Other:FindFirstChild("Dashboard")
            if not v95 or (not v95:IsA("GuiButton") or v91 ~= v95 and not v91:IsDescendantOf(v95)) then
                v95 = v92
            end
        end
        if v95 and v_u_20 ~= v95 then
            local v96 = v_u_20
            v_u_20 = v95
            v_u_28(v95, v_u_22)
            if v96 then
                v_u_28(v96, v_u_21)
            end
            v_u_12.broadcastRouter("RunInterfaceSound", "UI Highlight")
        end
    end)
    v_u_14.OnScreenChanged:Connect(function(_, p97)
        -- upvalues: (ref) v_u_25, (ref) v_u_19, (ref) v_u_24, (ref) v_u_20, (ref) v_u_28, (ref) v_u_22, (ref) v_u_21
        if p97 then
            local v98 = v_u_25.Menu:FindFirstChild(p97)
            if v98 and v98:IsA("Frame") then
                v_u_19 = v98
            end
            local v99 = v_u_24.Other:FindFirstChild(p97) or v_u_24.Buttons:FindFirstChild(p97)
            if v99 and (v99:IsA("GuiButton") and v_u_20 ~= v99) then
                local v100 = v_u_20
                v_u_20 = v99
                v_u_28(v99, v_u_22)
                if v100 then
                    v_u_28(v100, v_u_21)
                end
            end
        end
    end)
    v_u_8.CharacterAdded:Connect(function(_)
        -- upvalues: (ref) v_u_25, (ref) v_u_14, (ref) v_u_9
        task.defer(function()
            -- upvalues: (ref) v_u_25, (ref) v_u_14, (ref) v_u_9
            if not (v_u_25.Menu.Visible or (v_u_25.Gameplay.Middle.TeamSelection.Visible or (v_u_14.IsCaseSceneActive() or v_u_14.IsInspectActive()))) then
                v_u_9.resetForceLockOverride()
                v_u_9.setPerspective(true, false)
            end
        end)
    end)
    v_u_13.observeAttribute(v_u_8, "Team", function(p101)
        -- upvalues: (ref) v_u_1
        if p101 == "Spectators" then
            v_u_1.CloseTeamSelection()
        end
    end)
    v_u_11.ListenToState(function(p102, p103)
        -- upvalues: (ref) v_u_14, (ref) v_u_25, (ref) v_u_2, (ref) v_u_12, (ref) v_u_65, (ref) v_u_1, (ref) v_u_9, (ref) v_u_8
        if v_u_14.IsCaseSceneActive() then
            if p103 == "Game Ending" or p103 == "Map Voting" then
                v_u_25.Gameplay.Bottom.Visible = false
                v_u_25.Gameplay.Visible = false
            end
            return
        elseif v_u_14.IsInspectActive() then
            return
        else
            if p103 == "Game Ending" or p103 == "Map Voting" then
                if require(v_u_2.Controllers.EndScreenController).IsActive() then
                    if v_u_14.IsInspectActive() then
                        v_u_12.broadcastRouter("WeaponInspectCloseForGameEnd")
                    end
                    return
                end
                v_u_25.Gameplay.Visible = false
                v_u_25.Gameplay.Bottom.Visible = false
                if v_u_14.IsInspectActive() then
                    v_u_12.broadcastRouter("WeaponInspectCloseForGameEnd")
                end
                if not v_u_65() then
                    v_u_1.ResetToMainMenu()
                end
                if not v_u_25.Menu.Visible then
                    v_u_9.setForceLockOverride("Menu", true)
                    v_u_25.Menu.Visible = true
                end
            end
            if p103 == "Map Voting" then
                if v_u_8:GetAttribute("FollowGamemode") or v_u_8:GetAttribute("IsSpectating") then
                    v_u_1.openFrame("Play")
                    return
                end
                if not (v_u_25.Menu.Visible or v_u_65()) then
                    v_u_1.openFrame("Dashboard")
                    v_u_1.ToggleMenu()
                end
            end
            if (p102 == "Game Ending" or p102 == "Map Voting") and (p103 ~= "Game Ending" and p103 ~= "Map Voting") then
                if p102 == "Map Voting" then
                    if v_u_25.Menu.Visible then
                        return
                    end
                    local v104 = v_u_8:GetAttribute("Team")
                    if not v_u_8.Character or (not v104 or v104 == "Spectators") then
                        v_u_25.Menu.Visible = false
                        v_u_25.Gameplay.Visible = true
                        v_u_25.Gameplay.Top.Visible = true
                        require(v_u_2.Interface.Screens.Gameplay.Middle.TeamSelection).openFrame()
                        return
                    end
                elseif v_u_25.Menu.Visible and v_u_65() then
                    return
                end
                task.defer(function()
                    -- upvalues: (ref) v_u_14, (ref) v_u_2, (ref) v_u_25, (ref) v_u_65, (ref) v_u_1, (ref) v_u_9
                    if not v_u_14.IsInspectActive() then
                        if require(v_u_2.Controllers.MenuSceneController).IsActive() and not v_u_25.Menu.Visible then
                            if not v_u_65() then
                                v_u_1.ResetToMainMenu()
                            end
                            v_u_9.setForceLockOverride("Menu", true)
                            v_u_25.Gameplay.Visible = false
                            v_u_25.Menu.Visible = true
                        end
                    end
                end)
            end
            if p103 ~= "Game Ending" and (p103 ~= "Map Voting" and (v_u_25.Menu.Visible and v_u_65())) then
            end
        end
    end)
end
return v_u_1
