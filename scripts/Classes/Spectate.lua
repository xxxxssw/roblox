-- MODULESCRIPT: Spectate
-- Original Path: game.BAC - 30366.Classes.Spectate
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
game:GetService("RunService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v2.Controllers.CameraController)
local v_u_7 = require(v2.Controllers.DataController)
local v_u_8 = require(v2.Database.Custom.Constants)
local v_u_9 = require(v2.Database.Components.Common.RemoveFromArray)
local v_u_10 = require(v2.Components.Common.VFXLibary.CreateMuzzleFlash.Camera)
local v_u_11 = require(v2.Components.Common.VFXLibary.CreateZeusBeam)
local v_u_12 = require(v2.Components.Common.VFXLibary.CreateTracer)
local v_u_13 = require(v2.Classes.WeaponComponent)
local v_u_14 = require(v2.Classes.Freecam)
local v_u_15 = require(v2.Components.Weapon.Classes.Bullet)
local v_u_16 = require(v2.Shared.Janitor)
local v_u_17 = require(v2.Packages.Signal)
local v_u_18 = require(v2.Shared.Spring)
local v_u_19 = require(v2.Packages.Sift)
local v_u_20 = require(v2.Database.Security.Remotes)
local v_u_21 = workspace:WaitForChild("Characters")
local v_u_22 = workspace:WaitForChild("Debris")
local v_u_23 = workspace.CurrentCamera
local v_u_24 = RaycastParams.new()
v_u_24.FilterType = Enum.RaycastFilterType.Exclude
v_u_24.IgnoreWater = true
local v_u_25 = {
    ["Heavy Swing"] = true,
    ["BackStab"] = true,
    ["Swing1"] = true,
    ["Swing2"] = true,
    ["Inspect"] = true,
    ["Reload"] = true,
    ["Throw"] = true,
    ["Use"] = true
}
local v_u_26 = {
    ["StartThrow"] = true
}
local v_u_27 = {
    ["NoSuppressorShoot"] = true,
    ["ShootRight"] = true,
    ["ShootLeft"] = true,
    ["Shoot"] = true,
    ["SlamFire"] = true
}
local function v_u_36(p28, p29)
    if p29:IsA("BasePart") then
        local v30 = p28.Transparencies[p29] or {
            ["Transparency"] = p29.Transparency,
            ["Textures"] = {}
        }
        for _, v31 in p29:GetChildren() do
            if v31:IsA("Texture") and not table.find(v30.Textures, v31) then
                local v32 = v30.Textures
                table.insert(v32, v31)
                v31.Parent = nil
            end
        end
        if p29.Transparency < 1 then
            p29.Transparency = 1
        end
        p28.Transparencies[p29] = v30
    elseif p29:IsA("Texture") then
        local v33 = p29.Parent
        if v33 and v33:IsA("BasePart") then
            local v34 = p28.Transparencies[v33] or {
                ["Transparency"] = v33.Transparency,
                ["Textures"] = {}
            }
            if not table.find(v34.Textures, p29) then
                local v35 = v34.Textures
                table.insert(v35, p29)
            end
            p29.Parent = nil
            p28.Transparencies[v33] = v34
            return
        end
    elseif p29:IsA("BillboardGui") then
        p29.Enabled = false
    end
end
local function v_u_42(p37)
    if p37 and (p37.Properties and p37.Properties.RechargeTime) then
        local v38 = p37.Properties.Rounds
        local v39 = tonumber(v38) or 0
        local v40 = p37.Rounds
        local v41 = (tonumber(v40) or v39) - 1
        p37.Rounds = math.max(v41, 0)
        p37.RechargeStartTime = workspace:GetServerTimeNow()
    end
end
local function v_u_50(p43)
    -- upvalues: (copy) v_u_23, (copy) v_u_22, (copy) v_u_24, (copy) v_u_12, (copy) v_u_11, (copy) v_u_7, (copy) v_u_5, (copy) v_u_10
    v_u_24.FilterDescendantsInstances = { p43.Player.Character, v_u_23, v_u_22 }
    local v44 = p43.WeaponComponent
    if v44 and v44.Bullet then
        local v45 = v44.Properties.AimingOptions
        local v46 = v44.IsAiming
        if v44.Bullet._updateShotSpread then
            v44.Bullet:_updateShotSpread(v45, v46)
        end
    end
    local v47 = workspace:Raycast(v_u_23.CFrame.Position, v_u_23.CFrame.LookVector * p43.WeaponComponent.Properties.Range, v_u_24)
    local v48 = v47 and v47.Distance or p43.WeaponComponent.Properties.Range
    local v49 = p43.WeaponComponent.Viewmodel.Model.Interactables:FindFirstChild("MuzzlePart")
    if v49 then
        v_u_12(v48, v49.Position, v_u_23.CFrame.LookVector)
        if p43.WeaponComponent.Properties.MuzzleType == "Zeus x27" then
            v_u_11(v49)
        end
        if v_u_7.Get(v_u_5, "Settings.Video.Presets.Muzzle Flash") ~= false then
            v_u_10(v49, p43.WeaponComponent.Name, p43.WeaponComponent.Properties.HasSuppressor and p43.CurrentEquipped.IsSuppressed and "Suppressor" or nil)
        end
    end
end
function v_u_1.UpdateCameraCFrame(p51, p52)
    -- upvalues: (copy) v_u_18
    if not (p51.CameraPositionSpring and p51.CameraRotationSpring) then
        p51.CameraRotationSpring = v_u_18.new(1, 35, p52.LookVector)
        p51.CameraPositionSpring = v_u_18.new(1, 35, p52.Position)
    end
    p51.CameraRotationSpring:setGoal(p52.LookVector)
    p51.CameraPositionSpring:setGoal(p52.Position)
end
function v_u_1.UpdateSuppressorState(p53, p54)
    local v55 = p54.Viewmodel.Model:FindFirstChild("Silencer", true)
    if v55 and p54.Properties.HasSuppressor then
        v55.Transparency = p53.CurrentEquipped.IsSuppressed and 0 or 1
    end
end
function v_u_1.UpdateSuppressor(p56)
    if p56.WeaponComponent and p56.WeaponComponent.Viewmodel then
        local v_u_57 = p56.WeaponComponent.Viewmodel.Model:FindFirstChild("Silencer", true)
        if v_u_57 then
            local v60 = table.freeze({
                {
                    ["AnimationTrack"] = p56.WeaponComponent.Viewmodel.Animation:getAnimation("RemoveSuppressor"),
                    ["State"] = false,
                    ["Event"] = function(p58)
                        -- upvalues: (copy) v_u_57
                        return p58:GetMarkerReachedSignal("ScrewOnEnd"):Connect(function()
                            -- upvalues: (ref) v_u_57
                            v_u_57.Transparency = 1
                        end)
                    end
                },
                {
                    ["AnimationTrack"] = p56.WeaponComponent.Viewmodel.Animation:getAnimation("AddSuppressor"),
                    ["State"] = true,
                    ["Event"] = function(p_u_59)
                        -- upvalues: (copy) v_u_57
                        return p_u_59:GetPropertyChangedSignal("IsPlaying"):Connect(function()
                            -- upvalues: (copy) p_u_59, (ref) v_u_57
                            if p_u_59.IsPlaying then
                                task.delay(0.016666666666666666, function()
                                    -- upvalues: (ref) v_u_57
                                    v_u_57.Transparency = 0
                                end)
                            end
                        end)
                    end
                }
            })
            for _, v_u_61 in ipairs(v60) do
                if p56.WeaponComponent and p56.WeaponComponent.Janitor then
                    p56.WeaponComponent.Janitor:Add(v_u_61.Event(v_u_61.AnimationTrack))
                    p56.WeaponComponent.Janitor:Add(v_u_61.AnimationTrack.Ended:Connect(function()
                        -- upvalues: (copy) v_u_57, (copy) v_u_61
                        if v_u_57.Transparency < 1 == v_u_61.State then
                            v_u_57.Transparency = v_u_61.State and 0 or 1
                        end
                    end))
                end
            end
            p56:UpdateSuppressorState(p56.WeaponComponent)
        end
    else
        return
    end
end
function v_u_1.Switch(p62, p63)
    -- upvalues: (copy) v_u_23, (copy) v_u_6, (copy) v_u_8, (copy) v_u_14, (copy) v_u_20
    if p62.Humanoid and p62.Humanoid.Health > 0 then
        p62.PerspectiveState = p63
        if p62.FreecamInstance then
            p62.FreecamInstance:Stop()
            p62.FreecamInstance:Destroy()
            p62.FreecamInstance = nil
        end
        if p62.PerspectiveState == "First-Person" then
            p62.TransparencyState = true
            p62:SetCharacterTransparency(p62.TransparencyState)
            v_u_23.CameraType = Enum.CameraType.Scriptable
            v_u_23.CameraSubject = p62.Humanoid
            if p62.CurrentEquipped then
                p62:SetEquipped(p62.CurrentEquipped, false)
            end
            p62:UpdateScopeState()
            v_u_6.setPerspective(true, false)
        elseif p62.PerspectiveState == "Third-Person" then
            p62.TransparencyState = false
            p62:SetCharacterTransparency(p62.TransparencyState)
            v_u_23.CameraType = Enum.CameraType.Follow
            v_u_23.CameraSubject = p62.Humanoid
            if p62.WeaponComponent then
                p62.WeaponComponent.Janitor:Destroy()
                p62.WeaponComponent = nil
            end
            v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
            v_u_6.setPerspective(false, false)
        elseif p62.PerspectiveState == "Free-Cam" then
            p62.TransparencyState = false
            p62:SetCharacterTransparency(p62.TransparencyState)
            if p62.WeaponComponent then
                p62.WeaponComponent.Janitor:Destroy()
                p62.WeaponComponent = nil
            end
            v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
            if not p62.FreecamInstance then
                p62.FreecamInstance = p62.Janitor:Add(v_u_14.new())
            end
            if p62.FreecamInstance then
                p62.FreecamInstance:Start()
            end
        end
        v_u_20.Spectate.SetSpectatePerspective.Send(p62.PerspectiveState)
    end
end
function v_u_1.SetEquipped(p_u_64, p65, p66)
    -- upvalues: (copy) v_u_13, (copy) v_u_15
    local v67 = p_u_64.WeaponComponent
    if v67 then
        v67 = p_u_64.WeaponComponent.Identifier
    end
    p_u_64.CurrentEquipped = p65
    if v67 == p65.Identifier then
        local v68 = p_u_64.WeaponComponent
        if v68 then
            v68.IsSuppressed = p65.IsSuppressed
            v68.Rounds = p65.Rounds
            v68.Capacity = p65.Capacity
            v68.RechargeStartTime = p65.RechargeStartTime
        end
        p_u_64:UpdateSuppressorState(p_u_64.WeaponComponent)
    else
        if p_u_64.WeaponComponent then
            p_u_64:SetWeaponViewmodelTransparency(false)
            p_u_64.WeaponComponent.Janitor:Destroy()
            p_u_64.WeaponComponent = nil
        end
        if p_u_64.CurrentEquipped and p_u_64.PerspectiveState == "First-Person" then
            local v69, v70 = pcall(function()
                -- upvalues: (ref) v_u_13, (copy) p_u_64
                return v_u_13.new(p_u_64.Player, p_u_64.CurrentEquipped.Identifier, p_u_64.CurrentEquipped._id, 1, p_u_64.CurrentEquipped.Name, p_u_64.CurrentEquipped.Skin, p_u_64.CurrentEquipped.Float, p_u_64.CurrentEquipped.StatTrack, p_u_64.CurrentEquipped.NameTag, p_u_64.CurrentEquipped.Charm, p_u_64.CurrentEquipped.Stickers)
            end)
            if not (v69 and v70) then
                warn((("[Spectate] Failed to create viewmodel for %* (%* | %*): %*"):format(p_u_64.Player.Name, p_u_64.CurrentEquipped.Name, p_u_64.CurrentEquipped.Skin, (tostring(v70)))))
                p_u_64.TransparencyState = false
                if not pcall(function()
                    -- upvalues: (copy) p_u_64
                    p_u_64:SetCharacterTransparency(false)
                end) then
                    warn("[Spectate] Failed to restore character transparency after viewmodel creation failure")
                end
                p_u_64:Switch("Third-Person")
                p_u_64.CurrentEquippedChanged:Fire(p_u_64.CurrentEquipped)
                return
            end
            if v70.Properties and v70.Properties.Spread then
                v70.Bullet = v_u_15.new(v70, v70.Properties)
            end
            if v70 then
                v70.IsSuppressed = p65.IsSuppressed
                v70.Rounds = p65.Rounds
                v70.Capacity = p65.Capacity
                v70.RechargeStartTime = p65.RechargeStartTime
            end
            p_u_64.WeaponComponent = v70
            p_u_64.TransparencyState = true
            p_u_64:SetCharacterTransparency(p_u_64.TransparencyState)
            if p_u_64.WeaponComponent and p_u_64.WeaponComponent.Viewmodel then
                p_u_64.WeaponComponent.Viewmodel:equip(not p66)
                if p_u_64.WeaponComponent.Properties.HasSuppressor then
                    p_u_64:UpdateSuppressor()
                end
            end
            p_u_64:UpdateScopeState()
        end
        p_u_64.CurrentEquippedChanged:Fire(p_u_64.CurrentEquipped)
    end
end
function v_u_1.UpdateScopeState(p71)
    -- upvalues: (copy) v_u_6, (copy) v_u_8
    if p71.PerspectiveState == "First-Person" then
        if p71.CurrentEquipped then
            local v72 = p71.CurrentEquipped.Name
            local v73 = v72 == "AWP" and true or v72 == "SSG 08"
            local v74 = v72 == "AUG" and true or v72 == "SG 553"
            local v75 = p71.Player:GetAttribute("ScopeIncrement") or 0
            local v76 = v75 > 0
            if v73 then
                if p71.WeaponComponent and (p71.WeaponComponent.Viewmodel and p71.WeaponComponent.Viewmodel.Bobble) then
                    local v77 = p71.WeaponComponent.Viewmodel.Bobble.ScopeReticlePart
                    local v78 = v77 and v77:FindFirstChildOfClass("SurfaceGui")
                    if v78 then
                        v78.Enabled = false
                    end
                end
                if v76 and v75 <= 2 then
                    v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV - ({ 37, 60 })[v75])
                    if p71.WeaponComponent and p71.WeaponComponent.Viewmodel then
                        p71:SetWeaponViewmodelTransparency(true)
                        return
                    end
                else
                    v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
                    if p71.WeaponComponent and p71.WeaponComponent.Viewmodel then
                        p71:SetWeaponViewmodelTransparency(false)
                        return
                    end
                end
            elseif v74 then
                local v79 = p71.WeaponComponent
                if v79 then
                    v79 = p71.WeaponComponent.Viewmodel
                end
                if v79 then
                    if v76 then
                        if not v79.Hidden then
                            v79:hide()
                        end
                        if v79.Bobble and (v79.Bobble.Scope and v79.Bobble.ScopeReticlePart) then
                            v79:aim()
                        end
                        v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV - 15)
                    else
                        if v79.Hidden then
                            v79:unhide()
                        end
                        if v79.Bobble and (v79.Bobble.Scope and v79.Bobble.ScopeReticlePart) then
                            v79:unaim()
                        end
                        v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
                    end
                end
            else
                v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
                if p71.WeaponComponent and p71.WeaponComponent.Viewmodel then
                    p71:SetWeaponViewmodelTransparency(false)
                end
            end
        end
    else
        return
    end
