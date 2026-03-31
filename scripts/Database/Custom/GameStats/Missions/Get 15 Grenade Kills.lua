-- MODULESCRIPT: Get 15 Grenade Kills
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 15 Grenade Kills
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 15 Grenade Kills",
    ["Target"] = 15,
    ["Type"] = "weekly",
    ["Category"] = "grenade_kills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 38
        }
    }
}
return table.freeze(v1)
