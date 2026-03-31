-- MODULESCRIPT: Hostage Rescue
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.InventorySchemas.Hostage Rescue
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = table.freeze
local v2 = {
    ["MaxInventorySpace"] = 4
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
    },
    {
        ["MaxSlotSpace"] = 4,
        ["Type"] = "Grenade"
    }
}
v2.InventorySlots = v3
return v1(v2)
