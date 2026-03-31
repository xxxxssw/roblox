-- MODULESCRIPT: Deathmatch
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.InventorySchemas.Deathmatch
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = table.freeze
local v2 = {
    ["MaxInventorySpace"] = 3
}
local v3 = {
    {
        ["MaxSlotSpace"] = 1,
        ["Type"] = "Primary"
    },
    {
        ["MaxSlotSpace"] = 1,
        ["Type"] = "Secondary"
    },
    {
        ["MaxSlotSpace"] = 2,
        ["Type"] = "Melee"
    }
}
v2.InventorySlots = v3
return v1(v2)
