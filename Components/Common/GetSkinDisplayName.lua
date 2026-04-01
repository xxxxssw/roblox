-- MODULESCRIPT: GetSkinDisplayName
-- Original Path: game.BAC - 30366.Components.Common.GetSkinDisplayName
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = table.freeze({
    ["Lebron James"] = "LeGoat",
    ["Medal.tv"] = "Medal"
})
return function(p2)
    -- upvalues: (copy) v_u_1
    return v_u_1[p2] or p2
end
