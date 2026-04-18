-- MODULESCRIPT: GetWeaponProperties
-- Original Path: game.BAC - 30366.Components.Common.GetWeaponProperties
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("ReplicatedStorage")
require(v_u_1.Database.Custom.Types)
return function(p2)
    -- upvalues: (copy) v_u_1
    local v3 = v_u_1.Database.Custom.Weapons:FindFirstChild(p2)
    if v3 then
        return require(v3)
    else
        return nil
    end
end
