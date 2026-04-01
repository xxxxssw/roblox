-- MODULESCRIPT: Leaderboard
-- Original Path: game.BAC - 17285.Interface.Screens.Gameplay.Middle.Leaderboard
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("HttpService")
local v_u_6 = game:GetService("UserInputService")
require(script:WaitForChild("Types"))
local v_u_7 = v_u_4.LocalPlayer
local v_u_8 = require(v_u_2.Database.Components.Common.RemoveFromArray)
local v_u_9 = require(v_u_2.Components.Common.GetBadgeIcon)
local v_u_10 = require(v_u_2.Controllers.EndScreenController)
local v_u_11 = require(v_u_2.Controllers.DataController)
local v_u_12 = require(v_u_2.Controllers.CameraController)
local v_u_13 = require(v_u_2.Packages.Observers)
local v_u_14 = require(v_u_2.Shared.Janitor)
local v_u_15 = require(v_u_2.Components.Common.GetTimerFormat)
local v_u_16 = UDim2.fromScale(0.582, 0.782)
local v_u_17 = UDim2.fromScale(0.582, 0.355)
local v_u_18 = UDim2.fromScale(0.282, 0.85)
local v_u_19 = UDim2.fromScale(0.82, 0.9)
local v_u_20 = UDim2.fromScale(0.758, 0.9)
local v_u_21 = UDim2.fromScale(0.638, 0.9)
local v_u_22 = UDim2.fromScale(0.937, 0.9)
local v_u_23 = UDim2.fromScale(0.702, 0.9)
local v_u_24 = UDim2.fromScale(0.882, 0.9)
local v_u_25 = UDim2.fromScale(0.762, 0.365)
local v_u_26 = UDim2.fromScale(0.503, 0.785)
local v_u_27 = UDim2.fromScale(0.503, 0.364)
local v_u_28 = UDim2.fromScale(0.135, 0.85)
local v_u_29 = UDim2.fromScale(0.79, 0.9)
local v_u_30 = UDim2.fromScale(0.715, 0.9)
local v_u_31 = UDim2.fromScale(0.57, 0.9)
local v_u_32 = UDim2.fromScale(0.932, 0.9)
local v_u_33 = UDim2.fromScale(0.648, 0.9)
local v_u_34 = UDim2.fromScale(0.866, 0.9)
local v_u_35 = UDim2.fromScale(0.921, 0.365)
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = {}
local function v_u_42(p39)
    local v40 = p39:GetChildren()
    for _, v41 in ipairs(v40) do
        if v41.ClassName == "Frame" then
            v41:Destroy()
        end
    end
end
local function v_u_46(p43)
    -- upvalues: (copy) v_u_4
    local v44 = {}
    for _, v45 in ipairs(v_u_4:GetPlayers()) do
        if v45:GetAttribute("Team") == p43 then
            table.insert(v44, v45)
        end
    end
    return v44
end
local function v_u_49()
    -- upvalues: (ref) v_u_36, (copy) v_u_26, (copy) v_u_27, (copy) v_u_29, (copy) v_u_30, (copy) v_u_31, (copy) v_u_32, (copy) v_u_33, (copy) v_u_34, (copy) v_u_28, (copy) v_u_35, (copy) v_u_16, (copy) v_u_17, (copy) v_u_19, (copy) v_u_20, (copy) v_u_22, (copy) v_u_23, (copy) v_u_21, (copy) v_u_24, (copy) v_u_18, (copy) v_u_25
    local v47 = workspace:GetAttribute("Gamemode")
    v_u_36.Team.CT.Score.Visible = v47 ~= "Deathmatch"
    v_u_36.Team.T.Score.Visible = v47 ~= "Deathmatch"
    local v48 = workspace:GetAttribute("Map")
    v_u_36.TopInfo.Gamemode.Text = ("%* | %*"):format(v47, v48)
    if v47 == "Deathmatch" then
        v_u_36["Counter-Terrorists"].Position = v_u_26
        v_u_36.Terrorists.Position = v_u_27
        v_u_36.TopInfo.Assists.Position = v_u_29
        v_u_36.TopInfo.Deaths.Position = v_u_30
        v_u_36.TopInfo.Money.Position = v_u_31
        v_u_36.TopInfo.Score.Position = v_u_32
        v_u_36.TopInfo.Kills.Position = v_u_33
        v_u_36.TopInfo.MVPs.Position = v_u_34
        v_u_36.TopInfo.Ping.Position = v_u_28
        v_u_36["Counter-Terrorists"].Size = v_u_35
        v_u_36.Terrorists.Size = v_u_35
        v_u_36.DeathmatchDivider.Visible = true
        v_u_36.Team.Visible = false
    elseif v47 == "Bomb Defusal" or v47 == "Hostage Rescue" then
        v_u_36["Counter-Terrorists"].Position = v_u_16
        v_u_36.Terrorists.Position = v_u_17
        v_u_36.TopInfo.Assists.Position = v_u_19
        v_u_36.TopInfo.Deaths.Position = v_u_20
        v_u_36.TopInfo.Score.Position = v_u_22
        v_u_36.TopInfo.Kills.Position = v_u_23
        v_u_36.TopInfo.Money.Position = v_u_21
        v_u_36.TopInfo.MVPs.Position = v_u_24
        v_u_36.TopInfo.Ping.Position = v_u_18
        v_u_36["Counter-Terrorists"].Size = v_u_25
        v_u_36.Terrorists.Size = v_u_25
        v_u_36.DeathmatchDivider.Visible = false
        v_u_36.Team.Visible = true
    end
