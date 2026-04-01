-- MODULESCRIPT: Win 2 rounds
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions.Win 2 rounds
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Win 2 Rounds",
    ["Target"] = 2,
    ["Type"] = "hourly",
    ["Category"] = "round_wins",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 2
        }
    }
}
return table.freeze(v1)
