-- MODULESCRIPT: Players
-- Original Path: game.BAC - 12574.Controllers.Observers.Players
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HttpService")
local v3 = game:GetService("Players")
require(v1.Database.Custom.Types)
local v_u_4 = require(v1.Packages.Observers)
local v_u_5 = require(v1.Shared.DebugFlags)
local v_u_6 = v3.LocalPlayer
local v_u_7 = require(script.Components.CreateWeaponModel)
local v_u_8 = {}
local function v_u_16(p9)
    -- upvalues: (copy) v_u_8
    v_u_8[p9] = nil
    local v10 = p9.Character
    if v10 and v10:IsDescendantOf(workspace) then
        local v11 = v10:FindFirstChild("WeaponAttachments")
        if v11 then
            v11:ClearAllChildren()
        end
        local v12 = v10:FindFirstChild("WeaponModel")
        if v12 then
            v12:ClearAllChildren()
        end
        local v13 = workspace:FindFirstChild("Debris")
        if v13 then
            local v14 = v13:FindFirstChild(p9.Name .. "_Weapon")
            if v14 and v14 then
                debug.profilebegin("Observers.Players.ClearVisuals.DestroyEquippedWeapon")
                v14:Destroy()
                debug.profileend()
            end
            local v15 = v13:FindFirstChild(p9.Name .. "_WeaponAttachments")
            if v15 then
                if not v15 then
                    return
                end
                debug.profilebegin("Observers.Players.ClearVisuals.DestroyAttachmentsFolder")
                v15:Destroy()
                debug.profileend()
            end
        end
    else
        return
    end
end
local function v_u_21(p17)
    -- upvalues: (copy) v_u_2
    local v18 = {}
    for v19 = 1, 3 do
        local v20 = p17:GetAttribute("Slot" .. v19)
        if v20 then
            v18[v19] = v_u_2:JSONDecode(v20)
        end
    end
    return v18
end
local function v_u_32(p22)
    if typeof(p22) ~= "table" then
        return ""
    end
    local v23 = {}
    for v24, v25 in ipairs(p22) do
        if typeof(v25) == "table" then
            local v26 = v25.Position
            local v27 = typeof(v26) == "table" and (v26.Rotation or "") or ""
            local v28 = typeof(v26) == "table" and (v26.X or "") or ""
            local v29 = typeof(v26) == "table" and (v26.Y or "") or ""
            local v30 = string.format
            local v31 = v25.Sticker or ""
            v23[v24] = v30("%s@%s,%s,%s", tostring(v31), tostring(v27), tostring(v28), (tostring(v29)))
        else
            v23[v24] = tostring(v25)
        end
    end
    return table.concat(v23, ";")
end
local function v_u_54(p33)
    -- upvalues: (copy) v_u_32
    if typeof(p33) ~= "table" then
        return ""
    end
    local v34 = table.concat
    local v35 = {}
    local v36 = p33.Identifier or ""
    local v37 = tostring(v36)
    local v38 = p33.Name or ""
    local v39 = tostring(v38)
    local v40 = p33.Skin or ""
    local v41 = tostring(v40)
    local v42 = p33.Float or ""
    local v43 = tostring(v42)
    local v44 = p33.StatTrack or ""
    local v45 = tostring(v44)
    local v46 = p33.NameTag or ""
    local v47 = tostring(v46)
    local v48 = p33.Charm
    local v49
    if v48 == nil or v48 == false then
        v49 = ""
    elseif typeof(v48) == "table" then
        local v50 = v48._id or ""
        local v51 = tostring(v50)
        local v52 = v48.Position or ""
        v49 = v51 .. "@" .. tostring(v52)
    else
        v49 = tostring(v48)
    end
    local v53 = p33.IsSuppressed or ""
    __set_list(v35, 1, {v37, v39, v41, v43, v45, v47, v49, tostring(v53), v_u_32(p33.Stickers)})
    return v34(v35, "|")
end
local function v_u_58(p_u_55)
    -- upvalues: (copy) v_u_7, (copy) v_u_5
    local v56, v57 = pcall(function()
        -- upvalues: (ref) v_u_7, (copy) p_u_55
        v_u_7.RefreshObjectiveKitHolster(p_u_55)
    end)
    if v_u_5.IsEnabled("ThirdPersonWeaponModels") and not v56 then
        warn(("[ThirdPersonWeaponModels] %s RefreshObjectiveKitHolster failed: %s"):format(p_u_55.Name, (tostring(v57))))
    end
end
local function v_u_63(p_u_59)
    -- upvalues: (copy) v_u_4, (copy) v_u_58
    local v_u_60 = v_u_4.observeAttribute(p_u_59, "HasDefuseKit", function()
        -- upvalues: (ref) v_u_58, (copy) p_u_59
        v_u_58(p_u_59)
        return function() end
    end)
    local v_u_61 = v_u_4.observeAttribute(p_u_59, "HasRescueKit", function()
        -- upvalues: (ref) v_u_58, (copy) p_u_59
        v_u_58(p_u_59)
        return function() end
    end)
    local v_u_62 = p_u_59.CharacterAdded:Connect(function()
        -- upvalues: (ref) v_u_58, (copy) p_u_59
        v_u_58(p_u_59)
    end)
    v_u_58(p_u_59)
    return function()
        -- upvalues: (copy) v_u_60, (copy) v_u_61, (copy) v_u_62
        v_u_60()
        v_u_61()
        v_u_62:Disconnect()
    end