end
function v_u_1.createTemplate(p_u_50, p_u_51, p_u_52)
    -- upvalues: (copy) v_u_2, (copy) v_u_9, (copy) v_u_7, (copy) v_u_13, (copy) v_u_11, (copy) v_u_5
    local v_u_53 = v_u_2.Assets.UI.Leaderboard[p_u_51]:Clone()
    v_u_53.Player.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(p_u_50.UserId)
    v_u_53.PlayerName.Text = ("%* (@%*)"):format(p_u_50.DisplayName, p_u_50.Name)
    local v54 = v_u_9(p_u_50, p_u_51)
    v_u_53.Badge.Visible = v54 ~= ""
    v_u_53.Badge.Image = v54
    v_u_53.LayoutOrder = 0
    v_u_53.Assists.Amount.Text = "0"
    v_u_53.Deaths.Amount.Text = "0"
    v_u_53.Score.Amount.Text = "0"
    v_u_53.Kills.Amount.Text = "0"
    v_u_53.MVPs.Amount.Text = "0"
    v_u_53.Money.Amount.Text = ""
    v_u_53.LayoutOrder = 1
    v_u_53.Ping.Text = "0"
    local v_u_55 = {}
    local function v_u_58(p56)
        -- upvalues: (copy) v_u_55, (copy) v_u_58
        if p56:IsA("Frame") then
            v_u_55[p56] = {
                ["BackgroundTransparency"] = p56.BackgroundTransparency
            }
        elseif p56:IsA("TextLabel") then
            v_u_55[p56] = {
                ["BackgroundTransparency"] = p56.BackgroundTransparency,
                ["TextTransparency"] = p56.TextTransparency
            }
        elseif p56:IsA("TextButton") then
            v_u_55[p56] = {
                ["BackgroundTransparency"] = p56.BackgroundTransparency,
                ["TextTransparency"] = p56.TextTransparency
            }
        elseif p56:IsA("ImageLabel") then
            v_u_55[p56] = {
                ["BackgroundTransparency"] = p56.BackgroundTransparency,
                ["ImageTransparency"] = p56.ImageTransparency
            }
        elseif p56:IsA("ImageButton") then
            v_u_55[p56] = {
                ["BackgroundTransparency"] = p56.BackgroundTransparency,
                ["ImageTransparency"] = p56.ImageTransparency
            }
        end
        for _, v57 in p56:GetChildren() do
            v_u_58(v57)
        end
    end
    v_u_55[v_u_53] = {
        ["BackgroundTransparency"] = v_u_53.BackgroundTransparency
    }
    for _, v59 in v_u_53:GetChildren() do
        v_u_58(v59)
    end
    if p_u_50 == v_u_7 then
        v_u_53.BackgroundColor3 = Color3.fromRGB(139, 128, 98)
    end
    local function v_u_62()
        -- upvalues: (copy) p_u_50, (ref) v_u_7, (copy) v_u_53
        local v60 = workspace:GetAttribute("Gamemode")
        if p_u_50:GetAttribute("Team") == v_u_7:GetAttribute("Team") or v60 == "Deathmatch" then
            local v61 = p_u_50:GetAttribute("Money")
            v_u_53.Money.Amount.Text = v61 == nil and "" or (("$%*"):format((tostring(v61):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))) or "")
        else
            v_u_53.Money.Amount.Text = ""
        end
    end
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Money", function(_)
        -- upvalues: (copy) v_u_62
        v_u_62()
    end))
    v_u_62()
    local v_u_63 = v_u_53.Player:FindFirstChildOfClass("UIStroke")
    local function v_u_65()
        -- upvalues: (copy) v_u_63, (copy) p_u_50, (ref) v_u_7
        if v_u_63 then
            if p_u_50:GetAttribute("Team") == v_u_7:GetAttribute("Team") then
                local v64 = p_u_50:GetAttribute("CompetitivePlayerColor")
                if v64 then
                    v_u_63.Color = v64 or Color3.fromRGB(255, 255, 255)
                    v_u_63.Enabled = true
                else
                    v_u_63.Enabled = false
                end
            else
                v_u_63.Enabled = false
                return
            end
        else
            return
        end
    end
    if v_u_63 then
        if p_u_50:GetAttribute("Team") == v_u_7:GetAttribute("Team") then
            local v66 = p_u_50:GetAttribute("CompetitivePlayerColor")
            if v66 then
                v_u_63.Color = v66 or Color3.fromRGB(255, 255, 255)
                v_u_63.Enabled = true
            else
                v_u_63.Enabled = false
            end
        else
            v_u_63.Enabled = false
        end
    end
    p_u_52:Add(v_u_13.observeAttribute(v_u_7, "Team", function()
        -- upvalues: (copy) v_u_62, (copy) v_u_63, (copy) p_u_50, (ref) v_u_7
        v_u_62()
        if v_u_63 then
            if p_u_50:GetAttribute("Team") == v_u_7:GetAttribute("Team") then
                local v67 = p_u_50:GetAttribute("CompetitivePlayerColor")
                if v67 then
                    v_u_63.Color = v67 or Color3.fromRGB(255, 255, 255)
                    v_u_63.Enabled = true
                else
                    v_u_63.Enabled = false
                end
            else
                v_u_63.Enabled = false
                return
            end
        else
            return
        end
    end))
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Team", function()
        -- upvalues: (copy) v_u_62, (copy) v_u_63, (copy) p_u_50, (ref) v_u_7
        v_u_62()
        if v_u_63 then
            if p_u_50:GetAttribute("Team") == v_u_7:GetAttribute("Team") then
                local v68 = p_u_50:GetAttribute("CompetitivePlayerColor")
                if v68 then
                    v_u_63.Color = v68 or Color3.fromRGB(255, 255, 255)
                    v_u_63.Enabled = true
                else
                    v_u_63.Enabled = false
                end
            else
                v_u_63.Enabled = false
                return
            end
        else
            return
        end
    end))
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "CompetitivePlayerColor", v_u_65))
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Kills", function(p69)
        -- upvalues: (copy) v_u_53
        v_u_53.Kills.Amount.Text = tostring(p69):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        v_u_53.LayoutOrder = -p69
    end))
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Deaths", function(p70)
        -- upvalues: (copy) v_u_53
        v_u_53.Deaths.Amount.Text = tostring(p70):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end))
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Assists", function(p71)
        -- upvalues: (copy) v_u_53
        v_u_53.Assists.Amount.Text = tostring(p71):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end))
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Score", function(p72)
        -- upvalues: (copy) v_u_53
        v_u_53.Score.Amount.Text = tostring(p72):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end))
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "MVPs", function(p73)
        -- upvalues: (copy) v_u_53
        v_u_53.MVPs.Amount.Text = tostring(p73):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end))
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Ping", function(p74)
        -- upvalues: (copy) v_u_53
        v_u_53.Ping.Text = p74
    end))
    local function v_u_88()
        -- upvalues: (copy) p_u_50, (copy) v_u_53, (copy) v_u_55
        local v75 = p_u_50.Character
        if v75 then
            v75 = v75:GetAttribute("Dead") == true
        end
        local v76 = p_u_50:GetAttribute("IsSpectating") == true
        local v77 = v75 == true and true or v76 == true
        if v_u_53 and v_u_53:FindFirstChild("Dead") then
            v_u_53.Dead.Visible = v77
        end
        if v77 then
            if v_u_53:FindFirstChild("Bomb") then
                v_u_53.Bomb.Visible = false
            end
            if v_u_53:FindFirstChild("DefuseKit") then
                v_u_53.DefuseKit.Visible = false
            end
        end
        if v77 then
            v_u_53.BackgroundTransparency = 1
            local function v_u_80(p78)
                -- upvalues: (copy) v_u_80
                if p78:IsA("Frame") then
                    p78.BackgroundTransparency = 1
                elseif p78:IsA("TextLabel") then
                    p78.TextTransparency = 0.5
                    p78.BackgroundTransparency = 1
                elseif p78:IsA("TextButton") then
                    p78.TextTransparency = 0.5
                    p78.BackgroundTransparency = 1
                elseif p78:IsA("ImageLabel") then
                    p78.ImageTransparency = 0.5
                    p78.BackgroundTransparency = 1
                elseif p78:IsA("ImageButton") then
                    p78.ImageTransparency = 0.5
                    p78.BackgroundTransparency = 1
                end
                for _, v79 in ipairs(p78:GetChildren()) do
                    v_u_80(v79)
                end
            end
            for _, v81 in ipairs(v_u_53:GetChildren()) do
                v_u_80(v81)
            end
        else
            local function v_u_85(p82)
                -- upvalues: (ref) v_u_55, (copy) v_u_85
                local v83 = v_u_55[p82]
                if v83 then
                    if p82:IsA("Frame") then
                        p82.BackgroundTransparency = v83.BackgroundTransparency
                    elseif p82:IsA("TextLabel") then
                        p82.TextTransparency = v83.TextTransparency
                        p82.BackgroundTransparency = v83.BackgroundTransparency
                    elseif p82:IsA("TextButton") then
                        p82.TextTransparency = v83.TextTransparency
                        p82.BackgroundTransparency = v83.BackgroundTransparency
                    elseif p82:IsA("ImageLabel") then
                        p82.ImageTransparency = v83.ImageTransparency
                        p82.BackgroundTransparency = v83.BackgroundTransparency
                    elseif p82:IsA("ImageButton") then
                        p82.ImageTransparency = v83.ImageTransparency
                        p82.BackgroundTransparency = v83.BackgroundTransparency
                    end
                end
                for _, v84 in ipairs(p82:GetChildren()) do
                    v_u_85(v84)
                end
            end
            local v86 = v_u_55[v_u_53]
            if v86 then
                v_u_53.BackgroundTransparency = v86.BackgroundTransparency
            end
            for _, v87 in ipairs(v_u_53:GetChildren()) do
                v_u_85(v87)
            end
        end
    end
    local v_u_89 = nil
    local function v_u_91()
        -- upvalues: (copy) p_u_50, (copy) v_u_88, (ref) v_u_89
        local v90 = p_u_50.Character
        if v90 then
            v_u_88()
            return v90:GetAttributeChangedSignal("Dead"):Connect(function()
                -- upvalues: (ref) v_u_88, (ref) v_u_89
                v_u_88()
                if v_u_89 then
                    v_u_89()
                end
            end)
        else
            v_u_88()
            return nil
        end
    end
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "IsSpectating", function(_)
        -- upvalues: (copy) v_u_88
        v_u_88()
    end))
    local v95 = p_u_50.CharacterAdded:Connect(function(p92)
        -- upvalues: (copy) v_u_63, (copy) p_u_50, (ref) v_u_7, (copy) p_u_52, (copy) v_u_65, (copy) v_u_91, (ref) v_u_89
        task.wait(0.1)
        if v_u_63 then
            if p_u_50:GetAttribute("Team") == v_u_7:GetAttribute("Team") then
                local v93 = p_u_50:GetAttribute("CompetitivePlayerColor")
                if v93 then
                    v_u_63.Color = v93 or Color3.fromRGB(255, 255, 255)
                    v_u_63.Enabled = true
                else
                    v_u_63.Enabled = false
                end
            else
                v_u_63.Enabled = false
            end
        end
        p_u_52:Add(p92:GetAttributeChangedSignal("CompetitivePlayerColor"):Connect(v_u_65))
        local v94 = v_u_91()
        if v94 then
            p_u_52:Add(v94)
        end
        if v_u_89 then
            v_u_89()
        end
    end)
    local v96 = p_u_50.CharacterRemoving:Connect(function(_)
        -- upvalues: (copy) v_u_88
        v_u_88()
    end)
    p_u_52:Add(v95)
    p_u_52:Add(v96)
    if p_u_50.Character then
        local v97 = v_u_91()
        if v97 then
            p_u_52:Add(v97)
        end
    else
        v_u_88()
    end
    local v_u_99 = v_u_11.CreateListener(p_u_50, ("Loadout.%*.Equipped.Equipped Badge"):format(p_u_51), function()
        -- upvalues: (ref) v_u_9, (copy) p_u_50, (copy) p_u_51, (copy) v_u_53
        local v98 = v_u_9(p_u_50, p_u_51)
        v_u_53.Badge.Image = v98
        v_u_53.Badge.Visible = v98 ~= ""
    end)
    p_u_52:Add(function()
        -- upvalues: (ref) v_u_11, (copy) p_u_50, (copy) p_u_51, (copy) v_u_99
        v_u_11.RemoveListener(p_u_50, ("Loadout.%*.Equipped.Equipped Badge"):format(p_u_51), v_u_99)
    end)
    v_u_89 = function()
        -- upvalues: (copy) p_u_50, (ref) v_u_7, (copy) p_u_51, (copy) v_u_53, (ref) v_u_5
        local v100 = p_u_50:GetAttribute("Team") == v_u_7:GetAttribute("Team")
        local v101 = p_u_50.Character
        if v101 then
            v101 = v101:GetAttribute("Dead") == true
        end
        local v102 = p_u_50:GetAttribute("IsSpectating") == true
        local v103 = not v101
        if v103 then
            v103 = not v102
        end
        if p_u_51 == "Terrorists" then
            local v104 = v_u_53:FindFirstChild("Bomb")
            if v104 then
                local v105 = p_u_50:GetAttribute("Slot5")
                if v105 then
                    local v106 = v_u_5:JSONDecode(v105 or "[]")
                    if v100 then
                        if v103 then
                            if v106 then
                                v106 = v106.Weapon == "C4"
                            end
                        else
                            v106 = v103
                        end
                    else
                        v106 = v100
                    end
                    v104.Visible = v106
                else
                    v104.Visible = false
                end
            end
        else
            local v107 = p_u_51 == "Counter-Terrorists" and v_u_53:FindFirstChild("DefuseKit")
            if v107 then
                local v108 = p_u_50:GetAttribute("HasDefuseKit")
                if v100 then
                    if v103 then
                        v103 = v108 == true
                    end
                else
                    v103 = v100
                end
                v107.Visible = v103
            end
        end
    end
    if p_u_51 == "Terrorists" then
        p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Slot5", function(_)
            -- upvalues: (ref) v_u_89, (copy) v_u_53
            v_u_89()
            return function()
                -- upvalues: (ref) v_u_53
                if v_u_53 and v_u_53:FindFirstChild("Bomb") then
                    v_u_53.Bomb.Visible = false
                end
            end
        end))
    elseif p_u_51 == "Counter-Terrorists" then
        p_u_52:Add(v_u_13.observeAttribute(p_u_50, "HasDefuseKit", function(_)
            -- upvalues: (ref) v_u_89, (copy) v_u_53
            v_u_89()
            return function()
                -- upvalues: (ref) v_u_53
                if v_u_53 and v_u_53:FindFirstChild("DefuseKit") then
                    v_u_53.DefuseKit.Visible = false
                end
            end
        end))
    end
    p_u_52:Add(v_u_13.observeAttribute(v_u_7, "Team", function()
        -- upvalues: (ref) v_u_89
        v_u_89()
    end))
    v_u_89()
    return v_u_53
