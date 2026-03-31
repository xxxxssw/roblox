-- MODULESCRIPT: Get 200 Multi-Kills
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions.Get 200 Multi-Kills
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 200 Multi-Kills",
    ["Target"] = 200,
    ["Type"] = "monthly",
    ["Category"] = "multikills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 165
        }
    }
}
return table.freeze(v1)