end
local function v_u_67(p_u_64)
    -- upvalues: (copy) v_u_7, (copy) v_u_5
    local v65, v66 = pcall(function()
        -- upvalues: (ref) v_u_7, (copy) p_u_64
        v_u_7.RefreshBombHolster(p_u_64)
    end)
    if v_u_5.IsEnabled("ThirdPersonWeaponModels") and not v65 then
        warn(("[ThirdPersonWeaponModels] %s RefreshBombHolster failed: %s"):format(p_u_64.Name, (tostring(v66))))
    end
end
local function v_u_76(p_u_68)
    -- upvalues: (copy) v_u_4, (copy) v_u_67
    local v69 = p_u_68:GetAttribute("CurrentEquipped")
    local v_u_70 = typeof(v69) == "string" and (string.match(v69, "\"Name\"%s*:%s*\"([^\"]+)\"") or "") or ""
    local v_u_71 = v_u_4.observeAttribute(p_u_68, "Slot5", function()
        -- upvalues: (ref) v_u_67, (copy) p_u_68
        v_u_67(p_u_68)
        return function() end
    end)
    local v_u_74 = v_u_4.observeAttribute(p_u_68, "CurrentEquipped", function(p72)
        -- upvalues: (ref) v_u_70, (ref) v_u_67, (copy) p_u_68
        local v73 = typeof(p72) == "string" and (string.match(p72, "\"Name\"%s*:%s*\"([^\"]+)\"") or "") or ""
        if v73 == v_u_70 then
            return function() end
        end
        v_u_70 = v73
        v_u_67(p_u_68)
        return function() end
    end)
    local v_u_75 = p_u_68.CharacterAdded:Connect(function()
        -- upvalues: (ref) v_u_67, (copy) p_u_68
        v_u_67(p_u_68)
    end)
    v_u_67(p_u_68)
    return function()
        -- upvalues: (copy) v_u_71, (copy) v_u_74, (copy) v_u_75
        v_u_71()
        v_u_74()
        v_u_75:Disconnect()
    end
end
return v_u_4.observePlayer(function(p_u_77)
    -- upvalues: (copy) v_u_6, (copy) v_u_4, (copy) v_u_5, (copy) v_u_16, (copy) v_u_2, (copy) v_u_54, (copy) v_u_8, (copy) v_u_7, (copy) v_u_21, (copy) v_u_63, (copy) v_u_76
    if p_u_77 == v_u_6 then
        return function() end
    end
    local v_u_86 = v_u_4.observeAttribute(p_u_77, "CurrentEquipped", function(p78)
        -- upvalues: (ref) v_u_5, (copy) p_u_77, (ref) v_u_16, (ref) v_u_2, (ref) v_u_54, (ref) v_u_8, (ref) v_u_7, (ref) v_u_21
        if v_u_5.IsEnabled("ThirdPersonWeaponModels") then
            local v79 = warn
            local v80 = p_u_77.Name
            local v81 = typeof(p78) == "string" and (#p78 or -1) or -1
            v79(("[ThirdPersonWeaponModels] %s CurrentEquipped changed (%s bytes JSON)"):format(v80, (tostring(v81))))
        end
        if not p78 then
            v_u_16(p_u_77)
            return function() end
        end
        local v_u_82 = v_u_2:JSONDecode(p78)
        local v83 = v_u_54(v_u_82)
        if v83 ~= "" and v_u_8[p_u_77] == v83 then
            return function() end
        end
        v_u_8[p_u_77] = v83
        local v84, v85, _ = pcall(function()
            -- upvalues: (ref) v_u_7, (ref) p_u_77, (copy) v_u_82, (ref) v_u_21
            return v_u_7(p_u_77, v_u_82, (v_u_21(p_u_77)))
        end)
        if v_u_5.IsEnabled("ThirdPersonWeaponModels") then
            if v84 then
                warn(("[ThirdPersonWeaponModels] %s CreateWeaponModel ok"):format(p_u_77.Name))
            else
                warn(("[ThirdPersonWeaponModels] %s CreateWeaponModel failed: %s"):format(p_u_77.Name, (tostring(v85))))
            end
        end
        return function()
            -- upvalues: (ref) p_u_77, (ref) v_u_16
            if p_u_77:GetAttribute("CurrentEquipped") == nil then
                v_u_16(p_u_77)
            end
        end
    end)
    local v_u_87 = v_u_63(p_u_77)
    local v_u_88 = v_u_76(p_u_77)
    return function()
        -- upvalues: (copy) v_u_86, (copy) v_u_87, (copy) v_u_88, (ref) v_u_7, (copy) p_u_77, (ref) v_u_8
        v_u_86()
        v_u_87()
        v_u_88()
        v_u_7.ClearPlayerCache(p_u_77)
        v_u_8[p_u_77] = nil
    end
end)
