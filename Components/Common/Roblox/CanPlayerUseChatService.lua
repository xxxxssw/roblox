-- MODULESCRIPT: CanPlayerUseChatService
-- Original Path: game.BAC - 33020.Database.Components.Common.Roblox.CanPlayerUseChatService
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("TextChatService")
return function(p_u_2)
    -- upvalues: (copy) v_u_1
    local v3, v4 = pcall(function()
        -- upvalues: (ref) v_u_1, (copy) p_u_2
        return v_u_1:CanUserChatAsync(p_u_2.UserId)
    end)
    if v3 then
        return v4
    end
    warn("[CanUserUseChat] Failed to check if user can use chat", v4)
    return false
end
