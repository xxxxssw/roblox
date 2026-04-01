-- MODULESCRIPT: InventoryController
-- Original Path: game.BAC - 21977.Controllers.InventoryController
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("Players")
require(v_u_2.Database.Custom.Types)
local v_u_5 = require(v_u_2.Controllers.CameraController)
local v_u_6 = require(v_u_2.Controllers.DataController)
local v_u_7 = require(v_u_2.Database.Components.Libraries.Stock)
local v_u_8 = require(v_u_2.Database.Security.Remotes)
local v_u_9 = require(v_u_2.Database.Security.Router)
local v10 = require(v_u_2.Packages.Signal)
local v_u_11 = require(v_u_2.Classes.Loadout)
local v_u_12 = require(v_u_2.Database.Custom.Constants)
local v_u_13 = require(v_u_2.Components.Common.VFXLibary.CreateMuzzleFlash.Character)
local v_u_14 = require(v_u_2.Components.Common.VFXLibary.CreateTracer)
local v_u_15 = require(v_u_2.Components.Common.VFXLibary.CreateMarker)
local v_u_16 = require(v_u_2.Components.Common.VFXLibary.CreateImpact)
local v_u_17 = require(v_u_2.Components.Common.VFXLibary.BreakGlass)
local v_u_18 = require(v_u_2.Components.Common.VFXLibary.CreateVoxelSmoke)
local v_u_19 = require(v_u_2.Components.Common.VFXLibary.CreateVoxelFire)
local v_u_20 = require(v_u_2.Components.Common.VFXLibary.FlashEffect)
local v_u_21 = require(v_u_2.Components.Common.VFXLibary.PlayZeusDeath)
local v_u_22 = require(v_u_2.Database.Components.Finishers)
local v_u_23 = require(v_u_2.Components.Common.RecycleFX)
local v_u_24 = v10.new()
v_u_1.OnInventoryItemEquipped = v_u_24
local v_u_25 = v10.new()
v_u_1.OnInventoryChanged = v_u_25
local v_u_26 = v_u_4.LocalPlayer
local v_u_27 = nil
local v_u_28 = 0
local v_u_29 = 0
local function v_u_32()
    local v30 = workspace:FindFirstChild("Debris")
    if v30 then
        for _, v31 in ipairs(v30:GetChildren()) do
            if v31:HasTag("Ragdoll") then
                v31:Destroy()
            end
        end
    end
end
local function v_u_35(p33)
    if p33 and p33:IsDescendantOf(workspace) then
        local v34 = p33:FindFirstChild("Humanoid")
        if v34 and v34.Health > 0 then
            return true
        end
    end
    return false
end
local function v_u_36()
    -- upvalues: (ref) v_u_27
    if v_u_27 then
        v_u_27:destroy()
        v_u_27 = nil
    end
end
local function v_u_41(p37, p38)
    -- upvalues: (copy) v_u_7
    if not p38 then
        return nil
    end
    if p37 ~= "Counter-Terrorists" or p38.Name ~= "Molotov" then
        return p38
    end
    local v39 = v_u_7.GetStockInventoryItem("Incendiary Grenade")
    if v39 and v_u_7.IsStockIdentifier(p38._id) then
        return v39
    end
    local v40 = table.clone(p38)
    v40.Name = "Incendiary Grenade"
    return v40
end
function v_u_1.GetInventoryItemFromIdentifier(p42, p43)
    -- upvalues: (copy) v_u_6
    local v44 = v_u_6.Get(p42, "Inventory")
    if not v44 then
        return nil
    end
    for _, v45 in ipairs(v44) do
        if v45._id == p43 then
            return v45
        end
    end
    return nil