end
function v_u_1.SetWeaponViewmodelTransparency(p80, p81)
    if p80.WeaponComponent and (p80.WeaponComponent.Viewmodel and p80.WeaponComponent.Viewmodel.Model) then
        local v82 = p80.WeaponComponent.Viewmodel.Model
        if not p80.WeaponTransparencyCache then
            p80.WeaponTransparencyCache = {}
        end
        for _, v83 in ipairs(v82:GetDescendants()) do
            if v83:IsA("BasePart") and (v83.Name ~= "Right Arm" and (v83.Name ~= "Left Arm" and (v83.Name ~= "HumanoidRootPart" and v83.Name ~= "ViewmodelLight"))) then
                if p81 then
                    if not p80.WeaponTransparencyCache[v83] then
                        p80.WeaponTransparencyCache[v83] = v83.Transparency
                    end
                    v83.Transparency = 1
                else
                    local v84 = p80.WeaponTransparencyCache[v83]
                    if v84 ~= nil then
                        v83.Transparency = v84
                        p80.WeaponTransparencyCache[v83] = nil
                    end
                end
            end
        end
    end
end
function v_u_1.HideDebrisWeapons(p85)
    -- upvalues: (copy) v_u_22, (copy) v_u_36
    if p85.TransparencyState then
        local v86 = p85.Player.Name
        local v87 = v_u_22:FindFirstChild(v86 .. "_Weapon")
        if v87 then
            for _, v88 in ipairs(v87:GetDescendants()) do
                v_u_36(p85, v88)
            end
        end
        local v89 = v_u_22:FindFirstChild(v86 .. "_WeaponAttachments")
        if v89 then
            for _, v90 in ipairs(v89:GetDescendants()) do
                v_u_36(p85, v90)
            end
        end
    end
