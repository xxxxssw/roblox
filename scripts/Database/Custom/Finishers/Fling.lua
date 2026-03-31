-- MODULESCRIPT: Fling
-- Original Path: game.BAC - 29092.Database.Custom.Finishers.Fling
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(v1.Classes.Ragdoll.Types)
local v_u_3 = v2.LocalPlayer
local v4 = require(v1.Classes.Sound)
local v_u_5 = require(v1.Classes.Ragdoll)
local v_u_6 = v4.new("Finishers")
return {
    ["Replication"] = "All",
    ["Finisher"] = function(p7, p8)
        -- upvalues: (copy) v_u_5, (copy) v_u_3, (copy) v_u_6
        local v9 = v_u_5.new
        local v10 = {
            ["DirectionMultiplier"] = math.random(25, 40)
        }
        for v11, v12 in pairs(v10) do
            p8[v11] = v12
        end
        local v_u_13 = v9(p7, p8)
        local v14 = p8.Victim
        local v15 = v_u_3.UserId
        if v14 == tostring(v15) then
            v_u_6:play({
                ["Parent"] = v_u_3.PlayerGui,
                ["Name"] = "Fling"
            })
        end
        return {
            ["OnDestroy"] = v_u_13.OnDestroy,
            ["Destroy"] = function()
                -- upvalues: (copy) v_u_13
                v_u_13:Destroy()
            end
        }
    end
}
