-- MODULESCRIPT: Crosshair
-- Original Path: game.BAC - 52404.Interface.Screens.Gameplay.Middle.Crosshair
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Workspace")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = v5.LocalPlayer
local v_u_7 = require(v_u_2.Controllers.InventoryController)
local v_u_8 = require(v_u_2.Controllers.CameraController)
local v_u_9 = require(v_u_2.Controllers.DataController)
local v_u_10 = require(v_u_2.Database.Security.Remotes)
local v_u_11 = v4.CurrentCamera
local v_u_12 = require(script:WaitForChild("Settings"))
local v_u_13 = nil
local v_u_14 = nil
local function v_u_32(p15)
    -- upvalues: (ref) v_u_12, (copy) v_u_8, (copy) v_u_2, (copy) v_u_11
    if not (p15.Recoil and (p15.Properties and (p15.Properties.Recoil and v_u_12["Follow Recoil"]))) then
        return UDim2.new()
    end
    local v16 = 1 - p15.Properties.Recoil.CameraScale
    local v17 = v_u_8.getWeaponKickRotation()
    local v18 = p15.Recoil.RotationValue
    local v19 = 0
    if game:GetService("UserInputService").TouchEnabled then
        local v20, v21 = pcall(function()
            -- upvalues: (ref) v_u_2
            return require(v_u_2.Controllers.AimAssistController)
        end)
        if v20 and (v21 and v21.GetRecoilAssistMultiplier) then
            v19 = v21.GetRecoilAssistMultiplier()
        end
    end
    local v22 = v18.X * (1 - v19)
    local v23 = v18.Y * (1 - v19)
    local v24 = v18.Z
    local v25 = Vector3.new(v22, v23, v24)
    local v26 = Vector2.new(v25.Y - v17.Y, v25.X - v17.X) * 57.29577951308232
    local v27 = v_u_11.ViewportSize
    local v28, v29
    if v27.X > v27.Y then
        v28 = v_u_11.MaxAxisFieldOfView
        v29 = v_u_11.FieldOfView
    else
        v28 = v_u_11.FieldOfView
        v29 = v_u_11.MaxAxisFieldOfView
    end
    local v30
    if typeof(v26) == "number" then
        v30 = v26 / v29 * v27.Y
    else
        v30 = v26 / Vector2.new(v28, v29) * v27
    end
    if typeof(v30) ~= "Vector2" then
        return UDim2.new()
    end
    local v31 = v30 * -v16 / v_u_11.ViewportSize
    return UDim2.fromScale(v31.X, v31.Y)
end
local function v_u_45(p33, p34)
    -- upvalues: (copy) v_u_11, (ref) v_u_12
    if p33.IsAiming and p33.Properties.AimingOptions == "AutomaticScope" then
        if p33.getBaseSpread then
            local v35 = p33.Viewmodel.Bobble.ScopeReticlePart
            if v35 then
                local v36 = p33:getBaseSpread() or 0
                local v37 = v35.SurfaceGui.Frame.Frame
                local v38 = v_u_11.FieldOfView / 2
                local v39 = math.rad(v38)
                local v40 = math.tan(v39) * 2 * 0.15
                local v41 = v_u_11.ViewportSize
                local v42 = v41.X / v41.Y * v40 / 0.15
                local v43 = v40 / 0.15
                local v44 = math.clamp(v36, 0, 2) * 2
                v37.Size = UDim2.fromScale(v44 + 2.5, v44 + 2.5)
                v37.Position = UDim2.fromScale(0.5, 0.5) + UDim2.new(p34.X.Scale * v42, 0, p34.Y.Scale * v43, 0)
                local _ = v_u_12["Use Crosshair Color for Scope Dot"]
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_53(p46, p47, p48, p49)
    -- upvalues: (ref) v_u_12
    if p46 then
        local v50
        if p48 then
            v50 = p48.Gap
        else
            v50 = p48
        end
        local v51 = (v50 or v_u_12.Gap) * 5 / 5
        if not p48 or p48["Crosshair Style"] ~= "Classic" then
            v51 = v51 + 5
        end
        local v52 = v51 + (p49 or 0) + (p47 - 1) * 15
        p46.Right.Position = UDim2.new(0.5, v52, 0.5, 0)
        p46.Down.Position = UDim2.new(0.5, 0, 0.5, v52)
        p46.Left.Position = UDim2.new(0.5, -v52, 0.5, 0)
        p46.Up.Position = UDim2.new(0.5, 0, 0.5, -v52)
    end
