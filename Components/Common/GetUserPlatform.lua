-- MODULESCRIPT: GetUserPlatform
-- Original Path: game.BAC - 30366.Components.Common.GetUserPlatform
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("UserInputService")
return function()
    -- upvalues: (copy) v_u_1
    local v2 = {}
    if v_u_1.GamepadEnabled then
        table.insert(v2, "Console")
    end
    if v_u_1.VREnabled then
        table.insert(v2, "VR")
    end
    if v_u_1.MouseEnabled or v_u_1.KeyboardEnabled then
        table.insert(v2, "PC")
    end
    if v_u_1.TouchEnabled and not table.find(v2, "PC") then
        table.insert(v2, "Mobile")
    end
    return v2
end
