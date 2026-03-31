-- MODULESCRIPT: Deathmatch
-- Original Path: game.BAC - 17285.Interface.Screens.Gameplay.Top.Deathmatch
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = require(v2.Components.Common.GetTimerFormat)
local v_u_6 = require(v2.Interface.Screens.Gameplay.Top.PlayerInfo)
local v_u_7 = require(v2.Database.Security.Router)
local v_u_8 = require(v2.Packages.Observers)
require(v2.Shared.Janitor)
local v_u_9 = nil
local v_u_10 = nil
local v_u_11 = {}
local function v_u_15(p12)
    local v13 = p12:GetChildren()
    for _, v14 in ipairs(v13) do
        if v14.ClassName == "Frame" then
            v14:Destroy()
        end
    end
end
function v_u_1.createTemplate(p16, _)
    -- upvalues: (copy) v_u_1, (copy) v_u_6, (ref) v_u_9, (copy) v_u_11
    local v17 = workspace:GetAttribute("Gamemode")
    local v18 = p16:GetAttribute("Team")
    if v17 == "Deathmatch" and (v18 == "Terrorists" or v18 == "Counter-Terrorists") then
        v_u_1.cleanupPlayerTemplate(p16)
        local v19 = v_u_6.createTemplate(p16, v_u_9.Players)
        if v19 then
            v_u_11[p16] = v19
        end
    end
end
function v_u_1.cleanupPlayerTemplate(p20)
    -- upvalues: (copy) v_u_11, (copy) v_u_6
    local v21 = v_u_11[p20]
    v_u_11[p20] = nil
    if v21 then
        v21:Destroy()
        v_u_6.cleanupTemplate(p20)
    end
end
function v_u_1.playerAdded(p_u_22)
    -- upvalues: (copy) v_u_1
    if p_u_22.Character then
        v_u_1.createTemplate(p_u_22, p_u_22.Character)
    end
    p_u_22.CharacterAdded:Connect(function(p23)
        -- upvalues: (ref) v_u_1, (copy) p_u_22
        v_u_1.createTemplate(p_u_22, p23)
    end)
end
function v_u_1.Initialize(p24, p25)
    -- upvalues: (ref) v_u_10, (ref) v_u_9, (copy) v_u_8, (copy) v_u_5, (copy) v_u_7, (copy) v_u_3
    v_u_10 = p24
    v_u_9 = p25
    v_u_8.observeAttribute(workspace, "Timer", function(p26)
        -- upvalues: (ref) v_u_9, (ref) v_u_5, (ref) v_u_7
        local v27 = workspace:GetAttribute("Gamemode")
        local v28 = workspace:GetAttribute("GameState")
        v_u_9.Time.Timer.TextColor3 = Color3.fromRGB(255, 255, 255)
        v_u_9.Time.Timer.Text = v_u_5(p26)
        if v27 == "Deathmatch" and (v28 ~= "Warmup" and p26 <= 10) then
            v_u_9.Time.Timer.TextColor3 = Color3.fromRGB(165, 20, 20)
            v_u_7.broadcastRouter("PlayCountdownTimer")
        end
    end)
    v_u_3.Heartbeat:Connect(function()
        -- upvalues: (ref) v_u_9, (ref) v_u_10
        local v29 = v_u_9
        local v30
        if workspace:GetAttribute("Gamemode") == "Deathmatch" then
            v30 = not v_u_10.Gameplay.Middle.TeamSelection.Visible
        else
            v30 = false
        end
        v29.Visible = v30
    end)
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_15, (ref) v_u_9, (copy) v_u_4, (copy) v_u_1
    v_u_15(v_u_9.Players)
    for _, v31 in ipairs(v_u_4:GetPlayers()) do
        v_u_1.playerAdded(v31)
    end
    v_u_4.PlayerAdded:Connect(function(p32)
        -- upvalues: (ref) v_u_1
        v_u_1.playerAdded(p32)
    end)
    v_u_4.PlayerRemoving:Connect(function(p33)
        -- upvalues: (ref) v_u_1
        v_u_1.cleanupPlayerTemplate(p33)
    end)
end
return v_u_1
