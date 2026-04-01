-- MODULESCRIPT: Chat
-- Original Path: game.BAC - 52404.Interface.Screens.Gameplay.Middle.Chat
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
local v_u_6 = game:GetService("TextChatService")
require(script:WaitForChild("Types"))
local v_u_7 = v_u_5.LocalPlayer
local v_u_8 = require(v_u_2.Controllers.CameraController)
local v_u_9 = require(v_u_2.Controllers.InputController)
local v_u_10 = require(v_u_2.Interface.Screens.Gameplay.Middle.BuyMenu)
local v_u_11 = require(v_u_2.Interface.MenuState)
local v_u_12 = require(v_u_2.Database.Components.Common.Roblox.CanPlayerUseChatService)
local v_u_13 = require(v_u_2.Components.Common.GetUserPlatform)
local v_u_14 = require(v_u_2.Controllers.DataController)
local v_u_15 = require(v_u_2.Database.Security.Remotes)
local v_u_16 = require(v_u_2.Database.Custom.GameStats.UI.Chat.ChatModes)
local v_u_17 = require(v_u_2.Database.Custom.GameStats.UI.Chat.Platforms)
local v_u_18 = require(v_u_2.Database.Custom.GameStats.UI.Chat.HTML)
local v_u_19 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = { v_u_17.PC }
local v_u_23 = v_u_16.Modes.All
local v_u_24 = false
local v_u_25 = false
local v_u_26 = {}
local v_u_27 = {}
local function v_u_28()
    -- upvalues: (ref) v_u_22, (copy) v_u_17, (copy) v_u_9
    return table.find(v_u_22, v_u_17.Mobile) and "Tap to chat" or ((table.find(v_u_22, v_u_17.Console) or table.find(v_u_22, v_u_17.VR)) and "" or string.format("Team Chat (%s) | All Chat (%s)", v_u_9.GetActionKeybind("Team Message") or "U", v_u_9.GetActionKeybind("Chat Message") or "Y"))
end
local function v_u_35(p_u_29)
    -- upvalues: (ref) v_u_25, (copy) v_u_4
    if p_u_29.frame and p_u_29.frame.Parent then
        if v_u_25 then
            return
        elseif not p_u_29.fadeConnection and p_u_29.frame.Message.TextTransparency < 1 then
            local v_u_30 = p_u_29.frame.Message.TextTransparency
            local v_u_31 = os.clock()
            local v_u_32 = nil
            v_u_32 = v_u_4.Heartbeat:Connect(function()
                -- upvalues: (copy) p_u_29, (ref) v_u_32, (ref) v_u_25, (copy) v_u_31, (copy) v_u_30
                if p_u_29.frame and p_u_29.frame.Parent then
                    if v_u_25 then
                        v_u_32:Disconnect()
                        p_u_29.fadeConnection = nil
                        p_u_29.frame.Message.TextTransparency = 0
                    else
                        local v33 = (os.clock() - v_u_31) / 3
                        local v34 = math.min(v33, 1)
                        p_u_29.frame.Message.TextTransparency = v_u_30 + (1 - v_u_30) * v34
                        if v34 >= 1 then
                            v_u_32:Disconnect()
                            p_u_29.fadeConnection = nil
                        end
                    end
                else
                    v_u_32:Disconnect()
                    p_u_29.fadeConnection = nil
                    return
                end
            end)
            p_u_29.fadeConnection = v_u_32
        end
    else
        return
    end
end
local function v_u_41(p36)
    -- upvalues: (ref) v_u_25, (ref) v_u_21, (copy) v_u_28, (copy) v_u_26, (copy) v_u_35
    v_u_25 = p36
    v_u_21.Chat.ScrollingFrame.ScrollBarImageTransparency = p36 and 0 or 1
    v_u_21.Chat.BackgroundTransparency = p36 and 0.55 or 1
    v_u_21.Type.BackgroundTransparency = p36 and 0.55 or 1
    v_u_21.BackgroundTransparency = p36 and 0.55 or 1
    v_u_21.Type.TextBox.PlaceholderColor3 = p36 and Color3.fromRGB(141, 141, 141) or Color3.new(1, 1, 1)
    if not p36 then
        v_u_21.Type.TextBox.PlaceholderText = v_u_28()
    end
    local v37 = os.clock()
    for _, v38 in ipairs(v_u_26) do
        if p36 then
            if v38.fadeConnection then
                v38.fadeConnection:Disconnect()
                v38.fadeConnection = nil
            end
            v38.frame.Message.TextTransparency = 0
        else
            local v39 = v37 - v38.timestamp
            if v39 > 10 then
                v38.frame.Message.TextTransparency = 1
            else
                local v40 = 10 - v39
                task.delay(v40, v_u_35, v38)
            end
        end
    end
