-- MODULESCRIPT: Get 1 Kill While Low HP
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 1 Kill While Low HP
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 1 Kill While Low HP",
    ["Target"] = 1,
    ["Type"] = "hourly",
    ["Category"] = "kill_while_low_hp",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 2
        }
    }
}
return table.freeze(v1)
