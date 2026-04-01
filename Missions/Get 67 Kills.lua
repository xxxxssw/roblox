-- MODULESCRIPT: Get 67 Kills
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions.Get 67 Kills
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 67 Kills",
    ["Target"] = 67,
    ["Type"] = "daily",
    ["Category"] = "kills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 10
        }
    }
}
return table.freeze(v1)
