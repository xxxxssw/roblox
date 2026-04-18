-- MODULESCRIPT: Character
-- Original Path: game.BAC - 19589.Classes.Character
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("CollectionService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("Workspace")
local v7 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_8 = v7.LocalPlayer
local v_u_9 = workspace:WaitForChild("Debris")
local v_u_10 = v_u_6.CurrentCamera
local v_u_11 = v3:WaitForChild("Assets"):WaitForChild("CharacterAnimations")
local v_u_12 = require(script.Components.GetMovementAnimation)
local v_u_13 = require(script.Classes.CharacterAnimator)
local v_u_14 = require(v3.Controllers.InventoryController)
local v_u_15 = require(v3.Database.Components.GameState)
local v_u_16 = require(v3.Database.Security.Remotes)
local v_u_17 = require(v3.Shared.Janitor)
local v_u_18 = require(v3.Packages.Signal)
local v_u_19 = require(v_u_8:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()
local v_u_20 = RaycastParams.new()
v_u_20.FilterType = Enum.RaycastFilterType.Exclude
v_u_20.RespectCanCollide = true
local v_u_21 = RaycastParams.new()
v_u_21.FilterType = Enum.RaycastFilterType.Exclude
v_u_21.RespectCanCollide = true
local v_u_22 = {
    Vector3.new(0, 0, 0),
    Vector3.new(0.8, 0, 0),
    Vector3.new(-0.8, 0, 0),
    Vector3.new(0, 0, 0.8),
    Vector3.new(0, 0, -0.8)
}
local v_u_23 = { v_u_9, v_u_9, v_u_9 }
local v_u_24 = { v_u_9, v_u_9, v_u_9 }
if not v_u_8:GetAttribute("DefaultCameraOffset") then
    v_u_8:SetAttribute("DefaultCameraOffset", Vector3.new(0, -0.15, 0))
end
if not v_u_8:GetAttribute("CrouchCameraOffset") then
    v_u_8:SetAttribute("CrouchCameraOffset", Vector3.new(0, -1.4, 0))
end
local v_u_25 = {
    ["SSG 08"] = 13.6,
    ["SG 553"] = 12,
    ["AWP"] = 8,
    ["AUG"] = 12,
    ["SCAR-20"] = 8,
    ["G3SG1"] = 8
}
local function v_u_31()
    -- upvalues: (copy) v_u_11
    local v26 = v_u_11:FindFirstChild("Crouch")
    local v27 = v_u_11:FindFirstChild("Movement")
    if v27 then
        v27 = v27:FindFirstChild("Walking")
    end
    if not (v26 and v27) then
        return nil
    end
    local v28 = {
        ["CharacterIdle"] = true
    }
    for _, v29 in ipairs(v26:GetDescendants()) do
        if v29:IsA("Animation") then
            v28[v29.Name] = true
        end
    end
    for _, v30 in ipairs(v27:GetDescendants()) do
        if v30:IsA("Animation") then
            v28[v30.Name] = true
        end
    end
    return v28
end
local v_u_32 = nil
local v_u_33 = {
    ["CharacterIdle"] = true
}
local function v_u_48(p34, p35, p36)
    local v37 = p34:Dot(p35) * p36
    if v37 >= 0 then
        return p34
    end
    local v38 = p34 - p35 * v37
    local v39 = v38.X
    if math.abs(v39) < 0.1 then
        local v40 = v38.Y
        local v41 = v38.Z
        v38 = Vector3.new(0, v40, v41)
    end
    local v42 = v38.Y
    if math.abs(v42) < 0.1 then
        local v43 = v38.X
        local v44 = v38.Z
        v38 = Vector3.new(v43, 0, v44)
    end
    local v45 = v38.Z
    if math.abs(v45) < 0.1 then
        local v46 = v38.X
        local v47 = v38.Y
        v38 = Vector3.new(v46, v47, 0)
    end
    return v38
end
local function v_u_50(p49)
    p49.PlatformStand = false
    p49.Sit = false
    p49.Jump = false
    p49:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
    p49:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
    p49:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    p49:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
    p49:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    p49:ChangeState(Enum.HumanoidStateType.Running)
end
function v_u_1.GetMaxSpeed(p51)
    -- upvalues: (copy) v_u_15, (copy) v_u_8, (copy) v_u_14, (copy) v_u_25
    if v_u_15.GetState() == "Buy Period" then
        return 0
    elseif v_u_8:GetAttribute("IsDefusingBomb") then
        return 0
    elseif v_u_8:GetAttribute("IsRescuingHostage") then
        return 0
    else
        local v52 = v_u_8:GetAttribute("IsCarryingHostage") and 0.75 or 1
        local v53 = v_u_14.getCurrentEquipped()
        if v53 and (v53.Properties.Class == "C4" and v53.IsPlanting) then
            return 0
        else
            local v54 = 20
            if v53 and v53.Properties then
                if v53.CurrentWalkSpeedOverride then
                    v54 = v53.CurrentWalkSpeedOverride
                elseif v53.Properties.WalkSpeed then
                    v54 = v53.Properties.WalkSpeed
                end
            end
            local v55 = v53 and (v53.IsAiming and v_u_25[v53.Name])
            if v55 then
                local v56 = p51.IsClimbing and 0.5 or 1
                local v57 = p51.IsWalking and 0.52 or 1
                local v58 = p51.IsCrouching and not p51.IsJumping and 0.34 or 1
                return v55 * v57 * v56 * v58
            else
                local v59 = p51.IsCrouching and not p51.IsJumping and 0.34 or (p51.IsWalking and 0.52 or 1)
                local v60 = p51.IsClimbing and 0.5 or 1
                if p51.CanceledInertia then
                    v54 = 2.424
                elseif p51.IsJumping and not (p51.IsAirStrafing or p51.CanceledInertia) then
                    local v61 = p51.LocalVelocityOnJump.Magnitude
                    v54 = math.max(v61, 2.424)
                end
                return v54 * v59 * v60 * v52 * (tick() < p51.ShotSlowUntil and p51.ShotSlowMultiplier or 1)
            end
        end
    end
end
function v_u_1.ValidateHumanoidRootPart(p62)
    local v63 = p62.HumanoidRootPart
    if v63 and (v63.Parent and v63:IsDescendantOf(workspace)) then
        return v63
    else
        return nil
    end
end
function v_u_1.TakeStamina(p64, p65)
    local v66 = p64.Stamina - p65
    p64.Stamina = math.clamp(v66, 0, 100)
end
function v_u_1.ApplyFriction(p67, p68)
    if p67.IsJumping then
        return
    else
        local v69 = p67.GlobalVelocity.Magnitude
        if v69 >= 0.001 then
            local v70
            if p67.GlobalDirection.Magnitude < 0.1 then
                v70 = math.max(v69, 5)
            else
                v70 = v69
            end
            local v71 = v69 - v70 * 6 * p68
            local v72 = math.max(v71, 0)
            if v72 ~= v69 then
                if v72 == 0 then
                    p67.GlobalVelocity = Vector3.new(0, 0, 0)
                    return
                end
                p67.GlobalVelocity = p67.GlobalVelocity.Unit * v72
            end
        end
    end
end
function v_u_1.Accelerate(p73, p74, p75, p76, p77)
    local v78 = p75 - p73.GlobalVelocity:Dot(p74)
    if v78 > 0 then
        local v79 = p76 * p77 * p75
        local v80 = math.min(v79, v78)
        p73.GlobalVelocity = p73.GlobalVelocity + p74 * v80
    end
end
function v_u_1.AirAccelerate(p81, p82, p83, p84)
    local v85 = math.min(p83, 2.5)
    local v86 = v85 - p81.GlobalVelocity:Dot(p82)
    if v86 > 0 then
        local v87 = v85 * 100 * p84
        if v86 >= v87 then
            v86 = v87
        end
        p81.GlobalVelocity = p81.GlobalVelocity + p82 * v86
    end
end
function v_u_1.CheckGroundContact(p88)
    -- upvalues: (copy) v_u_6, (copy) v_u_24, (copy) v_u_9, (copy) v_u_21, (copy) v_u_22
    if not p88.HumanoidRootPart then
        return false, nil, nil
    end
    local v89 = v_u_6.CurrentCamera
    v_u_24[1] = p88.Character
    v_u_24[2] = v89 or v_u_9
    v_u_21.FilterDescendantsInstances = v_u_24
    local v90 = p88.Player:GetAttribute("Team")
    if v90 and workspace:GetAttribute("VIPPlayerCollisionsEnabled") ~= true then
        v_u_21.CollisionGroup = v90
    else
        v_u_21.CollisionGroup = "Default"
    end
    local v91 = p88.HumanoidRootPart.Position
    for _, v92 in ipairs(v_u_22) do
        local v93 = v91 + v92
        local v94 = workspace:Raycast(v93, Vector3.new(0, -3.1, 0), v_u_21)
        if v94 and (v94.Normal.Y > 0.7 and v94.Instance.CanCollide) then
            return true, v94.Instance, v94.Normal
        end
    end
    return false, nil, nil
end
function v_u_1.SetTargetMoveDirection(p95, p96)
    if not p96:FuzzyEq(p95.TargetMoveDirection, 0.001) then
        p95.TargetMoveDirection = p96
        p95.MoveDirectionChanged:Fire(p96)
    end
end
function v_u_1.Jump(p97)
    -- upvalues: (copy) v_u_15, (copy) v_u_8, (copy) v_u_14
    if v_u_15.GetState() == "Buy Period" then
        return
    elseif v_u_8:GetAttribute("IsDefusingBomb") then
        return
    else
        local v98 = v_u_14.getCurrentEquipped()
        if v98 and (v98.Properties.Class == "C4" and v98.IsPlanting) then
            return
        elseif p97.Character and (p97.Humanoid and p97.HumanoidRootPart) then
            local v99 = tick() - p97.LastJumpTick
            local v100 = tick() - p97.LastLandTick <= 0.5
            if v99 < 0.15 and (p97.LastJumpTick > 0 and (not v100 or (p97.LastAirTime or 0) < 0.15)) then
                p97.IsJumpRequested = false
                return
            else
                if not p97.IsClimbing then
                    local v101 = p97.Humanoid:GetState()
                    if v101 == Enum.HumanoidStateType.Freefall or v101 == Enum.HumanoidStateType.Jumping then
                        p97.IsJumpRequested = false
                        return
                    end
                end
                local v102 = p97.HumanoidRootPart
                if p97.IsClimbing and (p97.IsJumpRequested and not p97.JumpedOffLadder) then
                    local v103 = tick()
                    p97.LastJumpTick = v103
                    p97.LastFreefallTick = v103
                    p97.PeakFallVelocity = 0
                    p97.LandingVelocityY = nil
                    p97.LastLadderJumpTick = tick()
                    p97.JumpedOffLadder = true
                    local v104 = Vector3.new(0, 0, 1)
                    local v105 = p97.LadderZone
                    if v105 then
                        local v106 = p97:GetLadderCFrame(v105)
                        if v106 then
                            local v107 = v102.Position
                            local v108 = v106.Position
                            local v109 = v108.X - v107.X
                            local v110 = v108.Z - v107.Z
                            local v111 = Vector3.new(v109, 0, v110)
                            if v111.Magnitude > 0.1 then
                                v104 = -v111.Unit
                            end
                        end
                    end
                    local v112 = p97.LadderClimbPercentage or 0.5
                    local v113 = -1 - v112 * 2
                    local v114 = v104.X * 12
                    local v115 = v104.Z * 12
                    local v116 = Vector3.new(v114, v113, v115)
                    print("[Ladder Debug] Jumping off ladder", "climb%:", string.format("%.2f", v112), "jumpVel:", v116)
                    p97.ClimbEnded:Fire(p97.LadderZone, true)
                    local v117
                    if v116 == v116 then
                        v117 = v116.Magnitude < 10000
                    else
                        v117 = false
                    end
                    if v117 then
                        v102.AssemblyLinearVelocity = v116
                        local v118 = v116.X
                        local v119 = v116.Z
                        p97.GlobalVelocity = Vector3.new(v118, 0, v119)
                    end
                    p97.ReadyToJump = false
                    p97.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
                elseif not p97.IsClimbing and (not p97.IsJumping and (p97.IsJumpRequested and p97.Stamina >= 20)) then
                    p97.Humanoid.JumpPower = 19.5
                    if p97.AgainstWall then
                        p97.GlobalVelocity = Vector3.new(0, 0, 0)
                    end
                    local v120 = p97.HumanoidRootPart.AssemblyLinearVelocity.X
                    local v121 = p97.HumanoidRootPart.AssemblyLinearVelocity.Z
                    local v122 = Vector3.new(v120, 0, v121)
                    local v123 = p97.Humanoid.MoveDirection
                    if v122.Magnitude < 1 and v123.Magnitude > 0.1 then
                        local v124 = RaycastParams.new()
                        v124.FilterType = Enum.RaycastFilterType.Exclude
                        v124.FilterDescendantsInstances = { p97.Character }
                        local v125 = workspace:Raycast(p97.HumanoidRootPart.Position, v123 * 2, v124)
                        if v125 then
                            local v126 = v125.Normal.Y
                            if math.abs(v126) < 0.5 then
                                local v127 = v125.Normal.X
                                local v128 = v125.Normal.Z
                                local v129 = Vector3.new(v127, 0, v128).Unit * 400
                                local v130 = p97.HumanoidRootPart
                                local v131 = v129.X
                                local v132 = p97.HumanoidRootPart.AssemblyLinearVelocity.Y
                                local v133 = v129.Z
                                v130:ApplyImpulse((Vector3.new(v131, v132, v133)))
                            end
                        end
                    end
                    if p97.HumanoidRootPart.AssemblyLinearVelocity.Y > 5 then
                        local v134 = p97.HumanoidRootPart.AssemblyLinearVelocity
                        local v135 = p97.HumanoidRootPart
                        local v136 = v134.X
                        local v137 = v134.Z
                        v135.AssemblyLinearVelocity = Vector3.new(v136, 0, v137)
                    end
                    p97.Humanoid.Jump = true
                    p97.IsJumping = true
                    p97.LastJumpTick = tick()
                    p97.ReadyToJump = false
                    p97.IsJumpRequested = false
                    p97.Jumping:Fire()
                    p97.CharacterAnimator:play("Jump", 0.2)
                end
            end
        else
            return
        end
    end
end
function v_u_1.AddLadder(p138, p139)
    if not p138.LadderZones[p139] then
        p139.Anchored = true
        p139.CollisionGroup = "Debris"
        p139.CastShadow = false
        p139.CanCollide = false
        p139.CanTouch = false
        p139.Transparency = 1
        p138.LadderZones[p139] = {
            ["CFrame"] = p139.CFrame,
            ["Extents"] = p139.Size / 2,
            ["Part"] = p139
        }
    end
end
function v_u_1.RemoveLadder(p140, p141)
    p140.LadderZones[p141] = nil
end
function v_u_1.GetLadderCFrame(_, p142)
    if p142.Part and p142.Part.Parent then
        return p142.Part.CFrame
    else
        return nil
    end
end
function v_u_1.ForceExitLadder(p143, p144)
    if p143.IsClimbing then
        print("[Ladder Debug] ForceExitLadder reason:", p144 or "unknown")
        p143.VectorForce.Enabled = false
        p143.IsClimbing = false
        p143.LadderZone = nil
        p143.LadderClimbPercentage = 0
        p143.LastLadderJumpTick = tick()
        if p143.Humanoid then
            p143.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
        end
        p143.Climbing:Fire()
    end
end
function v_u_1.GetLadderClimbPercentage(p145, p146)
    local v147 = p145:ValidateHumanoidRootPart()
    if not v147 then
        return 0
    end
    local v148 = p145:GetLadderCFrame(p146)
    if not v148 then
        return 0
    end
    local v149 = p146.Extents.Y * 2
    if v149 <= 0 then
        warn("[Character] Invalid ladder height:", v149)
        return 0.5
    end
    local v150 = v148.Position
    local v151 = p146.Extents.Y
    local v152 = v150 - Vector3.new(0, v151, 0)
    local v153 = v147.Position
    if v153 ~= v153 or v152 ~= v152 then
        warn("[Character] Invalid positions in climb calculation")
        return 0.5
    end
    local v154 = (v153.Y - v152.Y) / v149
    local v155 = math.clamp(v154, 0, 1)
    return v155 ~= v155 and 0.5 or v155
end
function v_u_1.CheckLadderOverlap(p156, p157)
    local v158 = p156:ValidateHumanoidRootPart()
    if v158 then
        local v159 = p156:GetLadderCFrame(p157)
        if v159 then
            local v160 = v158.Position
            local v161 = p157.Extents
            local v162 = v159:Inverse() * v160
            local v163 = v162.X
            local v164 = math.abs(v163)
            local v165 = v162.Z
            local v166 = math.abs(v165)
            local v167 = v162.Y >= v161.Y - 1
            local v168 = p156.Character:FindFirstChildOfClass("Humanoid")
            if v168 then
                v168 = v168.FloorMaterial ~= Enum.Material.Air
            end
            if v167 and v168 then
                return false
            else
                local v169
                if v161.X > v161.Z then
                    if v161.Z * 0.5 <= v166 then
                        v169 = v166 <= v161.Z + 2
                    else
                        v169 = false
                    end
                elseif v161.X * 0.5 <= v164 then
                    v169 = v164 <= v161.X + 2
                else
                    v169 = false
                end
                if v162.Y <= v161.Y + 0.8 + (v169 and 3 or 0.5) and v162.Y >= -(v161.Y + 0.8 + 3) then
                    if v161.X > v161.Z then
                        if v161.X + 0.8 < v164 then
                            return false
                        elseif v161.X < v164 and v166 < v161.Z * 2 then
                            return false
                        else
                            return v166 <= v161.Z + 2
                        end
                    elseif v161.Z + 0.8 < v166 then
                        return false
                    elseif v161.Z < v166 and v164 < v161.X * 2 then
                        return false
                    else
                        return v164 <= v161.X + 2
                    end
                else
                    return false
                end
            end
        else
            return false
        end
    else
        return false
    end
end
function v_u_1.FindNearestLadder(p170)
    local v171 = p170:ValidateHumanoidRootPart()
    if not v171 then
        return nil
    end
    local v172 = v171.Position
    local v173 = 0
    local v174 = (1 / 0)
    local v175 = nil
    for _, v176 in pairs(p170.LadderZones) do
        v173 = v173 + 1
        local v177 = p170:GetLadderCFrame(v176)
        if v177 then
            local v178 = v172.X - v177.Position.X
            local v179 = v172.Z - v177.Position.Z
            local v180 = Vector3.new(v178, 0, v179).Magnitude
            if v180 <= 2 and (p170:CheckLadderOverlap(v176) and v180 < v174) then
                v175 = v176
                v174 = v180
            end
        end
    end
    local _ = v173 == 0
    return v175
end
function v_u_1.ResolveGroundedFreefall(p181, p182, p183)
    local v184 = p182 or p181:ValidateHumanoidRootPart()
    if not v184 then
        return false
    end
    if p181.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
        return false
    end
    if p183 == nil then
        p183 = p181:CheckGroundContact()
    end
    if not p183 then
        return false
    end
    if v184.AssemblyLinearVelocity.Y > 1 then
        return false
    end
    local v185 = v184.AssemblyLinearVelocity
    local v186 = v185.X
    local v187 = v185.Z
    local v188 = Vector3.new(v186, 0, v187)
    local v189
    if v188 == v188 then
        v189 = v188.Magnitude < 10000
    else
        v189 = false
    end
    if v189 then
        v184.AssemblyLinearVelocity = v188
    end
    p181.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
    p181.IsJumping = false
    p181.IsLanded = true
    p181.ReadyToJump = true
    p181.LockedAirDirection = nil
    return true
end
function v_u_1.MoveFunction(p190, p191, p192)
    -- upvalues: (copy) v_u_10, (copy) v_u_6, (copy) v_u_23, (copy) v_u_9, (copy) v_u_20, (copy) v_u_48, (copy) v_u_19
    local v193 = p190:ValidateHumanoidRootPart()
    if not v193 then
        if p190.IsClimbing then
            p190:ForceExitLadder("Invalid HumanoidRootPart at MoveFunction start")
        end
        return
    end
    local v194 = tick()
    local v195 = v194 - p190.LastMoveUpdate
    local v196, _, _ = p190:CheckGroundContact()
    p190:ResolveGroundedFreefall(v193, v196)
    local v197 = p190:GetMaxSpeed()
    p190.MaxSpeed = v197
    if v197 <= 0 then
        p190.GlobalDirection = Vector3.new(0, 0, 0)
        p190.LocalVelocity = Vector3.new(0, 0, 0)
        p190.GlobalVelocity = Vector3.new(0, 0, 0)
        local v198 = v193.AssemblyLinearVelocity.Y
        v193.AssemblyLinearVelocity = Vector3.new(0, v198, 0)
        v193.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        p190.Humanoid.WalkSpeed = 0
        p190.LastMoveUpdate = v194
        return
    end
    p190.GlobalDirection = Vector3.new(0, 0, 0)
    local v199 = Vector3.new(0, 0, 0)
    local v200 = tick() - p190.LastJumpTick
    if p190.IsJumping and (v196 and v200 >= 0.15) then
        local v201 = v193.AssemblyLinearVelocity.Y
        if v201 <= 1 then
            p190.LastAirTime = tick() - (p190.LastFreefallTick or p190.LastJumpTick)
            p190.LandingVelocityY = p190.PeakFallVelocity or v201
            p190.IsJumping = false
            p190.IsLanded = true
            p190.LandAtPosition = v193.CFrame.Position
            p190.LastLandTick = tick()
            p190.ReadyToJump = true
            p190.LockedAirDirection = nil
            p190.CharacterAnimator:stop("Jump", 0.2)
            p190.Landed:Fire()
        end
    end
    local v202 = p190.Humanoid:GetState()
    if v202 == Enum.HumanoidStateType.Freefall and true or v202 == Enum.HumanoidStateType.Jumping then
        if not p190.LastFreefallTick then
            p190.LastFreefallTick = tick()
            p190.PeakFallVelocity = 0
        end
        local v203 = v193.AssemblyLinearVelocity.Y
        if v203 < (p190.PeakFallVelocity or 0) then
            p190.PeakFallVelocity = v203
        end
    end
    local v204 = v_u_10.CFrame
    local v205 = v204.Position
    local v206, v207, v208 = v204:ToEulerAnglesXYZ()
    local v209 = CFrame.new(v205) * CFrame.fromEulerAnglesXYZ(v206, v207, v208)
    if p191.Magnitude > 0 then
        if p192 then
            p190.GlobalDirection = v209:VectorToWorldSpace(p191)
        else
            p190.GlobalDirection = p191
            p191 = v209:VectorToObjectSpace(p191)
        end
    else
        p191 = v199
    end
    local v210 = v209.LookVector.X
    local v211 = v209.LookVector.Z
    local v212 = Vector3.new(v210, 0, v211)
    local v213 = p190.LastCameraCFrame.LookVector.X
    local v214 = p190.LastCameraCFrame.LookVector.Z
    local v215 = Vector3.new(v213, 0, v214):Cross(v212).Y
    p190.LocalVelocity = v209:VectorToObjectSpace(p190.GlobalVelocity)
    local v216 = p190.LocalVelocity:Angle(p191, Vector3.new(0, 1, 0))
    local _ = v216 == v216
    v212.Unit:Angle(p190.GlobalDirection, Vector3.new(0, 1, 0))
    local v217 = p190.GlobalDirection:Angle(p190.GlobalVelocity, Vector3.new(0, 1, 0))
    math.abs(v217)
    local v218 = p191.X
    local v219 = math.abs(v218) > 0.1
    local v220 = p191.Z <= 0
    local v221 = math.abs(v215) > 0.02
    local v222 = p191.X
    local v223 = math.sign(v222)
    local v224 = math.sign(v215)
    local v225 = p190.IsJumping
    if v225 then
        if v219 then
            if v220 then
                if v221 then
                    v221 = v223 == -v224
                end
            else
                v221 = v220
            end
        else
            v221 = v219
        end
    else
        v221 = v225
    end
    p190.IsAirStrafing = v221
    local v226
    if p190.GlobalDirection.Magnitude > 0 then
        v226 = p190.GlobalDirection.Unit
    else
        v197 = 0
        v226 = Vector3.new(0, 0, 0)
    end
    if p190.IsJumping then
        local v227 = v193.AssemblyLinearVelocity
        local v228 = v227.X
        local v229 = v227.Z
        p190.GlobalVelocity = Vector3.new(v228, 0, v229)
        if v197 > 0 then
            p190:AirAccelerate(v226, v197, v195)
        end
        if p190.IsAirStrafing then
            local v230 = p190.GlobalVelocity.Magnitude
            if v230 > 0.1 then
                local v231 = v212.X
                local v232 = v212.Z
                local v233 = Vector3.new(v231, 0, v232)
                if v233.Magnitude > 0 then
                    local v234 = v233.Unit
                    local v235 = p190.GlobalVelocity.Unit
                    local v236 = 5 * v195 * 10
                    local v237 = math.min(1, v236)
                    local v238 = v235 + (v234 - v235) * v237
                    if v238.Magnitude > 0 then
                        p190.GlobalVelocity = v238.Unit * v230
                    end
                end
            end
        end
        local v239 = p190.GlobalVelocity.Magnitude
        if v239 > 24.5 then
            local v240 = 24.5 / v239
            p190.GlobalVelocity = p190.GlobalVelocity * v240
        end
        local v241 = p190.GlobalVelocity.X
        local v242 = v227.Y
        local v243 = p190.GlobalVelocity.Z
        local v244 = Vector3.new(v241, v242, v243)
        local v245
        if v244 == v244 then
            v245 = v244.Magnitude < 10000
        else
            v245 = false
        end
        if v245 then
            v193.AssemblyLinearVelocity = v244
        end
    else
        local v246
        if tick() - p190.LastLandTick < 0.5 then
            v246 = p190.IsJumpRequested
        else
            v246 = false
        end
        if not v246 then
            p190:ApplyFriction(v195)
        end
        if v197 > 0 then
            p190:Accelerate(v226, math.min(v197, 24.5), 6, v195)
        end
    end
    local v247 = p190.GlobalVelocity.X
    local v248 = p190.GlobalVelocity.Z
    local v249 = Vector3.new(v247, 0, v248).Magnitude
    local _ = p190.IsJumping or p190.IsBhopAttempt
    local v250 = 24.5
    if v250 < v249 then
        local v251 = v250 / v249
        local v252 = p190.GlobalVelocity.X * v251
        local v253 = p190.GlobalVelocity.Y
        local v254 = p190.GlobalVelocity.Z * v251
        p190.GlobalVelocity = Vector3.new(v252, v253, v254)
    end
    p190.Humanoid.WalkSpeed = p190.LocalVelocity.Magnitude
    local v255 = v_u_6.CurrentCamera
    v_u_23[1] = p190.Character
    v_u_23[2] = v255 or v_u_9
    v_u_20.FilterDescendantsInstances = v_u_23
    local v256 = p190.Player:GetAttribute("Team")
    if v256 and workspace:GetAttribute("VIPPlayerCollisionsEnabled") ~= true then
        v_u_20.CollisionGroup = v256
    else
        v_u_20.CollisionGroup = "Default"
    end
    p190.AgainstWall = false
    p190.WallNormal = nil
    if p190.IsJumping then
        local v257 = v193.AssemblyLinearVelocity
        local v258 = v257.X
        local v259 = v257.Z
        local v260 = Vector3.new(v258, 0, v259)
        local v261 = v260.Magnitude
        local v262 = v193.Position
        local v263 = tick()
        if p190.LastWallNormal and v263 - p190.LastWallHitTime < 0.15 then
            local v264 = p190.LastWallNormal
            local v265 = v264.X
            local v266 = v264.Z
            local v267 = v260:Dot((Vector3.new(v265, 0, v266)))
            if v267 > 0.5 then
                local v268 = v264.X
                local v269 = v264.Z
                v257 = v257 - Vector3.new(v268, 0, v269) * v267
                local v270
                if v257 == v257 then
                    v270 = v257.Magnitude < 10000
                else
                    v270 = false
                end
                if v270 then
                    v193.AssemblyLinearVelocity = v257
                end
                local v271 = v257.X
                local v272 = v257.Z
                v260 = Vector3.new(v271, 0, v272)
                v261 = v260.Magnitude
            end
        end
        local v273 = { Vector3.new(0, 0, 0), v193.CFrame.RightVector * 1 * 0.8, -v193.CFrame.RightVector * 1 * 0.8 }
        local v274 = {}
        if v261 > 0.5 then
            local v275 = v260.Unit
            table.insert(v274, v275)
        end
        local v276 = p190.GlobalDirection.X
        local v277 = p190.GlobalDirection.Z
        local v278 = Vector3.new(v276, 0, v277)
        if v278.Magnitude > 0.1 then
            local v279 = v278.Unit
            table.insert(v274, v279)
        end
        for _, v280 in ipairs(v274) do
            for _, v281 in ipairs(v273) do
                local v282 = v262 + v281
                local v283 = v280 * (0.5 + (v261 > 0.5 and (v261 * 0.02 or 0.3) or 0.3))
                local v284 = workspace:Raycast(v282, v283, v_u_20)
                if v284 then
                    local v285 = v284.Normal
                    local v286 = v285.Y
                    if math.abs(v286) < 0.7 then
                        p190.AgainstWall = true
                        p190.WallNormal = v285
                        p190.LastWallNormal = v285
                        p190.LastWallHitTime = v263
                        local v287 = v_u_48(v257, v285, 1)
                        local v288 = v287.X
                        local v289 = v287.Z
                        local v290 = Vector3.new(v288, 0, v289)
                        if v290.Magnitude < v261 * 0.3 then
                            local v291 = v257.Y
                            v287 = Vector3.new(0, v291, 0)
                            p190.GlobalVelocity = Vector3.new(0, 0, 0)
                        else
                            p190.GlobalVelocity = v290
                        end
                        local v292
                        if v287 == v287 then
                            v292 = v287.Magnitude < 10000
                        else
                            v292 = false
                        end
                        if v292 then
                            v193.AssemblyLinearVelocity = v287
                        end
                        break
                    end
                end
            end
            if p190.AgainstWall then
                break
            end
        end
    end
    if v193 and (p190.IsCrouching and not p190.CrouchInputDown) then
        p190.CrouchHeadBlocked = workspace:Spherecast(v193.CFrame.Position, 1.5, Vector3.new(0, 1, 0), v_u_20) ~= nil
    end
    if v193 then
        if p190.IsClimbing then
            local v293 = p190.LadderZone
            if v293 then
                local v294 = p190:GetLadderCFrame(v293)
                if not v294 then
                    p190:ForceExitLadder("Ladder part removed")
                    return
                end
                local v295 = v193.Position
                local v296 = v295.Y - 2.5
                local v297 = v294.Position
                local v298 = v297.Y - v293.Extents.Y
                local v299 = v297.Y + v293.Extents.Y
                local v300 = v299 - v298
                local v301 = (v296 - v298) / v300
                local v302 = math.clamp(v301, 0, 1)
                p190.LadderClimbPercentage = v302
                local v303 = v295.X - v297.X
                local v304 = v295.Z - v297.Z
                local v305 = Vector3.new(v303, 0, v304).Magnitude
                if v305 > 50 then
                    print("[Ladder Debug] Sanity check failed - distance:", string.format("%.2f", v305))
                    p190:ForceExitLadder("Distance sanity check failed")
                    return
                end
                local v306 = v302 <= 0.15
                local v307 = v302 >= 0.98
                local v308 = v305 > 2.5
                local v309 = p190.GlobalDirection
                local v310 = v309.X
                local v311 = v309.Z
                local v312 = Vector3.new(v310, 0, v311)
                if v312.Magnitude > 0.1 then
                    v312 = v312.Unit
                end
                local v313 = v209.LookVector.X
                local v314 = v209.LookVector.Z
                local v315 = Vector3.new(v313, 0, v314)
                if v315.Magnitude > 0 then
                    v315 = v315.Unit
                end
                local v316 = v312:Dot(v315)
                local v317 = v297.X - v295.X
                local v318 = v297.Z - v295.Z
                local v319 = Vector3.new(v317, 0, v318)
                if v319.Magnitude > 0.1 and v315:Dot(v319.Unit) <= 0 then
                    v316 = -v316
                end
                local v320 = v316 > 0.1
                local v321 = v316 < -0.1
                local v322 = tick() - (p190.LastLadderAttachTick or 0) >= 0.1
                if v308 then
                    v322 = v308
                elseif not (v306 and (v321 and v322)) then
                    if v307 then
                        if not v320 then
                            v322 = v320
                        end
                    else
                        v322 = v307
                    end
                end
                if v299 + 0.5 <= v296 and true or v322 then
                    print("[Ladder Debug] Detaching", "reason:", v308 and "TooFar" or (v306 and v321 and "BottomExit" or (v307 and v320 and "TopExit" or "FeetAboveTop")), "climb%:", string.format("%.2f", v302), "dist:", string.format("%.2f", v305), "verticalInput:", string.format("%.2f", v316))
                    if v307 and v320 then
                        local v323 = v315 * 8
                        local v324 = v323.X
                        local v325 = v323.Z
                        local v326 = Vector3.new(v324, 2, v325)
                        local v327
                        if v326 == v326 then
                            v327 = v326.Magnitude < 10000
                        else
                            v327 = false
                        end
                        if v327 then
                            v193.AssemblyLinearVelocity = v326
                            p190.GlobalVelocity = v323
                        end
                    end
                    p190.ClimbEnded:Fire(v293, false)
                end
            end
        else
            local v328 = tick() - (p190.LastLadderJumpTick or 0) > (p190.JumpedOffLadder and 0.5 or 0.25) and p190:FindNearestLadder()
            if v328 then
                p190.ClimbBegan:Fire(v328)
            end
        end
    end
    local v329 = Vector3.new(0, 0, 0)
    if p190.IsClimbing and not p190.JumpedOffLadder then
        local v330 = p190.LadderZone
        p190.GlobalVelocity = Vector3.new(0, 0, 0)
        if v330 and v193 then
            local v331 = p190.GlobalDirection
            local v332 = v331.X
            local v333 = v331.Z
            local v334 = Vector3.new(v332, 0, v333)
            local v335 = v209.LookVector.X
            local v336 = v209.LookVector.Z
            local v337 = Vector3.new(v335, 0, v336)
            local v338 = v209.RightVector.X
            local v339 = v209.RightVector.Z
            local v340 = Vector3.new(v338, 0, v339)
            if v334.Magnitude > 0.1 then
                v334 = v334.Unit
            end
            local v341 = v337.Magnitude <= 0 and Vector3.new(0, 0, -1) or v337.Unit
            if v340.Magnitude > 0 then
                v340 = v340.Unit
            end
            local v342 = p190.LadderClimbPercentage or 0
            local v343 = v342 >= 0.98
            local v344 = v342 <= 0.15
            local v345 = v334:Dot(v341)
            local v346 = v334:Dot(v340)
            local v347 = v331.Magnitude > 0.1
            local v348 = p190:GetLadderCFrame(v330)
            if not v348 then
                p190:ForceExitLadder("Ladder part removed during climb")
                return
            end
            local v349 = v193.Position
            local v350 = v348.Position
            local v351 = v350.X - v349.X
            local v352 = v350.Z - v349.Z
            local v353 = Vector3.new(v351, 0, v352)
            if v353.Magnitude > 0.1 and v341:Dot(v353.Unit) <= 0 then
                v345 = -v345
            end
            local v354 = tick() - (p190.LastLadderAttachTick or 0) >= 0.1
            if v343 and (v345 > 0.1 and v354) then
                print("[Ladder Debug] Auto-detach at top", "climb%:", string.format("%.2f", v342), "verticalInput:", string.format("%.2f", v345))
                local v355 = v341 * 8
                local v356 = v355.X
                local v357 = v355.Z
                local v358 = Vector3.new(v356, 2, v357)
                local v359
                if v358 == v358 then
                    v359 = v358.Magnitude < 10000
                else
                    v359 = false
                end
                if v359 then
                    v193.AssemblyLinearVelocity = v358
                    p190.GlobalVelocity = v355
                end
                p190.ClimbEnded:Fire(v330, false)
                return
            end
            if v344 and (v345 < -0.1 and v354) then
                print("[Ladder Debug] Auto-detach at bottom", "climb%:", string.format("%.2f", v342), "verticalInput:", string.format("%.2f", v345))
                p190.ClimbEnded:Fire(v330, false)
                return
            end
            if v347 then
                if math.abs(v345) > 0.1 then
                    local v360 = 14 * v345
                    if math.abs(v346) > 0.1 then
                        v360 = v360 * 1.15
                    end
                    v329 = Vector3.new(0, v360, 0)
                end
                if math.abs(v346) > 0.1 then
                    local v361 = p190:GetLadderCFrame(v330)
                    if not v361 then
                        p190:ForceExitLadder("Ladder part removed during strafe")
                        return
                    end
                    local v362 = v361.RightVector
                    local v363 = v361:VectorToObjectSpace(v349 - v350).X
                    local v364 = v330.Extents.X * 0.8
                    local v365 = v363 + v346 * 0.5
                    if math.abs(v365) < v364 then
                        v329 = v329 + v362 * (5.6000000000000005 * v346)
                    end
                end
            end
        end
        local v366 = v193 and p190.Character.PrimaryPart
        if v366 then
            local v367
            if v329 == v329 then
                v367 = v329.Magnitude < 10000
            else
                v367 = false
            end
            if v367 then
                v366.AssemblyLinearVelocity = v329
            end
        end
    end
    local v368 = not v_u_19.activeController:GetIsJumping() and v_u_19.touchJumpController
    if v368 then
        v368 = v_u_19.touchJumpController:GetIsJumping()
    end
    if v368 and not (p190.IsJumping or p190.IsJumpRequested) then
        p190.IsJumpRequested = true
    elseif not v368 then
        p190.IsJumpRequested = false
    end
    p190:Jump()
    p190.LastCameraCFrame = v209
    p190.Humanoid:MoveTo(p190.HumanoidRootPart.Position + p190.GlobalVelocity)
    p190.LastMoveUpdate = v194
end
function v_u_1.StopMovementAnimations(p369)
    -- upvalues: (ref) v_u_32, (copy) v_u_31, (copy) v_u_33
    local v370
    if v_u_32 then
        v370 = v_u_32
    else
        v370 = v_u_31()
        if v370 then
            v_u_32 = v370
        else
            v370 = v_u_33
        end
    end
    for v371, v372 in pairs(p369.CharacterAnimator.Animations) do
        if v371 ~= "Jump" and (v370[v371] and v372.IsPlaying) then
            p369.CharacterAnimator:stop(v371, 0.2)
        end
    end
end
function v_u_1.ToggleWalkState(p373, p374)
    -- upvalues: (copy) v_u_16
    if p374 ~= p373.IsWalking then
        p373.IsWalking = p374
        v_u_16.Character.UpdateWalkState.Send(p373.IsWalking)
        p373.Walking:Fire(p373.IsWalking)
    end
end
function v_u_1.ToggleCrouchInput(p375, p376)
    p375.CrouchInputDown = p376
end
function v_u_1.PlantBomb(p377)
    -- upvalues: (copy) v_u_4
    if not p377.IsPlantingBomb then
        p377.IsPlantingBomb = true
        if p377.BombPlantTween then
            p377.BombPlantTween:Cancel()
            p377.BombPlantTween = nil
        end
        p377.BombPlantTween = p377.Janitor:Add(v_u_4:Create(p377.Humanoid, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ["CameraOffset"] = Vector3.new(0, -0.9, 0) + p377.DefaultCameraOffset
        }))
        p377.BombPlantTween:Play()
    end
end
function v_u_1.CancelBombPlant(p378)
    -- upvalues: (copy) v_u_4
    if p378.IsPlantingBomb then
        p378.IsPlantingBomb = false
        if p378.BombPlantTween then
            p378.BombPlantTween:Cancel()
            p378.BombPlantTween = nil
        end
        p378.Janitor:Add(v_u_4:Create(p378.Humanoid, TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ["CameraOffset"] = p378.DefaultCameraOffset
        })):Play()
    end
