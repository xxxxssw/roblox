-- MODULESCRIPT: MobileButtons
-- Original Path: game.BAC - 17285.Interface.Screens.Gameplay.Middle.MobileButtons
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("CollectionService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = game:GetService("RunService")
local v7 = game:GetService("Players")
require(v3.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_8 = require(v3.Controllers.CharacterController)
local v_u_9 = require(v3.Controllers.InventoryController)
local v_u_10 = require(v3.Controllers.CaseSceneController)
local v_u_11 = require(v3.Controllers.SpectateController)
local v_u_12 = require(v3.Controllers.InspectController)
local v_u_13 = require(v3.Controllers.DataController)
local v_u_14 = require(v3.Controllers.HintController)
local v_u_15 = require(v3.Database.Components.Libraries.Skins)
local v_u_16 = require(v3.Database.Components.GameState)
local v_u_17 = require(v3.Database.Components.Common.IsInBuyArea)
local v18 = require(v3.Components.Common.GetUserPlatform)
local v_u_19 = require(v3.Database.Security.Remotes)
local v_u_20 = require(v3.Database.Security.Router)
local v_u_21 = require(v3.Shared.Promise)
local v_u_22 = require(v3.Interface.Screens.Gameplay.Middle.TeamSelection)
local v_u_23 = require(v3.Interface.Screens.Gameplay.Middle.BuyMenu)
local v_u_24 = require(v3.Interface.Screens.Menu.Top)
local v_u_25 = require(v3.Database.Custom.GameStats.Rarities)
local v26 = require(script.Buttons)
local v_u_27 = v7.LocalPlayer
local v_u_28 = workspace.CurrentCamera
local v_u_29 = require(v_u_27:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("CameraInput"))
local v_u_30 = RaycastParams.new()
v_u_30.FilterType = Enum.RaycastFilterType.Exclude
v_u_30.IgnoreWater = true
local v_u_31 = RaycastParams.new()
v_u_31.FilterType = Enum.RaycastFilterType.Exclude
v_u_31.IgnoreWater = false
local v32 = v18()
local v_u_33 = table.find(v32, "Mobile")
if v_u_33 then
    v_u_33 = #v32 <= 1
end
local v_u_34 = nil
local v_u_35 = nil
local v_u_36 = 0
local v_u_37 = {}
local v_u_38 = {}
local v_u_39 = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
local v_u_40 = v26.BUTTONS_WITH_EXPLICIT_INPUT_ENDED
local v_u_41 = v26.BUTTONS_WITH_EXPLICIT_HANDLERS
local v_u_42 = v26.BUTTONS_EXCLUDED_FROM_CLEARING
local v_u_43 = v26.SPECTATE_MOBILE_BUTTONS
local v_u_44 = v26.GAMEPLAY_MOBILE_BUTTONS
local v_u_45 = nil
local function v_u_49(p46)
    -- upvalues: (copy) v_u_2
    while p46 do
        if v_u_2:HasTag(p46, "WeaponDropped") then
            local v47 = p46:GetAttribute("Weapon")
            local v48 = p46:GetAttribute("Skin")
            if v47 and v48 then
                return v47, v48, p46.Name
            end
            break
        end
        p46 = p46.Parent
    end
    return nil, nil, nil
end
local function v_u_53(...)
    -- upvalues: (copy) v_u_28, (copy) v_u_31
    local v50 = { v_u_28, ... }
    v_u_31.FilterDescendantsInstances = v50
    local v51 = workspace:Raycast(v_u_28.CFrame.Position, v_u_28.CFrame.LookVector * 1000, v_u_31)
    while v51 and v51.Instance do
        local v52 = v51.Instance
        if not v52:IsA("BasePart") or v52.Transparency <= 0.98 then
            break
        end
        table.insert(v50, v52)
        v_u_31.FilterDescendantsInstances = v50
        v51 = workspace:Raycast(v51.Position, v_u_28.CFrame.LookVector.Unit * (1000 - v51.Distance), v_u_31)
    end
    return v51 or nil
end
local function v_u_58()
    -- upvalues: (copy) v_u_28, (copy) v_u_27, (copy) v_u_30
    if not (v_u_28 and v_u_27.Character) then
        return nil
    end
    if v_u_27:GetAttribute("Team") ~= "Counter-Terrorists" then
        return nil
    end
    v_u_30.FilterDescendantsInstances = { v_u_27.Character, v_u_28 }
    local v54 = workspace:Raycast(v_u_28.CFrame.Position, v_u_28.CFrame.LookVector * 5, v_u_30)
    if v54 then
        local v55 = v54.Instance
        if v55 and (v55.Parent and v55.Parent:HasTag("Hostage")) or false then
            local v56 = v54.Instance.Parent
            if v56 and v56:GetAttribute("CanRescue") == true then
                local v57 = v56:GetAttribute("RescuingPlayer")
                if v57 and v57 ~= v_u_27.Name then
                    return nil
                elseif v56:GetAttribute("CarryingPlayer") then
                    return nil
                else
                    return v56
                end
            end
        end
    end
    return nil
end
local function v_u_65(p59, p60)
    -- upvalues: (copy) v_u_5, (copy) v_u_39, (copy) v_u_38
    local v61 = v_u_5
    local v62 = v_u_39
    local v63 = {}
    local v64 = v_u_38[p59] or p59.Size
    v63.Size = UDim2.fromScale(v64.X.Scale * p60, v64.Y.Scale * p60)
    v61:Create(p59, v62, v63):Play()
end
local function v_u_69()
    -- upvalues: (ref) v_u_45, (copy) v_u_2, (copy) v_u_58
    if v_u_45 then
        local v66 = v_u_2:GetTagged("Bomb")[1]
        if v66 then
            v66 = v66:GetAttribute("CanDefuse")
        end
        local v67 = #v_u_2:GetTagged("IsHoveringInteractable") > 0
        local v68 = v_u_58() ~= nil
        if v66 then
            v_u_45.Interact.Defuse.Visible = true
            v_u_45.Interact.Use.Visible = false
            v_u_45.Interact.Visible = true
            return
        elseif v67 or v68 then
            v_u_45.Interact.Defuse.Visible = false
            v_u_45.Interact.Use.Visible = true
            v_u_45.Interact.Visible = true
        else
            v_u_45.Interact.Defuse.Visible = false
            v_u_45.Interact.Use.Visible = false
            v_u_45.Interact.Visible = false
        end
    else
        return
    end
end
local function v_u_72()
    -- upvalues: (copy) v_u_11, (ref) v_u_45, (copy) v_u_9, (copy) v_u_16
    if v_u_11.IsLocalPlayerDead() then
        v_u_45.Drop.Visible = false
        return
    else
        local v70 = v_u_9.getCurrentEquipped()
        if v70 then
            local v71
            if v70.Properties.Class == "Melee" then
                v71 = workspace:GetAttribute("VIPKnifeDropEnabled") == true
            else
                v71 = false
            end
            if v70.Properties.Droppable or v71 then
                if v_u_16.GetState() == "Warmup" then
                    v_u_45.Drop.Visible = false
                    return
                elseif workspace:GetAttribute("Gamemode") == "Deathmatch" then
                    v_u_45.Drop.Visible = false
                    return
                elseif v70.Properties.Class == "C4" and v70.IsPlanting then
                    v_u_45.Drop.Visible = false
                else
                    v_u_45.Drop.Visible = true
                end
            else
                v_u_45.Drop.Visible = false
                return
            end
        else
            v_u_45.Drop.Visible = false
            return
        end
    end
end
function v_u_1.setupButton(p_u_73)
    -- upvalues: (copy) v_u_38, (copy) v_u_41, (copy) v_u_37, (copy) v_u_65, (copy) v_u_42, (copy) v_u_40
    v_u_38[p_u_73] = p_u_73.Size
    p_u_73.InputBegan:Connect(function(p74)
        -- upvalues: (ref) v_u_41, (copy) p_u_73, (ref) v_u_37, (ref) v_u_65
        if p74.UserInputType == Enum.UserInputType.Touch or p74.UserInputType == Enum.UserInputType.MouseButton1 then
            if p74.UserInputState == Enum.UserInputState.Begin then
                if not v_u_41[p_u_73.Name] then
                    local v75 = p_u_73
                    if not v_u_37[v75] and p74.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v75] = p74
                    end
                end
                if v_u_37[p_u_73] == p74 then
                    v_u_65(p_u_73, 0.9)
                end
            end
        end
    end)
    if not v_u_42[p_u_73.Name] then
        p_u_73.InputChanged:Connect(function(p76)
            -- upvalues: (ref) v_u_37, (copy) p_u_73, (ref) v_u_65
            if p76.UserInputType == Enum.UserInputType.Touch then
                if v_u_37[p_u_73] == p76 then
                    local v77 = p_u_73
                    local v78 = p76.Position
                    local v79 = v77.AbsolutePosition
                    local v80 = v77.AbsoluteSize
                    local v81
                    if v78.X >= v79.X and (v78.X <= v79.X + v80.X and v78.Y >= v79.Y) then
                        v81 = v78.Y <= v79.Y + v80.Y
                    else
                        v81 = false
                    end
                    if not v81 then
                        local v82 = p_u_73
                        if v_u_37[v82] == p76 then
                            v_u_37[v82] = nil
                        end
                        v_u_65(p_u_73, 1)
                    end
                end
            end
        end)
    end
    p_u_73.InputEnded:Connect(function(p83)
        -- upvalues: (ref) v_u_65, (copy) p_u_73, (ref) v_u_40, (ref) v_u_37
        if p83.UserInputType == Enum.UserInputType.Touch or p83.UserInputType == Enum.UserInputType.MouseButton1 then
            v_u_65(p_u_73, 1)
            if not v_u_40[p_u_73.Name] then
                local v84 = p_u_73
                if v_u_37[v84] == p83 then
                    v_u_37[v84] = nil
                end
            end
        end
    end)
end
function v_u_1.Initialize(_, p85)
    -- upvalues: (ref) v_u_45, (copy) v_u_38, (copy) v_u_33, (copy) v_u_37, (copy) v_u_8, (copy) v_u_65, (copy) v_u_21, (copy) v_u_9, (copy) v_u_15, (copy) v_u_25, (copy) v_u_20, (ref) v_u_34, (copy) v_u_27, (copy) v_u_11, (copy) v_u_16, (copy) v_u_29, (ref) v_u_35, (copy) v_u_2, (copy) v_u_58, (copy) v_u_19, (copy) v_u_23, (copy) v_u_24, (copy) v_u_10, (copy) v_u_12, (copy) v_u_14, (copy) v_u_22, (copy) v_u_13, (copy) v_u_53, (copy) v_u_49, (ref) v_u_36, (copy) v_u_1, (copy) v_u_6, (copy) v_u_17, (copy) v_u_69, (copy) v_u_72, (copy) v_u_4
    v_u_45 = p85
    for _, v86 in ipairs(v_u_45:GetChildren()) do
        if v86:IsA("TextButton") then
            v_u_38[v86] = v86.Size
        end
    end
    if v_u_33 then
        local v87 = v_u_45.Parent.Parent:FindFirstChild("Top")
        local v88 = v87 and v87:FindFirstChild("Bomb Defusal")
        if v88 then
            v88.Size = UDim2.new(0.6, 0, 0.75, 0)
        end
        v_u_45.Jump.InputBegan:Connect(function(p89)
            -- upvalues: (ref) v_u_45, (ref) v_u_37, (ref) v_u_8
            if p89.UserInputType == Enum.UserInputType.Touch or p89.UserInputType == Enum.UserInputType.MouseButton1 then
                if p89.UserInputState == Enum.UserInputState.Begin then
                    local v90 = v_u_45.Jump
                    if not v_u_37[v90] and p89.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v90] = p89
                    end
                end
                local v91 = v_u_37[v_u_45.Jump]
                local v92
                if v91 then
                    v92 = (not p89 or p89 == v91) and true or false
                else
                    v92 = false
                end
                if v92 then
                    v_u_8.jump()
                end
            end
        end)
        v_u_45.Crouch.InputBegan:Connect(function(p93)
            -- upvalues: (ref) v_u_45, (ref) v_u_37, (ref) v_u_65
            if p93.UserInputType == Enum.UserInputType.Touch or p93.UserInputType == Enum.UserInputType.MouseButton1 then
                if p93.UserInputState == Enum.UserInputState.Begin then
                    local v94 = v_u_45.Crouch
                    if not v_u_37[v94] and p93.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v94] = p93
                    end
                    if v_u_37[v_u_45.Crouch] == p93 then
                        v_u_65(v_u_45.Crouch, 0.9)
                    end
                end
            end
        end)
        v_u_45.Crouch.InputEnded:Connect(function(p95)
            -- upvalues: (ref) v_u_65, (ref) v_u_45, (ref) v_u_37, (ref) v_u_8
            if p95.UserInputType == Enum.UserInputType.Touch or p95.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.Crouch, 1)
                local v96 = v_u_37[v_u_45.Crouch]
                local v97
                if v96 then
                    v97 = (not p95 or p95 == v96) and true or false
                else
                    v97 = false
                end
                if v97 then
                    v_u_8.crouch(not v_u_8.GetCrouchState())
                end
                local v98 = v_u_45.Crouch
                if v_u_37[v98] == p95 then
                    v_u_37[v98] = nil
                end
            end
        end)
        v_u_45.Drop.InputEnded:Connect(function(p99)
            -- upvalues: (ref) v_u_45, (ref) v_u_37, (ref) v_u_21, (ref) v_u_9, (ref) v_u_15, (ref) v_u_25, (ref) v_u_20
            if p99.UserInputType == Enum.UserInputType.Touch or p99.UserInputType == Enum.UserInputType.MouseButton1 then
                local v100 = v_u_37[v_u_45.Drop]
                local v101
                if v100 then
                    v101 = (not p99 or p99 == v100) and true or false
                else
                    v101 = false
                end
                if v101 then
                    local v102 = v_u_45.Drop
                    if v_u_37[v102] == p99 then
                        v_u_37[v102] = nil
                    end
                    v_u_21.new(function(p103, p104)
                        -- upvalues: (ref) v_u_9
                        local v105 = v_u_9.getCurrentEquipped()
                        if v105 then
                            p103(v105)
                        else
                            p104("Failed to fetch current equipped")
                        end
                    end):catch(warn):andThen(function(p106)
                        -- upvalues: (ref) v_u_15, (ref) v_u_25, (ref) v_u_20
                        if p106 then
                            local v107 = v_u_15.GetSkinInformation(p106.Name, p106.Skin)
                            local v108 = "Skin data not found for weapon: " .. p106.Name .. " and skin: " .. p106.Skin
                            assert(v107, v108)
                            local v109 = v_u_25[v107.rarity]
                            local v110 = v109.Color.R * 255
                            local v111 = math.floor(v110)
                            local v112 = v109.Color.G * 255
                            local v113 = math.floor(v112)
                            local v114 = v109.Color.B * 255
                            local v115 = math.floor(v114)
                            if p106:drop() then
                                v_u_20.broadcastRouter("CreateNotification", "Item Dropped", ("You dropped your <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v111, v113, v115, p106.Name, p106.Skin), 2)
                            end
                        end
                    end)
                else
                    local v116 = v_u_45.Drop
                    if v_u_37[v116] == p99 then
                        v_u_37[v116] = nil
                    end
                end
            else
                return
            end
        end)
        v_u_45.Reload.InputBegan:Connect(function(p117)
            -- upvalues: (ref) v_u_45, (ref) v_u_37, (ref) v_u_65
            if p117.UserInputType == Enum.UserInputType.Touch or p117.UserInputType == Enum.UserInputType.MouseButton1 then
                if p117.UserInputState == Enum.UserInputState.Begin then
                    local v118 = v_u_45.Reload
                    if not v_u_37[v118] and p117.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v118] = p117
                    end
                    if v_u_37[v_u_45.Reload] == p117 then
                        v_u_65(v_u_45.Reload, 0.9)
                    end
                end
            end
        end)
        v_u_45.Reload.InputEnded:Connect(function(p119)
            -- upvalues: (ref) v_u_65, (ref) v_u_45, (ref) v_u_37, (ref) v_u_21, (ref) v_u_9
            if p119.UserInputType == Enum.UserInputType.Touch or p119.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.Reload, 1)
                local v120 = v_u_37[v_u_45.Reload]
                local v121
                if v120 then
                    v121 = (not p119 or p119 == v120) and true or false
                else
                    v121 = false
                end
                if v121 then
                    local v122 = v_u_45.Reload
                    if v_u_37[v122] == p119 then
                        v_u_37[v122] = nil
                    end
                    v_u_21.new(function(p123, p124)
                        -- upvalues: (ref) v_u_9
                        local v125 = v_u_9.getCurrentEquipped()
                        if v125 then
                            p123(v125)
                        else
                            p124("Failed to fetch current equipped")
                        end
                    end):catch(warn):andThen(function(p126)
                        if p126 then
                            p126:reload()
                        end
                    end)
                else
                    local v127 = v_u_45.Reload
                    if v_u_37[v127] == p119 then
                        v_u_37[v127] = nil
                    end
                end
            else
                return
            end
        end)
        v_u_45.Shoot.Active = true
        local v_u_128 = false
        local function v136(p129, p130)
            -- upvalues: (ref) v_u_34, (ref) v_u_128, (ref) v_u_65, (ref) v_u_45, (ref) v_u_21, (ref) v_u_9
            if p129 == v_u_34 then
                if p130 or p129.UserInputState == Enum.UserInputState.End then
                    v_u_34 = nil
                    if v_u_128 then
                        v_u_128 = false
                        v_u_65(v_u_45.Shoot, 1)
                        v_u_21.new(function(p131, p132)
                            -- upvalues: (ref) v_u_9
                            local v133 = v_u_9.getCurrentEquipped()
                            if v133 then
                                p131(v133)
                            else
                                p132("Failed to fetch current equipped")
                            end
                        end):catch(warn):andThen(function(p134)
                            if p134 then
                                if p134.Properties.Class == "Weapon" then
                                    if p134.Properties.ShootingOptions == "Revolver" then
                                        local v135 = p134.Properties.FireModes
                                        if v135 then
                                            v135 = p134.Properties.FireModes.Primary
                                        end
                                        if not v135 or v135.CancelOnRelease ~= false then
                                            p134:cancelRevolverCharge(false)
                                        else
                                            p134.IsFireHeld = false
                                            p134.FireInputBinding = nil
                                        end
                                    else
                                        p134.IsFireHeld = false
                                        return
                                    end
                                elseif p134.Properties.Class == "Melee" then
                                    p134.IsFireHeld = false
                                    return
                                elseif p134.Properties.Class == "C4" then
                                    p134:cancel()
                                    return
                                elseif p134.Properties.Slot == "Grenade" then
                                    p134:Throw("Far")
                                end
                            else
                                return
                            end
                        end)
                    end
                else
                    return
                end
            else
                return
            end
        end
        v_u_45.Shoot.InputBegan:Connect(function(p137)
            -- upvalues: (ref) v_u_34, (ref) v_u_27, (ref) v_u_11, (ref) v_u_16, (ref) v_u_20, (ref) v_u_128, (ref) v_u_65, (ref) v_u_45, (ref) v_u_21, (ref) v_u_9
            if p137.UserInputType == Enum.UserInputType.Touch or p137.UserInputType == Enum.UserInputType.MouseButton1 then
                if v_u_34 then
                    return
                elseif p137.UserInputState == Enum.UserInputState.Begin then
                    v_u_34 = p137
                    if v_u_27:GetAttribute("IsPlayerChatting") then
                        return
                    elseif v_u_11.IsLocalPlayerDead() then
                        return
                    elseif v_u_27.Character then
                        if v_u_16.GetState() ~= "Buy Period" then
                            v_u_20.broadcastRouter("Cancel Defuse Bomb")
                            v_u_128 = true
                            v_u_65(v_u_45.Shoot, 0.9)
                            v_u_21.new(function(p138, p139)
                                -- upvalues: (ref) v_u_9
                                local v140 = v_u_9.getCurrentEquipped()
                                if v140 then
                                    p138(v140)
                                else
                                    p139("Failed to fetch current equipped")
                                end
                            end):catch(warn):andThen(function(p141)
                                if p141 then
                                    if p141.Properties.Class == "Weapon" then
                                        if p141.Properties.ShootingOptions == "Revolver" then
                                            p141:startRevolverCharge(nil)
                                        else
                                            p141.IsFireHeld = true
                                            p141:shoot()
                                        end
                                    elseif p141.Properties.Class == "Melee" then
                                        p141.IsFireHeld = true
                                        p141:shoot()
                                        return
                                    elseif p141.Properties.Class == "C4" then
                                        p141:shoot()
                                        return
                                    elseif p141.Properties.Slot == "Grenade" then
                                        p141:StartThrow()
                                    end
                                else
                                    return
                                end
                            end)
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
        end)
        v_u_45.Shoot.InputEnded:Connect(v136)
        v_u_45.Shoot.InputChanged:Connect(function(p142)
            -- upvalues: (ref) v_u_34, (ref) v_u_29
            if p142 == v_u_34 and p142.UserInputType == Enum.UserInputType.Touch then
                v_u_29.addTouchMove(Vector2.new(p142.Delta.X, p142.Delta.Y))
            end
        end)
        v_u_45.Aim.Active = true
        local function v149(p143, p144)
            -- upvalues: (ref) v_u_35, (ref) v_u_65, (ref) v_u_45, (ref) v_u_21, (ref) v_u_9
            if p143 == v_u_35 then
                if p144 or p143.UserInputState == Enum.UserInputState.End then
                    v_u_35 = nil
                    v_u_65(v_u_45.Aim, 1)
                    v_u_21.new(function(p145, p146)
                        -- upvalues: (ref) v_u_9
                        local v147 = v_u_9.getCurrentEquipped()
                        if v147 then
                            p145(v147)
                        else
                            p146("Failed to fetch current equipped")
                        end
                    end):catch(warn):andThen(function(p148)
                        if p148 then
                            if p148.Properties.ShootingOptions == "Revolver" then
                                p148:stopRevolverSecondaryFire()
                                return
                            elseif p148.Properties.HasScope then
                                p148:unscope()
                            end
                        else
                            return
                        end
                    end)
                end
            else
                return
            end
        end
        v_u_45.Aim.InputBegan:Connect(function(p150)
            -- upvalues: (ref) v_u_35, (ref) v_u_65, (ref) v_u_45, (ref) v_u_21, (ref) v_u_9
            if p150.UserInputType == Enum.UserInputType.Touch or p150.UserInputType == Enum.UserInputType.MouseButton1 then
                if v_u_35 then
                    return
                elseif p150.UserInputState == Enum.UserInputState.Begin then
                    v_u_35 = p150
                    v_u_65(v_u_45.Aim, 0.9)
                    v_u_21.new(function(p151, p152)
                        -- upvalues: (ref) v_u_9
                        local v153 = v_u_9.getCurrentEquipped()
                        if v153 then
                            p151(v153)
                        else
                            p152("Failed to fetch current equipped")
                        end
                    end):catch(warn):andThen(function(p154)
                        if p154 then
                            if p154.Properties.HasScope then
                                p154:scope(true)
                                return
                            elseif p154.Properties.ShootingOptions == "Revolver" then
                                p154:startRevolverSecondaryFire(nil)
                                return
                            elseif p154.Properties.HasSuppressor then
                                if p154.IsSuppressed then
                                    p154:removeSuppressor()
                                else
                                    p154:addSuppressor()
                                end
                            elseif p154.Properties.ShootingOptions == "Burst" then
                                p154:updateFireMode()
                            end
                        else
                            return
                        end
                    end)
                end
            else
                return
            end
        end)
        v_u_45.Aim.InputEnded:Connect(v149)
        v_u_45.Aim.InputChanged:Connect(function(p155)
            -- upvalues: (ref) v_u_35, (ref) v_u_29
            if p155 == v_u_35 and p155.UserInputType == Enum.UserInputType.Touch then
                v_u_29.addTouchMove(Vector2.new(p155.Delta.X, p155.Delta.Y))
            end
        end)
        v_u_45.Interact.Active = true
        local v_u_156 = nil
        v_u_45.Interact.InputBegan:Connect(function(p157)
            -- upvalues: (ref) v_u_156, (ref) v_u_45, (ref) v_u_37, (ref) v_u_2, (ref) v_u_20, (ref) v_u_58, (ref) v_u_27, (ref) v_u_15, (ref) v_u_25, (ref) v_u_19
            if p157.UserInputType == Enum.UserInputType.Touch or p157.UserInputType == Enum.UserInputType.MouseButton1 then
                if v_u_156 then
                    return
                elseif p157.UserInputState == Enum.UserInputState.Begin then
                    v_u_156 = p157
                    local v158 = v_u_45.Interact
                    if not v_u_37[v158] and p157.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v158] = p157
                    end
                    local v159 = v_u_2:GetTagged("Bomb")[1]
                    if v159 and (v159:GetAttribute("CanDefuse") and not v159:GetAttribute("Defused")) then
                        v_u_20.broadcastRouter("Start Defuse Bomb")
                        return
                    else
                        local v160 = v_u_58()
                        if v160 then
                            local v161 = v_u_27:GetAttribute("Team")
                            if not v_u_27:GetAttribute("IsCarryingHostage") and (not v_u_27:GetAttribute("IsRescuingHostage") and v161 == "Counter-Terrorists") then
                                local v162 = v160:GetAttribute("RescuingPlayer")
                                local v163 = v160:GetAttribute("CarryingPlayer")
                                if (not v162 or v162 == v_u_27.Name) and not v163 then
                                    v_u_20.broadcastRouter("Start Rescue Hostage")
                                    return
                                end
                            end
                        end
                        local v164 = v_u_2:GetTagged("IsHoveringInteractable")
                        if #v164 == 0 then
                            return
                        else
                            local v165 = v164[1]
                            local v166 = v165:GetAttribute("Weapon")
                            local v167 = v165:GetAttribute("Skin")
                            if v166 ~= "C4" or v_u_27:GetAttribute("Team") == "Terrorists" then
                                if v165:GetAttribute("CanPickup") then
                                    local v168 = v_u_15.GetSkinInformation(v166, v167)
                                    if v168 then
                                        local v169 = v_u_25[v168.rarity]
                                        local v170 = v169.Color.R * 255
                                        local v171 = math.floor(v170)
                                        local v172 = v169.Color.G * 255
                                        local v173 = math.floor(v172)
                                        local v174 = v169.Color.B * 255
                                        local v175 = math.floor(v174)
                                        v_u_20.broadcastRouter("CreateNotification", "Item Picked Up", ("You picked up a <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v171, v173, v175, v166, v167), 2)
                                    end
                                    v_u_19.Inventory.PickupWeapon.Send({
                                        ["Identity"] = v165.Name,
                                        ["AllowAutoEquip"] = true
                                    })
                                end
                            end
                        end
                    end
                else
                    return
                end
            else
                return
            end
        end)
        local function v_u_178(p176)
            -- upvalues: (ref) v_u_156, (ref) v_u_45, (ref) v_u_37, (ref) v_u_2, (ref) v_u_27, (ref) v_u_20
            if p176 == v_u_156 then
                v_u_156 = nil
                local v177 = v_u_45.Interact
                if v_u_37[v177] == p176 then
                    v_u_37[v177] = nil
                end
                if v_u_2:GetTagged("Bomb")[1] and v_u_27:GetAttribute("IsDefusingBomb") then
                    v_u_20.broadcastRouter("Cancel Defuse Bomb")
                    return
                elseif v_u_27:GetAttribute("IsRescuingHostage") then
                    v_u_20.broadcastRouter("Cancel Rescue Hostage")
                end
            else
                return
            end
        end
        v_u_45.Interact.InputEnded:Connect(v_u_178)
        v_u_45.Interact.InputChanged:Connect(function(p179)
            -- upvalues: (ref) v_u_156, (ref) v_u_29
            if p179 == v_u_156 and p179.UserInputType == Enum.UserInputType.Touch then
                v_u_29.addTouchMove(Vector2.new(p179.Delta.X, p179.Delta.Y))
            end
        end)
        v_u_45.Shop.InputBegan:Connect(function(p180)
            -- upvalues: (ref) v_u_45, (ref) v_u_37, (ref) v_u_65
            if p180.UserInputType == Enum.UserInputType.Touch or p180.UserInputType == Enum.UserInputType.MouseButton1 then
                if p180.UserInputState == Enum.UserInputState.Begin then
                    local v181 = v_u_45.Shop
                    if not v_u_37[v181] and p180.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v181] = p180
                    end
                    if v_u_37[v_u_45.Shop] == p180 then
                        v_u_65(v_u_45.Shop, 0.9)
                    end
                end
            end
        end)
        v_u_45.Shop.InputEnded:Connect(function(p182)
            -- upvalues: (ref) v_u_65, (ref) v_u_45, (ref) v_u_37, (ref) v_u_23
            if p182.UserInputType == Enum.UserInputType.Touch or p182.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.Shop, 1)
                local v183 = v_u_37[v_u_45.Shop]
                local v184
                if v183 then
                    v184 = (not p182 or p182 == v183) and true or false
                else
                    v184 = false
                end
                if v184 then
                    local v185 = v_u_45.Shop
                    if v_u_37[v185] == p182 then
                        v_u_37[v185] = nil
                    end
                    v_u_23.toggleFrame()
                else
                    local v186 = v_u_45.Shop
                    if v_u_37[v186] == p182 then
                        v_u_37[v186] = nil
                    end
                end
            else
                return
            end
        end)
        v_u_45.Menu.InputBegan:Connect(function(p187)
            -- upvalues: (ref) v_u_45, (ref) v_u_37, (ref) v_u_65
            if p187.UserInputType == Enum.UserInputType.Touch or p187.UserInputType == Enum.UserInputType.MouseButton1 then
                if p187.UserInputState == Enum.UserInputState.Begin then
                    local v188 = v_u_45.Menu
                    if not v_u_37[v188] and p187.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v188] = p187
                    end
                    if v_u_37[v_u_45.Menu] == p187 then
                        v_u_65(v_u_45.Menu, 0.9)
                    end
                end
            end
        end)
        v_u_45.Menu.InputEnded:Connect(function(p189)
            -- upvalues: (ref) v_u_65, (ref) v_u_45, (ref) v_u_37, (ref) v_u_24
            if p189.UserInputType == Enum.UserInputType.Touch or p189.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.Menu, 1)
                local v190 = v_u_37[v_u_45.Menu]
                local v191
                if v190 then
                    v191 = (not p189 or p189 == v190) and true or false
                else
                    v191 = false
                end
                if v191 then
                    local v192 = v_u_45.Menu
                    if v_u_37[v192] == p189 then
                        v_u_37[v192] = nil
                    end
                    v_u_24.ToggleMenu()
                else
                    local v193 = v_u_45.Menu
                    if v_u_37[v193] == p189 then
                        v_u_37[v193] = nil
                    end
                end
            else
                return
            end
        end)
        v_u_45.Inspect.InputBegan:Connect(function(p194)
            -- upvalues: (ref) v_u_45, (ref) v_u_37, (ref) v_u_65
            if p194.UserInputType == Enum.UserInputType.Touch or p194.UserInputType == Enum.UserInputType.MouseButton1 then
                if p194.UserInputState == Enum.UserInputState.Begin then
                    local v195 = v_u_45.Inspect
                    if not v_u_37[v195] and p194.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v195] = p194
                    end
                    if v_u_37[v_u_45.Inspect] == p194 then
                        v_u_65(v_u_45.Inspect, 0.9)
                    end
                end
            end
        end)
        v_u_45.Inspect.InputEnded:Connect(function(p196)
            -- upvalues: (ref) v_u_65, (ref) v_u_45, (ref) v_u_37, (ref) v_u_27, (ref) v_u_10, (ref) v_u_12, (ref) v_u_9, (ref) v_u_14
            if p196.UserInputType == Enum.UserInputType.Touch or p196.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.Inspect, 1)
                local v197 = v_u_37[v_u_45.Inspect]
                local v198
                if v197 then
                    v198 = (not p196 or p196 == v197) and true or false
                else
                    v198 = false
                end
                if v198 then
                    local v199 = v_u_45.Inspect
                    if v_u_37[v199] == p196 then
                        v_u_37[v199] = nil
                    end
                    if v_u_27:GetAttribute("IsPlayerChatting") then
                        return
                    elseif not (v_u_10.IsActive() or v_u_12.IsActive()) then
                        local v200 = v_u_9.getCurrentEquipped()
                        if v200 then
                            v200:inspect()
                            v_u_14:clearHint("Inspect")
                        end
                    end
                else
                    local v201 = v_u_45.Inspect
                    if v_u_37[v201] == p196 then
                        v_u_37[v201] = nil
                    end
                    return
                end
            else
                return
            end
        end)
        v_u_45.SwapTeam.InputBegan:Connect(function(p202)
            -- upvalues: (ref) v_u_45, (ref) v_u_37, (ref) v_u_65
            if p202.UserInputType == Enum.UserInputType.Touch or p202.UserInputType == Enum.UserInputType.MouseButton1 then
                if p202.UserInputState == Enum.UserInputState.Begin then
                    local v203 = v_u_45.SwapTeam
                    if not v_u_37[v203] and p202.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v203] = p202
                    end
                    if v_u_37[v_u_45.SwapTeam] == p202 then
                        v_u_65(v_u_45.SwapTeam, 0.9)
                    end
                end
            end
        end)
        v_u_45.SwapTeam.InputEnded:Connect(function(p204)
            -- upvalues: (ref) v_u_65, (ref) v_u_45, (ref) v_u_37, (ref) v_u_27, (ref) v_u_22
            if p204.UserInputType == Enum.UserInputType.Touch or p204.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.SwapTeam, 1)
                local v205 = v_u_37[v_u_45.SwapTeam]
                local v206
                if v205 then
                    v206 = (not p204 or p204 == v205) and true or false
                else
                    v206 = false
                end
                if v206 then
                    local v207 = v_u_45.SwapTeam
                    if v_u_37[v207] == p204 then
                        v_u_37[v207] = nil
                    end
                    if v_u_27:GetAttribute("IsSpectating") then
                        v_u_22.openFrame()
                        return
                    elseif v_u_27.Character then
                        v_u_22.ToggleTeamSelection()
                    end
                else
                    local v208 = v_u_45.SwapTeam
                    if v_u_37[v208] == p204 then
                        v_u_37[v208] = nil
                    end
                    return
                end
            else
                return
            end
        end)
        v_u_45.Ping.InputBegan:Connect(function(p209)
            -- upvalues: (ref) v_u_45, (ref) v_u_37, (ref) v_u_65
            if p209.UserInputType == Enum.UserInputType.Touch or p209.UserInputType == Enum.UserInputType.MouseButton1 then
                if p209.UserInputState == Enum.UserInputState.Begin then
                    local v210 = v_u_45.Ping
                    if not v_u_37[v210] and p209.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v210] = p209
                    end
                    if v_u_37[v_u_45.Ping] == p209 then
                        v_u_65(v_u_45.Ping, 0.9)
                        return
                    end
                end
            end
        end)
        v_u_45.Ping.InputEnded:Connect(function(p211)
            -- upvalues: (ref) v_u_65, (ref) v_u_45, (ref) v_u_37, (ref) v_u_13, (ref) v_u_27, (ref) v_u_53, (ref) v_u_49, (ref) v_u_19, (ref) v_u_36
            if p211.UserInputType == Enum.UserInputType.Touch or p211.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.Ping, 1)
                local v212 = v_u_37[v_u_45.Ping]
                local v213
                if v212 then
                    v213 = (not p211 or p211 == v212) and true or false
                else
                    v213 = false
                end
                if v213 then
                    local v214 = v_u_45.Ping
                    if v_u_37[v214] == p211 then
                        v_u_37[v214] = nil
                    end
                    if workspace:GetAttribute("Gamemode") == "Deathmatch" then
                        return
                    elseif v_u_13.Get(v_u_27, "Settings.Game.HUD.Player Pings") == "Disabled" then
                        return
                    else
                        local v215 = v_u_27.Character
                        local v216
                        if v215 and v215:IsDescendantOf(workspace) then
                            local v217 = v215:FindFirstChildOfClass("Humanoid")
                            v216 = v217 and v217.Health > 0 and true or false
                        else
                            v216 = false
                        end
                        if v216 then
                            local v218 = v_u_53(v_u_27.Character)
                            if v218 then
                                local v219, v220, v221 = v_u_49(v218.Instance)
                                local v222
                                if v219 then
                                    if v220 then
                                        v222 = v221
                                    else
                                        v222 = v220
                                    end
                                else
                                    v222 = v219
                                end
                                if v222 then
                                    v_u_19.Ping.CreatePlayerPositionPing.Send({
                                        ["Position"] = v218.Position,
                                        ["WeaponIdentity"] = v221,
                                        ["WeaponName"] = v219,
                                        ["WeaponSkin"] = v220,
                                        ["IsDanger"] = false
                                    })
                                else
                                    v_u_19.Ping.CreatePlayerPositionPing.Send({
                                        ["IsDanger"] = tick() - v_u_36 < 0.5,
                                        ["Position"] = v218.Position
                                    })
                                end
                                v_u_36 = tick()
                            end
                        else
                            return
                        end
                    end
                else
                    local v223 = v_u_45.Ping
                    if v_u_37[v223] == p211 then
                        v_u_37[v223] = nil
                    end
                    return
                end
            else
                return
            end
        end)
        local v_u_224 = v_u_128
        local v_u_225 = v_u_156
        for _, v226 in ipairs(v_u_45:GetChildren()) do
            if v226:IsA("TextButton") and (v226.Name ~= "Shoot" and v226.Name ~= "Aim") then
                v_u_1.setupButton(v226)
            end
        end
        v_u_6.Heartbeat:Connect(function()
            -- upvalues: (ref) v_u_27, (ref) v_u_45, (ref) v_u_17, (ref) v_u_69, (ref) v_u_11, (ref) v_u_9, (ref) v_u_72
            local _ = v_u_27:GetAttribute("IsSpectating") == true
            local v227 = v_u_45.Shop
            local v228 = v_u_27:GetAttribute("BuyMenu")
            if v228 then
                v228 = v_u_17(v_u_27)
            end
            v227.Visible = v228
            v_u_69()
            if v_u_45:FindFirstChild("Inspect") then
                if v_u_11.IsLocalPlayerDead() then
                    v_u_45.Inspect.Visible = false
                else
                    local v229 = v_u_9.getCurrentEquipped()
                    v_u_45.Inspect.Visible = v229 ~= nil
                end
            end
            if v_u_11.IsLocalPlayerDead() then
                v_u_45.Reload.Visible = false
            else
                local v230 = v_u_9.getCurrentEquipped()
                if v230 then
                    if v230.Properties.Class == "Weapon" then
                        v_u_45.Reload.Visible = true
                    else
                        v_u_45.Reload.Visible = false
                    end
                else
                    v_u_45.Reload.Visible = false
                end
            end
            v_u_72()
            if v_u_27:GetAttribute("IsSpectating") == true or v_u_11.IsLocalPlayerDead() then
                v_u_45.Ping.Visible = false
            else
                v_u_45.Ping.Visible = workspace:GetAttribute("Gamemode") ~= "Deathmatch"
            end
            local v231 = v_u_9.getCurrentEquipped()
            if v231 then
                local v232 = v231.Properties.ShootingOptions == "Burst"
                local v233 = v231.Properties.ShootingOptions == "Revolver"
                local v234 = v231.Properties.HasSuppressor == true
                local v235 = v231.Properties.HasScope == true
                v_u_45.Aim.Visible = v235 or (v234 or (v232 or v233))
            else
                v_u_45.Aim.Visible = false
            end
        end)
        v_u_4.InputChanged:Connect(function(p236)
            -- upvalues: (ref) v_u_34, (ref) v_u_35, (ref) v_u_225, (ref) v_u_29
            if p236 == v_u_34 or (p236 == v_u_35 or p236 == v_u_225) then
                v_u_29.addTouchMove(Vector2.new(p236.Delta.X, p236.Delta.Y))
            end
        end)
        v_u_4.InputEnded:Connect(function(p237)
            -- upvalues: (ref) v_u_34, (ref) v_u_224, (ref) v_u_65, (ref) v_u_45, (ref) v_u_21, (ref) v_u_9, (ref) v_u_35, (copy) v_u_178, (ref) v_u_37
            if p237.UserInputType == Enum.UserInputType.Touch or p237.UserInputType == Enum.UserInputType.MouseButton1 then
                if p237 == v_u_34 then
                    v_u_34 = nil
                    if v_u_224 then
                        v_u_224 = false
                        v_u_65(v_u_45.Shoot, 1)
                        v_u_21.new(function(p238, p239)
                            -- upvalues: (ref) v_u_9
                            local v240 = v_u_9.getCurrentEquipped()
                            if v240 then
                                p238(v240)
                            else
                                p239("Failed to fetch current equipped")
                            end
                        end):catch(warn):andThen(function(p241)
                            if p241 then
                                if p241.Properties.Class == "Weapon" then
                                    if p241.Properties.ShootingOptions == "Revolver" then
                                        local v242 = p241.Properties.FireModes
                                        if v242 then
                                            v242 = p241.Properties.FireModes.Primary
                                        end
                                        if not v242 or v242.CancelOnRelease ~= false then
                                            p241:cancelRevolverCharge(false)
                                        else
                                            p241.IsFireHeld = false
                                            p241.FireInputBinding = nil
                                        end
                                    else
                                        p241.IsFireHeld = false
                                        return
                                    end
                                elseif p241.Properties.Class == "Melee" then
                                    p241.IsFireHeld = false
                                    return
                                elseif p241.Properties.Class == "C4" then
                                    p241:cancel()
                                    return
                                elseif p241.Properties.Slot == "Grenade" then
                                    p241:Throw("Far")
                                end
                            else
                                return
                            end
                        end)
                    end
                end
                if p237 == v_u_35 then
                    v_u_35 = nil
                    v_u_65(v_u_45.Aim, 1)
                    v_u_21.new(function(p243, p244)
                        -- upvalues: (ref) v_u_9
                        local v245 = v_u_9.getCurrentEquipped()
                        if v245 then
                            p243(v245)
                        else
                            p244("Failed to fetch current equipped")
                        end
                    end):catch(warn):andThen(function(p246)
                        if p246 then
                            if p246.Properties.ShootingOptions == "Revolver" then
                                p246:stopRevolverSecondaryFire()
                                return
                            elseif p246.Properties.HasScope then
                                p246:unscope()
                            end
                        else
                            return
                        end
                    end)
                end
                v_u_178(p237)
                for v247, v248 in pairs(v_u_37) do
                    if v248 == p237 then
                        v_u_37[v247] = nil
                    end
                end
            end
        end)
    else
        v_u_45.Visible = false
    end