end
local function v_u_58(p54, p55)
    -- upvalues: (ref) v_u_12
    if p54 then
        local v56
        if p55 then
            v56 = p55.Gap
        else
            v56 = p55
        end
        local v57 = (v56 or v_u_12.Gap) * 5 / 5
        if not p55 or p55["Crosshair Style"] ~= "Classic" then
            v57 = v57 + 5
        end
        p54.Right.Position = UDim2.new(0.5, v57, 0.5, 0)
        p54.Down.Position = UDim2.new(0.5, 0, 0.5, v57)
        p54.Left.Position = UDim2.new(0.5, -v57, 0.5, 0)
        p54.Up.Position = UDim2.new(0.5, 0, 0.5, -v57)
    end
end
local function v_u_68(p59, p60, p61, p62, p63)
    if p59 then
        for _, v64 in ipairs({
            "Up",
            "Down",
            "Left",
            "Right"
        }) do
            local v65 = p59:FindFirstChild(v64)
            if v65 then
                v65.BackgroundColor3 = p60
                v65.BackgroundTransparency = 1 - p61
                v65.Visible = true
                local v66 = 15 * (p62.Length / 5) * p63
                local v67 = 2 * (p62.Thickness / 1)
                if v64 == "Up" or v64 == "Down" then
                    v65.Size = UDim2.new(0, v67, 0, v66)
                else
                    v65.Size = UDim2.new(0, v66, 0, v67)
                end
                if p62.Outline.Enabled then
                    v65.BorderSizePixel = p62.Outline.Value
                    v65.BorderColor3 = Color3.new(0, 0, 0)
                else
                    v65.BorderSizePixel = 0
                end
            end
        end
        if p59.Up then
            p59.Up.Visible = not p62["T Style"]
        end
    end
end
function v_u_1.ResetCrosshair()
    -- upvalues: (ref) v_u_13, (copy) v_u_58, (ref) v_u_12, (ref) v_u_14, (copy) v_u_7
    if v_u_13 then
        v_u_13.Position = UDim2.fromScale(0.5, 0.5)
        v_u_58(v_u_13.Ticks, v_u_12)
        v_u_58(v_u_14, v_u_12)
        local v69 = v_u_7.getCurrentEquipped()
        if v69 and typeof(v69) == "table" then
            if v69.IsAiming and (v69.Properties and v69.Properties.AimingOptions == "AutomaticScope") then
                local v70 = v69.Viewmodel
                if v70 and v70.Bobble then
                    local v71 = v70.Bobble.ScopeReticlePart
                    local v72 = v71 and (v71.SurfaceGui and v71.SurfaceGui.Frame) and v71.SurfaceGui.Frame:FindFirstChild("Frame")
                    if v72 then
                        v72.Position = UDim2.fromScale(0.5, 0.5)
                        v72.Size = UDim2.fromScale(2.5, 2.5)
                    end
                end
            end
            local v73 = v69.Recoil
            if v73 then
                v73.Value = Vector2.zero
                v73.RecoveryStartTime = 0
                v73.Time = 0
                v73.RotationValue = Vector3.new(0, 0, 0)
            end
        end
    end
