-- MODULESCRIPT: Ammo
-- Original Path: game.BAC - 17285.Interface.Screens.Gameplay.Bottom.Ammo
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = v5.LocalPlayer
local v_u_7 = require(v2.Controllers.InventoryController)
local v_u_8 = require(v2.Controllers.SpectateController)
local v_u_9 = require(v2.Components.Common.GetPreferenceColor)
local v_u_10 = require(v2.Components.Common.GetWeaponProperties)
local v_u_11 = require(v2.Controllers.DataController)
local v_u_12 = require(v2.Database.Components.GameState)
local v_u_13 = require(v2.Packages.Observers)
local v14 = require(v2.Shared.Janitor)
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = game:GetService("HttpService")
local v_u_20 = v14.new()
function v_u_1.tweenAnimation(p21)
    -- upvalues: (ref) v_u_15, (ref) v_u_17, (ref) v_u_16
    if v_u_15 ~= p21.Identifier then
        v_u_15 = p21.Identifier
        v_u_17.Size = UDim2.new(v_u_17.Size.X.Scale, -25, v_u_17.Size.Y.Scale, -25)
        if v_u_16 then
            v_u_16:Play()
        end
    end
end
function v_u_1.updateFrame(p22)
    -- upvalues: (ref) v_u_17, (copy) v_u_1, (copy) v_u_9, (ref) v_u_16, (ref) v_u_18
    local v23 = p22.Properties
    local v24 = v_u_17
    local v25
    if v23 == nil or v23.Class ~= "Weapon" then
        v25 = false
    else
        v25 = v23.MuzzleType ~= "Zeus x27"
    end
    v24.Visible = v25
    if v_u_17.Visible then
        v_u_1.tweenAnimation(p22)
        local v26 = p22.Rounds
        local v27 = p22.Capacity
        v_u_17.Capacity.Amount.Text = tostring(v27)
        v_u_17.Rounds.Amount.Text = tostring(v26)
        local v28 = v_u_9()
        v_u_17.Capacity.Amount.TextColor3 = v28
        v_u_17.Rounds.Amount.TextColor3 = v28
        v_u_17.Divider.BackgroundColor3 = v28
        v_u_17.SemiAuto.ImageColor3 = v28
        v_u_17.Auto.ImageColor3 = v28
        local v29 = v26 / v23.Rounds
        v_u_17.Rounds.Glow.ImageTransparency = 1
        if v29 <= 0.2 then
            v_u_17.Rounds.Glow.ImageTransparency = math.max(v29, 0.3)
        end
        if v23.ShootingOptions == "Default" then
            v_u_17.SemiAuto.Visible = not v23.Automatic
            v_u_17.Auto.Visible = v23.Automatic
        elseif v23.ShootingOptions == "Burst" then
            v_u_17.SemiAuto.Visible = p22.AlternativeShootingOption == "Default"
            v_u_17.Auto.Visible = p22.AlternativeShootingOption == "Burst"
        elseif v23.ShootingOptions == "Revolver" then
            v_u_17.SemiAuto.Visible = false
            v_u_17.Auto.Visible = false
        end
    elseif v_u_16 then
        v_u_16:Cancel()
    end
    local v30 = v_u_17
    local v31 = v_u_17.Visible
    if v31 then
        v31 = not v_u_18.Gameplay.Middle.BuyMenu.Visible
    end
    v30.Visible = v31
end
local function v_u_39()
    -- upvalues: (copy) v_u_7, (ref) v_u_17, (copy) v_u_1
    local v32 = v_u_7.getCurrentEquipped()
    if v32 then
        local v33 = v32.Rounds
        local v34 = v32.Capacity
        local v35 = v_u_17.Rounds.Amount.Text
        local v36 = tonumber(v35) or 0
        local v37 = v_u_17.Capacity.Amount.Text
        local v38 = tonumber(v37) or 0
        if v33 ~= v36 or v34 ~= v38 then
            v_u_1.updateFrame(v32)
        end
    end
end
function v_u_1.characterAdded(_, p40)
    -- upvalues: (copy) v_u_20, (copy) v_u_6, (copy) v_u_4, (copy) v_u_7, (copy) v_u_1, (copy) v_u_39, (copy) v_u_13, (copy) v_u_19, (copy) v_u_10, (ref) v_u_17
    v_u_20:Cleanup()
    if p40 == v_u_6 then
        v_u_20:Add(v_u_4.Stepped:Connect(function(_, _)
            -- upvalues: (ref) v_u_7, (ref) v_u_1
            local v41 = v_u_7.getCurrentEquipped()
            if v41 then
                v_u_1.updateFrame(v41)
            end
        end))
        task.wait(0.1)
        v_u_39()
        task.delay(3, function()
            -- upvalues: (ref) v_u_6, (ref) v_u_39
            if v_u_6.Character and v_u_6.Character:IsDescendantOf(workspace) then
                v_u_39()
            end
        end)
        return
    else
        v_u_20:Add(v_u_13.observeAttribute(p40, "CurrentEquipped", function(p42)
            -- upvalues: (ref) v_u_19, (ref) v_u_10, (ref) v_u_1, (ref) v_u_17
            if p42 then
                local v43 = v_u_19:JSONDecode(p42)
                if v43 and v43.Name then
                    local v44 = {
                        ["Properties"] = v_u_10(v43.Name),
                        ["Identifier"] = v43.Identifier or "",
                        ["Rounds"] = v43.Rounds or 0,
                        ["Capacity"] = v43.Capacity or 0,
                        ["AlternativeShootingOption"] = "Default"
                    }
                    local v45 = v44.Properties
                    local v46
                    if v45 == nil or v45.Class ~= "Weapon" then
                        v46 = false
                    else
                        v46 = v45.MuzzleType ~= "Zeus x27"
                    end
                    if v46 then
                        v_u_1.updateFrame(v44)
                    else
                        v_u_17.Visible = false
                    end
                else
                    v_u_17.Visible = false
                    return
                end
            else
                v_u_17.Visible = false
                return
            end
        end))
        local v47 = p40:GetAttribute("CurrentEquipped")
        if v47 then
            local v48 = v_u_19:JSONDecode(v47)
            if v48 and v48.Name then
                local v49 = {
                    ["Properties"] = v_u_10(v48.Name),
                    ["Identifier"] = v48.Identifier or "",
                    ["Rounds"] = v48.Rounds or 0,
                    ["Capacity"] = v48.Capacity or 0,
                    ["AlternativeShootingOption"] = "Default"
                }
                local v50 = v49.Properties
                local v51
                if v50 == nil or v50.Class ~= "Weapon" then
                    v51 = false
                else
                    v51 = v50.MuzzleType ~= "Zeus x27"
                end
                if v51 then
                    v_u_1.updateFrame(v49)
                else
                    v_u_17.Visible = false
                end
            else
                v_u_17.Visible = false
                return
            end
        else
            v_u_17.Visible = false
            return
        end
    end
