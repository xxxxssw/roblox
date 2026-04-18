-- MODULESCRIPT: Get 2 Flash Assists
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions.Get 2 Flash Assists
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 2 Flash Assists",
    ["Target"] = 2,
    ["Type"] = "hourly",
    ["Category"] = "flash_assists",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 1
        }
    }
}
return table.freeze(v1)
