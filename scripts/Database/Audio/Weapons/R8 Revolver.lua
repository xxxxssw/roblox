-- MODULESCRIPT: R8 Revolver
-- Original Path: game.BAC - 54247.Database.Audio.Weapons.R8 Revolver
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 101450661540963 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 60,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 2
    }
}
v2.Equip = v3
local v4 = {
    ["Identifiers"] = { 117309994998140 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 60,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagIn = v4
local v5 = {
    ["Identifiers"] = { 134811694709654 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 60,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagOut = v5
local v6 = {
    ["Identifiers"] = { 126386741440481 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 40,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.SideIn = v6
local v7 = {
    ["Identifiers"] = { 98268584253902 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 40,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.SideRelease = v7
local v8 = {
    ["Identifiers"] = { 124814717709767 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 35,
        ["Volume"] = 0.9
    }
}
v2.Shoot = v8
local v9 = {
    ["Identifiers"] = { 81487509100437 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 35,
        ["Volume"] = 0.9
    }
}
v2.Hammer = v9
local v10 = {
    ["Identifiers"] = { 79755879528922 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 30,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 0.9
    }
}
v2.Prepare = v10
return v1(v2)