end
function v_u_1.SetCharacterTransparency(p_u_91, p92)
    -- upvalues: (copy) v_u_36, (copy) v_u_16, (copy) v_u_22, (copy) v_u_9
    local v93 = p_u_91.Character:GetDescendants()
    local function v_u_97(p94)
        -- upvalues: (ref) v_u_36, (copy) p_u_91
        for _, v95 in ipairs(p94:GetDescendants()) do
            v_u_36(p_u_91, v95)
        end
        if p_u_91.TransparencyJanitor then
            p_u_91.TransparencyJanitor:Add(p94.DescendantAdded:Connect(function(p96)
                -- upvalues: (ref) p_u_91, (ref) v_u_36
                if p_u_91.TransparencyState then
                    v_u_36(p_u_91, p96)
                end
            end))
        end
    end
    if p92 then
        if not p_u_91.TransparencyJanitor then
            local v98 = p_u_91.Janitor:Add(v_u_16.new())
            p_u_91.TransparencyJanitor = v98
            v98:Add(p_u_91.Character.DescendantAdded:Connect(function(p99)
                -- upvalues: (copy) p_u_91, (ref) v_u_36
                if p_u_91.TransparencyState then
                    v_u_36(p_u_91, p99)
                end
            end))
            v98:Add(v_u_22.ChildAdded:Connect(function(p100)
                -- upvalues: (copy) p_u_91, (copy) v_u_97
                if p_u_91.TransparencyState then
                    local v101 = p_u_91.Player.Name
                    if p100.Name == v101 .. "_Weapon" or p100.Name == v101 .. "_WeaponAttachments" then
                        v_u_97(p100)
                    end
                end
            end))
        end
        for _, v102 in ipairs(v93) do
            v_u_36(p_u_91, v102)
        end
        local v103 = p_u_91.Player.Name
        local v104 = v_u_22:FindFirstChild(v103 .. "_Weapon")
        if v104 then
            v_u_97(v104)
        end
        local v105 = v_u_22:FindFirstChild(v103 .. "_WeaponAttachments")
        if v105 then
            v_u_97(v105)
            return
        end
    else
        if p_u_91.TransparencyJanitor then
            p_u_91.TransparencyJanitor:Destroy()
            p_u_91.TransparencyJanitor = nil
        end
        for v_u_106, v107 in pairs(p_u_91.Transparencies) do
            if v_u_106 and v_u_106.Parent then
                v_u_106.Transparency = v107.Transparency
                v_u_9(v107.Textures, function(_, p108)
                    -- upvalues: (copy) v_u_106
                    p108.Parent = v_u_106
                    return true
                end)
            end
        end
        for _, v109 in ipairs(v93) do
            if v109:IsA("BillboardGui") then
                v109.Enabled = true
            end
        end
    end