end
function v_u_1.Start()
    -- upvalues: (ref) v_u_45, (copy) v_u_33, (copy) v_u_27, (copy) v_u_44, (copy) v_u_43, (ref) v_u_35, (copy) v_u_13, (copy) v_u_38
    v_u_45.Visible = false
    if v_u_33 then
        if v_u_27:GetAttribute("IsSpectating") == true then
            if v_u_45 then
                for _, v249 in ipairs(v_u_44) do
                    local v250 = v_u_45:FindFirstChild(v249)
                    if v250 then
                        v250.Visible = table.find(v_u_43, v249) ~= nil
                    end
                end
            end
            v_u_45.Visible = true
        elseif v_u_27.Character then
            if v_u_45 then
                for _, v251 in ipairs(v_u_44) do
                    local v252 = v_u_45:FindFirstChild(v251)
                    if v252 then
                        v252.Visible = true
                    end
                end
            end
            v_u_45.Visible = true
        end
    end
    v_u_27.CharacterAdded:Connect(function()
        -- upvalues: (ref) v_u_45, (ref) v_u_33, (ref) v_u_44
        v_u_45.Visible = v_u_33
        if v_u_45 then
            for _, v253 in ipairs(v_u_44) do
                local v254 = v_u_45:FindFirstChild(v253)
                if v254 then
                    v254.Visible = true
                end
            end
        end
    end)
    v_u_27.CharacterRemoving:Connect(function()
        -- upvalues: (ref) v_u_27, (ref) v_u_35, (ref) v_u_33, (ref) v_u_45, (ref) v_u_44, (ref) v_u_43
        local v255 = v_u_27:GetAttribute("IsSpectating") == true
        v_u_35 = nil
        if v255 and v_u_33 then
            if v_u_45 then
                for _, v256 in ipairs(v_u_44) do
                    local v257 = v_u_45:FindFirstChild(v256)
                    if v257 then
                        v257.Visible = table.find(v_u_43, v256) ~= nil
                    end
                end
            end
            v_u_45.Visible = true
        else
            v_u_45.Visible = false
        end
    end)
    v_u_27:GetAttributeChangedSignal("IsSpectating"):Connect(function()
        -- upvalues: (ref) v_u_27, (ref) v_u_33, (ref) v_u_45, (ref) v_u_44, (ref) v_u_43
        local v258 = v_u_27:GetAttribute("IsSpectating") == true
        if v_u_33 then
            if v258 then
                if v_u_45 then
                    for _, v259 in ipairs(v_u_44) do
                        local v260 = v_u_45:FindFirstChild(v259)
                        if v260 then
                            v260.Visible = table.find(v_u_43, v259) ~= nil
                        end
                    end
                end
                v_u_45.Visible = true
                return
            elseif v_u_27.Character then
                if v_u_45 then
                    for _, v261 in ipairs(v_u_44) do
                        local v262 = v_u_45:FindFirstChild(v261)
                        if v262 then
                            v262.Visible = true
                        end
                    end
                end
                v_u_45.Visible = true
            else
                v_u_45.Visible = false
            end
        elseif not v258 then
            v_u_45.Visible = false
        end
    end)
    v_u_13.CreateListener(v_u_27, "MobileButtons", function(p263)
        -- upvalues: (ref) v_u_45, (ref) v_u_38
        if typeof(p263) == "table" then
            for v264, v265 in pairs(p263) do
                local v266 = v_u_45:FindFirstChild(v264)
                if v266 then
                    v266.Position = UDim2.fromScale(v265.Position.X, v265.Position.Y)
                    v266.Size = UDim2.fromScale(v265.Size.X, v265.Size.Y)
                    v_u_38[v266] = v266.Size
                end
            end
        end
    end)
end
return v_u_1
