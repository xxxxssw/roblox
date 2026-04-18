-- MODULESCRIPT: CameraController
-- Original Path: game.BAC - 44074.Controllers.CameraController
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = require(v_u_2.Controllers.DataController)
local v_u_7 = require(v_u_2.Database.Custom.Constants)
local v8 = require(v_u_2.Shared.Spring)
local v_u_9 = v5.LocalPlayer
local v_u_10 = v_u_9:WaitForChild("PlayerGui"):WaitForChild("MainGui")
local v_u_11 = workspace.CurrentCamera
local v_u_12 = true
local v_u_13 = 1
local v_u_14 = 0
Vector2.new(4, 3)
local v_u_15 = {}
local v_u_16 = {}
local v_u_17 = false
local v_u_18 = 1
local v_u_19 = 0.5
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = nil
local v_u_23 = v8.new(1, 100, v_u_7.DEFAULT_CAMERA_FOV)
local v_u_24 = v8.new(0.5, 25, Vector3.new(0, 0, 0))
local v_u_25 = v8.new(0.4, 25, Vector3.new(0, 0, 0))
local v_u_26 = v8.new(0.3, 35, Vector3.new(0, 0, 0))
local v_u_27 = v8.new(0.6, 30, Vector3.new(0, 0, 0))
local v_u_28 = v8.new(1, 1, Vector3.new(0, 0, 0))
local v_u_29 = v8.new(1, 1, Vector3.new(0, 0, 0))
local v_u_30 = v8.new(1, 1, Vector3.new(0, 0, 0))
local function v_u_39(p31)
    -- upvalues: (copy) v_u_24, (copy) v_u_29, (copy) v_u_25, (copy) v_u_28, (copy) v_u_30, (ref) v_u_13, (ref) v_u_21, (copy) v_u_2, (copy) v_u_27, (copy) v_u_26, (ref) v_u_22
    local v32 = v_u_24:getPosition()
    local v33 = v_u_29:getPosition() + v_u_25:getPosition()
    local v34 = v32 + v_u_28:getPosition()
    local v35 = v_u_30:getPosition() * (p31 or v_u_13)
    if not v_u_21 then
        local v36, v37 = pcall(function()
            -- upvalues: (ref) v_u_2
            return require(v_u_2.Controllers.AimAssistController)
        end)
        if v36 and v37 then
            v_u_21 = v37
        end
    end
    local v38 = v34 + v35 * (1 - (not (v_u_21 and v_u_21.GetRecoilAssistMultiplier) and 0 or v_u_21.GetRecoilAssistMultiplier())) + v_u_27:getPosition() + v_u_26:getPosition()
    return v_u_22 * CFrame.new(v33) * CFrame.Angles(v38.X, v38.Y, v38.Z)
end
function v_u_1.getWeaponKickRotation()
    -- upvalues: (copy) v_u_28
    return v_u_28:getPosition()
end
function v_u_1.updateCameraFOV()
    -- upvalues: (copy) v_u_16, (copy) v_u_23
    -- failed to decompile
end
function v_u_1.setFOVLock(p40, p41, p42)
    -- upvalues: (copy) v_u_23, (copy) v_u_16
    -- block 12
    if p41 then
        local v43 = p42 or v_u_23:getGoal()
        v_u_16[p40] = math.clamp(v43, 1, 80)
    else
        v_u_16[p40] = nil
    end
    local v44, v45, v46
    -- GenericForInit
v44, v45, v46 = pairs(v_u_16)
[internal control] = v46
-- end GenericForInit
    local v47, v48
    -- GenericForNext
v47, v48 = v44(v45, [internal control])
if v47 ~= nil
[internal control] = v47
-- end GenericForNext
    -- block 2
    goto l8
    ::l4::
    v48 = nil
    goto l8
    -- block 7
    goto l4
    ::l8::
    if v48 ~= nil then
        v_u_23:reset(v48)
    end
    return
end
function v_u_1.isFOVLocked()
    -- upvalues: (copy) v_u_16
    return next(v_u_16) ~= nil
end
function v_u_1.setMouseEnabled(p49)
    -- upvalues: (ref) v_u_17, (copy) v_u_15, (copy) v_u_3, (copy) v_u_10
    v_u_17 = p49
    if next(v_u_15) == nil then
        v_u_3.MouseBehavior = p49 and Enum.MouseBehavior.Default or Enum.MouseBehavior.LockCenter
        v_u_3.MouseIconEnabled = p49
        v_u_10.CameraPerspective.Visible = p49
    end
