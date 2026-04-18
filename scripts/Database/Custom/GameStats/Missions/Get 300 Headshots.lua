-- MODULESCRIPT: Get 300 Headshots
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 300 Headshots
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 300 Headshots",
    ["Target"] = 300,
    ["Type"] = "monthly",
    ["Category"] = "headshots",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 150
        }
    }
}
return table.freeze(v1)