end
function v_u_1.ToggleCrouchState(p379, p380)
    -- upvalues: (copy) v_u_14, (copy) v_u_16, (copy) v_u_4
    local v381 = v_u_14.getCurrentEquipped()
    if v381 and (v381.Properties.Class == "C4" and v381.IsPlanting) then
        return
    elseif p380 ~= p379.IsCrouching then
        local v382 = tick()
        p379.IsCrouching = p380
        v_u_16.Character.UpdateCrouchState.Send(p379.IsCrouching)
        if p379.CrouchTween then
            p379.CrouchTween:Cancel()
            p379.CrouchTween = nil
        end
        if p379.IsCrouching then
            p379.CrouchCount = p379.CrouchCount + 1
            if v382 - p379.LastCrouchTick > 0.5 then
                p379.CrouchCount = 0
            end
            local v383 = p379.CrouchCount * 0.05 + 0.15
            local v384 = math.min(v383, 0.4)
            p379.LastCrouchTick = v382
            p379.CrouchTween = p379.Janitor:Add(v_u_4:Create(p379.Humanoid, TweenInfo.new(v384, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["CameraOffset"] = p379.CrouchCameraOffset + p379.DefaultCameraOffset
            }))
            p379.CrouchTween:Play()
        else
            local v385 = p379.CrouchCount * 0.05 + 0.15
            local v386 = math.min(v385, 0.4)
            p379.CrouchTween = p379.Janitor:Add(v_u_4:Create(p379.Humanoid, TweenInfo.new(v386, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["CameraOffset"] = p379.DefaultCameraOffset
            }))
            p379.CrouchTween:Play()
        end
        p379.LastCrouchTick = v382
        p379.Crouching:Fire(p379.IsCrouching)
    end
