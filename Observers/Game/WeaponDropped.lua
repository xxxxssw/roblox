-- MODULESCRIPT: WeaponDropped
-- Original Path: game.BAC - 41394.Controllers.Observers.Game.WeaponDropped
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Observers)
local v_u_3 = require(script.Weapon)
return v2.observeTag("WeaponDropped", function(p4)
    -- upvalues: (copy) v_u_3
    local v_u_5 = v_u_3.new(p4)
    return function()
        -- upvalues: (copy) v_u_5
        if v_u_5 then
            v_u_5:destroy()
        end
    end
end)