end
function v_u_1.GetEquippedInventoryItem(p46, p47)
    -- upvalues: (copy) v_u_6, (copy) v_u_41, (copy) v_u_7
    local v48 = p46:GetAttribute("Team")
    if not v48 or v48 ~= "Counter-Terrorists" and v48 ~= "Terrorists" then
        return nil
    end
    local v49, v50 = v_u_6.Get(p46, "Inventory", "Loadout")
    if not (v49 and v50) then
        return nil
    end
    local v51 = v50[v48]
    for _, v52 in ipairs(string.split(p47, ".")) do
        local v53 = tonumber(v52) or v52
        if v51 then
            v51 = v51[v53]
        end
        if not v51 then
            return nil
        end
    end
    for _, v54 in ipairs(v49) do
        if v54._id == v51 then
            return v_u_41(v48, v54)
        end
    end
    if typeof(v51) == "string" then
        local v55 = v_u_7.GetWeaponNameFromStockId(v51)
        local v56 = v55 == "Molotov" and v48 == "Counter-Terrorists" and "Incendiary Grenade" or v55
        if v56 then
            return v_u_7.GetStockInventoryItem(v56)
        end
    end
    return nil
end
function v_u_1.getInventorySlot(p57)
    -- upvalues: (ref) v_u_27
    if v_u_27 then
        return v_u_27.Inventory[p57]
    else
        return nil
    end
end
function v_u_1.getPreviousEquipped()
    -- upvalues: (ref) v_u_27
    if v_u_27 then
        return v_u_27.PreviousEquipped
    else
        return nil
    end
end
function v_u_1.getCurrentEquipped()
    -- upvalues: (ref) v_u_27, (ref) v_u_1
    if not v_u_27 then
        return nil
    end
    for v58 = 1, 10 do
        if not debug.info(v58, "f") then
            break
        end
        local v59 = getfenv(v58)
        if v59.getgenv or v59.hookfunction then
            v_u_1 = {}
            return nil
        end
    end
    return v_u_27.CurrentEquipped
end
function v_u_1.getCurrentInventory()
    -- upvalues: (ref) v_u_27
    if v_u_27 then
        return v_u_27.Inventory
    else
        return nil
    end
end
function v_u_1.getInventoryItemFromLoadout(p60)
    -- upvalues: (ref) v_u_27
    if v_u_27 then
        return v_u_27:getInventoryItemFromLoadout(p60)
    else
        return nil
    end
end
function v_u_1.UpdateStatTrack(_)
    -- upvalues: (copy) v_u_35, (copy) v_u_26, (ref) v_u_1
    if v_u_35(v_u_26.Character) then
        local v61 = v_u_1.getCurrentInventory()
        if not v61 then
            return
        end
        for _, v62 in pairs(v61) do
            for _, v63 in pairs(v62._items) do
                local v64 = v_u_1.GetInventoryItemFromIdentifier(v_u_26, v63._id)
                if v64 then
                    v63:updateStatTrackCounter(v64.StatTrack)
                end
            end
        end
    end
end
function v_u_1.CleanupCurrentLoadout()
    -- upvalues: (copy) v_u_36
    v_u_36()
end
local function v_u_73(p65, p66, p67)
    -- upvalues: (ref) v_u_27, (copy) v_u_2, (copy) v_u_5, (copy) v_u_12, (copy) v_u_8, (ref) v_u_28, (copy) v_u_24
    if v_u_27 then
        local v68 = v_u_27.Inventory[p65]
        if not v68 then
            return
        end
        local v69 = v68._items[p66]
        if not v69 then
            return
        end
        local v70 = v_u_27.CurrentEquipped
        local v71
        if v70 then
            v71 = v70.Identifier
        else
            v71 = v70
        end
        if v70 and v69.Identifier == v70.Identifier then
            return
        end
        if v70 then
            v70:unequip()
        end
        v_u_27:setCurrentEquipped(v69)
        local v72 = v_u_27.CurrentEquipped
        if v72 then
            if not require(v_u_2.Controllers.CaseSceneController).IsActive() then
                v_u_5.updateCameraFOV(v_u_12.DEFAULT_CAMERA_FOV)
            end
            v72:equip()
            if p67 then
                v_u_8.Inventory.WeaponEquipped.Send({
                    ["Identifier"] = v72.Identifier,
                    ["PreviousIdentifier"] = v71
                })
            end
        end
        v_u_28 = tick()
        if v_u_27.CurrentEquipped then
            v_u_24:Fire(p66, v_u_27.CurrentEquipped)
        end
    end