end
function v_u_1.setForceLockOverride(p50, p51)
    -- upvalues: (copy) v_u_15, (copy) v_u_3, (copy) v_u_10
    if p51 then
        v_u_15[p50] = true
    else
        v_u_15[p50] = nil
    end
    if next(v_u_15) ~= nil then
        v_u_3.MouseBehavior = Enum.MouseBehavior.Default
        v_u_3.MouseIconEnabled = true
        v_u_10.CameraPerspective.Visible = true
    else
        v_u_3.MouseBehavior = Enum.MouseBehavior.LockCenter
        v_u_3.MouseIconEnabled = false
        v_u_10.CameraPerspective.Visible = false
    end
end
function v_u_1.resetForceLockOverride()
    -- upvalues: (copy) v_u_15, (ref) v_u_17, (copy) v_u_3, (copy) v_u_10
    table.clear(v_u_15)
    v_u_17 = false
    v_u_3.MouseBehavior = Enum.MouseBehavior.LockCenter
    v_u_3.MouseIconEnabled = false
    v_u_10.CameraPerspective.Visible = false
end
function v_u_1.isForceLockOverrideActive()
    -- upvalues: (copy) v_u_15
    return next(v_u_15) ~= nil
end
function v_u_1.SetEnabled(p52)
    -- upvalues: (ref) v_u_12, (ref) v_u_22
    v_u_12 = p52
    if not p52 then
        v_u_22 = nil
    end
end
function v_u_1.IsEnabled()
    -- upvalues: (ref) v_u_12
    return v_u_12
end
function v_u_1.setPerspective(p53, p54)
    -- upvalues: (copy) v_u_1, (copy) v_u_9
    local v55 = p53 and 0 or 5
    v_u_1.setMouseEnabled(p54)
    v_u_9.CameraMaxZoomDistance = v55
    v_u_9.CameraMinZoomDistance = v55
    v_u_9.CameraMode = p53 and Enum.CameraMode.LockFirstPerson or Enum.CameraMode.Classic
end
function v_u_1.toWeaponFirePosition()
    -- upvalues: (ref) v_u_22, (copy) v_u_28, (copy) v_u_29, (copy) v_u_11, (copy) v_u_1, (copy) v_u_39
    if v_u_22 then
        v_u_28:reset(Vector3.new(0, 0, 0))
        v_u_29:reset(Vector3.new(0, 0, 0))
        v_u_11.CFrame = v_u_22
        v_u_1.updateCamera((v_u_39(1)))
    end
end
function v_u_1.weaponKick(p56, p57)
    -- upvalues: (copy) v_u_28, (copy) v_u_29, (copy) v_u_1
    v_u_28:setDampingRatio(p56.Damper)
    v_u_28:setFrequency(p56.Speed)
    v_u_28:setPosition(p56.Value * 0.017453292519943295 * 1)
    v_u_29:setDampingRatio(p57.Damper)
    v_u_29:setFrequency(p57.Speed)
    v_u_29:setPosition(p57.Value * 1)
    v_u_1.updateCamera()
end
function v_u_1.setWeaponRecoil(p58, p59)
    -- upvalues: (copy) v_u_30, (ref) v_u_13
    v_u_30:setDampingRatio(p58.Damper)
    v_u_30:setFrequency(p58.Speed)
    v_u_30:setGoal(p58.Value)
    v_u_13 = p59
end
function v_u_1.getWeaponRecoil()
    -- upvalues: (copy) v_u_30
    return v_u_30:getPosition()
end
require(v_u_2.Database.Security.Router).observerRouter("CameraControllerGetWeaponRecoil", function()
    -- upvalues: (copy) v_u_1
    return v_u_1.getWeaponRecoil()
end)
function v_u_1.flinch(_, p60)
    -- upvalues: (copy) v_u_27
    v_u_27:impulse(Vector3.new(30, 0, 0) * (p60 and 2 or 1))
end
function v_u_1.BombExploded()
    -- upvalues: (copy) v_u_16, (copy) v_u_25, (copy) v_u_26, (copy) v_u_23
    -- failed to decompile
