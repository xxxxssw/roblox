-- MODULESCRIPT: Get 7 Kills
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 7 Kills
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 7 Kills",
    ["Target"] = 7,
    ["Type"] = "hourly",
    ["Category"] = "kills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 1
        }
    }
}
return table.freeze(v1)