end
function v_u_1.openFrame()
    -- upvalues: (copy) v_u_10, (ref) v_u_36
    if not v_u_10.IsActive() then
        v_u_36.Visible = true
    end
end
function v_u_1.closeFrame()
    -- upvalues: (ref) v_u_36, (copy) v_u_12
    v_u_36.Visible = false
    v_u_12.setForceLockOverride("Leaderboard", false)
end
function v_u_1.characterAdded(p109, p110)
    -- upvalues: (copy) v_u_14, (copy) v_u_1, (ref) v_u_36, (copy) v_u_38
    local v111 = v_u_14.new()
    v_u_1.cleanup(p109)
    local v_u_112 = v_u_1.createTemplate(p109, p110, v111)
    v_u_112.Parent = v_u_36:FindFirstChild(p110)
    v111:Add(function()
        -- upvalues: (copy) v_u_112
        v_u_112:Destroy()
    end)
    v_u_38[p109] = v111
end
function v_u_1.observePlayer(p_u_113)
    -- upvalues: (copy) v_u_13, (copy) v_u_1
    v_u_13.observeAttribute(p_u_113, "Team", function(p114)
        -- upvalues: (ref) v_u_1, (copy) p_u_113
        if p114 == "Terrorists" or p114 == "Counter-Terrorists" then
            v_u_1.characterAdded(p_u_113, p114)
        end
        return function()
            -- upvalues: (ref) v_u_1, (ref) p_u_113
            v_u_1.cleanup(p_u_113)
        end
    end)