end
function v_u_1.AddSpectateEvent(p110, p111)
    -- upvalues: (copy) v_u_50, (copy) v_u_27, (copy) v_u_42, (copy) v_u_26, (copy) v_u_25
    if p110.WeaponComponent and p110.WeaponComponent.Viewmodel then
        local v112 = p110.WeaponComponent.Viewmodel
        if v112 then
            v112 = p110.WeaponComponent.Viewmodel.Animation
        end
        local v113 = p110.WeaponComponent
        if p111 == "RevolverChargeStart" then
            if v113 and (v113.Bullet and v113.Properties.ShootingOptions == "Revolver") then
                local v114 = v113.Properties.FireModes
                if v114 then
                    v114 = v114.Primary
                end
                local v115 = v114 and v114.Spread or v113.Properties.Spread
                v113.Bullet:setSpreadConfig(v115)
            end
            v113.IsChargeFiring = true
            v113.ChargeStartTick = tick()
            v112:stopAnimations()
            v112:play("Shoot")
            v112:play("Idle")
            return
        end
        if p111 == "RevolverChargeCancel" then
            if v113 then
                if v113 and (v113.Bullet and v113.Properties.ShootingOptions == "Revolver") then
                    local v116 = v113.Properties.FireModes
                    if v116 then
                        v116 = v116.Secondary or v116.Primary
                    end
                    local v117 = v116 and v116.Spread or v113.Properties.Spread
                    v113.Bullet:setSpreadConfig(v117)
                end
                v113.IsChargeFiring = false
                v113.ChargeStartTick = 0
            end
            v112:stopAnimations()
            v112:play("Idle")
            return
        end
        if p111 == "RevolverChargeRelease" then
            if v113 and (v113.Bullet and v113.Properties.ShootingOptions == "Revolver") then
                local v118 = v113.Properties.FireModes
                if v118 then
                    v118 = v118.Primary
                end
                local v119 = v118 and v118.Spread or v113.Properties.Spread
                v113.Bullet:setSpreadConfig(v119)
            end
            v_u_50(p110)
            if v113 then
                if v113 and (v113.Bullet and v113.Properties.ShootingOptions == "Revolver") then
                    local v120 = v113.Properties.FireModes
                    if v120 then
                        v120 = v120.Secondary or v120.Primary
                    end
                    local v121 = v120 and v120.Spread or v113.Properties.Spread
                    v113.Bullet:setSpreadConfig(v121)
                end
                v113.IsChargeFiring = false
                v113.ChargeStartTick = 0
            end
        end
        if v_u_27[p111] then
            if v113.Properties.ShootingOptions == "Revolver" then
                local v122 = p111 == "SlamFire" and "Secondary" or "Primary"
                if v113 and (v113.Bullet and v113.Properties.ShootingOptions == "Revolver") then
                    local v123 = v113.Properties.FireModes
                    if v123 then
                        v123 = v122 == "Secondary" and v123.Secondary or v123.Primary
                    end
                    local v124 = v123 and v123.Spread or v113.Properties.Spread
                    v113.Bullet:setSpreadConfig(v124)
                end
                if v122 == "Secondary" then
                    if v113 then
                        if v113 and (v113.Bullet and v113.Properties.ShootingOptions == "Revolver") then
                            local v125 = v113.Properties.FireModes
                            if v125 then
                                v125 = v125.Secondary or v125.Primary
                            end
                            local v126 = v125 and v125.Spread or v113.Properties.Spread
                            v113.Bullet:setSpreadConfig(v126)
                        end
                        v113.IsChargeFiring = false
                        v113.ChargeStartTick = 0
                    end
                else
                    v113.IsChargeFiring = false
                    v113.ChargeStartTick = 0
                end
            end
            v_u_42(v113)
            local v127 = not v112:getAnimation(p111) and "Shoot" or p111
            v112:stopAnimations()
            v112:play(v127)
            v112:play("Idle")
            v_u_50(p110)
            if v113.Properties.ShootingOptions == "Revolver" and p111 ~= "SlamFire" then
                if v113 then
                    if v113 and (v113.Bullet and v113.Properties.ShootingOptions == "Revolver") then
                        local v128 = v113.Properties.FireModes
                        if v128 then
                            v128 = v128.Secondary or v128.Primary
                        end
                        local v129 = v128 and v128.Spread or v113.Properties.Spread
                        v113.Bullet:setSpreadConfig(v129)
                    end
                    v113.IsChargeFiring = false
                    v113.ChargeStartTick = 0
                end
            end
        else
            if p111 == "Remove Suppressor" or p111 == "Add Suppressor" then
                v112:stopAnimations()
                v112:play(string.gsub(p111, " ", ""))
                v112:play("Idle")
                return
            end
            if p111 == "Cancel Plant" then
                v112:stopAnimations()
                v112:play("Idle")
                return
            end
            if p111 == "Switch Fire Mode" then
                v112:stopAnimations()
                v112:play("Switch")
                v112:play("Idle")
                return
            end
            if v_u_26[p111] then
                v112:stopAnimations()
                v112:play("StartThrow")
                local v130 = v112:play("ThrowIdle")
                if v130 then
                    v130.Looped = true
                    return
                end
            else
                if p111 == "CancelThrow" then
                    v112:stopAnimations()
                    v112:play("Idle")
                    return
                end
                if v_u_25[p111] then
                    v112:stopAnimations()
                    v112:play(p111)
                    v112:play("Idle")
                end
            end
        end
    end
