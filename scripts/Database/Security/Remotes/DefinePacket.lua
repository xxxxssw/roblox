-- MODULESCRIPT: DefinePacket
-- Original Path: game.BAC - 29092.Database.Security.Remotes.DefinePacket
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Database.Security.Network)
require(script:WaitForChild("Types"))
return function(p_u_3, p4)
    -- upvalues: (copy) v_u_2
    local v_u_5 = p4 or {}
    return function(p6, p7)
        -- upvalues: (ref) v_u_2, (copy) p_u_3, (copy) v_u_5
        return v_u_2.CreatePacket(p6, p7, p_u_3, v_u_5)
    end
end
