-- MODULESCRIPT: RecycleFX
-- Original Path: game.BAC - 30366.Components.Common.RecycleFX
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = workspace:WaitForChild("Debris")
local v_u_4 = require(v1.Shared.DebugFlags)
return function()
    -- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4
    local v5 = 0
    local v6 = 0
    for _, v_u_7 in v_u_3:GetChildren() do
        if not v_u_7:IsA("Folder") then
            local v8
            if v_u_7:GetAttribute("PersistentDebris") == true then
                v8 = true
            else
                local v9 = v_u_7.Name
                v8 = string.sub(v9, -7) == "_Weapon" and true or string.find(v_u_7.Name, "_WeaponAttachments", 1, true) ~= nil
            end
            if v8 then
                v5 = v5 + 1
            else
                v6 = v6 + 1
                if v_u_2:FindFirstChild(v_u_7.Name) then
                    task.delay(0.5, function()
                        -- upvalues: (copy) v_u_7
                        if v_u_7 and v_u_7.Parent then
                            v_u_7:Destroy()
                        end
                    end)
                else
                    v_u_7:Destroy()
                end
            end
        end
    end
    if v_u_4.IsEnabled("DebrisCleanup") then
        warn(("[DebrisCleanup][Client] CleanupDebris received: destroyed=%d skipped=%d"):format(v6, v5))
    end
end
