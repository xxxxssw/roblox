-- MODULESCRIPT: Earn 75 MVPs
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions.Earn 75 MVPs
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["MissionId"] = "Earn 75 MVPs",
    ["Target"] = 75,
    ["Type"] = "weekly",
    ["Category"] = "mvp",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 40
        }
    }
}
return table.freeze(v1)
