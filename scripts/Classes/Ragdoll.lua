-- MODULESCRIPT: Ragdoll
-- Original Path: game.BAC - 30366.Classes.Ragdoll
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u_4 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_5 = require(v_u_2.Database.Components.GameState)
local v_u_6 = require(v_u_2.Shared.Janitor)
local v_u_7 = require(v_u_2.Packages.Signal)
local v_u_8 = require(script.Configuration.CustomPhysicalProperties)
local v_u_9 = require(script.Configuration.MaxFrictionTorque)
local v_u_10 = require(script.Configuration.PartMultipliers)
local v_u_11 = require(script.Configuration.Constraints)
local v_u_12 = workspace:WaitForChild("Debris")
local v_u_13 = nil
local v_u_14 = table.freeze({
    ["ParticleEmitter"] = true,
    ["RigidConstraint"] = true,
    ["WeldConstraint"] = true,
    ["BillboardGui"] = true,
    ["Highlight"] = true,
    ["LocalScript"] = true,
    ["Humanoid"] = true,
    ["Script"] = true,
    ["Sound"] = true
})
local v_u_15 = table.freeze({
    ["WeaponAttachments"] = true,
    ["CollisionCapsule"] = true,
    ["WeaponModel"] = true,
    ["Hitbox"] = true,
    ["Insert"] = true
})
local v_u_16 = table.freeze({
    ["Accessory"] = true,
    ["Shirt"] = true,
    ["Pants"] = true,
    ["ShirtGraphic"] = true,
    ["BodyColors"] = true,
    ["CharacterMesh"] = true,
    ["WrapLayer"] = true,
    ["WrapTarget"] = true
})
local function v_u_21(p17)
    -- upvalues: (copy) v_u_12
    for _, v18 in { ("%*_Weapon"):format(p17.Name), (("%*_WeaponAttachments"):format(p17.Name)) } do
        local v19 = v_u_12:FindFirstChild(v18)
        if v19 then
            v19:Destroy()
        end
    end
    local v20 = p17:FindFirstChild("CharacterModel")
    if v20 then
        v20:Destroy()
    end
end
local function v_u_23(p22)
    -- upvalues: (copy) v_u_8
    p22.CanQuery = false
    p22.CanTouch = false
    p22.CastShadow = false
    p22.Massless = false
    p22.Anchored = false
    if p22.Name == "HumanoidRootPart" then
        p22.Transparency = 1
        p22.CanCollide = false
        p22:ApplyImpulse(Vector3.new(0, 1, 0))
    else
        p22.CollisionGroup = "Debris"
        p22.CanCollide = true
        p22.Transparency = 0
        p22.CustomPhysicalProperties = v_u_8[p22.Name] or v_u_8.Default
        if p22.Name ~= "UpperTorso" then
            p22.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            p22.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        end
    end
end
local function v_u_26(p24)
    for _, v25 in p24:QueryDescendants("BasePart") do
        if not v25:HasTag("CharacterAccessory") then
            v25.CollisionGroup = "Debris"
            v25.CanQuery = false
            v25.CanTouch = false
            if v25.Name == "HumanoidRootPart" then
                v25.CanCollide = false
            else
                v25.CanCollide = true
            end
        end
    end
end
local function v_u_38(p27)
    -- upvalues: (copy) v_u_16
    for _, v28 in p27:GetChildren() do
        if v_u_16[v28.ClassName] then
            v28:Destroy()
        end
    end
    local v29 = p27:FindFirstChild("CharacterArmor")
    if v29 then
        for _, v30 in v29:GetChildren() do
            v30:Destroy()
        end
    end
    for _, v31 in p27:QueryDescendants("Weld, WeldConstraint, Motor6D") do
        local v32 = v31.Parent
        if v29 and (v32 and v32:IsDescendantOf(v29)) then
            v31:Destroy()
        else
            local v33 = v31.Part0
            local v34 = v31.Part1
            local v35
            if v33 == nil then
                v35 = false
            else
                v35 = v33:HasTag("CharacterAccessory")
            end
            if v35 then
                ::l19::
                v31:Destroy()
            else
                local v36
                if v34 == nil then
                    v36 = false
                else
                    v36 = v34:HasTag("CharacterAccessory")
                end
                if v36 then
                    goto l19
                end
            end
        end
    end
    for _, v37 in p27:QueryDescendants("Decal, SurfaceAppearance, BasePart") do
        if not v37:IsA("BasePart") or v37:HasTag("CharacterAccessory") then
            v37:Destroy()
        end
    end
end
local function v_u_43(p39, p40)
    local v41 = {}
    while p40 and p40 ~= p39 do
        local v42 = p40.Name
        table.insert(v41, 1, v42)
        p40 = p40.Parent
    end
    if p40 == p39 then
        return v41
    else
        return nil
    end
