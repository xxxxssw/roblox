-- MODULESCRIPT: Get 2 Headshots
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 2 Headshots
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 2 Headshots",
    ["Target"] = 2,
    ["Type"] = "hourly",
    ["Category"] = "headshots",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 2
        }
    }
}
return table.freeze(v1)
