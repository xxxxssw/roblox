-- MODULESCRIPT: Get 7 Pistol Kills
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions.Get 7 Pistol Kills
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 7 Pistol Kills",
    ["Target"] = 7,
    ["Type"] = "daily",
    ["Category"] = "pistol_kills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 11
        }
    }
}
return table.freeze(v1)
