-- MODULESCRIPT: Viewmodel
-- Original Path: game.BAC - 19589.Classes.WeaponComponent.Classes.Viewmodel
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("ReplicatedFirst")
local v_u_4 = game:GetService("HttpService")
local v_u_5 = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u_6 = require(v_u_2.Controllers.DataController)
local v_u_7 = require(v_u_2.Database.Components.Common.AttachGlovesToViewmodel)
local v_u_8 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_9 = require(v_u_2.Classes.Sound)
local v_u_10 = require(v_u_2.Shared.Janitor)
local v_u_11 = require(v_u_2.Database.Security.Router)
local v_u_12 = require(script.Classes.Animation)
local v_u_13 = require(script.Classes.Bobble)
local v_u_14 = workspace.CurrentCamera
local function v_u_22(p15, p16)
    local v17 = p15:GetDescendants()
    for _, v18 in ipairs(v17) do
        if v18:IsA("BasePart") then
            local v19 = v18:GetAttribute("HiddenTransparency")
            if p16 then
                local v20 = v18.Transparency
                v18.Transparency = 1
                if not v19 then
                    v18:SetAttribute("HiddenTransparency", v20)
                end
            elseif v19 then
                v18.Transparency = v19
            end
        elseif v18:IsA("Texture") then
            if p16 then
                if v18.Transparency < 1 then
                    v18:SetAttribute("HiddenTransparency", v18.Transparency)
                    v18.Transparency = 1
                end
            else
                local v21 = v18:GetAttribute("HiddenTransparency")
                if v21 ~= nil then
                    v18.Transparency = v21
                    v18:SetAttribute("HiddenTransparency", nil)
                end
            end
        end
    end
end
local function v_u_26(p23, p24)
    for _, v25 in pairs(p23:GetDescendants()) do
        if v25:IsA("MeshPart") then
            v25.Transparency = p24 == true and 0 or 1
        elseif v25:IsA("SurfaceGui") then
            v25.Enabled = p24
        end
    end
end
local function v_u_30(p27)
    if p27 then
        local v28 = p27:FindFirstChild("Interactables")
        if v28 then
            v28 = v28:FindFirstChild("Charge", true)
        end
        if v28 then
            v28 = v28:FindFirstChildOfClass("SurfaceGui")
        end
        if v28 then
            local v29 = v28:FindFirstChild("Frame")
            if v29 and v29:IsA("Frame") then
                return v29
            else
                return v28:FindFirstChildWhichIsA("Frame")
            end
        else
            return nil
        end
    else
        return nil
    end
end
local function v_u_34(p31)
    if p31 then
        local v32 = p31:FindFirstChild("Interactables")
        if v32 then
            v32 = v32:FindFirstChild("Charge", true)
        end
        if v32 then
            v32 = v32:FindFirstChildOfClass("SurfaceGui")
        end
        if v32 then
            local v33 = v32:FindFirstChild("TextLabel")
            if v33 and v33:IsA("TextLabel") then
                return v33
            else
                return v32:FindFirstChildWhichIsA("TextLabel")
            end
        else
            return nil
        end
    else
        return nil
    end
end
local function v_u_47(p35)
    if not p35 then
        return nil
    end
    local v36 = p35.Properties
    if not v36 then
        return nil
    end
    local v37 = v36.RechargeTime
    local v38 = v36.Rounds
    if not v37 or (not v38 or v38 <= 0) then
        return nil
    end
    local v39 = p35.Rounds
    local v40 = (tonumber(v39) or v38) / v38
    local v41 = math.clamp(v40, 0, 1)
    if v41 >= 1 then
        return 1
    end
    local v42 = p35.RechargeStartTime
    local v43 = tonumber(v42)
    if not v43 then
        return v41
    end
    local v44 = workspace:GetServerTimeNow() - v43
    local v45 = math.max(v44, 0) / v37
    local v46 = v41 + math.clamp(v45, 0, 1) / v38
    return math.clamp(v46, 0, 1)
