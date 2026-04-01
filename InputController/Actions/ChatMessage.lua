-- MODULESCRIPT: ChatMessage
-- Original Path: game.BAC - 44074.Controllers.InputController.Actions.ChatMessage
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.Types)
local v_u_2 = nil
local v4 = {
    ["Name"] = "Chat Message",
    ["Group"] = "Default",
    ["Category"] = "Communication Options",
    ["Callback"] = function(p3, _)
        -- upvalues: (ref) v_u_2, (copy) v_u_1
        if p3 == Enum.UserInputState.Begin then
            if not v_u_2 then
                v_u_2 = require(v_u_1.Interface.Screens.Gameplay.Middle.Chat)
            end
            v_u_2.OpenChat(1)
        end
    end
}
return table.freeze(v4)
