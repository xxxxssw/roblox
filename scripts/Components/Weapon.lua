-- MODULESCRIPT: Weapon
-- Original Path: game.BAC - 30366.Components.Weapon
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
require(v_u_2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_6 = require(v_u_2.Classes.WeaponComponent)
local v7 = require(v_u_2.Classes.Sound)
local v_u_8 = require(v_u_2.Components.Common.VFXLibary.CreateMuzzleFlash.Camera)
local v_u_9 = require(v_u_2.Components.Common.VFXLibary.CreateZeusBeam)
local v_u_10 = require(v_u_2.Components.Common.VFXLibary.CreateMarker)
local v_u_11 = require(v_u_2.Components.Common.VFXLibary.CreateImpact)
local v_u_12 = require(v_u_2.Components.Common.VFXLibary.CreateTracer)
local v_u_13 = require(v_u_2.Components.Common.VFXLibary.BreakGlass)
local v_u_14 = require(v_u_2.Controllers.HapticsController)
local v_u_15 = require(v_u_2.Controllers.CameraController)
local v_u_16 = require(v_u_2.Controllers.SoundController)
local v_u_17 = require(v_u_2.Controllers.InputController)
local v_u_18 = require(v_u_2.Controllers.HintController)
local v_u_19 = require(v_u_2.Controllers.DataController)
local v_u_20 = require(v_u_2.Database.Components.GameState)
local v_u_21 = require(v_u_2.Database.Security.Remotes)
local v_u_22 = require(v_u_2.Database.Security.Router)
local v_u_23 = require(v_u_2.Database.Custom.Constants)
local v_u_24 = require(script.Classes.Bullet)
local v_u_25 = workspace.CurrentCamera
local v_u_26 = v_u_5.LocalPlayer
local v_u_27 = v7.new("Other")
local v_u_28 = { 37, 60 }
local v_u_29 = { Enum.UserInputType.MouseButton1, Enum.KeyCode.ButtonR2 }
local v_u_30 = { Enum.UserInputType.MouseButton2, Enum.KeyCode.ButtonL2 }
local v_u_31 = workspace:GetAttribute("VIPInfiniteAmmoEnabled") == true
workspace:GetAttributeChangedSignal("VIPInfiniteAmmoEnabled"):Connect(function()
    -- upvalues: (ref) v_u_31
    v_u_31 = workspace:GetAttribute("VIPInfiniteAmmoEnabled") == true
end)
local v_u_32 = v_u_31
local v_u_33 = {}
for _, v34 in ipairs(v_u_2.Database.Custom.Weapons:GetChildren()) do
    if v34:IsA("ModuleScript") then
        v_u_33[v34.Name] = require(v34)
    end
end
local function v_u_40(p35, p36)
    -- upvalues: (copy) v_u_17
    local v37 = v_u_17.getActionKeybinds(p35)
    for _, v38 in ipairs(v37) do
        if v_u_17.isBindingPressed(v38) then
            return v38
        end
    end
    if p36 and #v37 == 0 then
        for _, v39 in ipairs(p36) do
            if v_u_17.isBindingPressed(v39) then
                return v39
            end
        end
    end
    return nil
end
local function v_u_47(p41, p42)
    local v43 = p41.Properties.Recoil
    if not v43 then
        return nil
    end
    local v44 = p41.Properties
    if p41.Properties.ShootingOptions == "Revolver" and p42 then
        v44 = table.clone(p41.Properties)
        local v45 = p41.Properties.FireModes
        local v46 = not v45 or (p42 or "Primary") == "Secondary" and v45.Secondary or v45.Primary
        v44.FireRate = v46 and v46.FireRate or (p41.Properties.FireRate or 0.1)
    end
    return v43.Pattern(v44)
end
local function v_u_57(p48, p49)
    -- upvalues: (copy) v_u_47
    local v50 = p48.Recoil
    if v50 then
        local v51 = p48.Properties.ShootingOptions == "Revolver" and p49 and p49 or "Default"
        local v52 = p48.Properties.FireModes
        local v53 = not v52 or (p49 or "Primary") == "Secondary" and v52.Secondary or v52.Primary
        local v54 = v53 and v53.FireRate or (p48.Properties.FireRate or 0.1)
        local v55 = v50.Functions[v51]
        if not v55 then
            v55 = v_u_47(p48, p49)
            if not v55 then
                return
            end
            v50.Functions[v51] = v55
        end
        local v56 = v50.ActiveFireRate
        if v56 > 0 and (v54 > 0 and v56 ~= v54) then
            v50.Time = v50.Time / v56 * v54
            v50.RecoveryTime = v50.RecoveryTime / v56 * v54
        end
        v50.Function = v55
        v50.ActiveFireRate = v54
    end
end
local function v_u_61(p58)
    -- upvalues: (copy) v_u_26, (copy) v_u_21
    local v59 = v_u_26
    if v59 then
        v59 = v_u_26.Character
    end
    if v59 and v59:IsDescendantOf(workspace) then
        local v60 = v59:FindFirstChild("Head")
        if v60 then
            v_u_21.Sound.ReplicateSound.Send({
                ["Parent"] = v60,
                ["Class"] = p58.Name,
                ["Name"] = "Prepare"
            })
        end
    else
        return
    end
end
local function v_u_71(p_u_62)
    -- upvalues: (ref) v_u_32
    local v63 = p_u_62.Properties.RechargeTime
    local v_u_64 = p_u_62.Properties.Rounds
    if v63 and v_u_64 then
        if v_u_32 then
            if p_u_62.RechargeThread then
                task.cancel(p_u_62.RechargeThread)
                p_u_62.RechargeThread = nil
            end
            p_u_62.Rounds = v_u_64
            p_u_62.RechargeStartTime = nil
            return
        elseif v_u_64 <= p_u_62.Rounds then
            if p_u_62.RechargeThread then
                task.cancel(p_u_62.RechargeThread)
                p_u_62.RechargeThread = nil
            end
            p_u_62.RechargeStartTime = nil
            return
        else
            if p_u_62.RechargeThread then
                task.cancel(p_u_62.RechargeThread)
                p_u_62.RechargeThread = nil
            end
            local v65 = workspace:GetServerTimeNow()
            local v_u_66 = p_u_62.Identifier
            local v67 = p_u_62.RechargeStartTime or v65
            local v68 = v65 - v67
            local v69 = v63 - math.max(v68, 0)
            local v70 = math.max(v69, 0)
            p_u_62.RechargeStartTime = v67
            if v70 <= 0 then
                p_u_62.Rounds = v_u_64
                p_u_62.RechargeStartTime = nil
            else
                p_u_62.RechargeThread = task.delay(v70, function()
                    -- upvalues: (copy) p_u_62, (copy) v_u_66, (copy) v_u_64
                    if not p_u_62.IsDestroyed and p_u_62.Identifier == v_u_66 then
                        p_u_62.RechargeThread = nil
                        p_u_62.Rounds = v_u_64
                        p_u_62.RechargeStartTime = nil
                    end
                end)
            end
        end
    else
        return
    end
end
local function v_u_80(p72, p73, p74, p75)
    local v76 = p72.Properties.FireModes
    local v77 = not v76 or (p75 or "Primary") == "Secondary" and v76.Secondary or v76.Primary
    if not v77 then
        return p73, p74
    end
    local v78 = v77.Animation
    if v78 and (p72.Viewmodel and p72.Viewmodel.Animation) then
        if not p72.Viewmodel.Animation:getAnimation(v78) then
            v78 = p73
        end
    else
        v78 = p73
    end
    local v79 = v77.CharacterAnimation
    if v79 and p72.CharacterAnimator then
        if not p72.CharacterAnimator:getAnimation(v79) then
            v79 = p74
        end
    else
        v79 = p74
    end
    return v78, v79
end
local function v_u_85(p81, p82)
    -- upvalues: (copy) v_u_80
    if p81.Viewmodel and (p81.Viewmodel.Animation and p81.CharacterAnimator) then
        local v83, v84 = v_u_80(p81, "Shoot", "Shoot", "Primary")
        p81.Viewmodel.Animation:cancelCrossfade()
        p81.Viewmodel.Animation:stop(v83)
        p81.CharacterAnimator:stop(v84)
        if p82 ~= false and p81.IsEquipped then
            p81.Viewmodel.Animation:play("Idle")
            p81.CharacterAnimator:play("Idle")
        end
    end
end
local function v_u_92(p86)
    -- upvalues: (copy) v_u_26, (copy) v_u_20, (copy) v_u_57
    if p86.IsDestroyed then
        return
    elseif p86.IsEquipped then
        if p86.IsChargeFiring then
            local v87 = v_u_26
            if v87 then
                v87 = v_u_26.Character
            end
            local v88 = not v87 or v87:GetAttribute("Dead")
            if v88 or v_u_20.GetState() == "Buy Period" then
                p86:cancelRevolverCharge(false, not v88)
                return
            else
                p86.CurrentWalkSpeedOverride = nil
                if p86.Rounds > 0 then
                    p86:shoot("Primary")
                else
                    if p86.ChargeThread then
                        task.cancel(p86.ChargeThread)
                        p86.ChargeThread = nil
                    end
                    if p86.ChargeShootConnection and p86.ChargeShootConnection.Connected then
                        p86.ChargeShootConnection:Disconnect()
                    end
                    p86.ChargeShootConnection = nil
                    p86.HasPendingChargeRequest = false
                    p86.IsChargeFiring = false
                    p86.ChargeStartTick = 0
                    p86.CurrentWalkSpeedOverride = nil
                    if p86.Properties.ShootingOptions == "Revolver" then
                        if p86.Bullet then
                            local v89 = p86.Properties.FireModes
                            local v90
                            if v89 then
                                v90 = v89.Secondary or v89.Primary
                            else
                                v90 = nil
                            end
                            local v91 = v90 and v90.Spread or p86.Properties.Spread
                            p86.Bullet:setSpreadConfig(v91)
                        end
                        v_u_57(p86, "Secondary")
                    end
                    p86:reload()
                end
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_115(p93)
    -- upvalues: (copy) v_u_15
    local v94 = p93.Rotation
    local v95 = p93.Position
    local v96 = v94.RotationDampen.Value
    local v97 = v94.RotationSpeed.Value
    local v98 = v95.PositionDampen.Value
    local v99 = v95.PositionSpeed.Value
    local v100 = v98 > 2 and 1 or v98
    local v101 = v99 > 2 and 1 or v99
    local v102 = v97 >= 30 and 25 or v97
    local v103 = v94.RotationX.Value
    local v104 = v94.RotationY.Value
    local v105 = v94.RotationZ.Value
    local v106 = v96 >= 5 and 1 or v96
    local v107 = v103 < 0.1 and 1 or v103
    local v108 = v104 < 0.1 and 25 or v104
    local v109 = v105 < 0.1 and 1 or v105
    local v110 = {
        ["Value"] = Vector3.new(v107, v108, v109),
        ["Damper"] = v106,
        ["Speed"] = v102
    }
    local v111 = {}
    local v112 = v95.PositionX.Value
    local v113 = v95.PositionY.Value
    local v114 = v95.PositionZ.Value
    v111.Value = Vector3.new(v112, v113, v114)
    v111.Damper = v100
    v111.Speed = v101
    v_u_15.weaponKick(v110, v111)
end
function v_u_1.isJumping(_)
    return false
end
function v_u_1.getSpread(p116)
    local v117 = p116.Bullet:getTrueSpread()
    if p116:isJumping() then
        return v117 + 0
    else
        return v117
    end
end
function v_u_1.getCrosshairDisplayState(_)
    return nil
end
function v_u_1.getBaseSpread(p118)
    local v119 = p118.Bullet:getBaseSpread()
    if p118:isJumping() then
        return v119 + 0
    else
        return v119
    end
end
function v_u_1.cancelRevolverCharge(p120, p121, p122)
    -- upvalues: (copy) v_u_57, (copy) v_u_85, (copy) v_u_21
    local v123 = p120.IsChargeFiring
    if p120.ChargeThread then
        task.cancel(p120.ChargeThread)
        p120.ChargeThread = nil
    end
    if p120.ChargeShootConnection and p120.ChargeShootConnection.Connected then
        p120.ChargeShootConnection:Disconnect()
    end
    p120.ChargeShootConnection = nil
    p120.HasPendingChargeRequest = false
    p120.IsChargeFiring = false
    p120.ChargeStartTick = 0
    p120.CurrentWalkSpeedOverride = nil
    if p120.Properties.ShootingOptions == "Revolver" then
        if p120.Bullet then
            local v124 = p120.Properties.FireModes
            local v125
            if v124 then
                v125 = v124.Secondary or v124.Primary
            else
                v125 = nil
            end
            local v126 = v125 and v125.Spread or p120.Properties.Spread
            p120.Bullet:setSpreadConfig(v126)
        end
        v_u_57(p120, "Secondary")
    end
    if v123 then
        v_u_85(p120, p122)
        if p122 ~= false and (p120.IsEquipped and not p120.IsDestroyed) then
            v_u_21.Spectate.ReplicateSpectateEvent.Send("RevolverChargeCancel")
        end
    end
    if p121 ~= true then
        p120.IsFireHeld = false
        p120.FireInputBinding = nil
    end
end
function v_u_1.startRevolverCharge(p_u_127, p128)
    -- upvalues: (copy) v_u_26, (copy) v_u_20, (copy) v_u_57, (copy) v_u_80, (copy) v_u_92, (copy) v_u_61, (copy) v_u_21
    if p_u_127.Properties.ShootingOptions == "Revolver" then
        local v129 = p_u_127.Properties.FireModes
        local v130
        if v129 then
            v130 = v129.Primary
        else
            v130 = nil
        end
        if v130 and v130.InputBehavior == "Charge" then
            p_u_127:stopRevolverSecondaryFire()
            local v131 = p_u_127.Viewmodel.Animation:getAnimation("Equip")
            if (v131 and (v131.Length and (v131.Length > 0 and v131.Length * 0.925)) or 0.5) >= tick() - p_u_127.WeaponEquippedTick then
                return
            elseif v_u_26 and (v_u_26.Character and v_u_26.Character:GetAttribute("Dead")) then
                return
            elseif v_u_20.GetState() == "Buy Period" then
                return
            elseif p_u_127.IsAdjustingSuppressor or (p_u_127.IsReloading or p_u_127.IsChargeFiring) then
                return
            elseif p_u_127.IsShooting then
                local v132 = tick() - p_u_127.ShootRequestTick
                local v133 = 0
                local v134 = p_u_127.Properties.FireModes
                local v135
                if v134 then
                    v135 = v134.Primary
                else
                    v135 = nil
                end
                local v136 = (v135 and v135.FireRate or (p_u_127.Properties.FireRate or 0.1)) - v132
                if math.max(v133, v136) <= 0.15 then
                    p_u_127.IsFireHeld = true
                    p_u_127.FireInputBinding = p128
                    p_u_127.HasPendingChargeRequest = true
                end
                return
            elseif p_u_127.Rounds <= 0 then
                p_u_127.IsFireHeld = false
                p_u_127.FireInputBinding = nil
                p_u_127:reload()
            else
                p_u_127.IsFireHeld = true
                p_u_127.FireInputBinding = p128
                p_u_127.HasPendingChargeRequest = false
                p_u_127.IsChargeFiring = true
                p_u_127.ChargeStartTick = tick()
                p_u_127.CurrentWalkSpeedOverride = v130.HoldWalkSpeed or p_u_127.Properties.WalkSpeed
                if p_u_127.Bullet then
                    local v137 = p_u_127.Properties.FireModes
                    local v138
                    if v137 then
                        v138 = v137.Primary
                    else
                        v138 = nil
                    end
                    local v139 = v138 and v138.Spread or p_u_127.Properties.Spread
                    p_u_127.Bullet:setSpreadConfig(v139)
                end
                v_u_57(p_u_127, "Primary")
                local v140 = p_u_127.Bullet and (v130 and v130.ChargeStartSpread) and (v130.Spread or p_u_127.Properties.Spread)
                if v140 then
                    p_u_127.Bullet:setBaseSpreadForConfig(v130.ChargeStartSpread, v140)
                end
                if p_u_127.IsInspecting or p_u_127.IsInspectFadingOut then
                    p_u_127:cancelInspect(nil, nil, true)
                end
                if p_u_127.ChargeThread then
                    task.cancel(p_u_127.ChargeThread)
                    p_u_127.ChargeThread = nil
                end
                if p_u_127.ChargeShootConnection and p_u_127.ChargeShootConnection.Connected then
                    p_u_127.ChargeShootConnection:Disconnect()
                end
                p_u_127.ChargeShootConnection = nil
                p_u_127:stopAllAnimations()
                local v141, v142 = v_u_80(p_u_127, "Shoot", "Shoot", "Primary")
                local v143 = p_u_127.Viewmodel.Animation:play(v141)
                if v143 then
                    v143:AdjustSpeed(1)
                    p_u_127.ChargeShootConnection = v143:GetMarkerReachedSignal("Shoot"):Connect(function()
                        -- upvalues: (ref) v_u_92, (copy) p_u_127
                        v_u_92(p_u_127)
                    end)
                end
                local v144 = p_u_127.CharacterAnimator:play(v142)
                if v144 then
                    v144:AdjustSpeed(1)
                end
                v_u_61(p_u_127)
                v_u_21.Spectate.ReplicateSpectateEvent.Send("RevolverChargeStart")
                if not v143 then
                    local v145 = v130.ChargeTime or 0
                    p_u_127.ChargeThread = task.delay(v145, function()
                        -- upvalues: (ref) v_u_92, (copy) p_u_127
                        v_u_92(p_u_127)
                    end)
                end
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.startRevolverSecondaryFire(p146, p147)
    -- upvalues: (copy) v_u_20, (copy) v_u_57
    if p146.Properties.ShootingOptions == "Revolver" then
        if v_u_20.GetState() == "Buy Period" then
            return
        else
            p146:cancelRevolverCharge(false, false)
            p146.IsAlternativeFireHeld = true
            p146.AlternativeFireInputBinding = p147
            if p146.Bullet then
                local v148 = p146.Properties.FireModes
                local v149
                if v148 then
                    v149 = v148.Secondary or v148.Primary
                else
                    v149 = nil
                end
                local v150 = v149 and v149.Spread or p146.Properties.Spread
                p146.Bullet:setSpreadConfig(v150)
            end
            v_u_57(p146, "Secondary")
            if p146.IsShooting or (p146.IsReloading or p146.IsAdjustingSuppressor) then
                return
            elseif p146.Rounds > 0 then
                p146:shoot("Secondary")
            else
                p146:reload()
            end
        end
    else
        return
    end
end
function v_u_1.stopRevolverSecondaryFire(p151)
    -- upvalues: (copy) v_u_57
    p151.IsAlternativeFireHeld = false
    p151.AlternativeFireInputBinding = nil
    if not p151.IsChargeFiring then
        if p151.Properties.ShootingOptions ~= "Revolver" then
            return
        end
        if p151.Bullet then
            local v152 = p151.Properties.FireModes
            local v153
            if v152 then
                v153 = v152.Secondary or v152.Primary
            else
                v153 = nil
            end
            local v154 = v153 and v153.Spread or p151.Properties.Spread
            p151.Bullet:setSpreadConfig(v154)
        end
        v_u_57(p151, "Secondary")
    end
end
function v_u_1.stopAllAnimations(p155)
    if p155.CharacterAnimator then
        if p155.Viewmodel and p155.Viewmodel.Animation then
            p155.Viewmodel.Animation:cancelCrossfade()
            for v156, v157 in pairs(p155.CharacterAnimator.Animations) do
                if v157.IsPlaying and v157.Name ~= "Idle" then
                    p155.CharacterAnimator:stop(v156)
                end
            end
            for v158, v159 in pairs(p155.Viewmodel.Animation.Animations) do
                if v159.IsPlaying and v159.Name ~= "Idle" then
                    p155.Viewmodel.Animation:stop(v158)
                end
            end
        end
    else
        return
    end
end
function v_u_1.removeSuppressor(p160)
    -- upvalues: (copy) v_u_21
    if tick() - p160.WeaponEquippedTick <= 1 then
        return
    elseif not (p160.IsAdjustingSuppressor or (p160.IsShooting or (p160.IsReloading or p160.IsAiming))) then
        p160.IsAdjustingSuppressor = true
        p160.IsBurstShooting = false
        p160.IsInspecting = false
        p160.IsReloading = false
        p160.IsShooting = false
        p160.IsAiming = false
        p160.ScopeStartTick = 0
        p160:stopAllAnimations()
        p160.Viewmodel.Animation:play("RemoveSuppressor")
        p160.CharacterAnimator:play("RemoveSuppressor")
        v_u_21.Spectate.ReplicateSpectateEvent.Send("Remove Suppressor")
    end
end
function v_u_1.addSuppressor(p161)
    -- upvalues: (copy) v_u_21
    if tick() - p161.WeaponEquippedTick <= 1 then
        return
    elseif not (p161.IsAdjustingSuppressor or (p161.IsShooting or (p161.IsReloading or p161.IsAiming))) then
        p161.IsAdjustingSuppressor = true
        p161.IsBurstShooting = false
        p161.IsInspecting = false
        p161.IsReloading = false
        p161.IsShooting = false
        p161.IsAiming = false
        p161:stopAllAnimations()
        p161.Viewmodel.Animation:play("AddSuppressor")
        p161.CharacterAnimator:play("AddSuppressor")
        v_u_21.Spectate.ReplicateSpectateEvent.Send("Add Suppressor")
    end
end
function v_u_1.scope(p162, p163)
    -- upvalues: (copy) v_u_27, (copy) v_u_26, (copy) v_u_15, (copy) v_u_23, (copy) v_u_28, (copy) v_u_21
    if p162.Viewmodel then
        if tick() - p162.WeaponEquippedTick <= 1 then
            return
        else
            local v164 = p162.Properties.AimingOptions == "AutomaticScope"
            if p162.IsAdjustingSuppressor or (p162.IsReloading or p162.IsShooting and not v164) then
                return
            elseif not p162.IsDestroyed then
                if p162.Properties.HasScope then
                    if not p162.IsAiming then
                        p162:stopAllAnimations()
                    end
                    p162.IsBurstShooting = false
                    p162.IsInspecting = false
                    p162.IsReloading = false
                    p162.IsShooting = false
                    if not p162.IsAiming then
                        p162.ScopeStartTick = tick()
                    end
                    p162.IsAiming = true
                    local v165 = p162.Name
                    if v165 == "SSG 08" and true or v165 == "AWP" then
                        p162.IsSniperScoped = true
                        if p162.Name == "AWP" and p162.Player then
                            p162.Player:SetAttribute("IsSniperScoped", true)
                        end
                    end
                    if p162.Properties.AimingOptions == "SniperScope" then
                        if not p162.Viewmodel.Hidden then
                            p162.Viewmodel:hide()
                        end
                        v_u_27:play({
                            ["Parent"] = v_u_26.PlayerGui,
                            ["Name"] = "Toggle Scope"
                        })
                        if p163 then
                            p162.CurrentScopeIncrement = p162.CurrentScopeIncrement + 1
                            if p162.CurrentScopeIncrement >= 3 then
                                p162:unscope()
                            else
                                v_u_15.updateCameraFOV(v_u_23.DEFAULT_CAMERA_FOV - v_u_28[p162.CurrentScopeIncrement])
                                v_u_21.Inventory.UpdateScopeIncrement.Send(p162.CurrentScopeIncrement)
                            end
                        else
                            v_u_15.updateCameraFOV(v_u_23.DEFAULT_CAMERA_FOV - v_u_28[1])
                            v_u_21.Inventory.UpdateScopeIncrement.Send(1)
                            return
                        end
                    end
                    if p162.Properties.AimingOptions == "AutomaticScope" then
                        if p162.CurrentScopeIncrement == 1 then
                            p162:unscope()
                            return
                        end
                        p162.CurrentScopeIncrement = 1
                        if not p162.Viewmodel.Hidden then
                            p162.Viewmodel:hide()
                        end
                        p162.Viewmodel:aim()
                        v_u_15.updateCameraFOV(v_u_23.DEFAULT_CAMERA_FOV - 15 * p162.CurrentScopeIncrement)
                        v_u_21.Inventory.UpdateScopeIncrement.Send(p162.CurrentScopeIncrement)
                        v_u_27:play({
                            ["Parent"] = v_u_26.PlayerGui,
                            ["Name"] = "Scope In"
                        })
                    end
                end
            end
        end
    else
        return
    end
end
function v_u_1.unscope(p166, p167)
    -- upvalues: (copy) v_u_21, (copy) v_u_2, (copy) v_u_15, (copy) v_u_23, (copy) v_u_27, (copy) v_u_26
    if tick() - p166.WeaponEquippedTick <= 1 then
        return
    elseif p166.IsAdjustingSuppressor then
        return
    elseif tick() - p166.WeaponEquippedTick > 1 then
        if p166.Properties.HasScope then
            if p166.IsAiming then
                p166:stopAllAnimations()
            end
            if p166.CurrentScopeIncrement > 0 or p166.IsAiming then
                v_u_21.Inventory.UpdateScopeIncrement.Send(0)
            end
            if not p167 then
                p166.CurrentScopeIncrement = 0
            end
            p166.IsInspecting = false
            p166.IsReloading = false
            p166.IsAiming = false
            p166.ScopeStartTick = 0
            local v168 = p166.Name
            if v168 == "SSG 08" and true or v168 == "AWP" then
                p166.IsSniperScoped = false
                if p166.Name == "AWP" and p166.Player then
                    p166.Player:SetAttribute("IsSniperScoped", false)
                end
            end
            if p166.Properties.AimingOptions == "SniperScope" then
                if p166.Viewmodel.Hidden then
                    p166.Viewmodel:unhide()
                end
                local v169 = require(v_u_2.Controllers.CaseSceneController)
                local v170 = require(v_u_2.Controllers.MenuSceneController)
                if not (v169.IsActive() or v170.IsActive()) then
                    v_u_15.updateCameraFOV(v_u_23.DEFAULT_CAMERA_FOV)
                end
                if p167 then
                    local v171 = p166.CurrentScopeIncrement - 1
                    p166.CurrentScopeIncrement = math.clamp(v171, 0, 3)
                    return
                end
            elseif p166.Properties.AimingOptions == "AutomaticScope" then
                p166.CurrentScopeIncrement = 0
                p166.Viewmodel:unaim()
                if p166.Viewmodel.Hidden then
                    p166.Viewmodel:unhide()
                end
                v_u_15.updateCameraFOV(v_u_23.DEFAULT_CAMERA_FOV - 15 * p166.CurrentScopeIncrement)
                v_u_27:play({
                    ["Parent"] = v_u_26.PlayerGui,
                    ["Name"] = "Scope Out"
                })
            end
        end
    end
end
function v_u_1.cancelInspect(p_u_172, p173, p174, p175)
    if p_u_172.IsInspecting or p_u_172.IsInspectFadingOut then
        if p_u_172.InspectDelayThread then
            task.cancel(p_u_172.InspectDelayThread)
            p_u_172.InspectDelayThread = nil
        end
        if p_u_172.CancelDelayThread then
            task.cancel(p_u_172.CancelDelayThread)
            p_u_172.CancelDelayThread = nil
        end
        if p_u_172.FadeCompleteThread then
            task.cancel(p_u_172.FadeCompleteThread)
            p_u_172.FadeCompleteThread = nil
        end
        if p175 then
            p_u_172.IsInspecting = false
            p_u_172.IsInspectFadingOut = false
            p_u_172.Viewmodel.Animation:cancelCrossfade()
        else
            local v_u_176 = p173 or 0.25
            p_u_172.IsInspectFadingOut = true
            p_u_172.IsInspecting = false
            p_u_172.CancelDelayThread = task.delay(p174 or 0.3, function()
                -- upvalues: (copy) p_u_172, (copy) v_u_176
                if p_u_172.IsDestroyed then
                    return
                elseif p_u_172.IsInspectFadingOut then
                    p_u_172.Viewmodel.Animation:crossfadeTo("Idle", v_u_176)
                    p_u_172.FadeCompleteThread = task.delay(v_u_176, function()
                        -- upvalues: (ref) p_u_172
                        if not p_u_172.IsDestroyed then
                            p_u_172.FadeCompleteThread = nil
                            p_u_172.IsInspectFadingOut = false
                        end
                    end)
                end
            end)
        end
    else
        return
    end
end
function v_u_1.inspect(p_u_177)
    -- upvalues: (copy) v_u_21
    if tick() - p_u_177.WeaponEquippedTick <= 1 then
        return
    else
        if p_u_177.IsChargeFiring then
            p_u_177:cancelRevolverCharge(false, false)
        end
        p_u_177:stopRevolverSecondaryFire()
        if p_u_177.IsAdjustingSuppressor or (p_u_177.IsShooting or (p_u_177.IsReloading or p_u_177.IsAiming)) then
            return
        elseif p_u_177.IsInspecting and not p_u_177.IsInspectFadingOut then
            return
        else
            local v178 = p_u_177.IsInspectFadingOut == true
            if v178 then
                p_u_177.IsInspectFadingOut = false
                if p_u_177.CancelDelayThread then
                    task.cancel(p_u_177.CancelDelayThread)
                    p_u_177.CancelDelayThread = nil
                end
                if p_u_177.FadeCompleteThread then
                    task.cancel(p_u_177.FadeCompleteThread)
                    p_u_177.FadeCompleteThread = nil
                end
                p_u_177.Viewmodel.Animation:cancelCrossfade()
            end
            p_u_177.IsBurstShooting = false
            p_u_177.IsInspecting = true
            p_u_177.IsReloading = false
            p_u_177.IsShooting = false
            p_u_177.ScopeStartTick = 0
            p_u_177.IsAiming = false
            if p_u_177.InspectDelayThread then
                task.cancel(p_u_177.InspectDelayThread)
                p_u_177.InspectDelayThread = nil
            end
            if v178 then
                if not p_u_177.Viewmodel.Animation:crossfadeRestart("Inspect", 0.25) then
                    p_u_177:stopAllAnimations()
                    p_u_177.Viewmodel.Animation:play("Inspect")
                end
                v_u_21.Spectate.ReplicateSpectateEvent.Send("Inspect")
                local v179 = p_u_177.Viewmodel.Animation:getAnimation("Inspect")
                if v179 then
                    p_u_177.InspectDelayThread = task.delay(v179.Length, function()
                        -- upvalues: (copy) p_u_177
                        if not p_u_177.IsDestroyed then
                            p_u_177.InspectDelayThread = nil
                            p_u_177.IsInspecting = false
                        end
                    end)
                end
            else
                p_u_177:stopAllAnimations()
                local v180 = p_u_177.Viewmodel.Animation:play("Inspect")
                v_u_21.Spectate.ReplicateSpectateEvent.Send("Inspect")
                p_u_177.InspectDelayThread = task.delay(v180.Length, function()
                    -- upvalues: (copy) p_u_177
                    if not p_u_177.IsDestroyed then
                        p_u_177.InspectDelayThread = nil
                        p_u_177.IsInspecting = false
                    end
                end)
            end
        end
    end
end
function v_u_1.updateFireMode(p181)
    -- upvalues: (copy) v_u_27, (copy) v_u_26, (copy) v_u_21, (copy) v_u_22
    if tick() - p181.WeaponEquippedTick <= 1 then
        return
    elseif not (p181.IsShooting or (p181.IsReloading or (p181.IsBurstShooting or p181.IsChargeFiring))) then
        v_u_27:play({
            ["Name"] = "Switch Fire Mode",
            ["Parent"] = v_u_26.PlayerGui
        })
        p181:stopAllAnimations()
        p181.Viewmodel.Animation:play("Switch")
        p181.AlternativeSwitchTick = tick()
        p181.AlternativeShootingOption = p181.AlternativeShootingOption == "Burst" and "Default" or "Burst"
        v_u_21.Spectate.ReplicateSpectateEvent.Send("Switch Fire Mode")
        local v182 = p181.Properties.Automatic and "Switched to automatic" or "Switched to semi-automatic"
        v_u_22.broadcastRouter("CreateNotification", "Switched Fire Mode", p181.AlternativeShootingOption == "Default" and v182 and v182 or "Switched to burst-fire mode", 2.5)
    end
end
function v_u_1.drop(p183)
    -- upvalues: (copy) v_u_20, (copy) v_u_21, (copy) v_u_25
    if workspace:GetAttribute("Gamemode") == "Deathmatch" then
        return false
    end
    if v_u_20.GetState() == "Warmup" then
        return false
    end
    if not p183.Properties.Droppable then
        return false
    end
    p183:unequip()
    v_u_21.Inventory.DropWeapon.Send({
        ["Direction"] = v_u_25.CFrame.LookVector,
        ["Identifier"] = p183.Identifier
    })
    return true
end
function v_u_1.reload(p_u_184)
    -- upvalues: (copy) v_u_27, (copy) v_u_26, (copy) v_u_3, (copy) v_u_21, (copy) v_u_18
    local v_u_185
    if workspace:GetAttribute("Gamemode") == "Deathmatch" then
        v_u_185 = p_u_184.Properties.ReloadAnimationCount == 1
    else
        v_u_185 = false
    end
    if tick() - p_u_184.WeaponEquippedTick <= 1 then
        return
    end
    if p_u_184.IsChargeFiring then
        p_u_184:cancelRevolverCharge(false, false)
    end
    p_u_184:stopRevolverSecondaryFire()
    if p_u_184.IsAdjustingSuppressor or (p_u_184.IsReloading or p_u_184.IsShooting) then
        return
    end
    if p_u_184.Properties.Rounds == p_u_184.Rounds then
        if p_u_184.IsInspecting or p_u_184.IsInspectFadingOut then
            p_u_184:cancelInspect(0.25)
        end
        return
    end
    if p_u_184.Properties.RechargeTime then
        if p_u_184.IsInspecting or p_u_184.IsInspectFadingOut then
            p_u_184:cancelInspect(0.25)
        end
        return
    end
    if p_u_184.Capacity <= 0 and not v_u_185 then
        if p_u_184.IsInspecting or p_u_184.IsInspectFadingOut then
            p_u_184:cancelInspect(0.25)
        end
        return v_u_27:play({
            ["Parent"] = v_u_26.PlayerGui,
            ["Name"] = "No Ammo"
        })
    end
    if p_u_184.IsAiming then
        p_u_184:unscope()
    end
    if not (p_u_184.Properties.Rounds and p_u_184.Properties.ReloadAnimationCount) then
        return
    end
    if p_u_184.IsInspecting or p_u_184.IsInspectFadingOut then
        p_u_184:cancelInspect(nil, nil, true)
    end
    p_u_184:stopAllAnimations()
    p_u_184.ReloadStartTick = tick()
    p_u_184.IsBurstShooting = false
    p_u_184.IsInspecting = false
    p_u_184.IsReloading = true
    p_u_184.IsShooting = false
    p_u_184.CurrentWalkSpeedOverride = nil
    if p_u_184.Properties.ReloadAnimationCount > 1 then
        local v_u_186 = p_u_184.Properties.Rounds / p_u_184.Properties.ReloadAnimationCount
        local v187 = p_u_184.Viewmodel.Animation:play("ReloadStart")
        task.wait(v187.Length * 0.75)
        local v188 = p_u_184.Properties.Rounds - p_u_184.Rounds / v_u_186
        for _ = 1, math.ceil(v188) do
            if not p_u_184.IsReloading then
                break
            end
            local v189 = p_u_184.Viewmodel.Animation:play("ReloadAction")
            if not v189 then
                error((("Client failed to fetch reload animation for %*."):format(p_u_184.Name)))
            end
            local v_u_190 = v_u_3:GenerateGUID(false)
            p_u_184.CurrentReloadIdentity = v_u_190
            p_u_184.CharacterAnimator:play("Reload")
            v_u_21.Spectate.ReplicateSpectateEvent.Send("Reload")
            v189:GetMarkerReachedSignal("MagOut"):Once(function()
                -- upvalues: (ref) v_u_21, (copy) p_u_184
                v_u_21.Inventory.CreateMagazine.Send(p_u_184.Identifier)
            end)
            v189:GetMarkerReachedSignal("MagIn"):Once(function()
                -- upvalues: (copy) p_u_184, (copy) v_u_186, (copy) v_u_190, (ref) v_u_21
                local v191 = p_u_184
                local v192 = not v191.IsDestroyed
                if v192 then
                    v192 = v191.IsEquipped == true
                end
                if v192 then
                    local v193 = v_u_186
                    local v194 = p_u_184.Capacity
                    local v195 = math.clamp(v193, 0, v194)
                    if p_u_184.CurrentReloadIdentity == v_u_190 and v195 <= p_u_184.Capacity then
                        v_u_21.Inventory.ReloadWeapon.Send({
                            ["Identifier"] = p_u_184.Identifier,
                            ["Capacity"] = p_u_184.Capacity,
                            ["Rounds"] = p_u_184.Rounds
                        })
                        p_u_184.Rounds = p_u_184.Rounds + v195
                        if workspace:GetAttribute("Gamemode") ~= "Deathmatch" then
                            p_u_184.Capacity = p_u_184.Capacity - v195
                        end
                    end
                end
            end)
            task.wait(v189.Length)
        end
        if p_u_184.IsReloading then
            p_u_184.Viewmodel.Animation:play("ReloadEnd").Ended:Once(function()
                -- upvalues: (copy) p_u_184
                p_u_184.IsReloading = false
            end)
        end
    else
        local v_u_196 = v_u_3:GenerateGUID(false)
        p_u_184.CurrentReloadIdentity = v_u_196
        local v_u_197 = p_u_184.Viewmodel.Animation:play("Reload")
        local v198 = ("Client failed to fetch reload animation for %*."):format(p_u_184.Name)
        assert(v_u_197, v198)
        if v_u_197 then
            p_u_184.CharacterAnimator:play("Reload")
            v_u_21.Spectate.ReplicateSpectateEvent.Send("Reload")
            v_u_197:GetMarkerReachedSignal("MagOut"):Once(function()
                -- upvalues: (ref) v_u_21, (copy) p_u_184
                v_u_21.Inventory.CreateMagazine.Send(p_u_184.Identifier)
            end)
            v_u_197:GetMarkerReachedSignal("MagIn"):Once(function()
                -- upvalues: (copy) p_u_184, (copy) v_u_196, (ref) v_u_21, (ref) v_u_18, (copy) v_u_185
                local v199 = p_u_184
                local v200 = not v199.IsDestroyed
                if v200 then
                    v200 = v199.IsEquipped == true
                end
                if v200 then
                    local v201 = p_u_184.Properties.Rounds - p_u_184.Rounds
                    local v202 = math.abs(v201)
                    if p_u_184.CurrentReloadIdentity == v_u_196 then
                        v_u_21.Inventory.ReloadWeapon.Send({
                            ["Identifier"] = p_u_184.Identifier,
                            ["Rounds"] = p_u_184.Rounds,
                            ["Capacity"] = p_u_184.Capacity
                        })
                        v_u_18:clearHint("Reload")
                        if v_u_185 then
                            p_u_184.Rounds = p_u_184.Properties.Rounds
                            p_u_184.Capacity = p_u_184.Properties.Capacity
                            return
                        end
                        if p_u_184.Capacity - v202 > 0 then
                            p_u_184.Rounds = p_u_184.Properties.Rounds
                            if workspace:GetAttribute("Gamemode") ~= "Deathmatch" then
                                local v203 = p_u_184
                                local v204 = p_u_184.Capacity - v202
                                v203.Capacity = math.max(0, v204)
                                return
                            end
                        elseif p_u_184.Capacity - v202 <= 0 then
                            p_u_184.Rounds = p_u_184.Rounds + p_u_184.Capacity
                            p_u_184.Capacity = 0
                        end
                    end
                end
            end)
            if p_u_184.ReloadTrackFinishedConnection and p_u_184.ReloadTrackFinishedConnection.Connected then
                p_u_184.ReloadTrackFinishedConnection:Disconnect()
            end
            p_u_184.ReloadTrackFinishedConnection = v_u_197:GetPropertyChangedSignal("IsPlaying"):Connect(function()
                -- upvalues: (copy) p_u_184, (copy) v_u_197
                if not p_u_184.IsDestroyed then
                    if not v_u_197.IsPlaying and p_u_184.WeaponEquippedTick < p_u_184.ReloadStartTick then
                        p_u_184.IsReloading = false
                    end
                    if p_u_184.ReloadTrackFinishedConnection and p_u_184.ReloadTrackFinishedConnection.Connected then
                        p_u_184.ReloadTrackFinishedConnection:Disconnect()
                    end
                    p_u_184.ReloadTrackFinishedConnection = nil
                end
            end)
        end
    end
    return nil
end
function v_u_1.shoot(p_u_205, p206)
    -- upvalues: (copy) v_u_26, (copy) v_u_20, (ref) v_u_1, (copy) v_u_33, (copy) v_u_27, (copy) v_u_15, (ref) v_u_32, (copy) v_u_80, (copy) v_u_71, (copy) v_u_16, (copy) v_u_22, (copy) v_u_57, (copy) v_u_21, (copy) v_u_19, (copy) v_u_9, (copy) v_u_12, (copy) v_u_8, (copy) v_u_5, (copy) v_u_11, (copy) v_u_13, (copy) v_u_10, (copy) v_u_115, (copy) v_u_14, (copy) v_u_17
    local v207 = p206 or "Primary"
    local v208 = p_u_205.Properties.FireModes
    local v209 = not v208 or (v207 or "Primary") == "Secondary" and v208.Secondary or v208.Primary
    local v_u_210 = v209 and v209.FireRate or (p_u_205.Properties.FireRate or 0.1)
    local v211 = p_u_205.Properties.ShootingOptions == "Revolver"
    if v211 then
        if v207 == "Primary" then
            v211 = p_u_205.IsChargeFiring
        else
            v211 = false
        end
    end
    local v212 = p_u_205.Viewmodel.Animation:getAnimation("Equip")
    if tick() - p_u_205.WeaponEquippedTick <= v212.Length * 0.925 or v_u_26 and (v_u_26.Character and v_u_26.Character:GetAttribute("Dead")) then
        return
    elseif v_u_20.GetState() == "Buy Period" then
        return
    elseif pcall(function()
        -- upvalues: (copy) p_u_205
        local v213 = p_u_205.Properties
        v213.FireRate = v213.FireRate + 1e-7
    end) then
        v_u_1 = {}
        while true do

        end
    else
        if v_u_33 and v_u_33[p_u_205.Name] then
            local v214 = v_u_33[p_u_205.Name]
            if p_u_205.Properties.FireRate < v214.FireRate or (p_u_205.Properties.BulletsPerShot > v214.BulletsPerShot or (p_u_205.Properties.Range > v214.Range or p_u_205.Properties.Penetration > v214.Penetration)) then
                v_u_1 = {}
                while true do

                end
            end
        end
        if p_u_205.Properties.FireRate and p_u_205.Properties.BulletsPerShot then
            if p_u_205.IsAdjustingSuppressor then
                return
            elseif p_u_205.IsReloading and p_u_205.Properties.MuzzleType ~= "ShotGun" then
                return
            else
                local v215 = p_u_205.Player
                if v215 then
                    v215 = p_u_205.Player.Character
                end
                if v215 then
                    if p_u_205.CharacterAnimator then
                        if p_u_205.AlternativeShootingOption ~= "Burst" then
                            p_u_205.ShootRequestTick = tick()
                        end
                        if p_u_205.IsShooting and p_u_205.AlternativeShootingOption == "Default" then
                            return
                        else
                            local v216 = p_u_205.Viewmodel.Model:FindFirstChild("Interactables")
                            if v216 then
                                if p_u_205.Rounds <= 0 then
                                    p_u_205:reload()
                                    return
                                else
                                    local v217 = p_u_205.Properties.Rounds
                                    if v217 and p_u_205.Rounds <= v217 * 0.2 then
                                        v_u_27:play({
                                            ["Parent"] = v_u_26.PlayerGui,
                                            ["Name"] = "Low Ammo Fire"
                                        })
                                    end
                                    local v218 = p_u_205.IsAiming and p_u_205.Properties.AimingOptions == "AutomaticScope" and "AimShoot" or "Shoot"
                                    local v219 = p_u_205.Properties.HasSuppressor and not p_u_205.IsSuppressed and "NoSuppressorShoot" or "Shoot"
                                    v_u_15.toWeaponFirePosition()
                                    if not v211 and (p_u_205.IsInspecting or p_u_205.IsInspectFadingOut) then
                                        p_u_205:cancelInspect(nil, nil, true)
                                    end
                                    if not v211 then
                                        p_u_205:stopAllAnimations()
                                    end
                                    p_u_205.CurrentReloadIdentity = nil
                                    p_u_205.IsInspecting = false
                                    p_u_205.IsInspectFadingOut = false
                                    p_u_205.IsReloading = false
                                    p_u_205.IsShooting = true
                                    if p_u_205.ChargeThread then
                                        task.cancel(p_u_205.ChargeThread)
                                        p_u_205.ChargeThread = nil
                                    end
                                    if p_u_205.ChargeShootConnection and p_u_205.ChargeShootConnection.Connected then
                                        p_u_205.ChargeShootConnection:Disconnect()
                                    end
                                    p_u_205.ChargeShootConnection = nil
                                    p_u_205.HasPendingChargeRequest = false
                                    p_u_205.IsChargeFiring = false
                                    p_u_205.ChargeStartTick = 0
                                    p_u_205.CurrentWalkSpeedOverride = nil
                                    if not v_u_32 then
                                        p_u_205.Rounds = p_u_205.Rounds - 1
                                    end
                                    p_u_205.RechargeStartTime = workspace:GetServerTimeNow()
                                    if p_u_205.Properties.ShootingOptions == "Dual" then
                                        p_u_205.ShootingHand = p_u_205.ShootingHand == "Left" and "Right" or "Left"
                                        v218 = "Shoot" .. p_u_205.ShootingHand
                                        v219 = "Shoot" .. p_u_205.ShootingHand
                                    end
                                    local v220, v221 = v_u_80(p_u_205, v219, v218, v207)
                                    if p_u_205.Properties.MuzzleType ~= "ShotGun" then
                                        p_u_205.CharacterAnimator:adjustAnimationSpeed(v221, v_u_210)
                                    end
                                    if p_u_205.Rounds <= 150 then
                                        v_u_71(p_u_205)
                                        local v222 = v215.PrimaryPart.Position
                                        local v223 = p_u_205.Properties.HasSuppressor
                                        if v223 then
                                            v223 = p_u_205.IsSuppressed
                                        end
                                        local v224 = v223 == true
                                        local v225 = v_u_16.GetWeaponShootRange(p_u_205.Name, v224)
                                        v_u_22.broadcastRouter("UpdatePlayerNoiseCone", "Weapon", v222, v225, nil)
                                        if p_u_205.Bullet then
                                            local v226 = p_u_205.Properties.FireModes
                                            local v227 = not v226 or (v207 or "Primary") == "Secondary" and v226.Secondary or v226.Primary
                                            local v228 = v227 and v227.Spread or p_u_205.Properties.Spread
                                            p_u_205.Bullet:setSpreadConfig(v228)
                                        end
                                        v_u_57(p_u_205, v207)
                                        local v229 = p_u_205.Properties.ShootingOptions == "Dual" and (p_u_205.ShootingHand == "Left" and v216:FindFirstChild("MuzzlePartL") or v216:FindFirstChild("MuzzlePartR")) or v216.MuzzlePart
                                        local v230 = v229.Position
                                        debug.profilebegin("Weapon.BuildShootPacket")
                                        local v231 = {}
                                        local v232 = {}
                                        for _ = 1, p_u_205.Properties.BulletsPerShot do
                                            local v233 = p_u_205.Bullet:create(p_u_205.Properties.AimingOptions, p_u_205.IsAiming)
                                            if v233 then
                                                table.insert(v231, v233)
                                                local v234 = v233.Origin
                                                local v235 = {}
                                                for _, v236 in ipairs(v233.Hits) do
                                                    local v237 = {
                                                        ["Distance"] = (v236.Position - v234).Magnitude,
                                                        ["Instance"] = v236.Instance,
                                                        ["Position"] = v236.Position,
                                                        ["Normal"] = v236.Normal,
                                                        ["Material"] = v236.Material,
                                                        ["Exit"] = v236.Exit
                                                    }
                                                    table.insert(v235, v237)
                                                    v234 = v236.Position
                                                end
                                                local v238 = {
                                                    ["Direction"] = v233.Direction,
                                                    ["Origin"] = v233.Origin,
                                                    ["Hits"] = v235
                                                }
                                                table.insert(v232, v238)
                                            end
                                        end
                                        debug.profileend()
                                        if v211 and p_u_205.Properties.ShootingOptions == "Revolver" then
                                            if p_u_205.Bullet then
                                                local v239 = p_u_205.Properties.FireModes
                                                local v240
                                                if v239 then
                                                    v240 = v239.Secondary or v239.Primary
                                                else
                                                    v240 = nil
                                                end
                                                local v241 = v240 and v240.Spread or p_u_205.Properties.Spread
                                                p_u_205.Bullet:setSpreadConfig(v241)
                                            end
                                            v_u_57(p_u_205, "Secondary")
                                        end
                                        debug.profilebegin("Weapon.SendShootPacket")
                                        v_u_21.Inventory.ShootWeapon.Send({
                                            ["IsSniperScoped"] = p_u_205.IsSniperScoped,
                                            ["ShootingHand"] = p_u_205.ShootingHand,
                                            ["Identifier"] = p_u_205.Identifier,
                                            ["Capacity"] = p_u_205.Capacity,
                                            ["Bullets"] = v232,
                                            ["Rounds"] = p_u_205.Rounds
                                        })
                                        debug.profileend()
                                        local v242 = v_u_19.Get(v_u_26, "Settings.Video.Presets.First Person Tracers") ~= false
                                        local v243 = v_u_19.Get(v_u_26, "Settings.Video.Presets.Muzzle Flash") ~= false
                                        if v243 then
                                            local v244
                                            if p_u_205.Properties.AimingOptions == "AutomaticScope" then
                                                v244 = p_u_205.IsAiming
                                            else
                                                v244 = false
                                            end
                                            v243 = not v244
                                        end
                                        local v245 = v_u_19.Get(v_u_26, "Settings.Game.Other.Emit Particles When Server Validated") == true
                                        local v246 = p_u_205.Properties.MuzzleType == "Zeus x27"
                                        local v247 = p_u_205.Properties.MuzzleType ~= "Zeus x27"
                                        local v248 = p_u_205.Properties.MuzzleType == "Zeus x27"
                                        if v246 then
                                            v_u_9(v229)
                                        end
                                        for _, v249 in ipairs(v231) do
                                            if v242 then
                                                v_u_12(v249.Distance, v230, v249.Direction)
                                            end
                                            if v243 then
                                                v_u_8(v229, p_u_205.Name, p_u_205.Properties.HasSuppressor and p_u_205.IsSuppressed and "Suppressor" or nil)
                                            end
                                            local v250 = false
                                            for _, v251 in ipairs(v249.Hits) do
                                                local v252 = v251.Instance
                                                local v253 = v251.Position
                                                local v254 = v251.Material
                                                local v255 = v251.Normal
                                                local v256 = v251.Exit
                                                local v257
                                                if v252 then
                                                    v257 = v252:FindFirstAncestorOfClass("Model")
                                                else
                                                    v257 = v252
                                                end
                                                local v258
                                                if v257 == nil then
                                                    v258 = false
                                                else
                                                    v258 = v_u_5:GetPlayerFromCharacter(v257) ~= nil
                                                end
                                                if v258 then
                                                    if v245 then
                                                        v_u_11(v252, "Blood Splatter", v253, v255, v256, false, true, nil, v250, nil, v248)
                                                    end
                                                else
                                                    v250 = not v256 and true or v250
                                                    if v247 then
                                                        v_u_11(v252, v254, v253, v255, v256, false, true)
                                                    end
                                                    local v259 = v252.Parent
                                                    if v259 and (v259:HasTag("BreakableGlass") and not v256) then
                                                        v_u_13(v252, v253, v249.Direction)
                                                    elseif not v252:HasTag("BreakableGlass") then
                                                        if not (v259 and v259:HasTag("BreakableGlass")) then
                                                            if v247 then
                                                                v_u_10(v252, "Bullet", v253, v255)
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        if p_u_205.Viewmodel.Model.CameraShake then
                                            v_u_115(p_u_205.Viewmodel.Model.CameraShake)
                                        end
                                        p_u_205.Viewmodel.Bobble:addScopeKick()
                                        if p_u_205.Viewmodel.applyCharmImpulse then
                                            local v260 = p_u_205.Viewmodel.Model.WorldPivot.LookVector
                                            local v261 = p_u_205.Viewmodel.Model.WorldPivot.UpVector
                                            local v262 = v260 * -1 + v261 * 0.3
                                            p_u_205.Viewmodel:applyCharmImpulse(v262)
                                        end
                                        if p_u_205.Recoil then
                                            local v263 = p_u_205.Recoil
                                            v263.Time = v263.Time + v_u_210
                                        end
                                        v_u_21.Spectate.ReplicateSpectateEvent.Send(v211 and "RevolverChargeRelease" or v220)
                                        local v_u_264 = p_u_205.IsAiming
                                        if v_u_264 then
                                            v_u_264 = p_u_205.Properties.AimingOptions == "SniperScope"
                                        end
                                        if v_u_264 then
                                            p_u_205:unscope(true)
                                        end
                                        local v265
                                        if v211 then
                                            v265 = p_u_205.Viewmodel.Animation:getAnimation(v220)
                                        else
                                            v265 = p_u_205.Viewmodel.Animation:play(v220)
                                        end
                                        if v211 then
                                            if not (v265 and v265.IsPlaying) then
                                                v265 = p_u_205.Viewmodel.Animation:play(v220)
                                                p_u_205.CharacterAnimator:play(v221)
                                            end
                                        else
                                            p_u_205.CharacterAnimator:play(v221)
                                        end
                                        v_u_14.vibrate(Enum.VibrationMotor.Small, 1.25, 0.225)
                                        if p_u_205.ShootDelayThread then
                                            task.cancel(p_u_205.ShootDelayThread)
                                            p_u_205.ShootDelayThread = nil
                                        end
                                        local v266 = v_u_210 or (v265 and v265.Length or 0.1)
                                        p_u_205.ShootDelayThread = task.delay(v266, function()
                                            -- upvalues: (copy) p_u_205, (copy) v_u_264, (ref) v_u_19, (ref) v_u_26, (ref) v_u_17, (copy) v_u_210
                                            if p_u_205.IsDestroyed then
                                                return
                                            else
                                                p_u_205.IsShooting = false
                                                p_u_205.ShootDelayThread = nil
                                                local v267 = p_u_205
                                                local v268 = not v267.IsDestroyed
                                                if v268 then
                                                    v268 = v267.IsEquipped == true
                                                end
                                                if v268 then
                                                    if v_u_264 and (p_u_205.ShootRequestTick > p_u_205.WeaponEquippedTick and (p_u_205.Rounds > 0 and v_u_19.Get(v_u_26, "Settings.Game.Item.Auto Re-Zoom Sniper Rifle after Shot") == true)) then
                                                        p_u_205:scope(true)
                                                    end
                                                    if p_u_205.Properties.ShootingOptions == "Revolver" then
                                                        local v269 = p_u_205.IsAlternativeFireHeld == true
                                                        if v269 and (p_u_205.AlternativeFireInputBinding and not v_u_17.isBindingPressed(p_u_205.AlternativeFireInputBinding)) then
                                                            p_u_205.IsAlternativeFireHeld = false
                                                            p_u_205.AlternativeFireInputBinding = nil
                                                            v269 = false
                                                        end
                                                        local v270 = p_u_205.Properties.FireModes
                                                        local v271
                                                        if v270 then
                                                            v271 = v270.Secondary or v270.Primary
                                                        else
                                                            v271 = nil
                                                        end
                                                        if v269 and (v271 and v271.HoldRepeat) then
                                                            if p_u_205.Rounds > 0 then
                                                                p_u_205:shoot("Secondary")
                                                            else
                                                                p_u_205:reload()
                                                            end
                                                        else
                                                            local v272 = p_u_205.IsFireHeld == true
                                                            if v272 and (p_u_205.FireInputBinding and not v_u_17.isBindingPressed(p_u_205.FireInputBinding)) then
                                                                p_u_205.IsFireHeld = false
                                                                p_u_205.FireInputBinding = nil
                                                                v272 = false
                                                            end
                                                            local v273 = p_u_205.Properties.FireModes
                                                            local v274
                                                            if v273 then
                                                                v274 = v273.Primary
                                                            else
                                                                v274 = nil
                                                            end
                                                            if v272 and (v274 and v274.HoldRepeat) then
                                                                if p_u_205.Rounds > 0 then
                                                                    p_u_205:startRevolverCharge(p_u_205.FireInputBinding)
                                                                else
                                                                    p_u_205:reload()
                                                                end
                                                            else
                                                                if p_u_205.HasPendingChargeRequest == true then
                                                                    p_u_205.HasPendingChargeRequest = false
                                                                    if v272 then
                                                                        p_u_205:startRevolverCharge(p_u_205.FireInputBinding)
                                                                    end
                                                                end
                                                                return
                                                            end
                                                        end
                                                    else
                                                        local v275 = tick()
                                                        local v276 = v_u_210
                                                        local v277 = math.min(0.15, v276) >= v275 - p_u_205.ShootRequestTick
                                                        local v278 = p_u_205.IsFireHeld == true
                                                        if v278 and (p_u_205.FireInputBinding and not v_u_17.isBindingPressed(p_u_205.FireInputBinding)) then
                                                            p_u_205.IsFireHeld = false
                                                            p_u_205.FireInputBinding = nil
                                                            v278 = false
                                                        end
                                                        if p_u_205.Properties.Automatic and v278 and v278 or (not p_u_205.Properties.Automatic and (v277 and not v278) or false) then
                                                            if p_u_205.Properties.ShootingOptions == "Burst" and p_u_205.AlternativeShootingOption == "Burst" then
                                                                return
                                                            elseif p_u_205.Rounds > 0 then
                                                                p_u_205:shoot()
                                                            else
                                                                p_u_205:reload()
                                                            end
                                                        else
                                                            return
                                                        end
                                                    end
                                                else
                                                    return
                                                end
                                            end
                                        end)
                                    end
                                end
                            else
                                return
                            end
                        end
                    else
                        return
                    end
                else
                    return
                end
            end
        else
            return
        end
    end
end
function v_u_1.equip(p_u_279)
    -- upvalues: (copy) v_u_20, (copy) v_u_17, (copy) v_u_40, (copy) v_u_30, (copy) v_u_29, (copy) v_u_57
    p_u_279.IsEquipped = true
    if p_u_279.Viewmodel.Hidden then
        p_u_279.Viewmodel:unhide()
    end
    p_u_279.Viewmodel.Animation:stopAnimations()
    p_u_279.CharacterAnimator:stopAnimations()
    p_u_279.CharacterAnimator:play("Idle")
    p_u_279.CharacterAnimator:play("Equip")
    p_u_279.WeaponEquippedTick = tick()
    p_u_279.Viewmodel:equip(false)
    if p_u_279.Janitor:Get("EquipDelayFire") then
        p_u_279.Janitor:Remove("EquipDelayFire")
    end
    local v280 = p_u_279.Viewmodel.Animation:getAnimation("Equip")
    local v281 = v280 and (v280.Length and (v280.Length > 0 and v280.Length * 0.925)) or 0.5
    local v_u_284 = task.delay(v281, function()
        -- upvalues: (copy) p_u_279, (ref) v_u_20, (ref) v_u_17, (ref) v_u_40, (ref) v_u_30, (ref) v_u_29
        if p_u_279.IsDestroyed then
            return
        elseif p_u_279.IsEquipped then
            if v_u_20.GetState() == "Buy Period" then
                return
            else
                if p_u_279.Properties.ShootingOptions == "Revolver" and (p_u_279.IsAlternativeFireHeld or v_u_17.isActionActive("SecondaryFire")) then
                    local v282 = p_u_279.AlternativeFireInputBinding or v_u_40("SecondaryFire", v_u_30)
                    if v282 or p_u_279.IsAlternativeFireHeld then
                        p_u_279:startRevolverSecondaryFire(v282)
                        return
                    end
                end
                if v_u_17.isActionActive("Fire") then
                    local v283 = v_u_40("Fire", v_u_29)
                    if v283 then
                        if p_u_279.Properties.ShootingOptions == "Revolver" then
                            p_u_279:startRevolverCharge(v283)
                            return
                        end
                        p_u_279.IsFireHeld = true
                        p_u_279.FireInputBinding = v283
                        p_u_279:shoot()
                    end
                end
            end
        else
            return
        end
    end)
    p_u_279.Janitor:Add(function()
        -- upvalues: (copy) v_u_284
        task.cancel(v_u_284)
    end, false, "EquipDelayFire")
    p_u_279.CurrentScopeIncrement = 0
    p_u_279.IsBurstShooting = false
    p_u_279.IsInspectFadingOut = false
    p_u_279.IsInspecting = false
    p_u_279.IsReloading = false
    p_u_279.IsShooting = false
    p_u_279.IsFireHeld = false
    p_u_279.FireInputBinding = nil
    p_u_279.HasPendingChargeRequest = false
    p_u_279.IsAlternativeFireHeld = false
    p_u_279.AlternativeFireInputBinding = nil
    p_u_279.IsAiming = false
    p_u_279.IsChargeFiring = false
    p_u_279.ScopeStartTick = 0
    p_u_279.IsAdjustingSuppressor = false
    p_u_279.CurrentWalkSpeedOverride = nil
    p_u_279.ChargeStartTick = 0
    p_u_279.ChargeThread = nil
    p_u_279.ChargeShootConnection = nil
    if p_u_279.Properties.ShootingOptions == "Revolver" then
        if p_u_279.Bullet then
            local v285 = p_u_279.Properties.FireModes
            local v286
            if v285 then
                v286 = v285.Secondary or v285.Primary
            else
                v286 = nil
            end
            local v287 = v286 and v286.Spread or p_u_279.Properties.Spread
            p_u_279.Bullet:setSpreadConfig(v287)
        end
        v_u_57(p_u_279, "Secondary")
    end
    local v288 = p_u_279.Name
    if v288 == "SSG 08" and true or v288 == "AWP" then
        p_u_279.IsSniperScoped = false
        if p_u_279.Name == "AWP" and p_u_279.Player then
            p_u_279.Player:SetAttribute("IsSniperScoped", false)
        end
    end
end
function v_u_1.unequip(p289)
    -- upvalues: (copy) v_u_2, (copy) v_u_15, (copy) v_u_23
    p289.IsEquipped = false
    p289:cancelRevolverCharge(false, false)
    p289:stopRevolverSecondaryFire()
    if p289.Janitor:Get("EquipDelayFire") then
        p289.Janitor:Remove("EquipDelayFire")
    end
    if p289.ShootDelayThread then
        task.cancel(p289.ShootDelayThread)
        p289.ShootDelayThread = nil
    end
    local v290 = require(v_u_2.Controllers.CaseSceneController)
    local v291 = require(v_u_2.Controllers.MenuSceneController)
    if not (v290.IsActive() or v291.IsActive()) then
        v_u_15.updateCameraFOV(v_u_23.DEFAULT_CAMERA_FOV)
    end
    p289.CharacterAnimator:stopAnimations()
    p289.Viewmodel:unequip()
    if p289.IsAiming then
        p289:unscope()
    end
    if p289.Viewmodel.Hidden then
        p289.Viewmodel:unhide()
    end
    p289.IsBurstShooting = false
    p289.IsInspectFadingOut = false
    p289.IsInspecting = false
    p289.IsReloading = false
    p289.IsShooting = false
    p289.IsFireHeld = false
    p289.FireInputBinding = nil
    p289.HasPendingChargeRequest = false
    p289.IsAlternativeFireHeld = false
    p289.AlternativeFireInputBinding = nil
    p289.IsAiming = false
    p289.IsChargeFiring = false
    p289.IsAdjustingSuppressor = false
    p289.CurrentWalkSpeedOverride = nil
    p289.ChargeStartTick = 0
    p289.ChargeThread = nil
    p289.ChargeShootConnection = nil
    local v292 = p289.Name
    if v292 == "SSG 08" and true or v292 == "AWP" then
        p289.IsSniperScoped = false
        if p289.Name == "AWP" and p289.Player then
            p289.Player:SetAttribute("IsSniperScoped", false)
        end
    end
    if p289.Recoil then
        p289.Recoil.Function = p289.Recoil.Functions.Default
        p289.Recoil.ActiveFireRate = p289.Properties.FireRate or 0.1
        p289.Recoil.Value = Vector2.zero
        p289.Recoil.RecoveryValue = Vector2.zero
        p289.Recoil.RecoveryTime = 0
        p289.Recoil.RecoveryStartTime = 0
        p289.Recoil.Time = 0
    end
end
function v_u_1.createSuppressor(p_u_293)
    -- upvalues: (copy) v_u_21
    local v_u_294 = p_u_293.Viewmodel.Model:FindFirstChild("Silencer", true)
    if v_u_294 then
        v_u_294.Transparency = p_u_293.IsSuppressed and 0 or 1
        local v_u_295 = p_u_293.Identifier
        local v_u_296 = false
        local v297 = p_u_293.Viewmodel.Animation:getAnimation("RemoveSuppressor")
        local v_u_298 = p_u_293.Viewmodel.Animation:getAnimation("AddSuppressor")
        p_u_293.Janitor:Add(v297:GetMarkerReachedSignal("ScrewOnEnd"):Connect(function()
            -- upvalues: (copy) p_u_293, (copy) v_u_294, (ref) v_u_21, (copy) v_u_295
            if not p_u_293.IsDestroyed then
                v_u_294.Transparency = 1
                local v299 = {
                    ["Identifier"] = v_u_295,
                    ["State"] = false
                }
                v_u_21.Inventory.UpdateWeaponSuppressor.Send(v299)
            end
        end))
        p_u_293.Janitor:Add(v297.Ended:Connect(function()
            -- upvalues: (copy) p_u_293, (copy) v_u_294, (ref) v_u_21, (copy) v_u_295
            p_u_293.IsAdjustingSuppressor = false
            if v_u_294.Transparency < 1 == false then
                if not p_u_293.IsDestroyed then
                    v_u_294.Transparency = 1
                    local v300 = {
                        ["Identifier"] = v_u_295,
                        ["State"] = false
                    }
                    v_u_21.Inventory.UpdateWeaponSuppressor.Send(v300)
                end
                p_u_293.IsSuppressed = false
            end
        end))
        p_u_293.Janitor:Add(v_u_298:GetMarkerReachedSignal("ScrewOnEnd"):Connect(function()
            -- upvalues: (ref) v_u_296, (copy) p_u_293, (copy) v_u_294, (ref) v_u_21, (copy) v_u_295
            v_u_296 = true
            if not p_u_293.IsDestroyed then
                v_u_294.Transparency = 0
                local v301 = {
                    ["Identifier"] = v_u_295,
                    ["State"] = true
                }
                v_u_21.Inventory.UpdateWeaponSuppressor.Send(v301)
            end
            p_u_293.IsSuppressed = true
        end))
        p_u_293.Janitor:Add(v_u_298:GetPropertyChangedSignal("IsPlaying"):Connect(function()
            -- upvalues: (copy) v_u_298, (ref) v_u_296, (copy) v_u_294
            if v_u_298.IsPlaying then
                v_u_296 = false
                task.delay(0.016666666666666666, function()
                    -- upvalues: (ref) v_u_298, (ref) v_u_294
                    if v_u_298.IsPlaying then
                        v_u_294.Transparency = 0
                    end
                end)
            end
        end))
        p_u_293.Janitor:Add(v_u_298.Ended:Connect(function()
            -- upvalues: (copy) p_u_293, (ref) v_u_296, (copy) v_u_294
            p_u_293.IsAdjustingSuppressor = false
            if not v_u_296 then
                v_u_294.Transparency = 1
            end
        end))
    end
end
function v_u_1.setupRecoil(p_u_302)
    -- upvalues: (copy) v_u_4, (copy) v_u_15
    local v303 = p_u_302.Properties.Recoil
    if p_u_302.Properties.Recoil then
        local v_u_304 = v303.RecoverySpeed
        local v_u_305 = v303.Scale
        local v_u_306 = v303.Damper
        local v_u_307 = v303.Speed
        local v_u_308 = v303.CameraScale
        local v_u_309 = p_u_302.Identifier
        local v310 = v303.Pattern(p_u_302.Properties)
        local v311 = {
            ["Function"] = v310,
            ["Functions"] = {
                ["Default"] = v310
            },
            ["Value"] = Vector2.zero,
            ["RotationValue"] = Vector3.new(0, 0, 0),
            ["ActiveFireRate"] = p_u_302.Properties.FireRate or 0.1,
            ["Time"] = 0,
            ["RecoveryValue"] = Vector2.zero,
            ["RecoveryTime"] = 0,
            ["RecoveryStartTime"] = 0
        }
        p_u_302.Recoil = v311
        local v_u_312 = p_u_302.Recoil
        p_u_302.Janitor:Add(v_u_4.Stepped:Connect(function(_, p313)
            -- upvalues: (copy) p_u_302, (copy) v_u_312, (copy) v_u_304, (copy) v_u_305, (copy) v_u_309, (ref) v_u_15, (copy) v_u_306, (copy) v_u_307, (copy) v_u_308
            if not p_u_302.IsDestroyed and v_u_312 then
                local v314 = v_u_312.Function(v_u_312.Time)
                if p_u_302.IsShooting then
                    v_u_312.Value = v314
                    v_u_312.RecoveryValue = v314
                    v_u_312.RecoveryTime = v_u_312.Time
                    v_u_312.RecoveryStartTime = os.clock()
                else
                    local v315 = v_u_312.RecoveryValue.Magnitude / v_u_304
                    if v_u_312.Value.Magnitude > 0 and v315 > 0 then
                        local v316 = os.clock() - v_u_312.RecoveryStartTime
                        local v317 = v_u_312
                        local v318 = v_u_312.RecoveryValue
                        local v319 = Vector2.zero
                        local v320 = v316 / v315
                        v317.Value = v318:Lerp(v319, (math.clamp(v320, 0, 1)))
                    end
                    if v_u_312.Time > 0 then
                        local v321 = v_u_312
                        local v322 = v_u_312.Time - v_u_312.RecoveryTime * v_u_304 * p313
                        v321.Time = math.max(v322, 0)
                    end
                end
                local v323 = v_u_312.Value.Y
                local v324 = v_u_312.Value.X
                local v325 = Vector3.new(v323, v324, 0)
                local v326 = v_u_305
                local v327 = v325 * math.rad(v326)
                v_u_312.RotationValue = v327
                if not p_u_302.IsDestroyed and (p_u_302.IsEquipped and p_u_302.Identifier == v_u_309) then
                    local v328 = {
                        ["Value"] = v327,
                        ["Damper"] = v_u_306,
                        ["Speed"] = v_u_307
                    }
                    v_u_15.setWeaponRecoil(v328, v_u_308)
                end
            end
        end), "Disconnect", "RecoilConnection")
    end
end
function v_u_1.new(p329, p330, p331, p332, p333, p334, p335, p336, p337, p338, p339, p340, p341)
    -- upvalues: (copy) v_u_6, (ref) v_u_1, (copy) v_u_24, (copy) v_u_57, (copy) v_u_2, (copy) v_u_15, (copy) v_u_23, (copy) v_u_71
    local v342 = v_u_6.new(p329, p330, p331, p332, p333, p334, p335, p336, p337, p338, p339, p340)
    local v343 = v_u_1
    local v_u_344 = setmetatable(v342, v343)
    v_u_344.IsEquipped = false
    local v345 = p341 or {}
    v_u_344.Bullet = v_u_24.new(v_u_344, v_u_344.Properties)
    v_u_344.Capacity = v345.Capacity or v_u_344.Properties.Capacity
    v_u_344.Rounds = v345.Rounds or v_u_344.Properties.Rounds
    v_u_344.RechargeStartTime = v345.RechargeStartTime
    v_u_344.CurrentReloadIdentity = nil
    v_u_344.AlternativeShootingOption = "Default"
    v_u_344.AlternativeSwitchTick = 0
    v_u_344.IsBurstShooting = false
    v_u_344.ShootingHand = "Right"
    v_u_344.HasPendingChargeRequest = false
    v_u_344.IsAlternativeFireHeld = false
    v_u_344.AlternativeFireInputBinding = nil
    v_u_344.IsChargeFiring = false
    v_u_344.CurrentWalkSpeedOverride = nil
    v_u_344.IsAdjustingSuppressor = false
    v_u_344.IsInspectFadingOut = false
    v_u_344.IsInspecting = false
    v_u_344.IsReloading = false
    v_u_344.IsShooting = false
    v_u_344.IsAiming = false
    v_u_344.IsFireHeld = false
    v_u_344.FireInputBinding = nil
    v_u_344.ScopeStartTick = 0
    if v345.IsSuppressed == nil then
        v_u_344.IsSuppressed = v_u_344.Properties.HasSuppressor
    else
        v_u_344.IsSuppressed = v345.IsSuppressed
    end
    v_u_344.IsSniperScoped = false
    v_u_344.ReloadTrackFinishedConnection = nil
    v_u_344.ShootDelayThread = nil
    v_u_344.InspectDelayThread = nil
    v_u_344.CancelDelayThread = nil
    v_u_344.FadeCompleteThread = nil
    v_u_344.ChargeThread = nil
    v_u_344.RechargeThread = nil
    v_u_344.ChargeShootConnection = nil
    v_u_344.CurrentScopeIncrement = 0
    v_u_344.WeaponEquippedTick = 0
    v_u_344.ChargeStartTick = 0
    v_u_344.ShootRequestTick = 0
    v_u_344.ReloadStartTick = 0
    v_u_344.ScopeStartTick = 0
    v_u_344:setupRecoil()
    if v_u_344.Properties.ShootingOptions == "Revolver" then
        if v_u_344.Bullet then
            local v346 = v_u_344.Properties.FireModes
            local v347
            if v346 then
                v347 = v346.Secondary or v346.Primary
            else
                v347 = nil
            end
            local v348 = v347 and v347.Spread or v_u_344.Properties.Spread
            v_u_344.Bullet:setSpreadConfig(v348)
        end
        v_u_57(v_u_344, "Secondary")
    end
    v_u_344.Janitor:Add(function()
        -- upvalues: (copy) v_u_344, (ref) v_u_2, (ref) v_u_15, (ref) v_u_23
        v_u_344:cancelRevolverCharge(false, false)
        v_u_344:stopRevolverSecondaryFire()
        if v_u_344.Bullet then
            v_u_344.Bullet:destroy()
            v_u_344.Bullet = nil
        end
        if v_u_344.IsAiming then
            local v349 = require(v_u_2.Controllers.CaseSceneController)
            local v350 = require(v_u_2.Controllers.MenuSceneController)
            if not (v349.IsActive() or v350.IsActive()) then
                v_u_15.updateCameraFOV(v_u_23.DEFAULT_CAMERA_FOV)
            end
        end
    end)
    if v_u_344.Properties.HasSuppressor then
        v_u_344:createSuppressor()
    end
    if v_u_344.Rounds < (v_u_344.Properties.Rounds or v_u_344.Rounds) then
        v_u_71(v_u_344)
    end
    return v_u_344
end
function v_u_1.destroy(p351)
    -- upvalues: (copy) v_u_6
    if not p351.IsDestroyed then
        p351.IsDestroyed = true
        if p351.ReloadTrackFinishedConnection and p351.ReloadTrackFinishedConnection.Connected then
            p351.ReloadTrackFinishedConnection:Disconnect()
            p351.ReloadTrackFinishedConnection = nil
        end
        if p351.ShootDelayThread then
            task.cancel(p351.ShootDelayThread)
            p351.ShootDelayThread = nil
        end
        if p351.ChargeThread then
            task.cancel(p351.ChargeThread)
            p351.ChargeThread = nil
        end
        if p351.RechargeThread then
            task.cancel(p351.RechargeThread)
            p351.RechargeThread = nil
        end
        if p351.ChargeShootConnection and p351.ChargeShootConnection.Connected then
            p351.ChargeShootConnection:Disconnect()
            p351.ChargeShootConnection = nil
        end
        if p351.InspectDelayThread then
            task.cancel(p351.InspectDelayThread)
            p351.InspectDelayThread = nil
        end
        if p351.CancelDelayThread then
            task.cancel(p351.CancelDelayThread)
            p351.CancelDelayThread = nil
        end
        if p351.FadeCompleteThread then
            task.cancel(p351.FadeCompleteThread)
            p351.FadeCompleteThread = nil
        end
        if p351.Recoil then
            p351.Recoil.RecoveryStartTime = nil
            p351.Recoil.RotationValue = nil
            p351.Recoil.RecoveryValue = nil
            p351.Recoil.RecoveryTime = nil
            p351.Recoil.ActiveFireRate = nil
            p351.Recoil.Function = nil
            p351.Recoil.Functions = nil
            p351.Recoil.Value = nil
            p351.Recoil.Time = nil
            p351.Recoil = nil
        end
        if p351.Bullet then
            p351.Bullet:destroy()
            p351.Bullet = nil
        end
        p351.Janitor:Destroy()
        p351.Janitor = nil
        p351.AlternativeShootingOption = nil
        p351.AlternativeSwitchTick = nil
        p351.CurrentReloadIdentity = nil
        p351.CurrentScopeIncrement = nil
        p351.WeaponEquippedTick = nil
        p351.ChargeStartTick = nil
        p351.ShootRequestTick = nil
        p351.ReloadStartTick = nil
        p351.ShootingHand = nil
        p351.CurrentWalkSpeedOverride = nil
        p351.HasPendingChargeRequest = nil
        p351.IsAlternativeFireHeld = nil
        p351.AlternativeFireInputBinding = nil
        p351.IsChargeFiring = nil
        p351.ChargeThread = nil
        p351.ChargeShootConnection = nil
        v_u_6.destroy(p351)
    end
end
return v_u_1
