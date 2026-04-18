-- MODULESCRIPT: Get 200 Pistol Kills
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions.Get 200 Pistol Kills
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 200 Pistol Kills",
    ["Target"] = 200,
    ["Type"] = "monthly",
    ["Category"] = "pistol_kills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 150
        }
    }
}
return table.freeze(v1)
