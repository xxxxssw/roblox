-- MODULESCRIPT: Get 1 Multi-Kill
-- Original Path: game.BAC - 42874.Database.Custom.GameStats.Missions.Get 1 Multi-Kill
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 1 Multi-Kill",
    ["Target"] = 1,
    ["Type"] = "hourly",
    ["Category"] = "multikills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 2
        }
    }
}
return table.freeze(v1)
