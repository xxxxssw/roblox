-- MODULESCRIPT: GetTimerFormat
-- Original Path: game.BAC - 30366.Components.Common.GetTimerFormat
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
game:GetService("ReplicatedStorage")
return function(p1)
    local v2 = p1 / 60
    local v3 = math.floor(v2)
    local v4 = string.format("%02i", v3)
    local v5 = p1 % 60
    return v4 .. ":" .. string.format("%02i", v5)
end
