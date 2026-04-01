-- MODULESCRIPT: Get 75 Headshots
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 75 Headshots
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 75 Headshots",
    ["Target"] = 75,
    ["Type"] = "weekly",
    ["Category"] = "headshots",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 35
        }
    }
}
return table.freeze(v1)
