-- MODULESCRIPT: Sawed-Off
-- Original Path: game.BAC - 54247.Database.Audio.Weapons.Sawed-Off
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 137150502547680 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Draw = v3
local v4 = {
    ["Identifiers"] = { 140232270425197, 111219016816566, 79315556711890 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Insert = v4
local v5 = {
    ["Identifiers"] = { 115455208830436 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.Pump = v5
local v6 = {
    ["Identifiers"] = { 109472139967331 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v6
return v1(v2)