end
function v_u_1.UpdateCrosshair(_)
    -- upvalues: (copy) v_u_6, (copy) v_u_2, (ref) v_u_12, (copy) v_u_9, (ref) v_u_13, (ref) v_u_14, (copy) v_u_7, (copy) v_u_68, (copy) v_u_11, (copy) v_u_32, (copy) v_u_45, (copy) v_u_53, (copy) v_u_58
    local v74 = v_u_6:GetAttribute("IsSpectating") == true
    local v75 = false
    local v76 = nil
    if v74 then
        local v77 = require(v_u_2.Controllers.SpectateController).GetCurrentSpectateInstance()
        if v77 and v_u_12["Show Player Crosshairs"] == true then
            v76 = v_u_9.Get(v77.Player, "Settings.Game.Crosshair")
            if v76 then
                v75 = true
            end
        end
        if v77 and (v77.PerspectiveState == "First-Person" and v77.CurrentEquipped) then
            local v78 = v77.CurrentEquipped.Name
            if v78 == "AWP" and true or v78 == "SSG 08" or (v78 == "AUG" and true or v78 == "SG 553") and (v77.Player:GetAttribute("ScopeIncrement") or 0) > 0 then
                v_u_13.Visible = false
                if v_u_13.Ticks then
                    for _, v79 in pairs(v_u_13.Ticks:GetChildren()) do
                        if v79:IsA("Frame") then
                            v79.Visible = false
                        end
                    end
                end
                if v_u_14 then
                    for _, v80 in pairs(v_u_14:GetChildren()) do
                        if v80:IsA("Frame") then
                            v80.Visible = false
                        end
                    end
                end
                if v_u_13.Dot then
                    v_u_13.Dot.Visible = false
                end
                if v_u_13.Crosshair then
                    v_u_13.Crosshair.Visible = false
                end
                return
            end
            local v81 = v75 and v76 and v76 or v_u_12
            local v82 = v81["Crosshair Style"] == "Image"
            if v_u_13.Ticks then
                v_u_13.Ticks.Visible = not v82
                for _, v83 in pairs(v_u_13.Ticks:GetChildren()) do
                    if v83:IsA("Frame") then
                        v83.Visible = true
                    end
                end
            end
            if v_u_14 then
                v_u_14.Visible = false
            end
            if v_u_13.Dot then
                local v84 = v_u_13.Dot
                local v85 = not v82
                if v85 then
                    v85 = v81["Center Dot"]
                end
                v84.Visible = v85
            end
            if v_u_13.Crosshair then
                v_u_13.Crosshair.Visible = v82
            end
        elseif v77 and v77.PerspectiveState == "First-Person" then
            v_u_13.Visible = true
        end
    end
    local v86 = v_u_6.Character
    local v87 = v_u_7.getCurrentEquipped()
    local v88 = v74 and not v87 and {
        ["Properties"] = {
            ["ShowCrosshair"] = true,
            ["AimingOptions"] = "None"
        },
        ["IsAiming"] = false
    } or v87
    if not (v74 or v86) then
        return
    end
    if not (v88 or v74) then
        return
    end
    local v89 = v74 and not v88 and {
        ["Properties"] = {
            ["ShowCrosshair"] = true,
            ["AimingOptions"] = "None"
        },
        ["IsAiming"] = false
    } or v88
    local v90 = v75 and v76 and v76 or v_u_12
    local v91 = v90.Alpha.Enabled and (v90.Alpha.Value / 255 or 1) or 1
    local v92 = Color3.fromRGB(v90.Red, v90.Green, v90.Blue)
    local v93
    if v90["Crosshair Style"] == "Classic" and (v89 and v89.getCrosshairDisplayState) then
        v93 = v89:getCrosshairDisplayState()
    else
        v93 = nil
    end
    local v94 = v90["Crosshair Style"] == "Image"
    v_u_13.Ticks.Visible = not v94
    if v_u_14 then
        v_u_14.Visible = false
    end
    local v95 = v_u_13.Dot
    local v96 = not v94
    if v96 then
        v96 = v90["Center Dot"]
    end
    v95.Visible = v96
    v_u_13.Crosshair.Visible = v94
    if v94 then
        local v97 = v_u_13.Crosshair
        local v98 = v90["Crosshair Image"]
        v97.Image = "rbxassetid://" .. tostring(v98)
        v_u_13.Crosshair.ImageColor3 = v92
        v_u_13.Crosshair.ImageTransparency = 1 - v91
    else
        local v99 = v91 * 1
        local v100 = v91 * 0.5
        local v101 = v_u_68
        local v102 = v_u_13.Ticks
        if v90["Crosshair Style"] ~= "Classic" then
            v100 = v91
        end
        v101(v102, v92, v100, v90, v90["Crosshair Style"] == "Classic" and 0.35 or 1)
        v_u_68(v_u_14, v92, v99, v90, 0.65)
        if v_u_13.Dot and v90["Center Dot"] then
            v_u_13.Dot.BackgroundColor3 = v92
            v_u_13.Dot.BackgroundTransparency = 1 - v91
            if v90.Outline.Enabled then
                v_u_13.Dot.BorderSizePixel = v90.Outline.Value
                v_u_13.Dot.BorderColor3 = Color3.new(0, 0, 0)
            else
                v_u_13.Dot.BorderSizePixel = 0
            end
        end
    end
    local v103 = v_u_13
    local v104 = v89.Properties.ShowCrosshair
    local v105 = v_u_13.Parent
    local v106 = v104 and not (v105.TeamSelection.Visible or v105.Leaderboard.Visible or (v105.EndScreen.Visible or v105.BuyMenu.Visible))
    if v106 then
        v106 = not v89.IsAiming
    end
    v103.Visible = v106
    local v107 = UDim2.new()
    local v108 = 1
    if not v_u_13.Visible and v89.Properties.AimingOptions ~= "AutomaticScope" then
        ::l118::
        v_u_45(v89, v107)
        v_u_13.Position = UDim2.fromScale(0.5, 0.5) + v107
        if not v94 then
            if v90["Crosshair Style"] == "Classic" then
                local v109 = (v108 - 1) * 15
                local v110 = math.max(0, v109)
                if v93 then
                    v93 = v93.InnerSpread
                end
                local v111
                if type(v93) == "number" then
                    local v112 = v93 / 2
                    local v113 = math.clamp(v112, 0, 30)
                    local v114 = v_u_11.ViewportSize
                    local v115, v116
                    if v114.X > v114.Y then
                        v115 = v_u_11.MaxAxisFieldOfView
                        v116 = v_u_11.FieldOfView
                    else
                        v115 = v_u_11.FieldOfView
                        v116 = v_u_11.MaxAxisFieldOfView
                    end
                    local v117
                    if typeof(v113) == "number" then
                        v117 = v113 / v116 * v114.Y
                    else
                        v117 = v113 / Vector2.new(v115, v116) * v114
                    end
                    local v118
                    if typeof(v117) == "Vector2" then
                        local v119 = v117.X
                        local v120 = v117.Y
                        v118 = math.max(v119, v120) / 15 + 1
                    else
                        v118 = 1 + v117 / 15
                    end
                    local v121 = (v118 - 1) * 15
                    v111 = math.max(0, v121)
                else
                    v111 = math.min(v110, 7)
                end
                local v122
                if v90 then
                    v122 = v90.Gap
                else
                    v122 = v90
                end
                local v123 = (v122 or v_u_12.Gap) * 5 / 5
                if not v90 or v90["Crosshair Style"] ~= "Classic" then
                    v123 = v123 + 5
                end
                local v124 = v90["Center Dot"]
                if v124 then
                    v124 = v123 + v111 <= 0
                end
                local v125 = v90["Center Dot"]
                if v125 then
                    v125 = v123 + v110 <= 0
                end
                if v_u_14 then
                    v_u_14.Visible = not v124
                    if not v124 then
                        v_u_53(v_u_14, v111 / 15 + 1, v90)
                    end
                end
                if v125 then
                    v_u_13.Ticks.Visible = false
                    v_u_58(v_u_13.Ticks, v90)
                else
                    v_u_13.Ticks.Visible = true
                    v_u_53(v_u_13.Ticks, v110 / 15 + 1, v90)
                end
            end
            v_u_13.Ticks.Visible = true
            v_u_53(v_u_13.Ticks, v108, v90)
            if v_u_14 then
                v_u_14.Visible = false
                v_u_58(v_u_14, v90)
            end
        end
        return
    end
    if v90["Crosshair Style"] == "Classic Static" or v90["Crosshair Style"] == "Image" then
        v108 = 1
    elseif v90["Crosshair Style"] == "Classic" then
        if v93 then
            local v126 = v93.OuterSpread
            if type(v126) == "number" then
                v135 = v93.OuterSpread
                ::l127::
                local v127 = v135 / 2
                local v128 = math.clamp(v127, 0, 30)
                local v129 = v_u_11.ViewportSize
                local v130, v131
                if v129.X > v129.Y then
                    v130 = v_u_11.MaxAxisFieldOfView
                    v131 = v_u_11.FieldOfView
                else
                    v130 = v_u_11.FieldOfView
                    v131 = v_u_11.MaxAxisFieldOfView
                end
                local v132
                if typeof(v128) == "number" then
                    v132 = v128 / v131 * v129.Y
                else
                    v132 = v128 / Vector2.new(v130, v131) * v129
                end
                if typeof(v132) == "Vector2" then
                    local v133 = v132.X
                    local v134 = v132.Y
                    v108 = math.max(v133, v134) / 15 + 1
                else
                    v108 = 1 + v132 / 15
                end
                goto l122
            end
        end
        local v135 = v89.getSpread and (v89:getSpread() or 0) or 0
        goto l127
    end
    ::l122::
    v107 = v_u_32(v89)
    goto l118
