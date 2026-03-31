-- MODULESCRIPT: Get 2 Grenade Kills
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions.Get 2 Grenade Kills
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 2 Grenade Kills",
    ["Target"] = 2,
    ["Type"] = "daily",
    ["Category"] = "grenade_kills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 12
        }
    }
}
return table.freeze(v1)