end
local function v_u_47(p42)
    -- upvalues: (copy) v_u_26, (ref) v_u_25, (copy) v_u_35, (ref) v_u_21
    local v43 = #v_u_26 >= 15 and v_u_26[15]
    if v43 then
        v43.frame:Destroy()
        table.remove(v_u_26, 15)
    end
    local v44 = v_u_26
    table.insert(v44, 1, p42)
    for v45, v46 in ipairs(v_u_26) do
        v46.frame.LayoutOrder = #v_u_26 - v45
    end
    p42.frame.Message.TextTransparency = 0
    if not v_u_25 then
        task.delay(10, v_u_35, p42)
    end
    p42.frame.Parent = v_u_21.Chat.ScrollingFrame
    task.defer(function()
        -- upvalues: (ref) v_u_21
        v_u_21.Chat.ScrollingFrame.CanvasPosition = Vector2.new(0, v_u_21.Chat.ScrollingFrame.AbsoluteCanvasSize.Y)
    end)
end
local function v_u_51()
    -- upvalues: (ref) v_u_24, (copy) v_u_27, (ref) v_u_20, (copy) v_u_47
    if not v_u_24 and #v_u_27 ~= 0 then
        local v48 = 0
        v_u_24 = true
        while #v_u_27 > 0 and v48 < 2 do
            local v49 = table.remove(v_u_27, 1)
            if v49 then
                local v50 = v_u_20:Clone()
                v50.Message.Text = v49.text
                v_u_47({
                    ["frame"] = v50,
                    ["timestamp"] = v49.timestamp,
                    ["text"] = v49.text,
                    ["fadeConnection"] = nil
                })
                v48 = v48 + 1
            end
        end
        v_u_24 = false
    end
end
function v_u_1.OpenChat(p52)
    -- upvalues: (ref) v_u_25, (copy) v_u_12, (copy) v_u_7, (ref) v_u_22, (copy) v_u_17, (copy) v_u_10, (ref) v_u_23, (ref) v_u_21, (copy) v_u_16, (copy) v_u_41, (copy) v_u_8
    if v_u_25 then
        return
    elseif v_u_12(v_u_7) then
        if not table.find(v_u_22, v_u_17.Mobile) then
            v_u_10.closeFrame()
            v_u_23 = p52
            v_u_21.Visible = true
            v_u_21.Type.TextBox.PlaceholderText = v_u_16.Labels[p52]
            v_u_21.Type.TextBox.TextTransparency = 0
            v_u_21.Type.TextBox.Text = ""
            v_u_41(true)
            v_u_8.setMouseEnabled(true)
            v_u_7:SetAttribute("IsPlayerChatting", true)
            v_u_21.Type.TextBox:CaptureFocus()
            task.delay(0, function()
                -- upvalues: (ref) v_u_21
                v_u_21.Type.TextBox.Text = ""
            end)
        end
    else
        return
    end
end
function v_u_1.ProcessChatData(p53, p54)
    -- upvalues: (copy) v_u_18, (copy) v_u_27, (ref) v_u_24, (copy) v_u_51
    local v55 = not (p53.role and v_u_18.Roles[p53.role]) and "" or v_u_18.Roles[p53.role]
    local v56
    if p54 then
        v56 = v_u_18.Prefixes[p53.team] or v_u_18.Prefixes.All
    else
        v56 = v_u_18.Prefixes.All
    end
    local v57 = v_u_18.TeamColors[p53.team] or ""
    local v58 = v_u_27
    local v59 = {
        ["text"] = v55 .. v56 .. string.format(v57, (p53.displayName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))) .. (not p53.verified and "" or v_u_18.Badges.Verified .. " ") .. (p53.alive and "" or v_u_18.Suffixes.Dead) .. ": " .. p53.message,
        ["timestamp"] = os.clock()
    }
    table.insert(v58, v59)
    if not v_u_24 then
        v_u_51()
    end
