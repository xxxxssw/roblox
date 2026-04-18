-- MODULESCRIPT: RoundWon
-- Original Path: game.BAC - 20621.Interface.Screens.Gameplay.Middle.RoundWon
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Database.Components.GameState)
local v_u_4 = require(v1.Controllers.DataController)
local v_u_5 = require(v1.Interface.MenuState)
local v_u_6 = require(v1.Classes.Sound)
local v_u_7 = require(v1.Database.Security.Remotes)
require(v1.Database.Custom.Types)
local v_u_8 = v_u_2.LocalPlayer
local v_u_9 = {}
local v_u_10 = false
local v_u_11 = nil
local v12 = {}
local function v_u_20()
    -- upvalues: (copy) v_u_2
    local v13 = 0
    local v14 = 0
    for _, v15 in ipairs(v_u_2:GetPlayers()) do
        local v16 = v15:GetAttribute("Team")
        if v16 == "Counter-Terrorists" or v16 == "Terrorists" then
            local v17 = v15.Character
            if v17 and (v17:IsDescendantOf(workspace) and not v17:GetAttribute("Dead")) then
                local v18 = v17:FindFirstChildOfClass("Humanoid")
                if v18 and (v18.Health > 0 and not v15:GetAttribute("IsSpectating")) then
                    if v16 == "Counter-Terrorists" then
                        v14 = v14 + 1
                    else
                        v13 = v13 + 1
                    end
                end
            end
        end
    end
    local v19
    if v14 > 0 then
        v19 = v13 > 0
    else
        v19 = false
    end
    return v19
end
local function v_u_23()
    -- upvalues: (ref) v_u_11, (copy) v_u_4, (copy) v_u_8
    if v_u_11 and v_u_11.Parent then
        local v21 = (v_u_4.Get(v_u_8, "Settings.Audio.Music.MVP Volume") or 50) / 50
        local v22 = (v_u_4.Get(v_u_8, "Settings.Audio.Audio.Master Volume") or 100) / 100
        v_u_11.Volume = (v_u_11:GetAttribute("BaseVolume") or v_u_11.Volume) * v21 * v22
    end
end
local function v_u_29()
    -- upvalues: (copy) v_u_5, (copy) v_u_8, (copy) v_u_4, (copy) v_u_20, (ref) v_u_11, (copy) v_u_6
    if v_u_5.GetCurrentScreen() == nil then
        local v24 = v_u_8:WaitForChild("PlayerGui")
        local v25 = v24:FindFirstChild("MVP")
        if v25 and (v25:IsA("Sound") and v25.IsPlaying) then
            return
        elseif v_u_4.Get(v_u_8, "Settings.Audio.Other.Mute MVP Music when players on both teams are alive") ~= true or not v_u_20() then
            local v26 = (v_u_4.Get(v_u_8, "Settings.Audio.Music.MVP Volume") or 50) / 50
            v_u_11 = v_u_6.new("Round"):play({
                ["Parent"] = v24,
                ["Name"] = "MVP"
            }, v26)
            if v_u_11 then
                local v27 = (v_u_4.Get(v_u_8, "Settings.Audio.Audio.Master Volume") or 100) / 100
                local v28 = v_u_11.Volume
                if v26 > 0 and v27 > 0 then
                    v28 = v28 / (v26 * v27) or v28
                end
                v_u_11:SetAttribute("BaseVolume", v28)
                v_u_11.Destroying:Once(function()
                    -- upvalues: (ref) v_u_11
                    v_u_11 = nil
                end)
            end
        end
    else
        return
    end
end
local function v_u_31()
    -- upvalues: (copy) v_u_9
    for _, v30 in v_u_9 do
        v30.roundWonFrame.Visible = false
        if v30.playerMVPCTFrame then
            v30.playerMVPCTFrame.Visible = false
        end
        if v30.playerMVPTFrame then
            v30.playerMVPTFrame.Visible = false
        end
    end
