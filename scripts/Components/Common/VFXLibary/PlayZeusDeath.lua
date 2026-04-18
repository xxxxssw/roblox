-- MODULESCRIPT: PlayZeusDeath
-- Original Path: game.BAC - 15337.Components.Common.VFXLibary.PlayZeusDeath
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("Debris")
local v_u_4 = v1:WaitForChild("Assets"):WaitForChild("Other")
local v_u_5 = workspace:WaitForChild("Debris")
return function(p6)
    -- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_5, (copy) v_u_3
    local v7 = tonumber(p6)
    if not v7 then
        return
    end
    local v8 = v_u_4:FindFirstChild("ZeusDeath")
    if not (v8 and v8:IsA("ParticleEmitter")) then
        return
    end
    local v9 = v_u_2:GetPlayerByUserId(v7)
    local v10
    if v9 then
        v10 = v_u_5:FindFirstChild(v9.Name)
        if not (v10 and (v10:IsA("Model") and v10:HasTag("Ragdoll"))) then
            v10 = nil
        end
    else
        v10 = nil
    end
    if v10 then
        ::l14::
        if v10 then
            local v11 = v10:FindFirstChild("HumanoidRootPart")
            if v11 and v11:IsA("BasePart") then
                local v_u_12 = v8:Clone()
                v_u_12.Enabled = false
                v_u_12.Parent = v11
                local v13 = v_u_12:GetAttribute("EmitCount")
                if typeof(v13) == "number" and v13 > 0 then
                    v_u_12:Emit(v13)
                else
                    v_u_12.Enabled = true
                    task.delay(0.15, function()
                        -- upvalues: (copy) v_u_12
                        if v_u_12 and v_u_12.Parent then
                            v_u_12.Enabled = false
                        end
                    end)
                end
                local v14 = v_u_3
                local v15 = v_u_12.Lifetime.Max
                v14:AddItem(v_u_12, math.max(v15, 1) + 1)
            end
        else
            return
        end
    else
        local v16 = os.clock() + 0.5
        while true do
            if true then
                task.wait(0.05)
                local v17 = v_u_2:GetPlayerByUserId(v7)
                if v17 then
                    v10 = v_u_5:FindFirstChild(v17.Name)
                    if not (v10 and (v10:IsA("Model") and v10:HasTag("Ragdoll"))) then
                        v10 = nil
                    end
                else
                    v10 = nil
                end
            end
            if v10 or v16 <= os.clock() then
                goto l14
            end
        end
    end
end