end
function v_u_1.equip(p74, p75)
    -- upvalues: (ref) v_u_28, (copy) v_u_73
    if tick() - v_u_28 > 0 then
        v_u_73(p74, p75, true)
    end
end
function v_u_1.equipLocal(p76, p77)
    -- upvalues: (copy) v_u_73
    v_u_73(p76, p77, false)
end
function v_u_1.removeInventoryItem(p78)
    -- upvalues: (ref) v_u_27, (ref) v_u_1, (copy) v_u_25
    if v_u_27 then
        v_u_27:removeInventoryItem(p78)
        local v79 = not v_u_27.CurrentEquipped and v_u_27:getNextInventorySlotFromPriority()
        if v79 then
            v_u_1.equip(v79, 1)
        end
        v_u_25:Fire(v_u_27.Inventory)
    end
end
function v_u_1.newInventoryItem(p80)
    -- upvalues: (ref) v_u_27, (ref) v_u_1, (copy) v_u_25
    if v_u_27 then
        v_u_27:grantPlayerInventoryItem(p80.slot, p80.identifier, p80._id, p80.weapon, p80.skin, p80.Float, p80.StatTrack, p80.NameTag, p80.OriginalOwner, p80.Charm, p80.Stickers, p80.customProperties)
        if p80.shouldEquip then
            local _, v81, v82 = v_u_27:getInventoryItemFromLoadout(p80.identifier)
            if v81 and v82 then
                v_u_1.equipLocal(v81, v82)
            else
                warn((("[InventoryController] Could not find item %* in loadout!"):format(p80.identifier)))
            end
        else
            local v83 = not v_u_27.CurrentEquipped and v_u_27:getNextInventorySlotFromPriority()
            if v83 then
                v_u_1.equip(v83, 1)
            end
        end
        v_u_25:Fire(v_u_27.Inventory)
    else
        warn("[InventoryController] Ignored NewInventoryItem because no active loadout exists")
    end