end
local v_u_48 = Color3.fromRGB(125, 20, 20)
local v_u_49 = Color3.fromRGB(255, 235, 140)
local v_u_50 = Color3.fromRGB(40, 223, 213)
local function v_u_66(p51, p52)
    -- upvalues: (copy) v_u_30, (copy) v_u_34, (copy) v_u_47, (copy) v_u_50, (copy) v_u_48, (copy) v_u_49
    local v53 = p51.ChargeFillFrame
    if not (v53 and v53.Parent) then
        v53 = v_u_30(p51.Model)
        p51.ChargeFillFrame = v53
        local v54
        if v53 then
            v54 = v53.Size or nil
        else
            v54 = nil
        end
        p51.ChargeFillBaseSize = v54
    end
    local v55 = p51.ChargeTextLabel
    if not (v55 and v55.Parent) then
        v55 = v_u_34(p51.Model)
        p51.ChargeTextLabel = v55
    end
    local v56 = p51.ChargeFillBaseSize
    if v53 and v56 then
        local v57 = v_u_47(p51.WeaponComponent) or 1
        local v58 = p51.DisplayedChargeAlpha
        local v59
        if v58 == nil or v57 < v58 then
            v59 = v57
        else
            local v60 = p52 * 3.5
            local v61 = math.clamp(v60, 0, 1)
            v59 = v58 + (v57 - v58) * v61
        end
        local v62 = v57 - v59
        if math.abs(v62) > 0.001 then
            v57 = v59
        end
        local v63 = v57 >= 0.999 and 1 or v57
        p51.DisplayedChargeAlpha = v63
        v53.Size = UDim2.new(v56.X.Scale, v56.X.Offset, 0.8 * v63, 0)
        local v64
        if v63 >= 0.999 then
            v64 = v_u_50
        else
            v64 = v_u_48:Lerp(v_u_49, v63)
        end
        v53.BackgroundColor3 = v64
        if v55 then
            local v65 = v63 * 100
            v55.Text = ("%*%%"):format((math.round(v65)))
            v55.TextColor3 = v64
        end
    end
end
local function v_u_70(p67)
    for _, v68 in ipairs({
        "Weapon",
        "WeaponL",
        "WeaponR",
        "CharmBase"
    }) do
        local v69 = p67:FindFirstChild(v68)
        if v69 then
            v69:Destroy()
        end
    end
end
function v_u_1.aim(p71)
    -- upvalues: (copy) v_u_26, (copy) v_u_14
    if p71.Bobble then
        p71.Bobble:setIsAiming(true)
    end
    v_u_26(p71.Bobble.Scope, true)
    v_u_26(p71.Bobble.ScopeReticlePart, true)
    if p71.MuzzlePartWeld then
        local v72 = v_u_14.CFrame
        local v73 = p71.Model.WorldPivot
        local v74 = v72 + v72.UpVector * -0.5 + v73.LookVector * 1 + v73.RightVector * 0.1
        local v75 = p71.MuzzlePartWeld
        p71.MuzzlePartWeld.C0 = v75.Part0.CFrame:Inverse() * v74
    end
end
function v_u_1.unaim(p76)
    -- upvalues: (copy) v_u_26
    if p76.Bobble then
        p76.Bobble:setIsAiming(false)
    end
    v_u_26(p76.Bobble.Scope, false)
    v_u_26(p76.Bobble.ScopeReticlePart, false)
    if p76.OriginalC0 and p76.MuzzlePartWeld then
        p76.MuzzlePartWeld.C0 = p76.OriginalC0
    end
end
function v_u_1.unhide(p77)
    -- upvalues: (copy) v_u_22
    if p77.Hidden then
        v_u_22(p77.Model, false)
        p77.Hidden = false
    end
end
function v_u_1.hide(p78)
    -- upvalues: (copy) v_u_22
    if not p78.Hidden then
        v_u_22(p78.Model, true)
        p78.Hidden = true
    end
