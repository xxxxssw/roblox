-- MODULESCRIPT: Get 400 Assists
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions.Get 400 Assists
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 400 Assists",
    ["Target"] = 400,
    ["Type"] = "monthly",
    ["Category"] = "assists",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 125
        }
    }
}
return table.freeze(v1)
