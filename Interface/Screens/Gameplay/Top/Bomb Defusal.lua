-- MODULESCRIPT: Bomb Defusal
-- Original Path: game.BAC - 17285.Interface.Screens.Gameplay.Top.Bomb Defusal
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("CollectionService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_7 = v_u_6.LocalPlayer
local v_u_8 = require(v3.Database.Components.Common.RemoveFromArray)
local v_u_9 = require(v3.Components.Common.GetTimerFormat)
local v_u_10 = require(v3.Interface.Screens.Gameplay.Top.PlayerInfo)
local v_u_11 = require(v3.Database.Components.GameState)
local v_u_12 = require(v3.Database.Security.Router)
local v_u_13 = require(v3.Packages.Observers)
require(v3.Shared.Janitor)
local v_u_14 = require(v3.Database.Security.Remotes)
local v_u_15 = 0
local v_u_16 = Color3.fromRGB(85, 255, 85)
local v_u_17 = Color3.fromRGB(250, 31, 31)
local v_u_18 = Color3.fromRGB(85, 255, 85)
local v_u_19 = Color3.fromRGB(230, 36, 36)
local v_u_20 = {}
local v_u_21 = nil
local v_u_22 = nil
local function v_u_25(p23)
    for _, v24 in p23:GetChildren() do
        if v24.ClassName == "Frame" then
            v24:Destroy()
        end
    end
end
local function v_u_29(p26)
    -- upvalues: (copy) v_u_6
    local v27 = {}
    for _, v28 in v_u_6:GetPlayers() do
        if v28:GetAttribute("Team") == p26 then
            table.insert(v27, v28)
        end
    end
    return v27
end
function v_u_1.CreateTemplate(p30)
    -- upvalues: (copy) v_u_1, (ref) v_u_21, (copy) v_u_10, (copy) v_u_20
    local v31 = workspace:GetAttribute("Gamemode")
    local v32 = p30:GetAttribute("Team")
    if v31 == "Bomb Defusal" or v31 == "Hostage Rescue" then
        v_u_1.CleanupTemplate(p30)
        local v33 = v_u_21:FindFirstChild(v32)
        local v34 = v33 and v_u_10.createTemplate(p30, v33)
        if v34 then
            v_u_20[p30] = v34
        end
    end
end
function v_u_1.CleanupTemplate(p35)
    -- upvalues: (copy) v_u_20, (copy) v_u_10
    local v36 = v_u_20[p35]
    v_u_20[p35] = nil
    if v36 then
        v36:Destroy()
        v_u_10.cleanupTemplate(p35)
    end
end
function v_u_1.PlayerAdded(p_u_37)
    -- upvalues: (copy) v_u_13, (copy) v_u_1, (copy) v_u_7, (copy) v_u_6, (copy) v_u_10
    v_u_13.observeAttribute(p_u_37, "Team", function(p38)
        -- upvalues: (ref) v_u_1, (copy) p_u_37, (ref) v_u_7, (ref) v_u_6, (ref) v_u_10
        if p38 ~= "Counter-Terrorists" and p38 ~= "Terrorists" then
            v_u_1.CleanupTemplate(p_u_37)
            return function()
                -- upvalues: (ref) v_u_1, (ref) p_u_37
                v_u_1.CleanupTemplate(p_u_37)
            end
        end
        v_u_1.CreateTemplate(p_u_37)
        if p_u_37 == v_u_7 then
            for _, v39 in v_u_6:GetPlayers() do
                local v40 = v39:GetAttribute("Team")
                if v39 ~= v_u_7 and (v40 == "Counter-Terrorists" or v40 == "Terrorists") then
                    v_u_1.CreateTemplate(v39)
                end
            end
        end
        v_u_10.refreshCompetitiveColors()
        return function()
            -- upvalues: (ref) v_u_1, (ref) p_u_37
            v_u_1.CleanupTemplate(p_u_37)
        end
    end)
end
function v_u_1.Initialize(p41, p42)
    -- upvalues: (ref) v_u_22, (ref) v_u_21, (copy) v_u_13, (copy) v_u_10, (copy) v_u_14, (copy) v_u_6, (copy) v_u_11, (copy) v_u_9, (copy) v_u_12, (copy) v_u_5, (ref) v_u_15, (copy) v_u_2, (copy) v_u_29, (copy) v_u_8, (copy) v_u_18, (copy) v_u_19, (copy) v_u_16, (copy) v_u_17, (copy) v_u_4
    v_u_22 = p41
    v_u_21 = p42
    v_u_13.observeAttribute(workspace, "CTScore", function(p43)
        -- upvalues: (ref) v_u_21
        v_u_21.Time["Counter-Terrorists"].Score.Text = tostring(p43)
        return function() end
    end)
    v_u_13.observeAttribute(workspace, "TScore", function(p44)
        -- upvalues: (ref) v_u_21
        v_u_21.Time.Terrorists.Score.Text = tostring(p44)
        return function() end
    end)
    v_u_13.observeAttribute(workspace, "ServerGamemode", function(_)
        -- upvalues: (ref) v_u_10
        v_u_10.refreshCompetitiveColors()
        return function() end
    end)
    v_u_14.UI.UIPlayerKilled.Listen(function(p45)
        -- upvalues: (ref) v_u_6, (ref) v_u_10
        local v46 = p45.Victim
        local v47 = tonumber(v46)
        local v48
        if v47 then
            v48 = v_u_6:GetPlayerByUserId(v47)
        else
            v48 = v47
        end
        if v48 then
            local v49 = v_u_10.getTemplateByUserId(v47)
            if v49 and v49.Parent then
                local v50 = v48.Character
                if v50 then
                    v50 = v50:GetAttribute("Dead") == true
                end
                local v51 = v48:GetAttribute("IsSpectating") == true
                if v50 == true and true or v51 == true then
                    v_u_10.applyTemplateLifeState(v49, true)
                end
            end
        end
        local v52 = p45.Killer
        local v53 = tonumber(v52)
        local v54
        if v53 then
            v54 = v_u_6:GetPlayerByUserId(v53)
        else
            v54 = v53
        end
        if v54 then
            v_u_10.incrementTemplateKills(v53, 1)
        end
    end)
    v_u_14.UI.RoundWinner.Listen(function(_)
        -- upvalues: (ref) v_u_10
        v_u_10.setTeammateInfoRevealed(true)
    end)
    v_u_11.ListenToState(function(p55, p56)
        -- upvalues: (ref) v_u_10
        if p56 == "Buy Period" then
            v_u_10.setTeammateInfoRevealed(true)
        elseif p55 == "Buy Period" and p56 == "Round In Progress" then
            v_u_10.setTeammateInfoRevealed(false)
        end
    end)
    workspace:GetAttributeChangedSignal("Timer"):Connect(function()
        -- upvalues: (ref) v_u_21, (ref) v_u_9, (ref) v_u_12
        local v57 = workspace:GetAttribute("Timer")
        if v57 then
            local v58 = workspace:GetAttribute("Gamemode")
            local v59 = workspace:GetAttribute("GameState")
            v_u_21.Time.Timer.TextColor3 = Color3.fromRGB(255, 255, 255)
            v_u_21.Time.Timer.Text = v_u_9(v57)
            if v58 == "Deathmatch" and (v59 ~= "Warmup" and v57 <= 10) then
                v_u_21.Time.Timer.TextColor3 = Color3.fromRGB(165, 20, 20)
                v_u_12.broadcastRouter("PlayCountdownTimer")
            end
        else
            return
        end
    end)
    v_u_5.Heartbeat:Connect(function(p60)
        -- upvalues: (ref) v_u_15, (ref) v_u_22, (ref) v_u_21, (ref) v_u_2, (ref) v_u_29, (ref) v_u_8, (ref) v_u_18, (ref) v_u_19, (ref) v_u_16, (ref) v_u_17, (ref) v_u_4
        local v61 = workspace:GetAttribute("Gamemode")
        v_u_15 = v_u_15 + p60
        v_u_21.Visible = (v61 == "Hostage Rescue" and true or v61 == "Bomb Defusal") and not v_u_22.Gameplay.Middle.TeamSelection.Visible
        if v_u_21.Visible then
            local v62 = v_u_2:GetTagged("Bomb")
            for _, v63 in { "Counter-Terrorists", "Terrorists" } do
                local v64 = v_u_21.Time:FindFirstChild(v63)
                if v64 then
                    v64 = v64:FindFirstChild("Players")
                end
                if v64 then
                    local v68 = #v_u_8(v_u_29(v63), function(_, p65)
                        local v66 = p65.Character
                        if v66 and v66:IsDescendantOf(workspace) then
                            local v67 = v66:FindFirstChildOfClass("Humanoid")
                            if v67 and v67.Health > 0 then
                                return false
                            end
                        end
                        return true
                    end)
                    v64.Text = tostring(v68)
                end
            end
            local v69 = v62[1]
            if v69 then
                v_u_21.Time.Timer.Visible = false
                v_u_21.Time.Bomb.Visible = true
                local v70 = v69:GetAttribute("Defused") == true
                local v71 = v70 and v_u_18 or v_u_19
                local v72 = v70 and v_u_16 or v_u_17
                v_u_21.Time.Bomb.Glow.ImageColor3 = v72
                v_u_21.Time.Bomb.ImageColor3 = v71
                if v70 or v_u_15 < 1 then
                    v_u_21.Time.Bomb.Glow.ImageTransparency = 0.75
                else
                    local v73 = v_u_21.Time.Bomb.Glow.ImageTransparency
                    v_u_15 = 0
                    v_u_4:Create(v_u_21.Time.Bomb.Glow, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        ["ImageTransparency"] = v73 < 0.5 and 0.75 or 0
                    }):Play()
                end
            else
                v_u_21.Time.Bomb.Glow.ImageColor3 = v_u_17
                v_u_21.Time.Bomb.ImageColor3 = v_u_19
                v_u_21.Time.Timer.Visible = true
                v_u_21.Time.Bomb.Visible = false
                return
            end
        else
            return
        end
    end)
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_25, (ref) v_u_21, (copy) v_u_6, (copy) v_u_1
    v_u_25(v_u_21["Counter-Terrorists"])
    v_u_25(v_u_21.Terrorists)
    for _, v74 in v_u_6:GetPlayers() do
        v_u_1.PlayerAdded(v74)
    end
    v_u_6.PlayerAdded:Connect(v_u_1.PlayerAdded)
    v_u_6.PlayerRemoving:Connect(v_u_1.CleanupTemplate)
end
return v_u_1
