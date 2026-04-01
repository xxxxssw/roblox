-- MODULESCRIPT: Get 13 Assists
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions.Get 13 Assists
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 13 Assists",
    ["Target"] = 13,
    ["Type"] = "daily",
    ["Category"] = "assists",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 8
        }
    }
}
return table.freeze(v1)