end
local function v_u_148(p131, p132)
    if p131.PerspectiveState == "First-Person" then
        if p131.CurrentEquipped then
            local v133 = p131.CurrentEquipped.Name
            if v133 == "AUG" and true or v133 == "SG 553" then
                if (p131.Player:GetAttribute("ScopeIncrement") or 0) > 0 then
                    if p131.WeaponComponent and p131.WeaponComponent.Viewmodel then
                        local v134 = p131.WeaponComponent.Viewmodel
                        if v134.Bobble and v134.Bobble.IsAiming then
                            local v135 = p131.WeaponComponent
                            if v135 and v135.Bullet then
                                local v136 = v135.Bullet:getBaseSpread() or 0
                                local v137 = v136 - (p131.LastSpreadValue or 0)
                                local v138 = math.abs(v137)
                                local v139 = (p131.LastScopeUpdateTime or 0) + p132
                                if v138 < 0.01 and v139 < 0.03333333333333333 then
                                    p131.LastScopeUpdateTime = v139
                                    return
                                else
                                    p131.LastScopeUpdateTime = 0
                                    p131.LastSpreadValue = v136
                                    local v140 = v134.Bobble.ScopeReticlePart
                                    if v140 then
                                        local v141 = p131.ScopeUICache
                                        if v141 and v141.SurfaceGui == v140 then
                                            local v142 = v141.Crosshair
                                            if v142 and v142.Parent then
                                                local v143 = math.clamp(v136, 0, 2) * 2
                                                v142.Size = UDim2.fromScale(v143 + 2.5, v143 + 2.5)
                                                v142.Position = UDim2.fromScale(0.5, 0.5)
                                                return
                                            end
                                            p131.ScopeUICache = nil
                                        end
                                        local v144 = v140:FindFirstChildOfClass("SurfaceGui")
                                        if v144 then
                                            local v145 = v144:FindFirstChild("Frame")
                                            if v145 then
                                                local v146 = v145:FindFirstChild("Frame")
                                                if v146 then
                                                    p131.ScopeUICache = {
                                                        ["Crosshair"] = v146,
                                                        ["SurfaceGui"] = v144,
                                                        ["Frame"] = v145
                                                    }
                                                    local v147 = math.clamp(v136, 0, 2) * 2
                                                    v146.Size = UDim2.fromScale(v147 + 2.5, v147 + 2.5)
                                                    v146.Position = UDim2.fromScale(0.5, 0.5)
                                                end
                                            else
                                                return
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
                        else
                            return
                        end
                    else
                        return
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.Render(p149, p150)
    -- upvalues: (copy) v_u_23, (copy) v_u_148
    if p149.PerspectiveState ~= "Free-Cam" then
        if p149.CameraPositionSpring and p149.CameraRotationSpring then
            p149.CameraPositionSpring:update(p150)
            p149.CameraRotationSpring:update(p150)
            if p149.PerspectiveState == "First-Person" then
                v_u_23.CFrame = CFrame.lookAt(p149.CameraPositionSpring:getPosition(), p149.CameraPositionSpring:getPosition() + p149.CameraRotationSpring:getPosition())
                if p149.WeaponComponent and p149.WeaponComponent.Viewmodel then
                    p149.WeaponComponent.Viewmodel:render(p150)
                end
                local v151 = p149.WeaponComponent
                if v151 and (v151.Bullet and v151.Bullet.updateSpread) then
                    v151.Bullet:updateSpread(p150)
                end
                v_u_148(p149, p150)
            end
        end
    end
