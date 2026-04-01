-- MODULESCRIPT: Money
-- Original Path: game.BAC - 17285.Interface.Screens.Gameplay.Bottom.Money
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players").LocalPlayer
local v_u_5 = require(v2.Controllers.SpectateController)
local v_u_6 = require(v2.Database.Components.Common.IsInBuyArea)
local v_u_7 = require(v2.Database.Components.GameState)
local v_u_8 = require(v2.Components.Common.GetPreferenceColor)
local v_u_9 = require(v2.Database.Security.Router)
local v_u_10 = require(v2.Packages.Observers)
local v11 = require(v2.Shared.Janitor)
local v12 = require(v2.Shared.Spring)
local v_u_13 = v11.new()
local v_u_14 = v12.new(1, 8, 0)
local v_u_15 = nil
function v_u_1.CreatePlayerObserver(p16)
    -- upvalues: (copy) v_u_13, (copy) v_u_10, (copy) v_u_14
    v_u_13:Cleanup()
    v_u_13:Add(v_u_10.observeAttribute(p16, "Money", function(p17)
        -- upvalues: (ref) v_u_14
        v_u_14:setGoal(p17)
        return function()
            -- upvalues: (ref) v_u_14
            v_u_14:setGoal(0)
        end
    end))
end
function v_u_1.Initialize(_, p18)
    -- upvalues: (ref) v_u_15, (copy) v_u_4, (copy) v_u_13
    v_u_15 = p18
    if v_u_15.Active then
        v_u_15.Active = false
    end
    for _, v19 in ipairs(v_u_15:GetDescendants()) do
        if v19:IsA("GuiObject") then
            v19.Active = false
        end
    end
    v_u_4.CharacterRemoving:Connect(function()
        -- upvalues: (ref) v_u_13
        v_u_13:Cleanup()
    end)
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_13, (copy) v_u_1, (copy) v_u_4, (copy) v_u_5, (copy) v_u_7, (copy) v_u_3, (copy) v_u_14, (ref) v_u_15, (copy) v_u_8, (copy) v_u_6, (copy) v_u_9
    v_u_4.CharacterAdded:Connect(function()
        -- upvalues: (ref) v_u_4, (ref) v_u_13, (ref) v_u_1
        local v20 = v_u_4
        v_u_13:Cleanup()
        v_u_1.CreatePlayerObserver(v20)
    end)
    v_u_5.ListenToSpectate:Connect(function(p21)
        -- upvalues: (ref) v_u_13, (ref) v_u_1, (ref) v_u_4
        if p21 then
            v_u_13:Cleanup()
            v_u_1.CreatePlayerObserver(p21)
        elseif not v_u_4:GetAttribute("IsSpectating") then
            local v22 = v_u_4
            v_u_13:Cleanup()
            v_u_1.CreatePlayerObserver(v22)
        end
    end)
    v_u_4:GetAttributeChangedSignal("IsSpectating"):Connect(function()
        -- upvalues: (ref) v_u_4, (ref) v_u_13, (ref) v_u_1, (ref) v_u_5
        if v_u_4:GetAttribute("IsSpectating") then
            local v23 = v_u_5.GetPlayer()
            if v23 then
                v_u_13:Cleanup()
                v_u_1.CreatePlayerObserver(v23)
            end
        else
            local v24 = v_u_4
            v_u_13:Cleanup()
            v_u_1.CreatePlayerObserver(v24)
        end
    end)
    if v_u_4:GetAttribute("IsSpectating") then
        local v25 = v_u_5.GetPlayer()
        if v25 then
            v_u_13:Cleanup()
            v_u_1.CreatePlayerObserver(v25)
        end
    else
        local v26 = v_u_4
        v_u_13:Cleanup()
        v_u_1.CreatePlayerObserver(v26)
    end
    v_u_7.ListenToState(function(_, p27)
        -- upvalues: (ref) v_u_4, (ref) v_u_13, (ref) v_u_1
        if p27 == "Buy Period" or p27 == "Round In Progress" then
            local v28 = v_u_4
            v_u_13:Cleanup()
            v_u_1.CreatePlayerObserver(v28)
        end
    end)
    v_u_3.Heartbeat:Connect(function(p29)
        -- upvalues: (ref) v_u_14, (ref) v_u_15, (ref) v_u_8, (ref) v_u_4, (ref) v_u_6, (ref) v_u_9
        local v30 = v_u_14:getPosition()
        local v31 = math.round(v30)
        local v32 = tostring(v31):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        v_u_15.Amount.TextColor3 = v_u_8()
        v_u_15.Amount.Text = ("$%*"):format(v32)
        v_u_14:update(p29)
        if v_u_4:GetAttribute("BuyMenu") then
            local v33 = v_u_15.Buy.Visible
            v_u_15.Buy.Visible = v_u_6(v_u_4)
            if v33 and not v_u_15.Buy.Visible then
                v_u_9.broadcastRouter("CreateNotification", "You have left the buy zone", "You have left the buy zone", 2)
            end
        else
            v_u_15.Buy.Visible = false
            return
        end
    end)
end
return v_u_1
