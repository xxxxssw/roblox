-- MODULESCRIPT: SecondaryFire
-- Original Path: game.BAC - 21977.Controllers.InputController.Actions.SecondaryFire
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("UserInputService")
require(script.Parent.Parent.Types)
local v_u_4 = v2.LocalPlayer
local v_u_5 = require(v1.Controllers.InventoryController)
local v_u_6 = require(v1.Controllers.SpectateController)
local v_u_7 = require(v1.Controllers.CaseSceneController)
local v_u_8 = require(v1.Controllers.InspectController)
local v_u_9 = require(v1.Database.Components.GameState)
local v_u_10 = {
    ["ToggleScope"] = true
}
local v_u_11 = false
local function v_u_13(p12)
    if p12.KeyCode and p12.KeyCode ~= Enum.KeyCode.Unknown then
        return p12.KeyCode
    elseif p12.UserInputType == Enum.UserInputType.MouseButton1 or (p12.UserInputType == Enum.UserInputType.MouseButton2 or p12.UserInputType == Enum.UserInputType.MouseButton3) then
        return p12.UserInputType
    else
        return nil
    end
end
local function v_u_15(p14)
    return (p14 == Enum.UserInputType.Gamepad1 or (p14 == Enum.UserInputType.Gamepad2 or (p14 == Enum.UserInputType.Gamepad3 or (p14 == Enum.UserInputType.Gamepad4 or (p14 == Enum.UserInputType.Gamepad5 or (p14 == Enum.UserInputType.Gamepad6 or p14 == Enum.UserInputType.Gamepad7)))))) and true or p14 == Enum.UserInputType.Gamepad8
end
local function v_u_20(p16)
    -- upvalues: (copy) v_u_15, (copy) v_u_3
    if p16.KeyCode ~= Enum.KeyCode.ButtonL2 then
        return false
    end
    local v17 = p16.UserInputType
    if not v_u_15(v17) then
        return false
    end
    local v18 = v_u_3:GetGamepadState(v17)
    for _, v19 in ipairs(v18) do
        if v19.KeyCode == p16.KeyCode then
            return v19.Position.Z > 0.3
        end
    end
    return false
end
local v25 = {
    ["Name"] = "Secondary Fire",
    ["Group"] = "Default",
    ["Category"] = "Weapon Keys",
    ["Callback"] = function(p21, p22)
        -- upvalues: (copy) v_u_4, (copy) v_u_6, (ref) v_u_11, (copy) v_u_7, (copy) v_u_8, (copy) v_u_5, (copy) v_u_9, (copy) v_u_15, (copy) v_u_13, (copy) v_u_10, (copy) v_u_20
        if v_u_4:GetAttribute("IsSpectating") and p21 == Enum.UserInputState.Begin then
            v_u_6.Next()
            return
        elseif v_u_6.IsLocalPlayerDead() then
            if p21 == Enum.UserInputState.End then
                v_u_11 = false
            end
            return
        elseif v_u_7.IsActive() or v_u_8.IsActive() then
            if p21 == Enum.UserInputState.End then
                v_u_11 = false
            end
            return
        else
            local v23 = v_u_5.getCurrentEquipped()
            if v_u_4.Character and v23 then
                if not v23 or (v23.Properties.Slot ~= "Grenade" or v_u_9.GetState() ~= "Buy Period") then
                    if p21 == Enum.UserInputState.Begin then
                        if v23.Properties.ShootingOptions == "Revolver" then
                            local v24 = v_u_15(p22.UserInputType)
                            if v24 then
                                v24 = p22.KeyCode == Enum.KeyCode.ButtonL2
                            end
                            if not (v24 and v_u_11) then
                                if v24 then
                                    v_u_11 = true
                                end
                                v23:startRevolverSecondaryFire((v_u_13(p22)))
                            end
                        end
                        if v23.Properties.Class == "Grenade" then
                            if v_u_9.GetState() ~= "Buy Period" then
                                v23:StartThrow()
                                return
                            end
                        else
                            if v23.Properties.HasScope then
                                v23:scope(v_u_10.ToggleScope)
                                return
                            end
                            if v23.Properties.HasSuppressor then
                                if v23.IsSuppressed then
                                    v23:removeSuppressor()
                                else
                                    v23:addSuppressor()
                                end
                            end
                            if v23.Properties.ShootingOptions == "Burst" then
                                v23:updateFireMode()
                                return
                            end
                            if v23.Properties.Type == "Equipment" and v_u_9.GetState() ~= "Buy Period" then
                                v23:shoot(true)
                                return
                            end
                        end
                    else
                        if v23.Properties.ShootingOptions == "Revolver" and p21 == Enum.UserInputState.End then
                            if not v_u_20(p22) then
                                v_u_11 = false
                                v23:stopRevolverSecondaryFire()
                            end
                        end
                        if v23.Properties.HasScope and (not v_u_10.ToggleScope and p21 == Enum.UserInputState.End) then
                            v_u_11 = false
                            v23:unscope()
                            return
                        end
                        if v23.Properties.Slot == "Grenade" and p21 == Enum.UserInputState.End then
                            v_u_11 = false
                            if v_u_9.GetState() == "Buy Period" then
                                return
                            end
                            if v23.ThrowStarted and not v23.ThrowFinished then
                                v23:Throw("Near")
                                return
                            end
                        elseif p21 == Enum.UserInputState.End then
                            v_u_11 = false
                        end
                    end
                end
            else
                if p21 == Enum.UserInputState.End then
                    v_u_11 = false
                end
                return
            end
        end
    end
}
return table.freeze(v25)
