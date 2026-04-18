-- MODULESCRIPT: Reload
-- Original Path: game.BAC - 21977.Controllers.InputController.Actions.Reload
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Controllers.InventoryController)
local v_u_5 = require(v1.Controllers.HintController)
return table.freeze({
    ["Name"] = "Reload",
    ["Group"] = "Gameplay",
    ["Category"] = "Weapon Keys",
    ["Callback"] = function(p6, _)
        -- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
        if v_u_3:GetAttribute("IsPlayerChatting") then
            return
        elseif p6 == Enum.UserInputState.Begin then
            local v7 = v_u_4.getCurrentEquipped()
            if v7 then
                v7:reload()
                v_u_5:clearHint("Reload")
            end
        else
            return
        end
    end
})
