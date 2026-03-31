-- MODULESCRIPT: Grenades
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Grenades
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("RunService"):IsStudio()
return table.freeze({
    ["Decoy Grenade"] = v1 and 99 or 1,
    ["Smoke Grenade"] = v1 and 99 or 1,
    ["HE Grenade"] = v1 and 99 or 1,
    ["Flashbang"] = v1 and 99 or 2,
    ["Molotov"] = v1 and 99 or 1,
    ["Incendiary Grenade"] = v1 and 99 or 1
})