end
function v_u_1.ProcessTeamJoin(p60, p61)
    -- upvalues: (copy) v_u_18, (copy) v_u_27, (ref) v_u_24, (copy) v_u_51
    local v62 = v_u_18.TeamJoinMessages[p61]
    if v62 then
        local v63 = v_u_27
        local v64 = {
            ["text"] = string.format(v62, p60),
            ["timestamp"] = os.clock()
        }
        table.insert(v63, v64)
        if not v_u_24 then
            v_u_51()
        end
    end
end
function v_u_1.ProcessPlayerLeave(p65)
    -- upvalues: (copy) v_u_18, (copy) v_u_27, (ref) v_u_24, (copy) v_u_51
    local v66 = v_u_27
    local v67 = {
        ["text"] = string.format(v_u_18.PlayerLeave, p65),
        ["timestamp"] = os.clock()
    }
    table.insert(v66, v67)
    if not v_u_24 then
        v_u_51()
    end
end
function v_u_1.ProcessPlayerBanned(p68)
    -- upvalues: (copy) v_u_18, (copy) v_u_27, (ref) v_u_24, (copy) v_u_51
    local v69 = v_u_27
    local v70 = {
        ["text"] = string.format(v_u_18.PlayerBanned, p68),
        ["timestamp"] = os.clock()
    }
    table.insert(v69, v70)
    if not v_u_24 then
        v_u_51()
    end
end
function v_u_1.ProcessSystemMessage(p71)
    -- upvalues: (copy) v_u_18, (copy) v_u_27, (ref) v_u_24, (copy) v_u_51
    local v72 = v_u_27
    local v73 = {
        ["text"] = string.format(v_u_18.SystemMessage, (p71:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))),
        ["timestamp"] = os.clock()
    }
    table.insert(v72, v73)
    if not v_u_24 then
        v_u_51()
    end
end
function v_u_1.ProcessTeamDamage(p74)
    -- upvalues: (copy) v_u_18, (copy) v_u_27, (ref) v_u_24, (copy) v_u_51
    if p74.messageType == "Warning" then
        local v75 = v_u_27
        local v76 = {
            ["text"] = v_u_18.TeamDamageWarning,
            ["timestamp"] = os.clock()
        }
        table.insert(v75, v76)
        if not v_u_24 then
            v_u_51()
        end
    elseif p74.messageType == "Announcement" then
        local v77 = p74.displayName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
        local v78 = string.format(v_u_18.TeamDamageAnnouncement, v77)
        local v79 = v_u_27
        local v80 = {
            ["text"] = v78,
            ["timestamp"] = os.clock()
        }
        table.insert(v79, v80)
        if not v_u_24 then
            v_u_51()
        end
    end
end
function v_u_1.ProcessKillMessage(p81)
    -- upvalues: (copy) v_u_7, (copy) v_u_18, (copy) v_u_27, (ref) v_u_24, (copy) v_u_51
    local v82 = p81.Killer
    local v83 = tostring(v82)
    local v84 = v_u_7.UserId
    if v83 == tostring(v84) then
        local v85 = p81.Points or 11
        local v86 = v85 == 1 and "point" or "points"
        local v87 = v_u_27
        local v88 = {
            ["text"] = string.format(v_u_18.Points.Deathmatch, v85, v86, p81.Weapon),
            ["timestamp"] = os.clock()
        }
        table.insert(v87, v88)
        if not v_u_24 then
            v_u_51()
        end
    end
