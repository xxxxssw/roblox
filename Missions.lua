-- MODULESCRIPT: Missions
-- Original Path: game.BAC - 22016.Database.Custom.GameStats.Missions
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
require(v2.Database.Custom.Types)
local v_u_3 = {}
function v1.GetMissionDefinition(p4)
    -- upvalues: (copy) v_u_3
    return v_u_3[p4]
end
function v1.GetMissionCategory(p5)
    -- upvalues: (copy) v_u_3
    local v6 = v_u_3[p5]
    if v6 and v6.Category then
        return v6.Category
    else
        return nil
    end
end
for _, v7 in ipairs(script:GetChildren()) do
    if v7:IsA("ModuleScript") then
        local v8 = require(v7)
        if v8 and v8.MissionId then
            v_u_3[v8.MissionId] = v8
        end
    end
end
return v1