end
function v_u_1.cleanup(p115)
    -- upvalues: (copy) v_u_38
    local v116 = v_u_38[p115]
    v_u_38[p115] = nil
    if v116 then
        v116:Destroy()
    end
end
function v_u_1.Initialize(_, p117)
    -- upvalues: (ref) v_u_36, (ref) v_u_37, (copy) v_u_6, (copy) v_u_12, (copy) v_u_13, (copy) v_u_49, (copy) v_u_15, (copy) v_u_1
    v_u_36 = p117
    if v_u_37 then
        v_u_37:Disconnect()
        v_u_37 = nil
    end
    v_u_37 = v_u_6.InputBegan:Connect(function(p118)
        -- upvalues: (ref) v_u_36, (ref) v_u_12
        if p118.UserInputType == Enum.UserInputType.MouseButton2 and (v_u_36 and v_u_36.Visible) then
            v_u_12.setForceLockOverride("Leaderboard", true)
        end
    end)
    v_u_13.observeAttribute(workspace, "Gamemode", v_u_49)
    v_u_13.observeAttribute(workspace, "Map", v_u_49)
    v_u_13.observeAttribute(workspace, "CTScore", function(p119)
        -- upvalues: (ref) v_u_36
        v_u_36.Team.CT.Score.Text = tostring(p119)
        return function()
            -- upvalues: (ref) v_u_36
            v_u_36.Team.CT.Score.Text = ""
        end
    end)
    v_u_13.observeAttribute(workspace, "TScore", function(p120)
        -- upvalues: (ref) v_u_36
        v_u_36.Team.T.Score.Text = tostring(p120)
        return function()
            -- upvalues: (ref) v_u_36
            v_u_36.Team.T.Score.Text = ""
        end
    end)
    v_u_13.observeAttribute(workspace, "Timer", function(p121)
        -- upvalues: (ref) v_u_36, (ref) v_u_15
        v_u_36.TopInfo.Timer.Text = v_u_15(p121)
    end)
    v_u_13.observePlayer(function(p_u_122)
        -- upvalues: (ref) v_u_1
        v_u_1.observePlayer(p_u_122)
        return function()
            -- upvalues: (ref) v_u_1, (copy) p_u_122
            v_u_1.cleanup(p_u_122)
        end
    end)
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_42, (ref) v_u_36, (copy) v_u_3, (copy) v_u_46, (copy) v_u_8
    v_u_42((v_u_36:WaitForChild("Counter-Terrorists")))
    v_u_42((v_u_36:WaitForChild("Terrorists")))
    v_u_3.Heartbeat:Connect(function()
        -- upvalues: (ref) v_u_46, (ref) v_u_8, (ref) v_u_36
        local v123 = workspace:GetAttribute("Gamemode")
        if v123 == "Bomb Defusal" or v123 == "Hostage Rescue" then
            local v124 = v_u_46("Counter-Terrorists")
            local v125 = v_u_46("Terrorists")
            local v126 = #v124
            local v127 = #v125
            local v131 = v_u_8(v124, function(_, p128)
                local v129 = p128.Character
                if v129 and v129:IsDescendantOf(workspace) then
                    local v130 = v129:FindFirstChildOfClass("Humanoid")
                    if v130 and v130.Health > 0 then
                        return false
                    end
                end
                return true
            end)
            local v135 = v_u_8(v125, function(_, p132)
                local v133 = p132.Character
                if v133 and v133:IsDescendantOf(workspace) then
                    local v134 = v133:FindFirstChildOfClass("Humanoid")
                    if v134 and v134.Health > 0 then
                        return false
                    end
                end
                return true
            end)
            local v136 = v_u_36.Team.CT.Alive
            local v137 = #v131
            v136.Text = ("ALIVE %*/%*"):format(tostring(v137), (tostring(v126)))
            local v138 = v_u_36.Team.T.Alive
            local v139 = #v135
            v138.Text = ("ALIVE %*/%*"):format(tostring(v139), (tostring(v127)))
        end
    end)
end
return v_u_1