end
function v_u_1.equip(p79, p80)
    -- upvalues: (copy) v_u_14
    p79.IsEquipped = true
    if p79.Model then
        p79.Model.Parent = v_u_14
        if p79.LargeWeaponModel then
            p79.LargeWeaponModel.Parent = v_u_14
        end
        p79.Animation:stopAnimations()
        p79.Animation:play("Idle")
        if p79.Hidden then
            p79:unhide()
        end
        if not p80 then
            p79.Animation:play("Equip")
        end
    end
end
function v_u_1.unequip(p81)
    p81.IsEquipped = false
    p81.Animation:stopAnimations()
    if p81.Model then
        p81.Model.Parent = nil
    end
    if p81.LargeWeaponModel then
        p81.LargeWeaponModel.Parent = nil
    end
end
function v_u_1.applyCharmImpulse(p82, p83)
    if p82.LargeCharmModel and p82.LargeCharmModel.PrimaryPart then
        local v84 = 0
        for _, v85 in ipairs(p82.LargeCharmModel:GetDescendants()) do
            if v85:IsA("BasePart") then
                v84 = v84 + v85:GetMass()
            end
        end
        p82.LargeCharmModel.PrimaryPart:ApplyImpulse(p83 * 10 * v84)
    end
end
function v_u_1.render(p86, p87)
    -- upvalues: (copy) v_u_66, (copy) v_u_6, (copy) v_u_14
    if p86.Model and p86.Model:FindFirstChild("Stats") then
        v_u_66(p86, p87)
        local v88 = v_u_6.Get(p86.Player, "Settings.Game.Viewmodel") or {}
        if p86.Bobble and (p86.Bobble.Character and p86.Bobble.Character.PrimaryPart) then
            local v89, v90, v91 = p86.Bobble:getNextCFrame(p87)
            local v92 = (v88["X Offset"] or 0) / 100
            local v93 = (v88["Y Offset"] or 0) / 100
            local v94 = (v88["Z Offset"] or 0) / 100
            local v95 = v_u_14.CFrame * v89 * CFrame.Angles(p86.Model.Stats.Rotation.Value.X, p86.Model.Stats.Rotation.Value.Y, p86.Model.Stats.Rotation.Value.Z) * CFrame.new(p86.Model.Stats.Default.Value) * CFrame.new(v92, v93, v94)
            p86.Model:PivotTo(v95)
            if p86.LargeWeaponModel and p86.SmallWeaponModel then
                p86.LargeWeaponModel:PivotTo(p86.SmallWeaponModel:GetPivot())
                local v96 = p86.Model.WorldPivot.Position
                if p86.LastViewmodelPosition then
                    local v97 = v96 - p86.LastViewmodelPosition
                    if p86.LargeCharmModel and p86.LargeCharmModel.PrimaryPart then
                        p86:applyCharmImpulse(-v97 * 0.2)
                    end
                end
                p86.LastViewmodelPosition = v96
            end
            if p86.Bobble.Scope and p86.Bobble.IsAiming then
                local v98 = v_u_14.CFrame
                local v99 = v91.X * -v98.LookVector + v91.Y * -v98.UpVector
                p86.Bobble.Scope:PivotTo(v98 + v98.LookVector * 0.15 + v90 + v99)
                if p86.Bobble.ScopeReticlePart then
                    p86.Bobble.ScopeReticlePart.CFrame = v98 * CFrame.Angles(1.5707963267948966, 1.5707963267948966, -1.5707963267948966) + v98.LookVector * 0.15
                end
            end
        end
    end
end
function v_u_1.attachSleeves(p100, p101)
    -- upvalues: (copy) v_u_2
    local v102 = v_u_2.Assets.Sleeves:FindFirstChild(p101)
    if v102 then
        for _, v103 in ipairs(v102:GetChildren()) do
            local v104 = p100.Model:FindFirstChild(v103.Name)
            if v104 then
                local v105 = v103:Clone()
                v105.CastShadow = false
                v105.CanCollide = false
                v105.CanTouch = false
                v105.Anchored = false
                v105.CanQuery = false
                v105.Name = "Sleeve"
                local v106 = v104.Size.X * 1.3
                local v107 = v104.Size.Y * 1.4
                local v108 = v104.Size.Z * 0.79
                v105.Size = Vector3.new(v106, v107, v108)
                local v109 = v104.Size.Z / 2 - v105.Size.Z / 2
                local v110 = CFrame.new(0, -0.02, -v109)
                v105.Parent = v104
                local v111 = Instance.new("Motor6D", v105)
                v111.Part0 = v104
                v111.Part1 = v105
                v111.C0 = CFrame.identity
                v111.C1 = v110
            end
        end
    end