end
function v_u_1.Initialize(p52, p53)
    -- upvalues: (ref) v_u_18, (ref) v_u_17, (ref) v_u_16, (copy) v_u_3, (copy) v_u_6, (copy) v_u_20, (copy) v_u_13, (copy) v_u_11, (copy) v_u_7, (copy) v_u_1
    v_u_18 = p52
    v_u_17 = p53
    if v_u_17.Active then
        v_u_17.Active = false
    end
    for _, v54 in ipairs(v_u_17:GetDescendants()) do
        if v54:IsA("GuiObject") then
            v54.Active = false
        end
    end
    v_u_16 = v_u_3:Create(v_u_17, TweenInfo.new(0.25), {
        ["Size"] = UDim2.fromScale(v_u_17.Size.X.Scale, v_u_17.Size.Y.Scale)
    })
    v_u_6.CharacterRemoving:Connect(function()
        -- upvalues: (ref) v_u_20
        v_u_20:Cleanup()
    end)
    v_u_13.observeProperty(v_u_17.Rounds.Amount, "Text", function(_)
        -- upvalues: (ref) v_u_3, (ref) v_u_17
        local v55 = v_u_3:Create(v_u_17.Rounds.Amount.UIScale, TweenInfo.new(0.05), {
            ["Scale"] = 1.2
        })
        v55:Play()
        v55.Completed:Once(function()
            -- upvalues: (ref) v_u_3, (ref) v_u_17
            v_u_3:Create(v_u_17.Rounds.Amount.UIScale, TweenInfo.new(0.05, Enum.EasingStyle.Elastic), {
                ["Scale"] = 1
            }):Play()
        end)
    end)
    v_u_11.CreateListener(v_u_6, "Settings.Game.HUD.Color", function()
        -- upvalues: (ref) v_u_7, (ref) v_u_1
        local v56 = v_u_7.getCurrentEquipped()
        if v56 then
            v_u_1.updateFrame(v56)
        end
    end)
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_20, (copy) v_u_1, (copy) v_u_6, (copy) v_u_8, (copy) v_u_12
    local v_u_57 = nil
    local function v_u_62(p_u_58)
        -- upvalues: (ref) v_u_20, (ref) v_u_57, (ref) v_u_1, (ref) v_u_6
        v_u_20:Cleanup()
        v_u_57 = p_u_58
        local v59 = p_u_58.Character
        if v59 and v59:IsDescendantOf(workspace) then
            v_u_1.characterAdded(v59, p_u_58)
        elseif p_u_58 ~= v_u_6 then
            local v_u_60 = nil
            v_u_60 = p_u_58.CharacterAdded:Connect(function(p61)
                -- upvalues: (ref) v_u_57, (copy) p_u_58, (ref) v_u_1, (ref) v_u_60
                if v_u_57 == p_u_58 and p61:IsDescendantOf(workspace) then
                    v_u_1.characterAdded(p61, p_u_58)
                    v_u_60:Disconnect()
                end
            end)
            v_u_20:Add(v_u_60)
        end
    end
    v_u_6.CharacterAdded:Connect(function()
        -- upvalues: (copy) v_u_62, (ref) v_u_6
        v_u_62(v_u_6)
    end)
    v_u_8.ListenToSpectate:Connect(function(p63)
        -- upvalues: (copy) v_u_62, (ref) v_u_6
        if p63 then
            v_u_62(p63)
        elseif not v_u_6:GetAttribute("IsSpectating") then
            v_u_62(v_u_6)
        end
    end)
    v_u_6:GetAttributeChangedSignal("IsSpectating"):Connect(function()
        -- upvalues: (ref) v_u_6, (copy) v_u_62, (ref) v_u_8
        if v_u_6:GetAttribute("IsSpectating") then
            local v64 = v_u_8.GetPlayer()
            if v64 then
                v_u_62(v64)
            end
        else
            v_u_62(v_u_6)
        end
    end)
    if v_u_6:GetAttribute("IsSpectating") then
        local v65 = v_u_8.GetPlayer()
        if v65 then
            v_u_62(v65)
        end
    else
        v_u_62(v_u_6)
    end
    v_u_12.ListenToState(function(_, p66)
        -- upvalues: (copy) v_u_62, (ref) v_u_6
        if p66 == "Buy Period" or p66 == "Round In Progress" then
            v_u_62(v_u_6)
        end
    end)
end
return v_u_1