end
function v_u_1.new(p152, p153, p154)
    -- upvalues: (copy) v_u_1, (copy) v_u_16, (copy) v_u_17, (copy) v_u_5, (copy) v_u_3, (copy) v_u_20, (copy) v_u_21, (copy) v_u_19, (copy) v_u_6, (copy) v_u_8
    local v155 = v_u_1
    local v_u_156 = setmetatable({}, v155)
    v_u_156.Janitor = v_u_16.new()
    v_u_156.CurrentEquippedChanged = v_u_156.Janitor:Add(v_u_17.new())
    v_u_156.StopSpectating = v_u_156.Janitor:Add(v_u_17.new())
    v_u_156.Humanoid = p154
    v_u_156.Character = p153
    v_u_156.Player = p152
    v_u_156.CurrentPlayerTeam = p152:GetAttribute("Team")
    v_u_156.PerspectiveState = "First-Person"
    v_u_156.TransparencyState = true
    v_u_156.FreecamInstance = nil
    v_u_156.Transparencies = {}
    v_u_156.TransparencyJanitor = nil
    v_u_156.WeaponTransparencyCache = {}
    v_u_156.ScopeUICache = nil
    v_u_156.LastScopeUpdateTime = 0
    v_u_156.LastSpreadValue = 0
    v_u_156:SetCharacterTransparency(v_u_156.TransparencyState)
    v_u_156:Switch(v_u_156.PerspectiveState)
    v_u_5.ReplicationFocus = v_u_156.Humanoid
    v_u_156.Janitor:Add(function()
        -- upvalues: (ref) v_u_5
        v_u_5.ReplicationFocus = nil
    end)
    if v_u_156.Player:GetAttribute("CurrentEquipped") then
        v_u_156:SetEquipped(v_u_3:JSONDecode((v_u_156.Player:GetAttribute("CurrentEquipped"))), false)
    end
    v_u_156.Janitor:Add(v_u_156.Player:GetAttributeChangedSignal("CurrentEquipped"):Connect(function()
        -- upvalues: (copy) v_u_156, (ref) v_u_3
        local v157 = v_u_156.Player:GetAttribute("CurrentEquipped")
        if v157 then
            v_u_156:SetEquipped(v_u_3:JSONDecode(v157), true)
            task.defer(function()
                -- upvalues: (ref) v_u_156
                if v_u_156.TransparencyState and v_u_156.PerspectiveState == "First-Person" then
                    v_u_156:HideDebrisWeapons()
                end
            end)
        end
    end))
    if v_u_156.Character:GetAttribute("CameraCFrame") then
        v_u_156:UpdateCameraCFrame((v_u_156.Character:GetAttribute("CameraCFrame")))
    end
    v_u_156.Janitor:Add(v_u_156.Character:GetAttributeChangedSignal("CameraCFrame"):Connect(function()
        -- upvalues: (copy) v_u_156
        v_u_156:UpdateCameraCFrame((v_u_156.Character:GetAttribute("CameraCFrame")))
    end))
    if v_u_156.Player:GetAttribute("ScopeIncrement") then
        v_u_156:UpdateScopeState()
    end
    v_u_156.Janitor:Add(v_u_156.Player:GetAttributeChangedSignal("ScopeIncrement"):Connect(function()
        -- upvalues: (copy) v_u_156
        v_u_156:UpdateScopeState()
    end))
    if v_u_156.Humanoid.Health <= 0 then
        task.defer(function()
            -- upvalues: (copy) v_u_156
            v_u_156.StopSpectating:Fire()
        end)
    end
    v_u_156.Janitor:Add(v_u_156.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
        -- upvalues: (copy) v_u_156
        if v_u_156.Humanoid and v_u_156.Humanoid.Health <= 0 then
            v_u_156.StopSpectating:Fire()
        end
    end))
    if v_u_156.Character:GetAttribute("Dead") then
        task.defer(function()
            -- upvalues: (copy) v_u_156
            v_u_156.StopSpectating:Fire()
        end)
    end
    v_u_156.Janitor:Add(v_u_156.Character:GetAttributeChangedSignal("Dead"):Connect(function()
        -- upvalues: (copy) v_u_156
        if v_u_156.Character:GetAttribute("Dead") then
            v_u_156.StopSpectating:Fire()
        end
    end))
    v_u_156.Janitor:Add(v_u_20.UI.UIPlayerKilled.Listen(function(p158)
        -- upvalues: (copy) v_u_156
        local v159 = p158.Victim
        if v159 then
            local v160 = v_u_156.Player.UserId
            if tostring(v160) == v159 then
                v_u_156.StopSpectating:Fire()
            end
        end
    end))
    v_u_156.Janitor:Add(v_u_156.Character.AncestryChanged:Connect(function(_, p161)
        -- upvalues: (ref) v_u_21, (copy) v_u_156
        if not (p161 and p161:IsDescendantOf(v_u_21)) then
            v_u_156.StopSpectating:Fire()
        end
    end))
    v_u_156.Janitor:Add(function()
        -- upvalues: (copy) v_u_156, (ref) v_u_19, (ref) v_u_6, (ref) v_u_8
        v_u_156.TransparencyState = false
        if v_u_19.Dictionary.count(v_u_156.Transparencies) > 0 then
            v_u_156:SetCharacterTransparency(v_u_156.TransparencyState)
        end
        v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
    end)
    v_u_156.Janitor:Add(function()
        -- upvalues: (copy) v_u_156
        if v_u_156.WeaponComponent then
            v_u_156.WeaponComponent.Janitor:Destroy()
            v_u_156.WeaponComponent = nil
        end
        v_u_156.WeaponTransparencyCache = {}
        v_u_156.LastScopeUpdateTime = 0
        v_u_156.LastSpreadValue = 0
        v_u_156.ScopeUICache = nil
    end)
    v_u_156.Janitor:Add(function()
        -- upvalues: (copy) v_u_156
        if v_u_156.FreecamInstance then
            v_u_156.FreecamInstance:Stop()
            v_u_156.FreecamInstance:Destroy()
            v_u_156.FreecamInstance = nil
        end
    end)
    return v_u_156
end
function v_u_1.Destroy(p162)
    p162.Janitor:Destroy()
end
return v_u_1
