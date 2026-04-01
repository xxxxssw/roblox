-- MODULESCRIPT: CharacterController
-- Original Path: game.BAC - 52212.Controllers.CharacterController
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
local v_u_4 = require(v2.Classes.Character)
local v_u_5 = require(v2.Classes.Sound)
local v_u_6 = require(v2.Database.Components.GameState)
local v_u_7 = require(v2.Controllers.CameraController)
local v_u_8 = require(v2.Controllers.CaseSceneController)
local v_u_9 = require(v2.Controllers.Observers.Character.Components.CharacterKinematics)
local v_u_10 = require(v2.Database.Security.Remotes)
local v_u_11 = require(v2.Database.Security.Router)
local v_u_12 = require(v2.Controllers.InventoryController)
local v_u_13 = v3.LocalPlayer
local v_u_14 = require(v_u_13:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
local v_u_15 = workspace.CurrentCamera
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = false
local function v_u_24()
    -- upvalues: (ref) v_u_16, (copy) v_u_13, (copy) v_u_1
    if v_u_16 then
        return
    else
        local v22 = v_u_13.Character
        if v22 and v22:IsDescendantOf(workspace) then
            local v23 = v22:FindFirstChildOfClass("Humanoid")
            if v23 and v23.Health > 0 then
                if v22:GetAttribute("Dead") ~= true then
                    v_u_1.characterAdded(v22)
                end
            else
                return
            end
        else
            return
        end
    end
end
function v_u_1.getCurrentCharacter()
    -- upvalues: (ref) v_u_16
    return v_u_16
end
function v_u_1.GetWalkState()
    -- upvalues: (ref) v_u_16
    local v25 = v_u_16
    if v25 then
        v25 = v_u_16.IsWalking
    end
    return v25
end
function v_u_1.GetCrouchState()
    -- upvalues: (ref) v_u_16
    local v26 = v_u_16
    if v26 then
        v26 = v_u_16.IsCrouching
    end
    return v26
end
function v_u_1.walk(p27)
    -- upvalues: (ref) v_u_16
    if v_u_16 then
        v_u_16:ToggleWalkState(p27)
    end
end
function v_u_1.crouch(p28)
    -- upvalues: (ref) v_u_16
    if v_u_16 then
        v_u_16:ToggleCrouchInput(p28)
    end
end
function v_u_1.PlantBomb()
    -- upvalues: (ref) v_u_16
    if v_u_16 then
        v_u_16:PlantBomb()
    end
end
function v_u_1.CancelBombPlant()
    -- upvalues: (ref) v_u_16
    if v_u_16 then
        v_u_16:CancelBombPlant()
    end
end
function v_u_1.jump()
    -- upvalues: (ref) v_u_16, (copy) v_u_13
    if v_u_16 then
        v_u_16.IsJumpRequested = true
        v_u_16:Jump()
    else
        local v29 = v_u_13.Character
        if v29 then
            local v30 = v29:FindFirstChildOfClass("Humanoid")
            if v30 and v30.Health > 0 then
                v30.Jump = true
            end
        end
    end
end
function v_u_1.characterAdded(p_u_31)
    -- upvalues: (ref) v_u_16, (copy) v_u_8, (copy) v_u_14, (copy) v_u_15, (copy) v_u_13, (ref) v_u_19, (ref) v_u_17, (ref) v_u_20, (ref) v_u_18, (ref) v_u_21, (copy) v_u_4, (copy) v_u_12, (copy) v_u_10
    if v_u_16 then
        v_u_16:Destroy()
        v_u_16 = nil
    end
    local v32 = v_u_8.IsActive()
    local v33 = p_u_31:WaitForChild("HumanoidRootPart", 20)
    local v34 = p_u_31:FindFirstChildOfClass("Humanoid")
    if not v34 then
        local v35 = tick()
        repeat
            task.wait(0.1)
            v34 = p_u_31:FindFirstChildOfClass("Humanoid")
        until v34 or tick() - v35 > 20
    end
    if p_u_31:IsDescendantOf(workspace) and v34 then
        v33.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        v33.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        local v36 = v_u_14:GetControls()
        if v36 then
            v36 = v36.activeController
        end
        if v36 then
            v36.moveVector = Vector3.new(0, 0, 0)
            v36.backwardValue = 0
            v36.forwardValue = 0
            v36.rightValue = 0
            v36.leftValue = 0
        end
        if not v32 then
            v_u_15.CameraType = Enum.CameraType.Custom
            v_u_15.CameraSubject = p_u_31.Humanoid
        end
        v_u_13.ReplicationFocus = p_u_31.Humanoid
        if v_u_19 then
            v_u_19()
            v_u_19 = nil
        end
        if v_u_17 then
            v_u_17:Disconnect()
            v_u_17 = nil
        end
        if v_u_20 then
            v_u_20()
            v_u_20 = nil
        end
        if v_u_18 then
            v_u_18:Disconnect()
            v_u_18 = nil
        end
        v_u_21 = false
        v_u_16 = v_u_4.new(p_u_31, v33, v34)
        local function v_u_37()
            -- upvalues: (ref) v_u_21, (ref) v_u_16, (ref) v_u_12, (ref) v_u_19, (ref) v_u_17, (ref) v_u_20, (ref) v_u_18
            if not v_u_21 then
                v_u_21 = true
                if v_u_16 then
                    v_u_16:Destroy()
                    v_u_16 = nil
                end
                v_u_12.CleanupCurrentLoadout()
                if v_u_19 then
                    v_u_19()
                    v_u_19 = nil
                end
                if v_u_17 then
                    v_u_17:Disconnect()
                    v_u_17 = nil
                end
                if v_u_20 then
                    v_u_20()
                    v_u_20 = nil
                end
                if v_u_18 then
                    v_u_18:Disconnect()
                    v_u_18 = nil
                end
            end
        end
        v_u_19 = v_u_10.Character.CharacterDied.Listen(function()
            -- upvalues: (ref) v_u_13, (copy) p_u_31, (copy) v_u_37
            if v_u_13.Character == p_u_31 then
                if p_u_31:GetAttribute("Dead") ~= true then
                    local v38 = p_u_31:FindFirstChildOfClass("Humanoid")
                    if v38 and v38.Health > 0 then
                        return
                    end
                end
                v_u_37()
            end
        end)
        v_u_17 = p_u_31:GetAttributeChangedSignal("Dead"):Connect(function()
            -- upvalues: (copy) p_u_31, (copy) v_u_37
            if p_u_31:GetAttribute("Dead") then
                v_u_37()
            end
        end)
        v_u_20 = v_u_10.UI.UIPlayerKilled.Listen(function(p39)
            -- upvalues: (ref) v_u_13, (copy) p_u_31, (copy) v_u_37
            if p39 then
                local v40 = p39.Victim
                local v41 = v_u_13.UserId
                if v40 == tostring(v41) and v_u_13.Character == p_u_31 then
                    v_u_37()
                    return
                end
            end
        end)
        v_u_18 = v34.HealthChanged:Connect(function(p42)
            -- upvalues: (copy) v_u_37
            if p42 <= 0 then
                v_u_37()
            end
        end)
        if p_u_31:GetAttribute("Dead") or v34.Health <= 0 then
            v_u_37()
        end
    else
        return
    end
end
function v_u_1.Initialize()
    -- upvalues: (copy) v_u_13, (copy) v_u_1, (ref) v_u_16, (ref) v_u_19, (ref) v_u_17, (ref) v_u_20, (ref) v_u_18, (ref) v_u_21, (copy) v_u_6, (copy) v_u_24, (copy) v_u_10, (copy) v_u_5, (copy) v_u_7, (copy) v_u_9
    v_u_13.CharacterAdded:Connect(function(p43)
        -- upvalues: (ref) v_u_1
        v_u_1.characterAdded(p43)
    end)
    v_u_13.CharacterRemoving:Connect(function()
        -- upvalues: (ref) v_u_16, (ref) v_u_19, (ref) v_u_17, (ref) v_u_20, (ref) v_u_18, (ref) v_u_21
        if v_u_16 then
            v_u_16:Destroy()
            v_u_16 = nil
        end
        if v_u_19 then
            v_u_19()
            v_u_19 = nil
        end
        if v_u_17 then
            v_u_17:Disconnect()
            v_u_17 = nil
        end
        if v_u_20 then
            v_u_20()
            v_u_20 = nil
        end
        if v_u_18 then
            v_u_18:Disconnect()
            v_u_18 = nil
        end
        v_u_21 = false
    end)
    v_u_6.ListenToState(function(_, p44)
        -- upvalues: (ref) v_u_24
        if p44 == "Buy Period" or p44 == "Round In Progress" then
            v_u_24()
        end
    end)
    v_u_10.Character.CharacterDamaged.Listen(function()
        -- upvalues: (ref) v_u_16, (ref) v_u_5, (ref) v_u_13
        if v_u_16 then
            v_u_16.CharacterAnimator:play("Damaged")
            v_u_5.new("Character"):playOneTime({
                ["Parent"] = v_u_13.PlayerGui,
                ["Name"] = "Character Damaged"
            })
        end
    end)
    v_u_10.Character.CharacterFlinch.Listen(function(p45)
        -- upvalues: (ref) v_u_7
        v_u_7.flinch(p45.Damage, p45.Headshot)
    end)
    v_u_10.Character.ShotSlow.Listen(function(p46)
        -- upvalues: (ref) v_u_16
        if v_u_16 then
            v_u_16.ShotSlowUntil = tick() + p46.Duration
            v_u_16.ShotSlowMultiplier = p46.Multiplier
        end
    end)
    v_u_10.Character.ReplicateLookAngle.Listen(function(p47)
        -- upvalues: (ref) v_u_9
        local v48 = p47.Player
        local v49 = p47.HorizontalAngle
        local v50 = p47.VerticalLook
        if v48 and (v49 == v49 and v50 == v50) then
            v_u_9.setTargetRotation(v48, v49)
            v_u_9.setVerticalLook(v48, v50)
        end
    end)
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_11, (copy) v_u_1
    v_u_11.observerRouter("Plant Bomb", function()
        -- upvalues: (ref) v_u_1
        v_u_1.PlantBomb()
    end)
    v_u_11.observerRouter("Cancel Bomb Plant", function()
        -- upvalues: (ref) v_u_1
        v_u_1.CancelBombPlant()
    end)
    v_u_11.observerRouter("GetCurrentCharacter", function()
        -- upvalues: (ref) v_u_1
        return v_u_1.getCurrentCharacter()
    end)
end
return v_u_1
