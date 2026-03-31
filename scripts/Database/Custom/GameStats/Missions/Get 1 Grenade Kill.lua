-- MODULESCRIPT: Get 1 Grenade Kill
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions.Get 1 Grenade Kill
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Get 1 Grenade Kill",
    ["Target"] = 1,
    ["Type"] = "hourly",
    ["Category"] = "grenade_kills",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 2
        }
    }
}
return table.freeze(v1)