end
function v_u_1.Initialize(_, p136)
    -- upvalues: (ref) v_u_13, (ref) v_u_14, (copy) v_u_9, (copy) v_u_6, (ref) v_u_12, (copy) v_u_1, (copy) v_u_3, (copy) v_u_10
    v_u_13 = p136
    v_u_14 = v_u_13:FindFirstChild("InnerTicks")
    if not v_u_14 and v_u_13.Ticks then
        local v137 = v_u_13.Ticks:Clone()
        v137.Name = "InnerTicks"
        v137.Visible = false
        v137.Parent = v_u_13
        v_u_14 = v137
    end
    v_u_9.CreateListener(v_u_6, "Settings.Game.Crosshair", function(p138)
        -- upvalues: (ref) v_u_12, (ref) v_u_1
        v_u_12 = p138
        task.delay(0.1, function()
            -- upvalues: (ref) v_u_1
            v_u_1.UpdateCrosshair(0)
        end)
    end)
    v_u_3.RenderStepped:Connect(function(p139)
        -- upvalues: (ref) v_u_1
        v_u_1.UpdateCrosshair(p139)
    end)
    v_u_10.Character.CharacterDied.Listen(function()
        -- upvalues: (ref) v_u_1
        v_u_1.ResetCrosshair()
    end)
end
return v_u_1