end
local function v_u_57(p44, p45)
    -- upvalues: (copy) v_u_43
    local v46 = p44:FindFirstChild("CharacterArmor")
    local v47 = p45:FindFirstChild("CharacterArmor")
    local v48 = {}
    if not (v46 and v47) then
        return v48
    end
    for _, v49 in v47:GetChildren() do
        v49:Destroy()
    end
    for _, v50 in v46:GetChildren() do
        local v51 = v50:Clone()
        for _, v52 in v51:QueryDescendants("BasePart, Weld, WeldConstraint") do
            if v52:IsA("BasePart") then
                v52.Massless = true
            else
                v52:Destroy()
            end
        end
        if v51:IsA("BasePart") and (v50:IsA("BasePart") and v50:HasTag("CharacterAccessory")) then
            v48[v50] = v51
        end
        for _, v53 in v50:QueryDescendants("BasePart") do
            if v53:HasTag("CharacterAccessory") then
                local v54 = v_u_43(v50, v53)
                if v54 then
                    local v55 = v51
                    for _, v56 in v54 do
                        v51 = v51:FindFirstChild(v56)
                        if not v51 then
                            v51 = nil
                            break
                        end
                    end
                    if v51 and v51:IsA("BasePart") then
                        v48[v53] = v51
                        v51 = v55
                    else
                        v51 = v55
                    end
                end
            end
        end
        v51.Parent = v47
    end
    return v48
end
local function v_u_63(p58, p59)
    for _, v60 in p58:GetChildren() do
        if v60:IsA("BasePart") then
            local v61 = p59:FindFirstChild(v60.Name)
            if v61 and v61:IsA("BasePart") then
                v61.Color = v60.Color
                for _, v62 in v60:GetChildren() do
                    if v62:IsA("Decal") or v62:IsA("SurfaceAppearance") then
                        v62:Clone().Parent = v61
                    end
                end
            end
        end
    end
end
local function v_u_67(p64, p65)
    -- upvalues: (copy) v_u_16
    for _, v66 in p64:GetChildren() do
        if v_u_16[v66.ClassName] then
            v66:Clone().Parent = p65
        end
    end
end
local function v_u_90(p68, p69, p70)
    -- upvalues: (copy) v_u_43
    local function v77(p71, p72, p73)
        if p71:IsA("Weld") then
            local v74 = Instance.new("Weld")
            v74.Name = p71.Name
            v74.C0 = p71.C0
            v74.C1 = p71.C1
            v74.Part0 = p72
            v74.Part1 = p73
            v74.Parent = p72
            return
        elseif p71:IsA("WeldConstraint") then
            local v75 = Instance.new("WeldConstraint")
            v75.Name = p71.Name
            v75.Part0 = p72
            v75.Part1 = p73
            v75.Parent = p72
        elseif p71:IsA("Motor6D") then
            local v76 = p73:FindFirstChild(p71.Name)
            if not (v76 and (v76:IsA("Motor6D") and v76)) then
                v76 = Instance.new("Motor6D")
            end
            v76.Name = p71.Name
            v76.C0 = p71.C0
            v76.C1 = p71.C1
            v76.Part0 = p72
            v76.Part1 = p73
            v76.Parent = p73
        end
    end
    for _, v78 in p68:QueryDescendants("Weld, WeldConstraint, Motor6D") do
        local v79 = v78.Part0
        local v80 = v78.Part1
        local v81
        if v79 == nil then
            v81 = false
        else
            v81 = v79:HasTag("CharacterAccessory")
        end
        if v81 then
            ::l6::
            local v82, v83
            if v79 then
                v82 = p70[v79]
                if v82 then
                    v83 = p69
                else
                    local v84 = v_u_43(p68, v79)
                    if v84 then
                        v83 = p69
                        for _, v85 in v84 do
                            p69 = p69:FindFirstChild(v85)
                            if not p69 then
                                p69 = nil
                                break
                            end
                        end
                        if p69 and p69:IsA("BasePart") then
                            v82 = p69
                        else
                            v82 = nil
                        end
                    else
                        v83 = p69
                        v82 = nil
                    end
                end
            else
                v83 = p69
                v82 = nil
            end
            if v80 then
                local v86 = p70[v80]
                if v86 then
                    p69 = v83
                    v83 = v86
                else
                    local v87 = v_u_43(p68, v80)
                    if v87 then
                        p69 = v83
                        for _, v88 in v87 do
                            v83 = v83:FindFirstChild(v88)
                            if not v83 then
                                v83 = nil
                                break
                            end
                        end
                        if not (v83 and v83:IsA("BasePart")) then
                            v83 = nil
                        end
                    else
                        p69 = v83
                        v83 = nil
                    end
                end
            else
                p69 = v83
                v83 = nil
            end
            if v82 and v83 then
                v77(v78, v82, v83)
            end
        else
            local v89
            if v80 == nil then
                v89 = false
            else
                v89 = v80:HasTag("CharacterAccessory")
            end
            if v89 then
                goto l6
            end
        end
    end
