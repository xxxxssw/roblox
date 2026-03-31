-- MODULESCRIPT: Finishers
-- Original Path: game.BAC - 15337.Database.Components.Finishers
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
require(v2.Database.Custom.Types)
local v_u_4 = v_u_3.LocalPlayer
local v_u_5 = {}
local v_u_6 = {}
local v_u_7 = {}
local v_u_8 = {}
local function v_u_12(p9)
    if typeof(p9) ~= "Instance" or not p9:IsA("Model") then
        return false
    end
    if p9:HasTag("Ragdoll") then
        return false
    end
    if p9:GetAttribute("Dead") == true then
        return true
    end
    local v10 = p9:FindFirstChildOfClass("Humanoid")
    local v11
    if v10 == nil then
        v11 = false
    else
        v11 = v10.Health <= 0
    end
    return v11
end
local function v_u_18(p13)
    -- upvalues: (copy) v_u_3, (copy) v_u_8, (copy) v_u_12
    local v14 = p13.Victim
    if v14 then
        local v15 = v_u_3:GetPlayerByUserId(v14)
        local v16 = v15 and v15.Name or v_u_8[v14]
        if v16 then
            local v17 = workspace:WaitForChild("Debris"):QueryDescendants((("#%*"):format(v16)))[1]
            if v_u_12(v17) then
                return v17
            else
                if v15 then
                    v15 = v15.Character
                end
                if v_u_12(v15) then
                    return v15
                elseif v15 and (v15:IsA("Model") and not v15:HasTag("Ragdoll")) then
                    return v15
                else
                    return nil
                end
            end
        else
            return nil
        end
    else
        return nil
    end
end
function v_u_1.IsFinisherValidForReplication(p19)
    -- upvalues: (copy) v_u_7, (copy) v_u_4
    local v20 = v_u_7[p19.Finisher]
    local v21 = ("\"%*\" is not a valid member of database.custom.finishers"):format(p19.Finisher)
    assert(v20, v21)
    local v22 = v_u_4.UserId
    return v20.Replication == "Killer" and p19.Killer == v22 and true or (v20.Replication == "Victim" and p19.Victim == v22 and true or (v20.Replication == "Both" and (p19.Killer == v22 or p19.Victim == v22) and true or v20.Replication == "All"))
end
function v_u_1.ExecuteFinisher(p_u_23)
    -- upvalues: (copy) v_u_1, (copy) v_u_7, (copy) v_u_18, (copy) v_u_6, (copy) v_u_5
    if v_u_1.IsFinisherValidForReplication(p_u_23) then
        local v_u_24 = v_u_7[p_u_23.Finisher]
        local v25 = ("\"%*\" is not a valid member of database.custom.finishers"):format(p_u_23.Finisher)
        assert(v_u_24, v25)
        local v36, v37 = pcall(function()
            -- upvalues: (ref) v_u_18, (copy) p_u_23, (ref) v_u_6, (ref) v_u_5, (copy) v_u_24
            local v26 = v_u_18(p_u_23)
            if not v26 then
                local v27 = os.clock() + 0.35
                repeat
                    task.wait(0.05)
                    v26 = v_u_18(p_u_23)
                until v26 or v27 <= os.clock()
            end
            if not v26 then
                warn((("Failed to execute finisher \"%*\": missing victim character \"%*\""):format(p_u_23.Finisher, p_u_23.Victim)))
                return nil
            end
            v26.Archivable = true
            local v28 = p_u_23.Victim
            local v_u_29 = tostring(v28)
            local v30 = v_u_6[v_u_29]
            if v30 then
                v30.Destroy()
            end
            while #v_u_5 >= 8 do
                local v31 = table.remove(v_u_5, 1)
                if v31 then
                    v31.Destroy()
                end
            end
            local v_u_32 = v_u_24.Finisher(v26, p_u_23)
            local v_u_33 = {
                ["Name"] = v_u_29,
                ["Destroy"] = function()
                    -- upvalues: (ref) v_u_6, (copy) v_u_29, (copy) v_u_32
                    v_u_6[v_u_29] = nil
                    v_u_32.Destroy()
                end
            }
            v_u_6[v_u_29] = v_u_32
            local v34 = v_u_5
            table.insert(v34, v_u_33)
            v_u_32.OnDestroy:Once(function()
                -- upvalues: (ref) v_u_5, (copy) v_u_33
                local v35 = table.find(v_u_5, v_u_33)
                if v35 then
                    table.remove(v_u_5, v35)
                end
            end)
        end)
        if not v36 then
            warn((("Failed to execute finisher \"%*\": %*"):format(p_u_23.Finisher, v37)))
        end
    end
end
for _, v38 in v_u_3:GetPlayers() do
    v_u_8[v38.UserId] = v38.Name
end
v_u_3.PlayerAdded:Connect(function(p39)
    -- upvalues: (copy) v_u_8
    v_u_8[p39.UserId] = p39.Name
end)
for _, v40 in ipairs(v2.Database.Custom.Finishers:GetChildren()) do
    if v40:IsA("ModuleScript") then
        v_u_7[v40.Name] = require(v40)
    end
end
return v_u_1
