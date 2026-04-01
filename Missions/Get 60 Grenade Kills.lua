-- MODULESCRIPT: Get 60 Grenade Kills
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions.Get 60 Grenade Kills
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 60 Grenade Kills",
    ["Target"] = 60,
    ["Type"] = "monthly",
    ["Category"] = "grenade_kills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 160
        }
    }
}
return table.freeze(v1)
