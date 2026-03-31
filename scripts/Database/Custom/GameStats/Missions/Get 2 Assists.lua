-- MODULESCRIPT: Get 2 Assists
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 2 Assists
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 2 Assists",
    ["Target"] = 2,
    ["Type"] = "hourly",
    ["Category"] = "assists",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 1
        }
    }
}
return table.freeze(v1)