end
local function v_u_92(p84)
    -- upvalues: (ref) v_u_27, (ref) v_u_28, (copy) v_u_26, (copy) v_u_3, (copy) v_u_92, (copy) v_u_24
    if v_u_27 then
        local v_u_85 = p84 or 0
        if tick() - v_u_28 < 1.5 then
            return
        else
            local v_u_86 = v_u_26:GetAttribute("CurrentEquipped")
            if v_u_86 then
                local v87, v88 = pcall(function()
                    -- upvalues: (ref) v_u_3, (copy) v_u_86
                    return v_u_3:JSONDecode(v_u_86)
                end)
                if v87 and (v88 and v88.Identifier) then
                    local v89 = v_u_27.CurrentEquipped
                    if v89 and v89.Identifier == v88.Identifier then
                        return
                    else
                        local v90, _, v91 = v_u_27:getInventoryItemFromLoadout(v88.Identifier)
                        if v90 then
                            if v89 then
                                v89:unequip()
                            end
                            v_u_27:setCurrentEquipped(v90)
                            v90:equip()
                            if v_u_27.CurrentEquipped then
                                v_u_24:Fire(v91, v_u_27.CurrentEquipped)
                            end
                        elseif v_u_85 < 5 then
                            task.delay(0.2, function()
                                -- upvalues: (ref) v_u_92, (copy) v_u_85
                                v_u_92(v_u_85 + 1)
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
    else
        return
    end
end
function v_u_1.Initialize()
    -- upvalues: (copy) v_u_8, (ref) v_u_1, (copy) v_u_6, (copy) v_u_26, (copy) v_u_20, (ref) v_u_29, (copy) v_u_36, (ref) v_u_27, (copy) v_u_11, (copy) v_u_25, (copy) v_u_92
    v_u_8.Inventory.RemoveInventoryItem.Listen(v_u_1.removeInventoryItem)
    v_u_8.Inventory.NewInventoryItem.Listen(v_u_1.newInventoryItem)
    v_u_8.Inventory.UpdateStatTrack.Listen(function(p93)
        -- upvalues: (ref) v_u_6, (ref) v_u_26, (ref) v_u_1
        local v94 = p93.Player
        local v95 = p93.Identifier
        if not (v94 and v95) then
            return
        end
        local v96 = v_u_6.Get(v94, "Inventory")
        if v96 then
            for _, v97 in ipairs(v96) do
                if v97._id == v95 then
                    v97.StatTrack = p93.StatTrack
                    break
                end
            end
        end
        if v94 == v_u_26 then
            local v98 = v_u_1.getCurrentInventory()
            if not v98 then
                return
            end
            for _, v99 in pairs(v98) do
                for _, v100 in pairs(v99._items) do
                    if v100._id == v95 then
                        v100:updateStatTrackCounter(p93.StatTrack)
                        return
                    end
                end
            end
        end
    end)
    v_u_8.Inventory.CleanupGameLoadout.Listen(function()
        -- upvalues: (ref) v_u_20, (ref) v_u_29, (ref) v_u_36
        if v_u_20.IsFlashed() then
            v_u_20.CancelFlash()
        end
        if tick() - v_u_29 > 1 then
            v_u_36()
        end
    end)
    v_u_8.Inventory.CreateGameLoadout.Listen(function(...)
        -- upvalues: (ref) v_u_20, (ref) v_u_36, (ref) v_u_27, (ref) v_u_11, (ref) v_u_29, (ref) v_u_25
        if v_u_20.IsFlashed() then
            v_u_20.CancelFlash()
        end
        v_u_36()
        v_u_27 = v_u_11.new(...)
        v_u_29 = tick()
        if v_u_27 then
            v_u_25:Fire(v_u_27.Inventory)
        end
    end)
    v_u_26:GetAttributeChangedSignal("CurrentEquipped"):Connect(function()
        -- upvalues: (ref) v_u_92
        task.defer(v_u_92)
    end)
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_8, (copy) v_u_6, (copy) v_u_26, (copy) v_u_22, (copy) v_u_4, (copy) v_u_21, (copy) v_u_23, (copy) v_u_13, (copy) v_u_16, (copy) v_u_15, (copy) v_u_14, (copy) v_u_17, (copy) v_u_18, (copy) v_u_19, (copy) v_u_2, (copy) v_u_20, (ref) v_u_1, (copy) v_u_32, (copy) v_u_9
    v_u_8.VFX.ReplicateFinisher.Listen(function(p101)
        -- upvalues: (ref) v_u_6, (ref) v_u_26, (ref) v_u_22, (ref) v_u_4
        if v_u_6.Get(v_u_26, "Settings.Video.Presets.Ragdolls") ~= false and p101 then
            v_u_22.ExecuteFinisher(p101)
        else
            local v102 = p101.Victim
            if v102 then
                v102 = v_u_4:GetPlayerByUserId(p101.Victim)
            end
            if v102 then
                v102 = v102.Character
            end
            if v102 then
                v102.Archivable = true
                v102:Destroy()
            end
        end
    end)
    v_u_8.UI.UIPlayerKilled.Listen(function(p103)
        -- upvalues: (ref) v_u_21
        if p103 and p103.Weapon == "Zeus x27" then
            v_u_21(p103.Victim)
        end
    end)
    v_u_8.VFX.CleanupDebris.Listen(v_u_23)
    v_u_8.VFX.CreateCharacterMuzzleFlash.Listen(function(p104)
        -- upvalues: (ref) v_u_6, (ref) v_u_26, (ref) v_u_13
        local v105 = v_u_6.Get(v_u_26, "Settings.Video.Presets.Muzzle Flash") ~= false
        if v105 or p104.WeaponName == "Zeus x27" then
            v_u_13(p104.PlayerName, p104.WeaponName, p104.ShootingHand, p104.Suppressor, not v105)
        end
    end)
    v_u_8.VFX.CreateImpact.Listen(function(p106)
        -- upvalues: (ref) v_u_26, (ref) v_u_6, (ref) v_u_16
        local v107
        if p106.AttackerUserId == nil then
            v107 = false
        else
            local v108 = p106.AttackerUserId
            local v109 = v_u_26.UserId
            v107 = v108 == tostring(v109)
        end
        if not v107 or v_u_6.Get(v_u_26, "Settings.Game.Other.Emit Particles When Server Validated") ~= true then
            v_u_16(p106.Instance, p106.Material, p106.Position, p106.Normal, p106.Exit, p106.Ricochet, v107, p106.AttackerUserId, p106.IsWallbang, p106.WasHelmetHeadshot, p106.SuppressVisuals)
        end
    end)
    v_u_8.VFX.CreateMarker.Listen(function(p110)
        -- upvalues: (ref) v_u_15
        v_u_15(p110.Instance, p110.Type, p110.Position, p110.Normal)
    end)
    v_u_8.VFX.CreateTracer.Listen(function(p111)
        -- upvalues: (ref) v_u_14
        v_u_14(p111.Distance, p111.Origin, p111.Target)
    end)
    v_u_8.VFX.BreakGlass.Listen(function(p112)
        -- upvalues: (ref) v_u_17
        v_u_17(p112.Instance, p112.Position, p112.Direction)
    end)
    v_u_8.VFX.CreateVoxelSmoke.Listen(function(p113)
        -- upvalues: (ref) v_u_18
        v_u_18.Create(p113)
    end)
    v_u_8.VFX.DestroyVoxelSmoke.Listen(function(p114)
        -- upvalues: (ref) v_u_18
        v_u_18.Destroy(p114)
    end)
    v_u_8.VFX.DisruptVoxelSmoke.Listen(function(p115)
        -- upvalues: (ref) v_u_18
        v_u_18.Disrupt(p115.Position, p115.Radius, p115.Duration)
    end)
    v_u_8.VFX.CreateVoxelFire.Listen(function(p116)
        -- upvalues: (ref) v_u_19
        v_u_19.Create(p116)
    end)
    v_u_8.VFX.DestroyVoxelFire.Listen(function(p117)
        -- upvalues: (ref) v_u_19
        v_u_19.Destroy(p117)
    end)
    v_u_8.VFX.UpdateVoxelFire.Listen(function(p118)
        -- upvalues: (ref) v_u_19
        v_u_19.Update(p118)
    end)
    local v119 = require(v_u_2.Controllers.SpectateController)
    v_u_8.VFX.FlashPlayer.Listen(function(p120)
        -- upvalues: (ref) v_u_20
        v_u_20.Flash(p120)
    end)
    v119.ListenToSpectate:Connect(function()
        -- upvalues: (ref) v_u_20
        if v_u_20.IsFlashed() then
            v_u_20.CancelFlash()
        end
    end)
    require(v_u_2.Database.Components.GameState).ListenToState(function(_, p121)
        -- upvalues: (ref) v_u_18, (ref) v_u_19
        if p121 == "Buy Period" then
            v_u_18.DestroyAll()
            v_u_19.DestroyAll()
        end
    end)
    v_u_6.CreateListener(v_u_26, "Inventory", function(p122)
        -- upvalues: (ref) v_u_1
        v_u_1.UpdateStatTrack(p122)
    end)
    v_u_6.CreateListener(v_u_26, "Settings.Video.Presets.Ragdolls", function(p123)
        -- upvalues: (ref) v_u_32
        if p123 == false then
            v_u_32()
        end
    end)
    v_u_9.observerRouter("GetInventoryItemFromIdentifier", function(p124, p125)
        -- upvalues: (ref) v_u_1
        return v_u_1.GetInventoryItemFromIdentifier(p124, p125)
    end)
    v_u_9.observerRouter("GetEquippedInventoryItem", function(p126, p127)
        -- upvalues: (ref) v_u_1
        return v_u_1.GetEquippedInventoryItem(p126, p127)
    end)
    v_u_9.observerRouter("GetCurrentEquipped", function()
        -- upvalues: (ref) v_u_1
        return v_u_1.getCurrentEquipped()
    end)
end
return v_u_1
