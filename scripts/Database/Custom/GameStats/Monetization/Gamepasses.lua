-- MODULESCRIPT: Gamepasses
-- Original Path: game.BAC - 48473.Database.Custom.GameStats.Monetization.Gamepasses
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {
    ["Quick Open"] = {
        ["GamepassId"] = 1667852725,
        ["OnPurchased"] = function(_)
            return {
                ["success"] = false
            }
        end
    }
}
return table.freeze(v1)