end
function v_u_1.addAttachments(p112, p113)
    -- upvalues: (copy) v_u_11, (copy) v_u_8, (copy) v_u_7
    local v114 = nil
    local v115 = nil
    local v116 = nil
    if type(p113) == "string" then
        local v117 = v_u_11.broadcastRouter("GetInventoryItemFromIdentifier", p112.Player, p113)
        if v117 then
            v114 = v117.Name
            v115 = v117.Skin
            v116 = v117.Float
        end
    elseif type(p113) == "table" then
        local v118 = p113.SkinIdentifier
        if type(v118) == "string" and v118 ~= "" then
            local v119 = v_u_11.broadcastRouter("GetInventoryItemFromIdentifier", p112.Player, v118)
            if v119 then
                v114 = v119.Name
                v115 = v119.Skin
                v116 = v119.Float
            end
        end
        if not v114 then
            local v120 = p113.Name
            if type(v120) == "string" then
                local v121 = p113.Skin
                if type(v121) == "string" then
                    v114 = p113.Name
                    v115 = p113.Skin
                    local v122 = p113.Float
                    if typeof(v122) == "number" then
                        v116 = p113.Float
                    else
                        v116 = nil
                    end
                end
            end
        end
    end
    if v114 and v115 then
        local v123 = v_u_8.GetGloves(v114, v115, v116)
        if v123 then
            v_u_7(v123:GetChildren(), p112.Model)
            if p112.Team == "Counter-Terrorists" then
                p112:attachSleeves((workspace:GetAttribute("CTCharacter")))
            end
        end
    else
        return
    end