end
function v_u_1.UpdateCharacterAnimations(p387, _)
    -- upvalues: (copy) v_u_12
    if p387.IsJumping then
        p387.CurrentMovementAnimation = nil
        p387:StopMovementAnimations()
    else
        local v388 = p387.CharacterAnimator:getAnimation("CrouchIdle")
        local v389 = v_u_12(p387.Character)
        local v390
        if p387.IsCrouching then
            if p387.GlobalDirection.Magnitude <= 0.1 then
                if not v388.IsPlaying then
                    p387.CurrentMovementAnimation = nil
                    p387:StopMovementAnimations()
                    local v391 = p387.CharacterAnimator
                    local v392 = p387.CrouchCount * 0.05 + 0.15
                    v391:play("CrouchIdle", (math.min(v392, 0.4)))
                end
                return
            end
            v390 = ("Crouch%*"):format(v389)
            if v388.IsPlaying then
                local v393 = p387.CharacterAnimator
                local v394 = p387.CrouchCount * 0.05 + 0.15
                v393:stop("CrouchIdle", (math.min(v394, 0.4)))
            end
        else
            if v388.IsPlaying then
                local v395 = p387.CharacterAnimator
                local v396 = p387.CrouchCount * 0.05 + 0.15
                v395:stop("CrouchIdle", (math.min(v396, 0.4)))
            end
            v390 = v389 or "CharacterIdle"
        end
        local v397 = p387.CharacterAnimator:getAnimation(v390)
        if v397 and v390 ~= "CharacterIdle" then
            v397:AdjustSpeed((p387.HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude / (p387.IsCrouching and 12 or 16))
        end
        if p387.CurrentMovementAnimation ~= v390 then
            p387.CurrentMovementAnimation = v390
            p387:StopMovementAnimations()
            if v397 then
                v397:Play(0.15)
                return
            end
        end
    end
end
function v_u_1.new(p_u_398, p399, p_u_400)
    -- upvalues: (copy) v_u_1, (copy) v_u_17, (copy) v_u_8, (copy) v_u_13, (copy) v_u_50, (copy) v_u_10, (copy) v_u_18, (copy) v_u_19, (copy) v_u_16, (copy) v_u_5, (copy) v_u_2
    local v401 = v_u_1
    local v_u_402 = setmetatable({}, v401)
    v_u_402.Janitor = v_u_17.new()
    v_u_402.DefaultCameraOffset = v_u_8:GetAttribute("DefaultCameraOffset") or Vector3.new(0, -0.15, 0)
    v_u_402.CrouchCameraOffset = v_u_8:GetAttribute("CrouchCameraOffset") or Vector3.new(0, -1.4, 0)
    v_u_402.Janitor:Add(v_u_8:GetAttributeChangedSignal("DefaultCameraOffset"):Connect(function()
        -- upvalues: (copy) v_u_402, (ref) v_u_8
        v_u_402.DefaultCameraOffset = v_u_8:GetAttribute("DefaultCameraOffset") or Vector3.new(0, -0.15, 0)
    end))
    v_u_402.Janitor:Add(v_u_8:GetAttributeChangedSignal("CrouchCameraOffset"):Connect(function()
        -- upvalues: (copy) v_u_402, (ref) v_u_8
        v_u_402.CrouchCameraOffset = v_u_8:GetAttribute("CrouchCameraOffset") or Vector3.new(0, -1.4, 0)
    end))
    v_u_402.CharacterAnimator = v_u_13.new(p_u_398)
    v_u_402.HumanoidRootPart = p399
    v_u_402.Character = p_u_398
    v_u_402.Humanoid = p_u_400
    v_u_402.Player = v_u_8
    v_u_402.Janitor:Add(p399.AncestryChanged:Connect(function(_, p403)
        -- upvalues: (copy) v_u_402
        if not p403 then
            if v_u_402.IsClimbing then
                v_u_402:ForceExitLadder("HumanoidRootPart removed")
            end
            v_u_402.HumanoidRootPart = nil
        end
    end))
    v_u_402.Humanoid.WalkSpeed = 20
    v_u_402.Humanoid.AutoRotate = false
    v_u_402.Humanoid.MaxSlopeAngle = 90
    if v_u_8:GetAttribute("SV_ACCELERATE") == nil then
        v_u_8:SetAttribute("SV_ACCELERATE", 6)
    end
    if v_u_8:GetAttribute("SV_STOPSPEED") == nil then
        v_u_8:SetAttribute("SV_STOPSPEED", 5)
    end
    if v_u_8:GetAttribute("SV_FRICTION") == nil then
        v_u_8:SetAttribute("SV_FRICTION", 6)
    end
    local function v_u_405(p404)
        if p404.Name == "CollisionCapsule" then
            p404.CanCollide = false
            return
        elseif p404.Name == "HumanoidRootPart" and p404:IsA("Part") then
            p404.CanCollide = true
            p404.Size = Vector3.new(2, 2, 2)
            p404.Shape = Enum.PartType.Ball
            p404.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0, 1, 1)
            return
        elseif p404.Name == "Head" then
            p404.CanCollide = true
            return
        elseif p404.Name == "UpperTorso" or p404.Name == "LowerTorso" then
            p404.CanCollide = false
        else
            p404.CanCollide = false
        end
    end
    for _, v406 in ipairs(p_u_398:GetDescendants()) do
        if v406:IsA("BasePart") then
            v_u_405(v406)
        end
    end
    v_u_402.Janitor:Add(p_u_398.DescendantAdded:Connect(function(p407)
        -- upvalues: (copy) v_u_405
        if p407:IsA("BasePart") then
            v_u_405(p407)
        end
    end))
    v_u_402.Humanoid.UseJumpPower = true
    v_u_402.Humanoid.JumpPower = 19.5
    v_u_50(v_u_402.Humanoid)
    v_u_402.GlobalVelocity = Vector3.new(0, 0, 0)
    v_u_402.LocalVelocity = Vector3.new(0, 0, 0)
    v_u_402.LocalVelocityOnJump = Vector3.new(0, 0, 0)
    v_u_402.GlobalDirection = Vector3.new(0, 0, 0)
    v_u_402.LastCameraCFrame = CFrame.new()
    v_u_402.LastMoveUpdate = 0
    v_u_402.JumpCooldownActive = false
    v_u_402.ReadyToJump = false
    v_u_402.LastJumpTick = 0
    v_u_402.JumpCount = 0
    v_u_402.LastWallHitTick = 0
    v_u_402.WallJumpCooldown = false
    v_u_402.LockedAirDirection = nil
    v_u_402.LastAirDirectionChangeTick = 0
    v_u_402.LastLandTick = 0
    v_u_402.LastFreefallTick = nil
    v_u_402.LastAirTime = 0
    v_u_402.PeakFallVelocity = 0
    v_u_402.LandingVelocityY = nil
    v_u_402.LastCrouchTick = 0
    v_u_402.CrouchCount = 0
    v_u_402.CrouchHeadBlocked = false
    v_u_402.CrouchInputDown = false
    v_u_402.CurrentMovementAnimation = nil
    v_u_402.LadderZones = {}
    v_u_402.LadderPart = nil
    v_u_402.LadderZone = nil
    v_u_402.LadderClimbPercentage = 0
    v_u_402.LastLadderJumpTick = 0
    v_u_402.LastLadderAttachTick = 0
    local _, v408, _ = v_u_10.CFrame:ToEulerAnglesYXZ()
    v_u_402.CurrentYRotation = v408
    v_u_402.TargetYRotation = v408
    local v409 = p399:FindFirstChild("RootAttachment")
    if not v409 then
        warn("[Character] RootAttachment not found - creating one")
        v409 = Instance.new("Attachment")
        v409.Name = "RootAttachment"
        v409.Parent = p399
    end
    local v410 = p399.AssemblyMass
    if v410 ~= v410 or v410 <= 0 then
        warn("[Character] Invalid initial AssemblyMass:", v410, "- using fallback")
        v410 = 10
    end
    v_u_402.VectorForce = v_u_402.Janitor:Add(Instance.new("VectorForce"))
    local v411 = v_u_402.VectorForce
    local v412 = v410 * workspace.Gravity
    v411.Force = Vector3.new(0, v412, 0)
    v_u_402.VectorForce.RelativeTo = Enum.ActuatorRelativeTo.World
    v_u_402.VectorForce.Enabled = false
    v_u_402.VectorForce.ApplyAtCenterOfMass = false
    v_u_402.VectorForce.Attachment0 = v409
    v_u_402.VectorForce.Parent = p399
    v_u_402.AlignOrientation = v_u_402.Janitor:Add(Instance.new("AlignOrientation"))
    v_u_402.AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
    v_u_402.AlignOrientation.Attachment0 = p399:FindFirstChild("RootAttachment")
    v_u_402.AlignOrientation.RigidityEnabled = true
    v_u_402.AlignOrientation.MaxTorque = (1 / 0)
    v_u_402.AlignOrientation.Responsiveness = 200
    v_u_402.AlignOrientation.CFrame = CFrame.Angles(0, v_u_402.CurrentYRotation, 0)
    v_u_402.AlignOrientation.Parent = p399
    v_u_402.JumpedOffLadder = false
    v_u_402.IsPlantingBomb = false
    v_u_402.IsCrouching = false
    v_u_402.IsClimbing = false
    v_u_402.IsJumping = false
    v_u_402.IsWalking = false
    v_u_402.IsLanded = false
    v_u_402.IsBhopAttempt = false
    v_u_402.AgainstWall = false
    v_u_402.WallNormal = nil
    v_u_402.LastWallHitTime = 0
    v_u_402.LastWallNormal = nil
    v_u_402.Stamina = 100
    v_u_402.CurrentMoveDirection = Vector3.new(0, 0, 0)
    v_u_402.TargetMoveDirection = Vector3.new(0, 0, 0)
    v_u_402.MaxSpeed = 20
    v_u_402.ShotSlowUntil = 0
    v_u_402.ShotSlowMultiplier = 1
    v_u_402.LastLookAngle = 0
    v_u_402.LastVerticalLook = 0
    v_u_402.LastLookAngleUpdate = 0
    v_u_402.MoveDirectionChanged = v_u_402.Janitor:Add(v_u_18.new())
    v_u_402.Crouching = v_u_402.Janitor:Add(v_u_18.new())
    v_u_402.ClimbBegan = v_u_402.Janitor:Add(v_u_18.new())
    v_u_402.ClimbEnded = v_u_402.Janitor:Add(v_u_18.new())
    v_u_402.Climbing = v_u_402.Janitor:Add(v_u_18.new())
    v_u_402.Jumping = v_u_402.Janitor:Add(v_u_18.new())
    v_u_402.Walking = v_u_402.Janitor:Add(v_u_18.new())
    v_u_402.Landed = v_u_402.Janitor:Add(v_u_18.new())
    v_u_402.Janitor:Add(function()
        -- upvalues: (copy) v_u_402
        if v_u_402.CharacterAnimator then
            v_u_402.CharacterAnimator:destroy()
        end
    end)
    v_u_402.Janitor:Add(v_u_402.Humanoid.StateChanged:Connect(function(p413, p414)
        -- upvalues: (copy) v_u_402, (ref) v_u_50
        if (p414 == Enum.HumanoidStateType.Ragdoll or p414 == Enum.HumanoidStateType.FallingDown) and v_u_402.Humanoid.Health > 0 then
            v_u_50(v_u_402.Humanoid)
        else
            local v415 = p414 == Enum.HumanoidStateType.Jumping and true or p414 == Enum.HumanoidStateType.Freefall
            local v416
            if p413 == Enum.HumanoidStateType.Freefall then
                v416 = not v415
            else
                v416 = false
            end
            if p414 == Enum.HumanoidStateType.Freefall then
                v_u_402.LastFreefallTick = tick()
                v_u_402.PeakFallVelocity = 0
            end
            if v416 then
                v_u_402.LastAirTime = tick() - (v_u_402.LastFreefallTick or 0)
                local v417 = v_u_402.HumanoidRootPart and v_u_402.HumanoidRootPart.AssemblyLinearVelocity.Y or 0
                local v418 = v_u_402
                local v419 = v_u_402.PeakFallVelocity or 0
                v418.LandingVelocityY = math.min(v417, v419)
                v_u_402.IsJumping = false
                v_u_402.IsLanded = true
                v_u_402.LandAtPosition = v_u_402.HumanoidRootPart.CFrame.Position
                v_u_402.LastLandTick = tick()
                v_u_402.ReadyToJump = true
                v_u_402.LockedAirDirection = nil
                v_u_402.CharacterAnimator:stop("Jump", 0.2)
                v_u_402.Landed:Fire()
            end
        end
    end))
    v_u_402.OriginalMoveFunction = v_u_19.moveFunction
    v_u_402.IsDestroyed = false
    task.delay(0.15, function()
        -- upvalues: (copy) v_u_402, (ref) v_u_8, (copy) p_u_398, (copy) p_u_400, (ref) v_u_50
        if not v_u_402.IsDestroyed then
            if v_u_8.Character == p_u_398 and (p_u_400.Parent and p_u_400.Health > 0) then
                v_u_50(p_u_400)
            end
        end
    end)
    local v_u_420 = setmetatable({
        ["instance"] = v_u_402
    }, {
        ["__mode"] = "v"
    })
    v_u_402._characterRef = v_u_420
    function v_u_19.moveFunction(_, ...)
        -- upvalues: (copy) v_u_420, (ref) v_u_19
        local v421 = v_u_420.instance
        if v421 and not v421.IsDestroyed then
            v421:MoveFunction(...)
        elseif v421 and v421.OriginalMoveFunction then
            v_u_19.moveFunction = v421.OriginalMoveFunction
        end
    end
    v_u_402.Janitor:Add(function()
        -- upvalues: (copy) v_u_420, (copy) v_u_402, (ref) v_u_19
        if v_u_420 then
            v_u_420.instance = nil
        end
        if not v_u_402.IsDestroyed then
            v_u_402.IsDestroyed = true
            if v_u_402.OriginalMoveFunction then
                v_u_19.moveFunction = v_u_402.OriginalMoveFunction
                v_u_402.OriginalMoveFunction = nil
            end
        end
    end, true, "MoveFunctionCleanup")
    v_u_402.Janitor:Add(v_u_402.Landed:Connect(function()
        -- upvalues: (copy) v_u_402, (ref) v_u_16
        local v422 = v_u_402.LandingVelocityY or v_u_402.HumanoidRootPart.AssemblyLinearVelocity.Y
        v_u_402.CanceledInertia = false
        v_u_402.IsCrouchJumping = false
        v_u_402.JumpedOffLadder = false
        if v_u_402.HumanoidRootPart then
            local v423 = v_u_402.HumanoidRootPart.AssemblyLinearVelocity
            local v424 = v423.X
            local v425 = v423.Z
            local v426 = Vector3.new(v424, 0, v425)
            local v427 = v426.Magnitude
            if v427 > 19 then
                local v428 = 1 - (0.1 + (v427 - 19) * 0.03)
                local v429 = v426 * math.max(0.4, v428)
                v_u_402.GlobalVelocity = v429
                local v430 = v_u_402.HumanoidRootPart
                local v431 = v429.X
                local v432 = v423.Y
                local v433 = v429.Z
                v430.AssemblyLinearVelocity = Vector3.new(v431, v432, v433)
            end
        end
        if v422 <= -42 then
            local v434 = v_u_402.LastFreefallTick or v_u_402.LastJumpTick
            if v_u_402.LastLandTick - v434 >= 0.3 then
                local v435 = v_u_16.Character.FallDamage.Send
                local v436 = (v422 - -42) / -35 * 100
                v435((math.abs(v436)))
                v_u_402:TakeStamina(100)
            end
        end
        v_u_402.LandingVelocityY = nil
        v_u_402.LastFreefallTick = nil
    end), "Disconnect")
    v_u_402.Janitor:Add(v_u_402.Jumping:Connect(function()
        -- upvalues: (copy) v_u_402, (ref) v_u_10
        v_u_402.LocalVelocityOnJump = v_u_10.CFrame:VectorToObjectSpace(v_u_402.GlobalVelocity)
        v_u_402.GlobalDirectionOnJump = v_u_402.GlobalDirection
        v_u_402.ReadyToJump = false
    end), "Disconnect")
    v_u_402.Janitor:Add(v_u_402.ClimbBegan:Connect(function(p437)
        -- upvalues: (copy) v_u_402
        if p437 and (p437.Part and p437.Part.Parent) then
            local v438 = v_u_402:GetLadderCFrame(p437)
            if v438 then
                local v439 = v438.Position
                if v439 == v439 then
                    local v440 = v439.X
                    if math.abs(v440) <= 50000 then
                        local v441 = v439.Y
                        if math.abs(v441) <= 50000 then
                            local v442 = v439.Z
                            if math.abs(v442) <= 50000 then
                                local v443 = v_u_402:ValidateHumanoidRootPart()
                                if v443 then
                                    local v444 = v443.Position
                                    if v444 == v444 then
                                        local v445 = v444.X
                                        if math.abs(v445) <= 50000 then
                                            local v446 = v444.Y
                                            if math.abs(v446) <= 50000 then
                                                local v447 = v444.Z
                                                if math.abs(v447) <= 50000 then
                                                    v_u_402.GlobalVelocity = Vector3.new(0, 0, 0)
                                                    local v448 = v443.AssemblyLinearVelocity
                                                    if v448 == v448 then
                                                        v443.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                                        v443.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                                                    else
                                                        warn("[Ladder Debug] HRP velocity was already NaN before climbing! Attempting recovery...")
                                                        v443.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                                        v443.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                                                    end
                                                    if v_u_402.VectorForce.Attachment0 and v_u_402.VectorForce.Attachment0.Parent then
                                                        local v449 = v443.AssemblyMass
                                                        if v449 ~= v449 or (v449 <= 0 or v449 > 10000) then
                                                            warn("[Ladder Debug] Invalid AssemblyMass:", v449, "- using fallback")
                                                            v449 = 10
                                                        end
                                                        local v450 = v449 * workspace.Gravity
                                                        local v451 = Vector3.new(0, v450, 0)
                                                        if v451 == v451 and v451.Magnitude <= 100000 then
                                                            v_u_402.VectorForce.Force = v451
                                                            task.defer(function()
                                                                -- upvalues: (ref) v_u_402
                                                                if v_u_402.IsDestroyed or not v_u_402.IsClimbing then
                                                                    return
                                                                else
                                                                    local v452 = v_u_402:ValidateHumanoidRootPart()
                                                                    if v452 then
                                                                        local v453 = v452.Position
                                                                        if v453 == v453 then
                                                                            v_u_402.VectorForce.Enabled = true
                                                                        else
                                                                            warn("[Ladder Debug] Position became NaN during defer - aborting")
                                                                            v_u_402:ForceExitLadder("Position NaN during defer")
                                                                        end
                                                                    else
                                                                        v_u_402:ForceExitLadder("HRP invalid after defer")
                                                                        return
                                                                    end
                                                                end
                                                            end)
                                                            v_u_402.LadderZone = p437
                                                            v_u_402.IsClimbing = true
                                                            v_u_402.LastLadderAttachTick = tick()
                                                            v_u_402.LadderClimbPercentage = v_u_402:GetLadderClimbPercentage(p437)
                                                            v_u_402.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
                                                            local v454 = v_u_402:GetLadderClimbPercentage(p437)
                                                            local v455 = p437.Part
                                                            print("[Ladder Debug] ClimbBegan", "part:", v455 and v455.Name or "nil", "pos:", v438 and v438.Position or "nil", "climb%:", string.format("%.2f", v454), "mass:", v449, "force:", v451)
                                                            v_u_402.IsJumping = false
                                                            v_u_402.IsJumpRequested = false
                                                            v_u_402.JumpedOffLadder = false
                                                            v_u_402.LastFreefallTick = nil
                                                            v_u_402.PeakFallVelocity = 0
                                                            v_u_402.LandingVelocityY = nil
                                                            v_u_402.Climbing:Fire()
                                                        else
                                                            warn("[Ladder Debug] Invalid counter-gravity force:", v451, "- aborting climb")
                                                        end
                                                    else
                                                        warn("[Ladder Debug] VectorForce has no valid Attachment0 - aborting climb")
                                                        return
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    warn("[Ladder Debug] ClimbBegan rejected - invalid player position:", v444)
                                else
                                    warn("[Ladder Debug] ClimbBegan rejected - no valid HumanoidRootPart")
                                end
                            end
                        end
                    end
                end
                warn("[Ladder Debug] ClimbBegan rejected - invalid ladder position:", v439)
            else
                warn("[Ladder Debug] ClimbBegan rejected - could not get ladder CFrame")
            end
        else
            warn("[Ladder Debug] ClimbBegan rejected - invalid ladder zone")
            return
        end
    end), "Disconnect")
    v_u_402.Janitor:Add(v_u_402.ClimbEnded:Connect(function(p456, p457)
        -- upvalues: (copy) v_u_402
        local v458 = v_u_402.LadderClimbPercentage or 0
        local v459
        if v_u_402.HumanoidRootPart then
            v459 = v_u_402.HumanoidRootPart.AssemblyLinearVelocity
        else
            v459 = nil
        end
        print("[Ladder Debug] ClimbEnded", p457 and "jumpedOff" or "walkedOff", "climb%:", string.format("%.2f", v458), "velocity:", v459, "ladder:", p456 and (p456.Part and p456.Part.Name) or "nil")
        v_u_402.VectorForce.Enabled = false
        v_u_402.IsClimbing = false
        v_u_402.LadderZone = nil
        v_u_402.LadderClimbPercentage = 0
        v_u_402.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
        v_u_402.LastLadderJumpTick = tick()
        if p457 then
            v_u_402.JumpedOffLadder = true
        end
        v_u_402.Climbing:Fire()
    end), "Disconnect")
    v_u_402.Janitor:Add(v_u_5.Stepped:Connect(function(_, p460)
        -- upvalues: (copy) v_u_402, (ref) v_u_10, (ref) v_u_16
        if v_u_402.IsDestroyed then
            return
        end
        if v_u_402.HumanoidRootPart and v_u_402.HumanoidRootPart.Parent then
            local v461 = v_u_402.HumanoidRootPart.Position
            if v461 == v461 then
                local v462 = v461.X
                if math.abs(v462) <= 50000 then
                    local v463 = v461.Y
                    if math.abs(v463) <= 50000 then
                        local v464 = v461.Z
                        if math.abs(v464) > 50000 then
                            goto l7
                        end
                        goto l4
                    end
                end
            end
            ::l7::
            warn("[Character] Detected invalid HumanoidRootPart position:", v461, "- forcing ladder exit and resetting velocity")
            if v_u_402.IsClimbing then
                v_u_402:ForceExitLadder("Invalid position detected")
            end
            if (Vector3.new(0, 0, 0)).Magnitude < 10000 then
                v_u_402.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                v_u_402.GlobalVelocity = Vector3.new(0, 0, 0)
            end
        else
            ::l4::
            v_u_402:UpdateCharacterAnimations(p460)
            if v_u_402.CrouchInputDown then
                v_u_402:ToggleCrouchState(true)
            elseif not v_u_402.CrouchHeadBlocked then
                v_u_402:ToggleCrouchState(false)
            end
            if not v_u_402.IsClimbing and v_u_402.Humanoid:GetState() == Enum.HumanoidStateType.Climbing then
                v_u_402.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
                v_u_402.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
            end
            v_u_402:ResolveGroundedFreefall(v_u_402.HumanoidRootPart)
            if v_u_402.IsClimbing and v_u_402.LadderZone then
                v_u_402.LadderClimbPercentage = v_u_402:GetLadderClimbPercentage(v_u_402.LadderZone)
            end
            if v_u_402.Stamina < 100 then
                local v465 = v_u_402
                local v466 = v_u_402.Stamina + p460 * 100
                v465.Stamina = math.min(v466, 100)
            end
            local _, v467, _ = v_u_10.CFrame:ToEulerAnglesYXZ()
            v_u_402.TargetYRotation = v467
            local v468 = v_u_402.GlobalVelocity.X
            local v469 = v_u_402.GlobalVelocity.Z
            if (Vector3.new(v468, 0, v469).Magnitude > 0.1 or v_u_402.Humanoid.MoveDirection.Magnitude > 0.1) and true or v_u_402.IsClimbing then
                local v470 = v_u_402.TargetYRotation - v_u_402.CurrentYRotation
                if v470 == v470 and math.abs(v470) ~= (1 / 0) then
                    local v471 = 0
                    while v470 > 3.141592653589793 and v471 < 10 do
                        v470 = v470 - 6.283185307179586
                        v471 = v471 + 1
                    end
                    local v472 = 0
                    while v470 < -3.141592653589793 and v472 < 10 do
                        v470 = v470 + 6.283185307179586
                        v472 = v472 + 1
                    end
                else
                    warn("[Character] Detected invalid rotation values - resetting. TargetY:", v_u_402.TargetYRotation, "CurrentY:", v_u_402.CurrentYRotation)
                    v_u_402.CurrentYRotation = v467
                    v_u_402.TargetYRotation = v467
                    v470 = 0
                end
                local v473 = p460 * 20
                local v474 = math.min(1, v473)
                v_u_402.CurrentYRotation = v_u_402.CurrentYRotation + v470 * v474
                v_u_402.AlignOrientation.RigidityEnabled = true
                v_u_402.AlignOrientation.MaxTorque = (1 / 0)
                v_u_402.AlignOrientation.Enabled = true
            else
                if v467 ~= v467 or math.abs(v467) == (1 / 0) then
                    warn("[Character] Detected invalid camera rotation - skipping stationary rotation update")
                    return
                end
                v_u_402.CurrentYRotation = v_u_402.TargetYRotation
                v_u_402.AlignOrientation.Enabled = false
                if v_u_402.HumanoidRootPart and v_u_402.HumanoidRootPart.Parent then
                    local v475 = v_u_402.HumanoidRootPart.Position
                    if v475 == v475 then
                        local v476 = v475.X
                        if math.abs(v476) < 50000 then
                            local v477 = v475.Y
                            if math.abs(v477) < 50000 then
                                local v478 = v475.Z
                                if math.abs(v478) < 50000 then
                                    v_u_402.HumanoidRootPart.CFrame = CFrame.new(v475) * CFrame.Angles(0, v_u_402.CurrentYRotation, 0)
                                end
                            end
                        end
                    end
                end
            end
            if v_u_402.CurrentYRotation == v_u_402.CurrentYRotation then
                local v479 = v_u_402.CurrentYRotation
                if math.abs(v479) < 100 then
                    v_u_402.AlignOrientation.CFrame = CFrame.Angles(0, v_u_402.CurrentYRotation, 0)
                end
            end
            local v480 = tick()
            if v480 - v_u_402.LastLookAngleUpdate >= 0.05 then
                local v481 = v_u_10.CFrame.LookVector.Y
                local v482 = v467 - v_u_402.LastLookAngle
                local v483 = math.abs(v482)
                local v484 = v481 - v_u_402.LastVerticalLook
                local v485 = math.abs(v484)
                if v483 > 0.1 or v485 > 0.1 then
                    v_u_402.LastLookAngle = v467
                    v_u_402.LastVerticalLook = v481
                    v_u_402.LastLookAngleUpdate = v480
                    v_u_16.Character.UpdateLookAngle.Send({
                        ["HorizontalAngle"] = v467,
                        ["VerticalLook"] = v481
                    })
                end
            end
        end
    end))
    local v486 = v_u_2:GetTagged("Ladder")
    for _, v487 in pairs(v486) do
        v_u_402:AddLadder(v487)
    end
    local v488 = 0
    for _ in pairs(v_u_402.LadderZones) do
        v488 = v488 + 1
    end
    v_u_402.Janitor:Add(v_u_2:GetInstanceAddedSignal("Ladder"):Connect(function(p489)
        -- upvalues: (copy) v_u_402
        if p489:IsA("BasePart") then
            v_u_402:AddLadder(p489)
        end
    end))
    v_u_402.Janitor:Add(v_u_2:GetInstanceRemovedSignal("Ladder"):Connect(function(p490)
        -- upvalues: (copy) v_u_402
        if p490:IsA("BasePart") then
            v_u_402:RemoveLadder(p490)
        end
    end))
    v_u_402._deadAttributeConnection = p_u_398:GetAttributeChangedSignal("Dead"):Connect(function()
        -- upvalues: (copy) p_u_398, (copy) v_u_402
        if p_u_398:GetAttribute("Dead") and not v_u_402.IsDestroyed then
            v_u_402:Destroy()
        end
    end)
    return v_u_402
