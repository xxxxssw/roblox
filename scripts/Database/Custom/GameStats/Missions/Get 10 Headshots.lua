-- MODULESCRIPT: Get 10 Headshots
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 10 Headshots
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 10 Headshots",
    ["Target"] = 10,
    ["Type"] = "daily",
    ["Category"] = "headshots",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 12
        }
    }
}
return table.freeze(v1)