end
function v_u_1.CreateJoint(_, p91)
    -- upvalues: (copy) v_u_11, (copy) v_u_9
    local v92 = p91.Part0
    local v93 = p91.Part1
    if v92 and (v93 and not (v92:HasTag("CharacterAccessory") or v93:HasTag("CharacterAccessory"))) then
        local v94 = v93.Name
        local v95 = v_u_11[v94] or v_u_11.Default
        local v96 = v95.ConstraintType == "Hinge"
        local v97 = Instance.new("Attachment")
        v97.CFrame = p91.C0
        v97.Parent = v92
        local v98 = Instance.new("Attachment")
        v98.CFrame = p91.C1
        v98.Parent = v93
        if v96 then
            local v99 = Instance.new("HingeConstraint")
            v99.Attachment0 = v97
            v99.Attachment1 = v98
            v99.LimitsEnabled = v95.LimitsEnabled
            v99.LowerAngle = v95.LowerAngle
            v99.UpperAngle = v95.UpperAngle
            v99.Restitution = v95.Restitution
            v99.Parent = v92
        else
            local v100 = Instance.new("BallSocketConstraint")
            v100.Attachment0 = v97
            v100.Attachment1 = v98
            v100.MaxFrictionTorque = v_u_9[v94] or 50
            v100.TwistLimitsEnabled = v95.TwistLimitsEnabled
            v100.TwistLowerAngle = v95.TwistLowerAngle
            v100.TwistUpperAngle = v95.TwistUpperAngle
            v100.LimitsEnabled = v95.LimitsEnabled
            v100.Restitution = v95.Restitution
            v100.UpperAngle = v95.UpperAngle
            v100.Parent = v92
        end
        local v101 = Instance.new("NoCollisionConstraint")
        v101.Part0 = v92
        v101.Part1 = v93
        v101.Parent = v92
        p91:Destroy()
    end
end
function v_u_1.Impulse(p_u_102, p103)
    -- upvalues: (copy) v_u_4, (copy) v_u_10, (copy) v_u_3
    local v104 = p_u_102.CharacterModel:FindFirstChild(p103.Part)
    if v104 then
        local v105 = v_u_4(p103.Weapon)
        if v105 then
            local v106 = (v105.RagdollMultiplier or 45) * p103.DirectionMultiplier
            if v_u_10[p103.Part] then
                local v107 = v_u_10[p103.Part]
                v106 = v106 * (math.random(v107.Minimum, v107.Maximum) / 100)
            end
            local v108 = p103.Direction.Unit
            local v109 = 2.5 + (p103.Part == "Head" and 1 or 0)
            v104.AssemblyLinearVelocity = (v108 * v106 + Vector3.new(-0, -5, -0)) * v109
            p_u_102.Janitor:Add(task.delay(5, function()
                -- upvalues: (copy) p_u_102, (ref) v_u_3
                local v_u_110 = p_u_102.CharacterModel
                if v_u_110 and (v_u_110.PrimaryPart and v_u_110.Parent) then
                    local v_u_111 = v_u_110:QueryDescendants("BasePart:not(.CharacterAccessory)")
                    if v_u_111 and #v_u_111 ~= 0 then
                        local v_u_112 = 0
                        local v_u_113 = 0
                        p_u_102.Janitor:Add(v_u_3.Heartbeat:Connect(function(p114)
                            -- upvalues: (copy) v_u_110, (ref) p_u_102, (ref) v_u_113, (copy) v_u_111, (ref) v_u_112
                            if v_u_110 and (v_u_110.PrimaryPart and v_u_110.Parent) then
                                v_u_113 = v_u_113 + p114
                                local v115 = 0
                                local v116 = true
                                for _, v117 in v_u_111 do
                                    if v117 and v117.Parent then
                                        v115 = v115 + 1
                                        if not v117.Anchored then
                                            local v118
                                            if v117.AssemblyLinearVelocity.Magnitude < 0.13 then
                                                v118 = v117.AssemblyAngularVelocity.Magnitude < 0.13
                                            else
                                                v118 = false
                                            end
                                            if not v118 then
                                                v116 = false
                                            end
                                        end
                                    end
                                end
                                if v115 == 0 then
                                    p_u_102.Janitor:Remove("WaitForSettle")
                                    return
                                else
                                    if v116 then
                                        v_u_112 = v_u_112 + p114
                                    else
                                        v_u_112 = 0
                                    end
                                    if v_u_112 >= 0.2 or v_u_113 >= 2.5 then
                                        for _, v119 in v_u_111 do
                                            if v119 and v119.Parent then
                                                v119.Anchored = true
                                            end
                                        end
                                        p_u_102.Janitor:Remove("WaitForSettle")
                                    end
                                end
                            else
                                p_u_102.Janitor:Remove("WaitForSettle")
                                return
                            end
                        end), "Disconnect", "WaitForSettle")
                    end
                else
                    return
                end
            end))
        end
    else
        return
    end