end
function v_u_1.Destroy(p491)
    -- upvalues: (copy) v_u_19
    if not p491.IsDestroyed then
        p491.IsDestroyed = true
        if p491.CharacterAnimator then
            p491.CharacterAnimator:destroy()
            p491.CharacterAnimator = nil
        end
        if p491._characterRef then
            p491._characterRef.instance = nil
            p491._characterRef = nil
        end
        if p491.OriginalMoveFunction then
            v_u_19.moveFunction = p491.OriginalMoveFunction
            p491.OriginalMoveFunction = nil
        end
        if p491._deadAttributeConnection then
            p491._deadAttributeConnection:Disconnect()
            p491._deadAttributeConnection = nil
        end
        if p491.MoveDirectionChanged then
            p491.MoveDirectionChanged:Destroy()
            p491.MoveDirectionChanged = nil
        end
        if p491.Crouching then
            p491.Crouching:Destroy()
            p491.Crouching = nil
        end
        if p491.ClimbBegan then
            p491.ClimbBegan:Destroy()
            p491.ClimbBegan = nil
        end
        if p491.ClimbEnded then
            p491.ClimbEnded:Destroy()
            p491.ClimbEnded = nil
        end
        if p491.Climbing then
            p491.Climbing:Destroy()
            p491.Climbing = nil
        end
        if p491.Jumping then
            p491.Jumping:Destroy()
            p491.Jumping = nil
        end
        if p491.Walking then
            p491.Walking:Destroy()
            p491.Walking = nil
        end
        if p491.Landed then
            p491.Landed:Destroy()
            p491.Landed = nil
        end
        if p491.LadderZones then
            table.clear(p491.LadderZones)
            p491.LadderZones = nil
        end
        p491.Character = nil
        p491.HumanoidRootPart = nil
        p491.Humanoid = nil
        p491.LadderZone = nil
        p491.LadderPart = nil
        if p491.VectorForce then
            p491.VectorForce = nil
        end
        if p491.AlignOrientation then
            p491.AlignOrientation = nil
        end
        if p491.BombPlantTween then
            p491.BombPlantTween = nil
        end
        if p491.CrouchTween then
            p491.CrouchTween = nil
        end
        p491.DefaultCameraOffset = nil
        p491.CrouchCameraOffset = nil
        p491.GlobalVelocity = nil
        p491.LocalVelocity = nil
        p491.LocalVelocityOnJump = nil
        p491.GlobalDirection = nil
        p491.TargetMoveDirection = nil
        p491.CurrentMoveDirection = nil
        p491.WallNormal = nil
        p491.LastWallNormal = nil
        p491.LandingVelocityY = nil
        p491.LockedAirDirection = nil
        p491.Janitor:Destroy()
        p491.Janitor = nil
    end
end
return v_u_1
