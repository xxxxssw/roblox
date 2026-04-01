-- MODULESCRIPT: Get 20 Rifle Kills
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 20 Rifle Kills
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 20 Rifle Kills",
    ["Target"] = 20,
    ["Type"] = "daily",
    ["Category"] = "rifle_kills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 10
        }
    }
}
return table.freeze(v1)