end
function v_u_1.construct(p124, p125, _)
    -- upvalues: (copy) v_u_10, (copy) v_u_8, (copy) v_u_3, (copy) v_u_70, (copy) v_u_4
    if p124.ModelJanitor then
        p124.ModelJanitor:Destroy()
    end
    p124.ModelJanitor = v_u_10.new()
    p124.CharmModel = nil
    p124.LargeWeaponModel = nil
    p124.SmallWeaponModel = nil
    p124.LargeCharmModel = nil
    p124.LastViewmodelPosition = nil
    p124.ChargeFillFrame = nil
    p124.ChargeTextLabel = nil
    p124.ChargeFillBaseSize = nil
    p124.DisplayedChargeAlpha = nil
    if p124.Animation then
        p124.Animation:stopAnimations()
    end
    if p124.Model then
        p124.Model:Destroy()
        p124.Model = nil
    end
    local v126 = p124.CameraModelWeapon or p124.Weapon
    local v127 = nil
    local v128
    if v126 == "Smoke Grenade" then
        v128 = p124.Team
        if v128 ~= "Counter-Terrorists" and v128 ~= "Terrorists" then
            v128 = v127
        end
    else
        v128 = v127
    end
    p124.Model = v_u_8.GetCameraModel(v126, p124.Skin, p124.Float, p124.StatTrack, p124.NameTag, p124.Charm, p124.Stickers, v128)
    if not p124.Model and p124.HideWeaponGeometry then
        p124.Model = v_u_8.GetBaseWeaponModel(v126, "Camera")
    end
    if not p124.Model then
        error((("Viewmodel.construct: Failed to get camera model for weapon \"%*\" with skin \"%*\""):format(v126, p124.Skin)))
    end
    p124.Model.Parent = v_u_3
    p124.Model.Name = v126
    if p124.HideWeaponGeometry then
        v_u_70(p124.Model)
    end
    local v_u_129 = p125:GetAttribute("EquippedGloves")
    if type(v_u_129) == "string" and v_u_129 ~= "" then
        local v130, v131 = pcall(function()
            -- upvalues: (ref) v_u_4, (copy) v_u_129
            return v_u_4:JSONDecode(v_u_129)
        end)
        if v130 and v131 then
            p124:addAttachments(v131)
        else
            p124:addAttachments(v_u_129)
        end
    end
    for _, v132 in ipairs(p124.Model:GetDescendants()) do
        if v132:IsA("BasePart") then
            v132.CollisionGroup = "Viewmodel"
            v132.CanCollide = false
            v132.CastShadow = false
            v132.CanQuery = true
            v132.CanTouch = false
            if v132.Name == "HumanoidRootPart" or v132.Name == "ViewmodelLight" then
                v132.Transparency = 1
            end
        end
    end
    local v133 = p125:FindFirstChild("Body Colors")
    local v134 = nil
    if v133 then
        v134 = v133.TorsoColor3
    else
        local v135 = p125:FindFirstChild("Torso") or p125:FindFirstChild("UpperTorso")
        if v135 and v135:IsA("BasePart") then
            v134 = v135.Color
        end
    end
    if v134 then
        for _, v136 in ipairs({ "Right Arm", "Left Arm" }) do
            local v137 = p124.Model:FindFirstChild(v136)
            if v137 and v137:IsA("BasePart") then
                v137.Color = v134
            end
        end
    end
    local v138 = p124.Model:FindFirstChild("Interactables")
    local v139 = not v138 or v138:FindFirstChild("MuzzlePart", true) or (v138:FindFirstChild("MuzzlePartL", true) or v138:FindFirstChild("MuzzlePartR", true))
    p124.MuzzlePart = v139
    if v138 then
        p124.MuzzlePartL = v138:FindFirstChild("MuzzlePartL", true)
        p124.MuzzlePartR = v138:FindFirstChild("MuzzlePartR", true)
        if p124.MuzzlePartL and p124.MuzzlePartL:IsA("BasePart") then
            p124.MuzzlePartL.Transparency = 1
        end
        if p124.MuzzlePartR and p124.MuzzlePartR:IsA("BasePart") then
            p124.MuzzlePartR.Transparency = 1
        end
    end
    if p124.MuzzlePart and p124.MuzzlePart:IsA("BasePart") then
        p124.MuzzlePart.Transparency = 1
    end
    if p124.MuzzlePart and not p124.MuzzlePart:FindFirstChild("WeldConstraint", true) then
        local v140 = p124.Model:GetDescendants()
        for _, v141 in ipairs(v140) do
            if v141:IsA("Weld") and (v141.Part1 == v139 or v141.Part0 == v139) then
                p124.MuzzlePartWeld = v141
                p124.OriginalC0 = v141.C0
                break
            end
        end
    end
    p124.Model:ScaleTo(0.1)
    local v142 = p124.Model:FindFirstChild("CharmBase", true)
    if v142 and v142:IsA("Model") then
        local v143 = v142:FindFirstChildOfClass("Model")
        if v143 and v143.PrimaryPart then
            p124.CharmModel = v143
        end
    end
    if p124.CharmModel then
        p124:setupCharmPhysics()
    end
    if p124.Animation then
        p124.Animation:setModel(p124.Model)
    end
    if p124.Bobble then
        p124.Bobble:setModel(p124.Model)
    end
    if p124.IsEquipped then
        p124:equip(false)
    else
        p124:unequip()
    end
