-- MODULESCRIPT: Get 50 Pistol Kills
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 50 Pistol Kills
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 50 Pistol Kills",
    ["Target"] = 50,
    ["Type"] = "weekly",
    ["Category"] = "pistol_kills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 34
        }
    }
}
return table.freeze(v1)
