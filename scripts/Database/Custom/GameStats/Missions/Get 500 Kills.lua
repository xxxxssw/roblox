-- MODULESCRIPT: Get 500 Kills
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 500 Kills
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 500 Kills",
    ["Target"] = 500,
    ["Type"] = "weekly",
    ["Category"] = "kills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 32
        }
    }
}
return table.freeze(v1)