end
function v_u_1.CloneCharacterModel(p120, p121)
    -- upvalues: (ref) v_u_13, (copy) v_u_21, (copy) v_u_38, (copy) v_u_57, (copy) v_u_63, (copy) v_u_67, (copy) v_u_90, (copy) v_u_12
    if not v_u_13 then
        local v122 = p121:Clone()
        v122.Name = "RagdollTemplate"
        v_u_21(v122)
        v_u_38(v122)
        p120:SetupCharacterParts(v122)
        v_u_13 = v122
    end
    local v123 = v_u_13:Clone()
    v123.Name = p121.Name
    local v124 = v123:FindFirstChild("UpperTorso")
    local v125 = p121:FindFirstChild("UpperTorso")
    if v124 and v125 then
        v124.AssemblyLinearVelocity = v125.AssemblyLinearVelocity
    end
    local v126 = v_u_57(p121, v123)
    v_u_63(p121, v123)
    v_u_67(p121, v123)
    v_u_90(p121, v123, v126)
    v_u_21(p121)
    v123:PivotTo(p121:GetPivot())
    v123.Parent = v_u_12
    v123:AddTag("Ragdoll")
    if p121.Parent then
        p121:Destroy()
    end
    return v123
end
function v_u_1.SetupCharacterAppearance(p_u_127)
    -- upvalues: (copy) v_u_2, (copy) v_u_26
    local v128 = v_u_2.Assets.Other.Ragdoll.Humanoid:Clone()
    v128.Parent = p_u_127.CharacterModel
    v128.PlatformStand = true
    v128.Sit = true
    for _, v_u_129 in p_u_127.CharacterModel:GetChildren() do
        if v_u_129:IsA("Accessory") or (v_u_129:IsA("Clothing") or v_u_129:IsA("ShirtGraphic")) then
            v_u_129.Parent = nil
            task.defer(function()
                -- upvalues: (copy) v_u_129, (copy) p_u_127
                v_u_129.Parent = p_u_127.CharacterModel
            end)
        end
    end
    task.defer(function()
        -- upvalues: (copy) p_u_127, (ref) v_u_26
        if p_u_127.CharacterModel and p_u_127.CharacterModel.Parent then
            v_u_26(p_u_127.CharacterModel)
        end
    end)
end
function v_u_1.SetupCharacterParts(p130, p131)
    -- upvalues: (copy) v_u_14, (copy) v_u_15, (copy) v_u_23
    for _, v132 in (p131 or p130.CharacterModel):GetDescendants() do
        if v_u_14[v132.ClassName] or v_u_15[v132.Name] then
            v132:Destroy()
        elseif v132:IsA("BasePart") then
            v_u_23(v132)
        elseif v132:IsA("Motor6D") then
            local v133 = p130.Motor6Ds
            table.insert(v133, v132)
        elseif v132:IsA("Decal") then
            v132.Transparency = 0
        end
    end
    for _, v134 in p130.Motor6Ds do
        p130:CreateJoint(v134)
    end
    table.clear(p130.Motor6Ds)
end
function v_u_1.new(p135, p_u_136)
    -- upvalues: (copy) v_u_1, (copy) v_u_6, (copy) v_u_7, (copy) v_u_5
    local v137 = v_u_1
    local v_u_138 = setmetatable({}, v137)
    v_u_138.Janitor = v_u_6.new()
    v_u_138.Motor6Ds = {}
    v_u_138.CharacterModel = v_u_138.Janitor:Add(v_u_138:CloneCharacterModel(p135))
    v_u_138.OnDestroy = v_u_138.Janitor:Add(v_u_7.new())
    v_u_138.IsDestroyed = false
    task.defer(function()
        -- upvalues: (ref) v_u_5, (copy) v_u_138, (copy) p_u_136
        local v139
        if v_u_5.GetState() == "Warmup" then
            v139 = workspace:GetAttribute("Gamemode") == "Deathmatch"
        else
            v139 = false
        end
        v_u_138:SetupCharacterAppearance()
        v_u_138:Impulse(p_u_136)
        task.delay(v139 and 10 or 15, function()
            -- upvalues: (ref) v_u_138
            v_u_138:Destroy()
        end)
    end)
    return v_u_138
end
function v_u_1.Destroy(p140)
    if not p140.IsDestroyed then
        p140.IsDestroyed = true
        p140.OnDestroy:Fire()
        task.defer(p140.Janitor.Destroy, p140.Janitor)
    end
end
return v_u_1
