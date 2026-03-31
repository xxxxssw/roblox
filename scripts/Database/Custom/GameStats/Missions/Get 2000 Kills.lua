-- MODULESCRIPT: Get 2000 Kills
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 2000 Kills
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 2000 Kills",
    ["Target"] = 2000,
    ["Type"] = "monthly",
    ["Category"] = "kills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 140
        }
    }
}
return table.freeze(v1)
