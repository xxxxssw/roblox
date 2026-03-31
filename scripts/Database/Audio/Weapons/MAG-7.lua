-- MODULESCRIPT: MAG-7
-- Original Path: game.BAC - 54247.Database.Audio.Weapons.MAG-7
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 123388272139659 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Draw = v3
local v4 = {
    ["Identifiers"] = { 135235818611788 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagOut = v4
local v5 = {
    ["Identifiers"] = { 115898616533129 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.MagIn = v5
local v6 = {
    ["Identifiers"] = { 76819368555754 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.PumpBack = v6
local v7 = {
    ["Identifiers"] = { 122789968435153 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.PumpForward = v7
local v8 = {
    ["Identifiers"] = { 79170683071311 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v8
return v1(v2)