end
function v_u_1.setupCharmPhysics(p_u_144)
    -- upvalues: (copy) v_u_14, (copy) v_u_5
    if p_u_144.CharmModel then
        local v145 = p_u_144.CharmModel.Parent
        p_u_144.CharmModel:PivotTo(v145.PrimaryPart.CFrame * CFrame.new(0, 0, -1))
        local v_u_146 = p_u_144.CharmModel
        local v_u_147 = p_u_144.Model:FindFirstChild("Weapon") or (p_u_144.Model:FindFirstChild("WeaponL") or p_u_144.Model:FindFirstChild("WeaponR"))
        if v_u_147 then
            local v_u_148 = v_u_147.Parent:Clone()
            v_u_148.Parent = v_u_14
            local v_u_149 = v_u_148:FindFirstChild("Weapon") or (p_u_144.Model:FindFirstChild("WeaponL") or p_u_144.Model:FindFirstChild("WeaponR"))
            for _, v150 in v_u_148:GetChildren() do
                if v150.Name ~= "Weapon" and (v150.Name ~= "WeaponL" and (v150.Name ~= "WeaponR" and v150.Name ~= "CharmBase")) then
                    v150:Destroy()
                end
            end
            for _, v151 in ipairs(v_u_148:GetDescendants()) do
                if v151.Name == "ViewmodelLight" then
                    v151:Destroy()
                end
            end
            v_u_148:ScaleTo(1)
            v_u_148:PivotTo(v_u_147.Parent:GetPivot())
            v_u_149.PrimaryPart.Anchored = true
            local v152 = v_u_148:GetBoundingBox()
            if v_u_148.PrimaryPart then
                v_u_148.PrimaryPart.PivotOffset = v_u_148.PrimaryPart.CFrame:ToObjectSpace(v152)
            else
                v_u_148.WorldPivot = v152
            end
            v_u_148.PrimaryPart = v_u_149.PrimaryPart
            for _, v153 in ipairs(v_u_148:GetDescendants()) do
                if v153:IsA("BasePart") then
                    v153.Transparency = 1
                    v153.CanCollide = true
                elseif v153:IsA("Decal") or (v153:IsA("Texture") or v153:IsA("Beam")) then
                    v153.Transparency = 1
                elseif v153:IsA("SurfaceGui") then
                    v153.Enabled = false
                elseif v153:IsA("ParticleEmitter") then
                    v153.Enabled = false
                end
            end
            local v154 = v_u_148:FindFirstChild("CharmBase", true)
            local v155
            if v154 and v154:IsA("Model") then
                v155 = v154:FindFirstChildOfClass("Model")
                if v155 then
                    for _, v156 in ipairs(v155:GetDescendants()) do
                        if v156:IsA("BasePart") then
                            v156.CanCollide = true
                            v156.CollisionGroup = "Charm"
                        end
                    end
                end
            else
                v155 = nil
            end
            p_u_144.LargeWeaponModel = v_u_149.Parent
            p_u_144.SmallWeaponModel = v_u_147
            p_u_144.LargeCharmModel = v155
            if v155 and (v_u_146 and p_u_144.ModelJanitor) then
                p_u_144.ModelJanitor:Add(v_u_5.PostSimulation:Connect(function()
                    -- upvalues: (copy) p_u_144, (copy) v_u_146, (copy) v_u_149, (copy) v_u_147
                    local v157 = p_u_144.LargeCharmModel
                    local v158 = v_u_146
                    if v157 and v158 then
                        if v157.PrimaryPart and v158.PrimaryPart then
                            local v159 = v_u_149:GetPivot():ToObjectSpace((v157:GetPivot()))
                            local v160 = CFrame.new(v159.Position / 10) * CFrame.fromOrientation(v159:ToOrientation())
                            v158:PivotTo(v_u_147:GetPivot() * v160)
                        end
                    else
                        return
                    end
                end))
            end
            if p_u_144.CharmModel.PrimaryPart then
                p_u_144.CharmModel.PrimaryPart.Anchored = true
            end
            if p_u_144.ModelJanitor then
                p_u_144.ModelJanitor:Add(function()
                    -- upvalues: (copy) v_u_148, (copy) p_u_144
                    if v_u_148 then
                        v_u_148:Destroy()
                    end
                    p_u_144.LargeWeaponModel = nil
                    p_u_144.SmallWeaponModel = nil
                    p_u_144.LargeCharmModel = nil
                end)
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.new(p_u_161, p162, p163)
    -- upvalues: (copy) v_u_1, (copy) v_u_10, (copy) v_u_9, (copy) v_u_12, (copy) v_u_13
    local v164 = v_u_1
    local v_u_165 = setmetatable({}, v164)
    v_u_165.Janitor = v_u_10.new()
    v_u_165.ModelJanitor = v_u_10.new()
    v_u_165.IsDestroyed = false
    v_u_165.Player = p_u_161.Player
    v_u_165.Team = v_u_165.Player:GetAttribute("Team")
    v_u_165.WeaponComponent = p_u_161
    v_u_165.Weapon = p162
    v_u_165.CameraModelWeapon = p_u_161.ViewmodelCameraWeapon or p162
    v_u_165.HideWeaponGeometry = p_u_161.ViewmodelHideWeaponGeometry == true
    v_u_165.Skin = p163
    v_u_165.StatTrack = p_u_161.StatTrack
    v_u_165.Stickers = p_u_161.Stickers
    v_u_165.NameTag = p_u_161.NameTag
    v_u_165.Float = p_u_161.Float
    v_u_165.Charm = p_u_161.Charm
    v_u_165.Hidden = false
    v_u_165.IsEquipped = false
    v_u_165.ChargeFillFrame = nil
    v_u_165.ChargeTextLabel = nil
    v_u_165.ChargeFillBaseSize = nil
    v_u_165.DisplayedChargeAlpha = nil
    v_u_165.Sound = v_u_9.new(v_u_165.CameraModelWeapon)
    v_u_165.Animation = v_u_12.new(v_u_165, v_u_165.Player, nil, v_u_165.Sound)
    v_u_165.Bobble = v_u_13.new(p_u_161, nil)
    local v166 = not p_u_161.Character and v_u_165.Player
    if v166 then
        v166 = v_u_165.Player.Character
    end
    if v166 then
        v_u_165:construct(v166, p_u_161)
    end
    v_u_165.Janitor:Add(v_u_165.Player.CharacterAdded:Connect(function(p167)
        -- upvalues: (copy) v_u_165, (copy) p_u_161
        v_u_165:construct(p167, p_u_161)
    end))
    v_u_165.Janitor:Add(function()
        -- upvalues: (copy) v_u_165
        if v_u_165.Animation then
            v_u_165.Animation:destroy()
            v_u_165.Animation = nil
        end
    end)
    v_u_165.Janitor:Add(function()
        -- upvalues: (copy) v_u_165
        if v_u_165.Bobble then
            v_u_165.Bobble:destroy()
            v_u_165.Bobble = nil
        end
    end)
    v_u_165.Janitor:Add(function()
        -- upvalues: (copy) v_u_165
        if v_u_165.Sound then
            v_u_165.Sound:destroy()
            v_u_165.Sound = nil
        end
    end)
    v_u_165.Janitor:Add(function()
        -- upvalues: (copy) v_u_165
        if v_u_165.ModelJanitor then
            v_u_165.ModelJanitor:Destroy()
            v_u_165.ModelJanitor = nil
        end
    end)
    return v_u_165