end
function v_u_1.updateCamera()
    -- upvalues: (copy) v_u_16, (copy) v_u_23, (copy) v_u_11, (copy) v_u_7, (ref) v_u_18, (ref) v_u_19, (ref) v_u_21, (copy) v_u_2, (copy) v_u_3, (ref) v_u_20, (copy) v_u_9, (copy) v_u_39
    -- failed to decompile
end
function v_u_1.StateChanged(p61, p62)
    -- upvalues: (ref) v_u_14, (copy) v_u_24
    if tick() - v_u_14 >= 0.3 then
        if p61 == Enum.HumanoidStateType.Freefall and p62 == Enum.HumanoidStateType.Landed then
            v_u_14 = tick()
            v_u_24:setFrequency(25)
            v_u_24:impulse(Vector3.new(-0.2, 0, 0))
            task.delay(0.2, function()
                -- upvalues: (ref) v_u_24
                v_u_24:setFrequency(15)
                v_u_24:impulse(Vector3.new(0.05, 0, 0))
            end)
        end
    end
end
function v_u_1.Initialize()
    -- upvalues: (copy) v_u_2, (ref) v_u_21, (copy) v_u_4, (copy) v_u_25, (copy) v_u_26, (copy) v_u_28, (copy) v_u_29, (copy) v_u_27, (copy) v_u_30, (copy) v_u_23, (copy) v_u_24, (ref) v_u_12, (copy) v_u_11, (copy) v_u_9, (ref) v_u_22, (copy) v_u_39, (copy) v_u_1, (copy) v_u_15, (ref) v_u_17, (copy) v_u_3, (copy) v_u_10
    local v63, v64 = pcall(function()
        -- upvalues: (ref) v_u_2
        return require(v_u_2.Controllers.AimAssistController)
    end)
    if v63 and (v64 and v64.Initialize) then
        v_u_21 = v64
        v64.Initialize()
    end
    v_u_4.Stepped:Connect(function(_, p65)
        -- upvalues: (ref) v_u_25, (ref) v_u_26, (ref) v_u_28, (ref) v_u_29, (ref) v_u_27, (ref) v_u_30, (ref) v_u_23, (ref) v_u_24
        v_u_25:update(p65)
        v_u_26:update(p65)
        v_u_28:update(p65)
        v_u_29:update(p65)
        v_u_27:update(p65)
        v_u_30:update(p65)
        v_u_23:update(p65)
        v_u_24:update(p65)
    end)
    v_u_4:BindToRenderStep("CameraController", Enum.RenderPriority.Camera.Value + 1, function(p66)
        -- upvalues: (ref) v_u_12, (ref) v_u_11, (ref) v_u_21, (ref) v_u_9, (ref) v_u_22, (ref) v_u_39, (ref) v_u_1, (ref) v_u_15, (ref) v_u_17, (ref) v_u_3, (ref) v_u_10
        if v_u_12 then
            local v67 = v_u_11.CFrame
            if v_u_21 and v_u_21.GetMagnetismRotation then
                local v68 = v_u_21.GetMagnetismRotation(p66)
                if v68.Magnitude > 0.001 and (v68.X == v68.X and v68.Y == v68.Y) then
                    local v69 = v68.X
                    if math.abs(v69) < 3.141592653589793 then
                        local v70 = v68.Y
                        if math.abs(v70) < 3.141592653589793 then
                            local v71 = v_u_9.Character
                            local v72
                            if v71 and v71:FindFirstChild("HumanoidRootPart") then
                                v72 = v71.HumanoidRootPart.Position
                            else
                                v72 = v67.Position
                            end
                            local v73 = v67.Position - v72
                            local v74 = v68.Y
                            local v75 = math.clamp(v74, -0.08726646259971647, 0.08726646259971647)
                            local v76 = v68.X
                            local v77 = math.clamp(v76, -0.08726646259971647, 0.08726646259971647)
                            local v78 = CFrame.Angles(0, v77, 0)
                            local v79 = CFrame.fromAxisAngle(v67.RightVector, v75) * v78
                            local v80 = v72 + v79:VectorToWorldSpace(v73)
                            local v81 = v79 * v67.Rotation
                            v67 = CFrame.new(v80) * v81
                        end
                    end
                end
            end
            v_u_22 = v67
            local v82 = v_u_39()
            v_u_1.updateCamera(v82)
            local v83 = next(v_u_15) ~= nil and true or v_u_17
            local v84
            if v83 then
                v84 = Enum.MouseBehavior.Default
            else
                v84 = Enum.MouseBehavior.LockCenter
            end
            if v_u_3.MouseBehavior ~= v84 then
                v_u_3.MouseBehavior = v84
            end
            if v_u_3.MouseIconEnabled ~= v83 then
                v_u_3.MouseIconEnabled = v83
            end
            if v_u_10.CameraPerspective.Visible ~= v83 then
                v_u_10.CameraPerspective.Visible = v83
            end
        end
    end)
    v_u_4:BindToRenderStep("ResetCameraShake", Enum.RenderPriority.Camera.Value - 1, function()
        -- upvalues: (ref) v_u_12, (ref) v_u_22, (ref) v_u_11
        if v_u_12 then
            if v_u_22 then
                v_u_11.CFrame = v_u_22
            end
        else
            return
        end
    end)
    v_u_3.TextBoxFocused:Connect(function()
        -- upvalues: (ref) v_u_1
        v_u_1.setForceLockOverride("TextBox", true)
    end)
    v_u_3.TextBoxFocusReleased:Connect(function()
        -- upvalues: (ref) v_u_3, (ref) v_u_1
        task.defer(function()
            -- upvalues: (ref) v_u_3, (ref) v_u_1
            local v85 = v_u_3:GetFocusedTextBox() ~= nil
            v_u_1.setForceLockOverride("TextBox", v85)
        end)
    end)
    local v86 = v_u_3:GetFocusedTextBox() ~= nil
    v_u_1.setForceLockOverride("TextBox", v86)
    v_u_4:BindToRenderStep("AspectRatioStretch", Enum.RenderPriority.Camera.Value + 2, function()
        -- upvalues: (ref) v_u_12
        if not v_u_12 then
        end
    end)
    local v87 = v_u_9:GetAttribute("Team")
    local v88 = v87 == "Counter-Terrorists" and true or v87 == "Terrorists"
    if v_u_9.Character == nil and not v88 then
        v_u_1.setForceLockOverride("InitialMenu", true)
    end
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_2, (copy) v_u_9, (copy) v_u_1, (copy) v_u_7, (copy) v_u_6, (ref) v_u_18, (ref) v_u_19
    local v_u_89 = require(v_u_2.Controllers.CaseSceneController)
    v_u_9.CharacterAdded:Connect(function(p90)
        -- upvalues: (copy) v_u_89, (ref) v_u_1, (ref) v_u_7
        if not v_u_89.IsActive() then
            v_u_1.updateCameraFOV(v_u_7.DEFAULT_CAMERA_FOV)
        end
        p90:GetAttributeChangedSignal("Dead"):Once(function()
            -- upvalues: (ref) v_u_89, (ref) v_u_1, (ref) v_u_7
            if not v_u_89.IsActive() then
                v_u_1.updateCameraFOV(v_u_7.DEFAULT_CAMERA_FOV)
            end
        end)
    end)
    v_u_6.CreateListener(v_u_9, "Settings.Keyboard/Mouse.Keyboard & Mouse Settings.Mouse Sensitivity", function(p91)
        -- upvalues: (ref) v_u_18, (ref) v_u_9
        v_u_18 = math.clamp(p91 or 1, 0.1, 10)
        local v92 = v_u_18
        local v93, v94 = pcall(function()
            -- upvalues: (ref) v_u_9
            return require(v_u_9:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("CameraInput"))
        end)
        if v93 and (v94 and v94.setTouchSensitivity) then
            v94.setTouchSensitivity(v92)
        end
    end)
    local v95 = v_u_18
    local v96, v97 = pcall(function()
        -- upvalues: (ref) v_u_9
        return require(v_u_9:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("CameraInput"))
    end)
    if v96 and (v97 and v97.setTouchSensitivity) then
        v97.setTouchSensitivity(v95)
    end
    v_u_6.CreateListener(v_u_9, "Settings.Keyboard/Mouse.Keyboard & Mouse Settings.Zoom Sensitivity Multiplier", function(p98)
        -- upvalues: (ref) v_u_19
        v_u_19 = math.clamp(p98 or 0.5, 0.1, 5)
    end)
end
function v_u_1.clampFOV(p99)
    return math.clamp(p99, 1, 80)
end
return v_u_1