end
function v_u_1.ProcessMoneyReward(p89)
    -- upvalues: (copy) v_u_18, (copy) v_u_27, (ref) v_u_24, (copy) v_u_51
    local v90 = v_u_18.Money[p89.source]
    if v90 then
        local v91 = p89.amount
        local v92 = tonumber(v91)
        if v92 then
            if p89.source == "Kill" then
                local v93 = p89.weaponName and v_u_18.Money.KillWithWeapon or v_u_18.Money.Kill
                local v94 = v_u_27
                local v95 = {
                    ["text"] = p89.weaponName and string.format(v93, v92, p89.weaponName) or string.format(v93, v92),
                    ["timestamp"] = os.clock()
                }
                table.insert(v94, v95)
                if not v_u_24 then
                    v_u_51()
                end
            else
                local v96 = v_u_27
                local v97 = {
                    ["text"] = string.format(v90, (math.abs(v92))),
                    ["timestamp"] = os.clock()
                }
                table.insert(v96, v97)
                if not v_u_24 then
                    v_u_51()
                end
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.ProcessDefuseStart(p98)
    -- upvalues: (copy) v_u_18, (copy) v_u_27, (ref) v_u_24, (copy) v_u_51
    local v99 = v_u_18.TeamColors[p98.team] or ""
    local v100 = p98.displayName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
    local v101
    if v99 == "" then
        v101 = v100 .. " "
    else
        v101 = string.format(v99, v100)
    end
    local v102 = v_u_18.Prefixes[p98.team] or v_u_18.Prefixes.All
    local v103 = "Bombsite " .. (p98.site or "?")
    local v104 = v_u_27
    local v105 = {
        ["text"] = v102 .. v101 .. string.format("<font color=\"%s\">@%s</font>", v_u_18.DefuseStartLocationColor, (v103:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))) .. "<font color=\"rgb(255,255,255)\">: </font>" .. v_u_18.DefuseStartAction,
        ["timestamp"] = os.clock()
    }
    table.insert(v104, v105)
    if not v_u_24 then
        v_u_51()
    end
end
function v_u_1.ProcessGrenadeThrow(p106)
    -- upvalues: (copy) v_u_18, (copy) v_u_27, (ref) v_u_24, (copy) v_u_51
    local v107 = v_u_18.TeamColors[p106.team] or ""
    local v108 = p106.displayName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
    local v109
    if v107 == "" then
        v109 = v108 .. " "
    else
        v109 = string.format(v107, v108)
    end
    local v110 = v_u_18.Prefixes[p106.team] or v_u_18.Prefixes.All
    local v111 = v_u_18.GrenadeDisplayNames[p106.grenadeName] or p106.grenadeName:gsub(" Grenade", "")
    local v112 = v_u_18.GrenadeColors[p106.grenadeName] or "rgb(255,255,255)"
    local v113 = v_u_27
    local v114 = {
        ["text"] = v110 .. v109 .. "<font color=\"rgb(255,255,255)\">: </font>" .. string.format("<font color=\"%s\">%s!</font>", v112, (v111:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))),
        ["timestamp"] = os.clock()
    }
    table.insert(v113, v114)
    if not v_u_24 then
        v_u_51()
    end
end
function v_u_1.ProcessCaseOpened(p115)
    -- upvalues: (copy) v_u_18, (copy) v_u_19, (copy) v_u_27, (ref) v_u_24, (copy) v_u_51
    local v116 = v_u_18.TeamColors[p115.team] or ""
    local v117 = p115.displayName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
    local v118
    if v116 == "" then
        v118 = v117 .. " "
    else
        v118 = string.format(v116, v117)
    end
    local v119 = (v_u_19[p115.rarity] or v_u_19.Stock).Color
    local v120 = v119.R * 255 + 0.5
    local v121 = math.floor(v120)
    local v122 = v119.G * 255 + 0.5
    local v123 = math.floor(v122)
    local v124 = v119.B * 255 + 0.5
    local v125 = math.floor(v124)
    local v126 = string.format("rgb(%d,%d,%d)", v121, v123, v125)
    local v127 = p115.weaponName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
    local v128 = p115.skinName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
    local v129 = (p115.statTrak and "KillTrak\226\132\162 " or "") .. v127 .. " | " .. v128
    local v130 = v_u_27
    local v131 = {
        ["text"] = v118 .. "<font color=\"rgb(255,255,255)\">opened a case and found: </font>" .. string.format("<font color=\"%s\">%s</font>", v126, v129),
        ["timestamp"] = os.clock()
    }
    table.insert(v130, v131)
    if not v_u_24 then
        v_u_51()
    end
