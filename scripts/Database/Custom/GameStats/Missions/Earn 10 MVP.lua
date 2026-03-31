-- MODULESCRIPT: Earn 10 MVP
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions.Earn 10 MVP
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Earn 10 MVP",
    ["Target"] = 10,
    ["Type"] = "daily",
    ["Category"] = "mvp",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 12
        }
    }
}
return table.freeze(v1)