end
local function v_u_41(p32, p33, p34)
    -- upvalues: (copy) v_u_2
    local v35 = p32:FindFirstChild("MVP")
    local v36 = v35 and v35:FindFirstChild("Text")
    if v36 then
        v36.Text = p33
    end
    local v37 = p32:FindFirstChild("Name")
    if v37 then
        v37.Text = p34
    end
    local v38 = p32:FindFirstChild("Player")
    if v38 then
        local v39 = v38:FindFirstChild("Player")
        local v40 = v39 and v_u_2:FindFirstChild(p34)
        if v40 then
            v39.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(v40.UserId)
        end
    end
end
local function v_u_47(p42)
    -- upvalues: (copy) v_u_8, (copy) v_u_9
    local v43 = v_u_8:GetAttribute("Team")
    for _, v44 in v_u_9 do
        local v45 = v44.roundWonFrame
        local v46
        if p42 == v44.winningTeam then
            v46 = v43 == p42
        else
            v46 = false
        end
        v45.Visible = v46
    end
end
local function v_u_54(p48)
    -- upvalues: (copy) v_u_2, (copy) v_u_9, (copy) v_u_41, (copy) v_u_29
    if p48 and (p48.Team and (p48.PlayerName and p48.Reason)) then
        local v49 = p48.Team
        local v50 = p48.PlayerName
        local v51 = p48.Reason
        if v49 == "Counter-Terrorists" or v49 == "Terrorists" then
            if v_u_2:FindFirstChild(v50) then
                local v52 = (not v51 or v51 == "Unknown") and "MVP" or ("MVP | %*"):format(v51)
                for _, v53 in v_u_9 do
                    if v49 == "Counter-Terrorists" and v53.playerMVPCTFrame then
                        v_u_41(v53.playerMVPCTFrame, v52, v50)
                        v53.playerMVPCTFrame.Visible = true
                        if v53.playerMVPTFrame then
                            v53.playerMVPTFrame.Visible = false
                        end
                        v_u_29()
                    elseif v49 == "Terrorists" and v53.playerMVPTFrame then
                        v_u_41(v53.playerMVPTFrame, v52, v50)
                        v53.playerMVPTFrame.Visible = true
                        if v53.playerMVPCTFrame then
                            v53.playerMVPCTFrame.Visible = false
                        end
                        v_u_29()
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
local function v_u_58()
    -- upvalues: (ref) v_u_10, (copy) v_u_4, (copy) v_u_8, (copy) v_u_23, (copy) v_u_3, (copy) v_u_31, (ref) v_u_11, (copy) v_u_7, (copy) v_u_47, (copy) v_u_54
    if not v_u_10 then
        v_u_10 = true
        v_u_4.CreateListener(v_u_8, "Settings.Audio.Audio.Master Volume", v_u_23)
        v_u_4.CreateListener(v_u_8, "Settings.Audio.Music.MVP Volume", v_u_23)
        v_u_3.ListenToState(function(p55, p56)
            -- upvalues: (ref) v_u_31, (ref) v_u_8, (ref) v_u_11
            if p55 == "Intermission" and p56 == "Buy Period" or p56 == "Round In Progress" then
                v_u_31()
                local v57 = v_u_8:WaitForChild("PlayerGui"):FindFirstChild("MVP")
                if v57 and v57:IsA("Sound") then
                    v57:Stop()
                    v57:Destroy()
                end
                v_u_11 = nil
            end
        end)
        v_u_7.UI.RoundWinner.Listen(v_u_47)
        v_u_7.UI.RoundMVP.Listen(v_u_54)
    end
end
function v12.create(p_u_59)
    -- upvalues: (copy) v_u_9, (copy) v_u_58
    return {
        ["Initialize"] = function(p60, p61)
            -- upvalues: (ref) v_u_9, (copy) p_u_59, (ref) v_u_58
            v_u_9[p_u_59] = {
                ["winningTeam"] = p_u_59,
                ["roundWonFrame"] = p61,
                ["mainGui"] = p60,
                ["playerMVPCTFrame"] = p60.Gameplay.Middle:FindFirstChild("PlayerMVPCT"),
                ["playerMVPTFrame"] = p60.Gameplay.Middle:FindFirstChild("PlayerMVPT")
            }
            v_u_58()
        end
    }
end
return v12
