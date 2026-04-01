-- MODULESCRIPT: BombPlanted
-- Original Path: game.BAC - 12574.Controllers.Observers.Game.BombPlanted
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Observers)
local v_u_3 = require(script.Bomb)
return v2.observeTag("Bomb", function(p4)
    -- upvalues: (copy) v_u_3
    local v_u_5 = v_u_3.new(p4)
    return function()
        -- upvalues: (copy) v_u_5
        if v_u_5 then
            v_u_5:destroy()
        end
    end
end)