end
function v_u_1.Initialize(_, p132)
    -- upvalues: (ref) v_u_21, (ref) v_u_22, (copy) v_u_13, (ref) v_u_20, (copy) v_u_2, (ref) v_u_25, (copy) v_u_10, (copy) v_u_7, (copy) v_u_41, (copy) v_u_16, (ref) v_u_23, (copy) v_u_11, (copy) v_u_8, (copy) v_u_6, (copy) v_u_12, (copy) v_u_17
    v_u_21 = p132
    v_u_22 = v_u_13()
    v_u_20 = v_u_2.Assets.UI.Chat.Template
    v_u_20.Message.RichText = true
    for _, v133 in ipairs(v_u_21.Chat.ScrollingFrame:GetChildren()) do
        if v133:IsA("Frame") then
            v133:Destroy()
        end
    end
    v_u_21.Type.TextBox.ClearTextOnFocus = false
    v_u_21.Type.TextBox.Focused:Connect(function()
        -- upvalues: (ref) v_u_25, (ref) v_u_21, (ref) v_u_10, (ref) v_u_7, (ref) v_u_41, (ref) v_u_16, (ref) v_u_23
        if v_u_25 then
            v_u_10.closeFrame()
            v_u_7:SetAttribute("IsPlayerChatting", true)
            v_u_21.Type.TextBox.TextTransparency = 0
            v_u_41(true)
            task.delay(0, function()
                -- upvalues: (ref) v_u_21
                v_u_21.Type.TextBox.Text = ""
            end)
            if v_u_16.Labels[v_u_23] then
                v_u_21.Type.TextBox.PlaceholderText = v_u_16.Labels[v_u_23]
            end
        else
            v_u_21.Type.TextBox:ReleaseFocus()
        end
    end)
    v_u_21.Type.TextBox.FocusLost:Connect(function(p134)
        -- upvalues: (ref) v_u_7, (ref) v_u_11, (ref) v_u_8, (ref) v_u_21, (ref) v_u_23, (ref) v_u_16, (ref) v_u_6, (ref) v_u_41
        v_u_7:SetAttribute("IsPlayerChatting", nil)
        local v135 = v_u_7.PlayerGui:FindFirstChild("MainGui")
        if v135 then
            v135 = v_u_7.PlayerGui.MainGui:FindFirstChild("Menu")
        end
        if v135 then
            v135 = v135.Visible
        end
        if not (v135 or (v_u_11.IsCaseSceneActive() or v_u_11.IsInspectActive())) then
            v_u_8.setMouseEnabled(false)
        end
        if p134 then
            local v136 = v_u_21.Type.TextBox.Text
            if string.len(v136) > 0 then
                local v137 = v_u_21.Type.TextBox.Text
                if #v137 <= 100 and #v137 > 0 then
                    local v138 = v_u_7.Character
                    local v139
                    if v138 then
                        v139 = v138:FindFirstChildOfClass("Humanoid")
                    else
                        v139 = v138
                    end
                    local v140
                    if v138 then
                        v140 = v138:GetAttribute("Dead") ~= true
                        if v140 then
                            v140 = v139 and v139.Health > 0 and true or false
                        end
                    else
                        v140 = false
                    end
                    local v141 = v_u_7:GetAttribute("Team")
                    local v142 = not v141 or v141 == "Spectators"
                    local v143 = workspace:GetAttribute("ServerGamemode") == "Competitive"
                    local v144
                    if v_u_23 == v_u_16.Modes.All then
                        v144 = (v140 or (v142 or v143 and not v142)) and "All" or "AllDead"
                    else
                        v144 = (v140 or v143 and not v142) and "Team" or "TeamDead"
                    end
                    local v145 = v_u_6:FindFirstChild(v144)
                    if v145 then
                        v145:SendAsync(v137)
                    end
                end
            end
        end
        v_u_21.Type.TextBox.TextTransparency = 1
        v_u_21.Type.TextBox.Text = ""
        v_u_41(false)
    end)
    v_u_41(false)
    local v146 = v_u_12(v_u_7)
    local v147 = v_u_21
    if v146 then
        v146 = not table.find(v_u_22, v_u_17.Mobile)
    end
    v147.Visible = v146
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_5, (copy) v_u_1, (copy) v_u_15, (copy) v_u_14, (copy) v_u_4, (copy) v_u_27, (copy) v_u_51, (copy) v_u_3, (copy) v_u_16
    local v148 = v_u_6:WaitForChild("All", 10)
    local v149 = v_u_6:WaitForChild("AllDead", 10)
    local v150 = v_u_6:WaitForChild("Team", 10)
    local v151 = v_u_6:WaitForChild("TeamDead", 10)
    local v_u_152 = true
    local v153 = v_u_7.Character
    v153 = v153
    local v154
    if v153 then
        v154 = v153:FindFirstChildOfClass("Humanoid")
    else
        v154 = v153
    end
    if v153 then
        local v155 = v153:GetAttribute("Dead") ~= true
        if v155 then
            v155 = v154 and v154.Health > 0 and true or false
        end
        v_u_152 = v155
    else
        v_u_152 = false
    end
    v_u_7.CharacterAdded:Connect(function(p156)
        -- upvalues: (ref) v_u_7, (ref) v_u_152
        local v157 = v_u_7.Character
        local v158
        if v157 then
            v158 = v157:FindFirstChildOfClass("Humanoid")
        else
            v158 = v157
        end
        if v157 then
            local v159 = v157:GetAttribute("Dead") ~= true
            if v159 then
                v159 = v158 and v158.Health > 0 and true or false
            end
            v_u_152 = v159
        else
            v_u_152 = false
        end
        p156:GetAttributeChangedSignal("Dead"):Connect(function()
            -- upvalues: (ref) v_u_7, (ref) v_u_152
            local v160 = v_u_7.Character
            local v161
            if v160 then
                v161 = v160:FindFirstChildOfClass("Humanoid")
            else
                v161 = v160
            end
            if v160 then
                local v162 = v160:GetAttribute("Dead") ~= true
                if v162 then
                    v162 = v161 and v161.Health > 0 and true or false
                end
                v_u_152 = v162
            else
                v_u_152 = false
            end
        end)
    end)
    local function v_u_168(p163)
        -- upvalues: (ref) v_u_5
        local v164 = v_u_5:GetPlayerByUserId(p163)
        if not (v164 and v164.Character) then
            return false
        end
        local v165 = v164.Character
        local v166 = v165:FindFirstChildOfClass("Humanoid")
        local v167 = v165:GetAttribute("Dead") ~= true
        if v167 then
            v167 = v166 and v166.Health > 0 and true or false
        end
        return v167
    end
    local v_u_169 = {}
    local function v_u_186(p170, p171, p172)
        -- upvalues: (ref) v_u_169, (ref) v_u_5, (copy) v_u_168, (ref) v_u_7, (ref) v_u_152, (ref) v_u_1
        if p170.Status == Enum.TextChatMessageStatus.Success then
            local v173 = p170.MessageId
            if v173 and v_u_169[v173] then
                return
            else
                if v173 then
                    v_u_169[v173] = true
                    local v174 = 0
                    for _ in v_u_169 do
                        v174 = v174 + 1
                    end
                    if v174 > 100 then
                        v_u_169 = {
                            [v173] = true
                        }
                    end
                end
                local v175 = p170.TextSource
                if v175 then
                    local v176 = v175.UserId
                    if v176 then
                        local v_u_177 = v_u_5:GetPlayerByUserId(v176)
                        if v_u_177 then
                            local v178 = v_u_168(v176)
                            local v179 = v_u_177:GetAttribute("Team")
                            local v180 = v_u_7:GetAttribute("Team")
                            local v181 = workspace:GetAttribute("ServerGamemode") == "Competitive"
                            if p171 == "All" or p171 == "AllDead" then
                                if v_u_152 and (not v178 and (p171 == "All" and not v181)) then
                                    return
                                end
                            elseif p171 == "Team" or p171 == "TeamDead" then
                                if v179 ~= v180 then
                                    return
                                end
                                if p171 == "Team" and (v_u_152 and not (v178 or v181)) then
                                    return
                                end
                            end
                            local v182 = 0
                            local v183, v184 = pcall(function()
                                -- upvalues: (copy) v_u_177
                                return v_u_177:GetRankInGroup(33751825)
                            end)
                            if v183 then
                                v182 = v184 or v182
                            end
                            local v185 = {
                                ["verified"] = v_u_177.HasVerifiedBadge,
                                ["userId"] = v176,
                                ["displayName"] = v_u_177.DisplayName,
                                ["team"] = v179 or "Spectators",
                                ["message"] = p170.Text,
                                ["alive"] = v178,
                                ["role"] = v182
                            }
                            v_u_1.ProcessChatData(v185, p172)
                        end
                    else
                        return
                    end
                else
                    return
                end
            end
        else
            return
        end
    end
    if v148 then
        function v148.OnIncomingMessage(p187)
            -- upvalues: (copy) v_u_186
            v_u_186(p187, "All", false)
            return nil
        end
    end
    if v149 then
        function v149.OnIncomingMessage(p188)
            -- upvalues: (copy) v_u_186
            v_u_186(p188, "AllDead", false)
            return nil
        end
    end
    if v150 then
        function v150.OnIncomingMessage(p189)
            -- upvalues: (copy) v_u_186
            v_u_186(p189, "Team", true)
            return nil
        end
    end
    if v151 then
        function v151.OnIncomingMessage(p190)
            -- upvalues: (copy) v_u_186
            v_u_186(p190, "TeamDead", true)
            return nil
        end
    end
    v_u_15.Chat.ChatTeamJoin.Listen(function(p191)
        -- upvalues: (ref) v_u_14, (ref) v_u_7, (ref) v_u_1
        if v_u_14.Get(v_u_7, "Settings.Game.HUD.System Chat Messages") ~= false then
            v_u_1.ProcessTeamJoin(p191.name, p191.team)
        end
    end)
    v_u_15.Chat.ChatPlayerLeave.Listen(function(p192)
        -- upvalues: (ref) v_u_14, (ref) v_u_7, (ref) v_u_1
        if v_u_14.Get(v_u_7, "Settings.Game.HUD.System Chat Messages") ~= false then
            v_u_1.ProcessPlayerLeave(p192.name)
        end
    end)
    v_u_15.Chat.ChatPlayerBanned.Listen(function(p193)
        -- upvalues: (ref) v_u_14, (ref) v_u_7, (ref) v_u_1
        if v_u_14.Get(v_u_7, "Settings.Game.HUD.System Chat Messages") ~= false then
            v_u_1.ProcessPlayerBanned(p193.name)
        end
    end)
    v_u_15.Chat.ChatSystemMessage.Listen(function(p194)
        -- upvalues: (ref) v_u_14, (ref) v_u_7, (ref) v_u_1
        if v_u_14.Get(v_u_7, "Settings.Game.HUD.System Chat Messages") ~= false then
            v_u_1.ProcessSystemMessage(p194.message)
        end
    end)
    v_u_15.Chat.ChatTeamDamage.Listen(function(p195)
        -- upvalues: (ref) v_u_14, (ref) v_u_7, (ref) v_u_1
        if v_u_14.Get(v_u_7, "Settings.Game.HUD.System Chat Messages") ~= false then
            v_u_1.ProcessTeamDamage(p195)
        end
    end)
    v_u_15.Chat.ChatPlayerKilled.Listen(function(p196)
        -- upvalues: (ref) v_u_14, (ref) v_u_7, (ref) v_u_1
        if v_u_14.Get(v_u_7, "Settings.Game.HUD.System Chat Messages") ~= false then
            v_u_1.ProcessKillMessage(p196)
        end
    end)
    v_u_15.Chat.ChatMoneyReward.Listen(function(p197)
        -- upvalues: (ref) v_u_14, (ref) v_u_7, (ref) v_u_1
        if v_u_14.Get(v_u_7, "Settings.Game.HUD.System Chat Messages") ~= false then
            v_u_1.ProcessMoneyReward(p197)
        end
    end)
    v_u_15.Chat.ChatCaseOpened.Listen(function(p198)
        -- upvalues: (ref) v_u_14, (ref) v_u_7, (ref) v_u_1
        if v_u_14.Get(v_u_7, "Settings.Game.HUD.System Chat Messages") ~= false then
            v_u_1.ProcessCaseOpened(p198)
        end
    end)
    v_u_15.Chat.ChatGrenadeThrow.Listen(function(p199)
        -- upvalues: (ref) v_u_14, (ref) v_u_7, (ref) v_u_1
        if v_u_14.Get(v_u_7, "Settings.Game.HUD.System Chat Messages") ~= false then
            v_u_1.ProcessGrenadeThrow(p199)
        end
    end)
    v_u_15.Chat.ChatDefuseStart.Listen(function(p200)
        -- upvalues: (ref) v_u_14, (ref) v_u_7, (ref) v_u_1
        if v_u_14.Get(v_u_7, "Settings.Game.HUD.System Chat Messages") ~= false then
            v_u_1.ProcessDefuseStart(p200)
        end
    end)
    v_u_4.Heartbeat:Connect(function()
        -- upvalues: (ref) v_u_27, (ref) v_u_51
        if #v_u_27 > 0 then
            v_u_51()
        end
    end)
    v_u_3.InputBegan:Connect(function(p201, p202)
        -- upvalues: (ref) v_u_1, (ref) v_u_16
        if not p202 and (p201.UserInputType == Enum.UserInputType.Keyboard and p201.KeyCode == Enum.KeyCode.Slash) then
            v_u_1.OpenChat(v_u_16.Modes.All)
        end
    end)
end
return v_u_1
