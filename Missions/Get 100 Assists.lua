-- MODULESCRIPT: Get 100 Assists
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 100 Assists
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 100 Assists",
    ["Target"] = 100,
    ["Type"] = "weekly",
    ["Category"] = "assists",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 30
        }
    }
}
return table.freeze(v1)
