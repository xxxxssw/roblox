-- MODULESCRIPT: Decoy Grenade
-- Original Path: game.BAC - 12574.Controllers.Observers.Game.Grenade.Executions.Decoy Grenade
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
require(v1.Database.Custom.Types)
return function(_, _, p_u_2)
    for _, v3 in ipairs(p_u_2:GetDescendants()) do
        if v3:IsA("BasePart") then
            v3.CollisionGroup = "Debris"
            v3.Transparency = 1
            v3.CanCollide = false
            v3.CanTouch = false
            v3.CanQuery = false
        end
    end
    task.delay(0.5, function()
        -- upvalues: (copy) p_u_2
        if p_u_2 and p_u_2.Parent then
            p_u_2:Destroy()
        end
    end)
end

>> Batch #53 complete. Yielding...
