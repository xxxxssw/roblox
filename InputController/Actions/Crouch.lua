-- MODULESCRIPT: Crouch
-- Original Path: game.BAC - 44074.Controllers.InputController.Actions.Crouch
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Controllers.CharacterController)
v_u_3:GetAttributeChangedSignal("IsPlayerChatting"):Connect(function()
    -- upvalues: (copy) v_u_3, (copy) v_u_4
    if v_u_3:GetAttribute("IsPlayerChatting") then
        v_u_4.crouch(false)
    end
end)
return table.freeze({
    ["Name"] = "Crouch",
    ["Group"] = "Gameplay",
    ["Category"] = "Movement Keys",
    ["Callback"] = function(p5, _)
        -- upvalues: (copy) v_u_3, (copy) v_u_4
        if v_u_3:GetAttribute("IsPlayerChatting") then
            return
        elseif p5 == Enum.UserInputState.Begin then
            v_u_4.crouch(true)
            return
        elseif p5 == Enum.UserInputState.End then
            v_u_4.crouch(false)
        end
    end
})