end
function v_u_1.destroy(p168)
    if not p168.IsDestroyed then
        p168.IsDestroyed = true
        if p168.Animation then
            p168.Animation:stopAnimations()
        end
        if p168.Animation then
            p168.Animation:destroy()
            p168.Animation = nil
        end
        if p168.Bobble then
            p168.Bobble:destroy()
            p168.Bobble = nil
        end
        if p168.Sound then
            p168.Sound:destroy()
            p168.Sound = nil
        end
        if p168.Model then
            p168.Model.Parent = nil
            p168.Model:Destroy()
            p168.Model = nil
        end
        if p168.Janitor then
            p168.Janitor:Destroy()
            p168.Janitor = nil
        end
        p168.StatTrack = nil
        p168.Stickers = nil
        p168.NameTag = nil
        p168.Player = nil
        p168.Weapon = nil
        p168.Float = nil
        p168.Charm = nil
        p168.Skin = nil
        p168.Team = nil
        p168.MuzzlePartWeld = nil
        p168.MuzzlePartL = nil
        p168.MuzzlePartR = nil
        p168.MuzzlePart = nil
        p168.OriginalC0 = nil
        p168.CharmModel = nil
        p168.ScaledCollisionModel = nil
        p168.LargeCharmModel = nil
        p168.LargeWeaponModel = nil
    end
end
return v_u_1
