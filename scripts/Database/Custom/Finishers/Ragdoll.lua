-- MODULESCRIPT: Ragdoll
-- Original Path: game.BAC - 29092.Database.Custom.Finishers.Ragdoll
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
require(v1.Classes.Ragdoll.Types)
local v_u_2 = require(v1.Classes.Ragdoll)
return {
    ["Replication"] = "All",
    ["Finisher"] = function(p3, p4)
        -- upvalues: (copy) v_u_2
        local v_u_5 = v_u_2.new(p3, p4)
        return {
            ["OnDestroy"] = v_u_5.OnDestroy,
            ["Destroy"] = function()
                -- upvalues: (copy) v_u_5
                v_u_5:Destroy()
            end
        }
    end
}
