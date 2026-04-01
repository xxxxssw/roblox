-- MODULESCRIPT: CreateWeaponModel
-- Original Path: game.BAC - 12574.Controllers.Observers.Players.Components.CreateWeaponModel
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HttpService")
local v3 = game:GetService("Players")
local v_u_4 = v1.Assets.Other
require(v1.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_5 = require(v1.Components.Common.GetWeaponProperties)
local v_u_6 = require(v1.Shared.DebugFlags)
local v_u_7 = require(v1.Database.Components.Libraries.Skins)
local v_u_8 = require(v1.Database.Custom.GameStats.Character.Attachments)
local v_u_9 = { "PrimaryAttachment", "SecondaryAttachment", "MeleeAttachment" }
local v_u_10 = {
    ["MuzzlePartL"] = 1,
    ["MuzzlePartR"] = 1,
    ["MuzzlePart"] = 1,
    ["RootPart"] = 1,
    ["Hitbox"] = 1,
    ["Insert"] = 1,
    ["move"] = 1
}
local v_u_11 = CFrame.new(0, -0.4, 0.24) * CFrame.Angles(0, 3.141592653589793, 0)
local v_u_12 = CFrame.new(0, 0.2, 0.8) * CFrame.Angles(1.5707963267948966, 0.20943951023931956, 0.17453292519943295)
local v_u_13 = {}
local v_u_14 = {}
local function v_u_18(p15, p16, ...)
    -- upvalues: (copy) v_u_6
    if v_u_6.IsEnabled("ThirdPersonWeaponModels") then
        local v17 = not p15 and "[ThirdPersonWeaponModels] " or "[ThirdPersonWeaponModels] " .. p15.Name .. " - "
        warn(v17 .. p16:format(...))
    end
end
local function v_u_22(p19, p20, ...)
    local v21 = not p19 and "[ZeusDebug][CreateWeaponModel] " or "[ZeusDebug][CreateWeaponModel] " .. p19.Name .. " - "
    warn(v21 .. p20:format(...))
end
local function v_u_25(p23)
    for _, v24 in ipairs(p23:GetDescendants()) do
        if v24:IsA("BasePart") then
            v24.CollisionGroup = "WeaponModel"
            v24.CastShadow = false
            v24.CanCollide = false
            v24.CanTouch = false
            v24.CanQuery = false
            v24.Anchored = false
            v24.Massless = true
        end
    end
end
local function v_u_30(p26)
    -- upvalues: (copy) v_u_10
    for v27, v28 in pairs(v_u_10) do
        local v29 = p26:FindFirstChild(v27, true)
        if v29 then
            v29.Transparency = v28
        end
    end
end
local function v_u_34(p31, p32)
    -- upvalues: (copy) v_u_30
    for _, v33 in ipairs(p31:GetDescendants()) do
        if v33:IsA("BasePart") then
            v33.Transparency = p32 and 0 or 1
        end
    end
    v_u_30(p31)
end
local function v_u_43(p35, p_u_36)
    local v37 = p_u_36.Parent
    if not (v37 and v37:IsA("BasePart")) then
        error((("Character attachment parent is not a BasePart: %*"):format(p_u_36.Name)))
    end
    local v_u_38 = p35:FindFirstChild("Insert", true) or p35.PrimaryPart
    if not v_u_38 then
        error("Weapon model has no PrimaryPart or Insert part")
    end
    local v_u_39 = v_u_38:FindFirstChild("WeaponAttachment")
    if not v_u_39 then
        v_u_39 = Instance.new("Attachment")
        v_u_39.Name = "WeaponAttachment"
        v_u_39.Parent = v_u_38
    end
    local v41, v42 = pcall(function()
        -- upvalues: (copy) v_u_38, (copy) p_u_36, (copy) v_u_39
        local v40 = Instance.new("AttachmentConstraint")
        v40.Parent = v_u_38
        v40.Attachment0 = p_u_36
        v40.Attachment1 = v_u_39
        return v40
    end)
    if not v41 then
        v_u_38.CFrame = v37.CFrame * p_u_36.CFrame * v_u_39.CFrame:Inverse()
        v42 = Instance.new("WeldConstraint")
        v42.Parent = v_u_38
        v42.Part0 = v37
        v42.Part1 = v_u_38
    end
    return v42
end
local function v_u_48(p44)
    local v45 = workspace:FindFirstChild("Debris")
    if not v45 then
        return nil
    end
    local v46 = p44.Name .. "_WeaponAttachments"
    local v47 = v45:FindFirstChild(v46)
    if not v47 then
        v47 = Instance.new("Folder")
        v47.Name = v46
        v47.Parent = v45
    end
    v47:SetAttribute("PersistentDebris", true)
    return v47
end
local function v_u_55(p49)
    local v50 = p49:Clone()
    if v50:IsA("BasePart") then
        local v51 = Instance.new("Model")
        v50.Parent = v51
        v51.PrimaryPart = v50
        return v51, v50
    elseif v50:IsA("Model") then
        local v52 = v50.PrimaryPart or v50:FindFirstChildWhichIsA("BasePart", true)
        if v52 then
            if not v50.PrimaryPart then
                v50.PrimaryPart = v52
            end
            return v50, v52
        else
            if v50 then
                debug.profilebegin("CreateWeaponModel.ToModelWithPrimaryPart.DestroyModelNoPrimaryPart")
                v50:Destroy()
                debug.profileend()
            end
            return nil, nil
        end
    else
        local v53 = Instance.new("Model")
        v50.Parent = v53
        local v54 = v53:FindFirstChildWhichIsA("BasePart", true)
        if v54 then
            v53.PrimaryPart = v54
            return v53, v54
        else
            if v53 then
                debug.profilebegin("CreateWeaponModel.ToModelWithPrimaryPart.DestroyWrappedModel")
                v53:Destroy()
                debug.profileend()
            end
            return nil, nil
        end
    end
end
local function v_u_60(p56)
    local v57 = p56:FindFirstChild("WeaponAttachments")
    if v57 and v57:IsA("Folder") then
        return v57
    end
    local v58 = p56:WaitForChild("WeaponAttachments", 10)
    if v58 and v58:IsA("Folder") then
        return v58
    end
    local v59 = Instance.new("Folder")
    v59.Name = "WeaponAttachments"
    v59.Parent = p56
    return v59
end
local function v_u_65(p61)
    -- upvalues: (copy) v_u_11
    local v62 = p61.Parent
    if not (v62 and v62:IsA("BasePart")) then
        return nil
    end
    local v63 = v62:FindFirstChild("ObjectiveKitTargetAttachment")
    if v63 and v63:IsA("Attachment") then
        v63.CFrame = p61.CFrame * v_u_11
        return v63
    end
    local v64 = Instance.new("Attachment")
    v64.Name = "ObjectiveKitTargetAttachment"
    v64.CFrame = p61.CFrame * v_u_11
    v64.Parent = v62
    return v64
end
local function v_u_84(p66)
    local v67 = p66:FindFirstChild("ObjectiveKitAttachment", true)
    if v67 and v67:IsA("Attachment") then
        return v67
    else
        local v68 = p66:FindFirstChild("BodyBackAttachment", true)
        if v68 and v68:IsA("Attachment") then
            return v68
        else
            local v_u_69 = os.clock() + 10
            local function v75(p70, p71)
                -- upvalues: (copy) v_u_69
                local v72 = p70:FindFirstChild(p71)
                if v72 and v72:IsA("Attachment") then
                    return v72
                else
                    local v73 = v_u_69 - os.clock()
                    if v73 <= 0 then
                        return nil
                    else
                        local v74 = p70:WaitForChild(p71, v73)
                        if v74 and v74:IsA("Attachment") then
                            return v74
                        else
                            return nil
                        end
                    end
                end
            end
            for _, v76 in ipairs({ "UpperTorso", "Torso" }) do
                local v77 = p66:FindFirstChild(v76)
                local v78
                if v77 then
                    v78 = v77
                else
                    local v79 = v_u_69 - os.clock()
                    if v79 > 0 then
                        v78 = p66:WaitForChild(v76, v79)
                        if v78 then
                            if not v78:IsA("BasePart") then
                                v78 = v77
                            end
                        else
                            v78 = v77
                        end
                    else
                        v78 = v77
                    end
                end
                if v78 then
                    local v80 = v75(v78, "ObjectiveKitAttachment")
                    if v80 then
                        return v80
                    end
                    local v81 = v75(v78, "BodyBackAttachment")
                    if v81 then
                        return v81
                    end
                end
            end
            local v82 = p66:FindFirstChild("ObjectiveKitAttachment", true)
            if v82 and v82:IsA("Attachment") then
                return v82
            else
                local v83 = p66:FindFirstChild("BodyBackAttachment", true)
                if v83 and v83:IsA("Attachment") then
                    return v83
                else
                    return nil
                end
            end
        end
    end
end
local function v_u_92(p85, p86)
    -- upvalues: (copy) v_u_4, (copy) v_u_18, (copy) v_u_84, (copy) v_u_65, (copy) v_u_55, (copy) v_u_25, (copy) v_u_43, (copy) v_u_60
    local v87 = v_u_4:FindFirstChild("DefuseKit")
    if not v87 then
        v_u_18(p85, "objective kit holster skipped: missing template Assets.Other.DefuseKit")
        return nil
    end
    local v88 = v_u_84(p86)
    if not v88 then
        v_u_18(p85, "objective kit holster skipped: no valid character attachment")
        return nil
    end
    local v89 = v_u_65(v88)
    if not v89 then
        v_u_18(p85, "objective kit holster skipped: failed to create target attachment")
        return nil
    end
    local v90, _ = v_u_55(v87)
    if not v90 then
        v_u_18(p85, "objective kit holster skipped: template has no BasePart")
        return nil
    end
    v_u_25(v90)
    v_u_43(v90, v89)
    local v91 = v_u_60(p86)
    if not v91 then
        if v90 then
            debug.profilebegin("CreateWeaponModel.ObjectiveKitHolster.DestroyModelNoAttachmentsFolder")
            v90:Destroy()
            debug.profileend()
        end
        return nil
    end
    v90.Name = "ObjectiveKitHolster"
    v90.Parent = v91
    return v90
end
local function v_u_100(p93, p94)
    -- upvalues: (copy) v_u_13, (copy) v_u_92
    local v95 = v_u_13[p93] or {
        ["Character"] = nil
    }
    v_u_13[p93] = v95
    local v96
    if p93:GetAttribute("Team") == "Counter-Terrorists" then
        v96 = p93:GetAttribute("HasDefuseKit") == true and true or p93:GetAttribute("HasRescueKit") == true
    else
        v96 = false
    end
    if v96 then
        local v97 = v95.ObjectiveKitHolsterModel
        if not (v97 and (v97.Parent and v97:IsDescendantOf(p94))) then
            if v95.ObjectiveKitHolsterModel then
                local v98 = v95.ObjectiveKitHolsterModel
                if v98 then
                    debug.profilebegin("CreateWeaponModel.ObjectiveKitHolster.DestroyPrevious")
                    v98:Destroy()
                    debug.profileend()
                end
                v95.ObjectiveKitHolsterModel = nil
            end
            v95.ObjectiveKitHolsterModel = v_u_92(p93, p94)
        end
    else
        if v95.ObjectiveKitHolsterModel then
            local v99 = v95.ObjectiveKitHolsterModel
            if v99 then
                debug.profilebegin("CreateWeaponModel.ObjectiveKitHolster.DestroyPrevious")
                v99:Destroy()
                debug.profileend()
            end
            v95.ObjectiveKitHolsterModel = nil
        end
        return
    end
end
local function v_u_105(p101)
    -- upvalues: (copy) v_u_12
    local v102 = p101:FindFirstChild("BombAttachment", true)
    if v102 and v102:IsA("Attachment") then
        v102.CFrame = v_u_12
        return v102
    end
    local v103 = p101:FindFirstChild("UpperTorso")
    if not v103 then
        return nil
    end
    local v104 = Instance.new("Attachment")
    v104.Name = "BombAttachment"
    v104.CFrame = v_u_12
    v104.Parent = v103
    return v104
end
local function v_u_113(p106, p107)
    -- upvalues: (copy) v_u_18, (copy) v_u_2, (copy) v_u_105, (copy) v_u_7, (copy) v_u_25, (copy) v_u_30, (copy) v_u_43, (copy) v_u_48
    local v108 = p106:GetAttribute("Slot5")
    if not v108 then
        v_u_18(p106, "bomb holster skipped: no Slot5 attribute")
        return nil
    end
    local v109 = v_u_2:JSONDecode(v108)
    if not v109 or v109.Weapon ~= "C4" then
        v_u_18(p106, "bomb holster skipped: Slot5 does not contain C4")
        return nil
    end
    local v110 = v_u_105(p107)
    if not v110 then
        v_u_18(p106, "bomb holster skipped: no valid character attachment (missing UpperTorso)")
        return nil
    end
    local v111 = v_u_7.GetCharacterModel("C4", v109.Skin or "", v109.Float, v109.StatTrack, v109.NameTag, v109.Charm, v109.Stickers)
    if not v111 then
        v_u_18(p106, "bomb holster skipped: SkinHandler returned nil for C4")
        return nil
    end
    v_u_25(v111)
    v_u_30(v111)
    v_u_43(v111, v110)
    local v112 = v_u_48(p106)
    if not v112 then
        if v111 then
            debug.profilebegin("CreateWeaponModel.BombHolster.DestroyModelNoAttachmentsFolder")
            v111:Destroy()
            debug.profileend()
        end
        return nil
    end
    v111.Name = "BombHolster"
    v111.Parent = v112
    return v111
end
local function v_u_123(p114, p115, p116)
    -- upvalues: (copy) v_u_13, (copy) v_u_2, (copy) v_u_113, (copy) v_u_34
    local v117 = v_u_13[p114] or {
        ["Character"] = nil
    }
    v_u_13[p114] = v117
    local v118 = p114:GetAttribute("Slot5")
    local v119
    if v118 then
        v119 = v_u_2:JSONDecode(v118)
        if v119 then
            v119 = v119.Weapon == "C4"
        end
    else
        v119 = false
    end
    if v119 then
        if p116 then
            p116 = p116.Name == "C4"
        end
        local v120 = v117.BombHolsterModel
        if not (v120 and v120.Parent) then
            if v117.BombHolsterModel then
                local v121 = v117.BombHolsterModel
                if v121 then
                    debug.profilebegin("CreateWeaponModel.BombHolster.DestroyPrevious")
                    v121:Destroy()
                    debug.profileend()
                end
                v117.BombHolsterModel = nil
            end
            v120 = v_u_113(p114, p115)
            v117.BombHolsterModel = v120
        end
        if v120 then
            v_u_34(v120, not p116)
        end
    elseif v117.BombHolsterModel then
        local v122 = v117.BombHolsterModel
        if v122 then
            debug.profilebegin("CreateWeaponModel.BombHolster.DestroyPrevious")
            v122:Destroy()
            debug.profileend()
        end
        v117.BombHolsterModel = nil
    end
end
local function v_u_148(p124, p125, p126, p127, p128, p129, p130, p131, p132, p133)
    -- upvalues: (copy) v_u_22, (copy) v_u_9, (copy) v_u_7, (copy) v_u_18, (copy) v_u_25, (copy) v_u_30, (copy) v_u_43, (copy) v_u_48, (copy) v_u_13
    local v134 = nil
    local v135
    if p127 == "Smoke Grenade" then
        v135 = p124:GetAttribute("Team")
        if v135 ~= "Counter-Terrorists" and v135 ~= "Terrorists" then
            v135 = v134
        end
    else
        v135 = v134
    end
    if p127 == "Zeus x27" then
        local v136 = v_u_22
        local v137 = "CacheWeaponCharacterModel slot=%d skin=%s team=%s meleeAttachment=%s"
        local v138 = tostring(p124:GetAttribute("Team"))
        local v139 = v_u_9[p126]
        local v140
        if v139 then
            v140 = p125:FindFirstChild(v139, true)
        else
            v140 = nil
        end
        v136(p124, v137, p126, p128, v138, (tostring(v140)))
    end
    local v141 = v_u_7.GetCharacterModel(p127, p128, p129, p130, p131, p132, p133, v135)
    if not v141 then
        v_u_18(p124, "holster skipped: SkinHandler returned nil for slot=%d weapon=%s skin=%s", p126, p127, p128)
        if p127 == "Zeus x27" then
            v_u_22(p124, "CacheWeaponCharacterModel SkinHandler returned nil")
        end
        return nil
    end
    if p127 == "Zeus x27" then
        v_u_22(p124, "CacheWeaponCharacterModel model=%s primaryPart=%s", v141.Name, not v141.PrimaryPart and "nil" or v141.PrimaryPart.Name)
    end
    v_u_25(v141)
    v_u_30(v141)
    local v142 = v_u_9[p126]
    local v143
    if v142 then
        v143 = p125:FindFirstChild(v142, true)
    else
        v143 = nil
    end
    if not v143 then
        local v144 = v_u_18
        local v145 = v_u_9[p126]
        v144(p124, "missing character attachment for slot=%d weapon=%s (expected %s)", p126, p127, (tostring(v145)))
        error((("Missing character attachment for slot: %*"):format(p126)))
    end
    v_u_43(v141, v143)
    if p127 == "Zeus x27" then
        v_u_22(p124, "CacheWeaponCharacterModel welded to attachment=%s parent=%s", v143.Name, v143.Parent and v143.Parent.Name or "nil")
    end
    local v146 = v_u_48(p124)
    if v146 then
        v141.Parent = v146
        v141.Name = p127
    end
    local v147 = v_u_13[p124] or {
        ["Character"] = nil
    }
    v_u_13[p124] = v147
    v147[p126] = {
        ["StatTrack"] = p130,
        ["Stickers"] = p133,
        ["NameTag"] = p131,
        ["Model"] = v141,
        ["Float"] = p129,
        ["Charm"] = p132,
        ["Weapon"] = p127,
        ["Skin"] = p128
    }
    v_u_18(p124, "cached holster slot=%d weapon=%s skin=%s visible=%s", p126, p127, p128, "unknown")
    return v141
end
local function v_u_160(p149)
    -- upvalues: (copy) v_u_14, (copy) v_u_13, (copy) v_u_18
    local v150 = v_u_14[p149]
    if v150 then
        v150:Disconnect()
        v_u_14[p149] = nil
    end
    local v151 = v_u_13[p149]
    if v151 then
        if v151.ObjectiveKitHolsterModel then
            local v152 = v151.ObjectiveKitHolsterModel
            if v152 then
                debug.profilebegin("CreateWeaponModel.ObjectiveKitHolster.DestroyPrevious")
                v152:Destroy()
                debug.profileend()
            end
            v151.ObjectiveKitHolsterModel = nil
        end
        if v151.BombHolsterModel then
            local v153 = v151.BombHolsterModel
            if v153 then
                debug.profilebegin("CreateWeaponModel.BombHolster.DestroyPrevious")
                v153:Destroy()
                debug.profileend()
            end
            v151.BombHolsterModel = nil
        end
        for v154, v155 in pairs(v151) do
            if v155 and (typeof(v154) == "number" and typeof(v155) == "table") then
                local v156 = v155.Model and v155.Model
                if v156 then
                    debug.profilebegin("CreateWeaponModel.ClearPlayerCache.DestroySlotModel")
                    v156:Destroy()
                    debug.profileend()
                end
                v151[v154] = nil
            end
        end
        local v157 = workspace:FindFirstChild("Debris")
        if v157 then
            local v158 = v157:FindFirstChild(p149.Name .. "_Weapon")
            if v158 and v158 then
                debug.profilebegin("CreateWeaponModel.ClearPlayerCache.DestroyEquippedWeapon")
                v158:Destroy()
                debug.profileend()
            end
            local v159 = v157:FindFirstChild(p149.Name .. "_WeaponAttachments")
            if v159 and v159 then
                debug.profilebegin("CreateWeaponModel.ClearPlayerCache.DestroyAttachmentsFolder")
                v159:Destroy()
                debug.profileend()
            end
        end
        v_u_18(p149, "cleared player cache (destroyed holsters)")
        v_u_13[p149] = nil
    end
end
local function v_u_172(p_u_161, p162)
    -- upvalues: (copy) v_u_13, (copy) v_u_160, (copy) v_u_14
    local v163 = v_u_13[p_u_161] or {
        ["Character"] = nil
    }
    v_u_13[p_u_161] = v163
    if v163.Character ~= p162 then
        if v163.Character then
            v_u_160(p_u_161)
            v163 = v_u_13[p_u_161] or {
                ["Character"] = nil
            }
            v_u_13[p_u_161] = v163
        end
        v163.Character = p162
        local v164 = v_u_14[p_u_161]
        if v164 then
            v164:Disconnect()
        end
        v_u_14[p_u_161] = p162.AncestryChanged:Connect(function(_, p165)
            -- upvalues: (copy) p_u_161, (ref) v_u_13
            if not p165 or p165.Name == "Debris" then
                local v166 = workspace:FindFirstChild("Debris")
                if v166 then
                    local v167 = v166:FindFirstChild(p_u_161.Name .. "_Weapon")
                    if v167 and v167 then
                        debug.profilebegin("CreateWeaponModel.AncestryCleanup.DestroyEquippedWeapon")
                        v167:Destroy()
                        debug.profileend()
                    end
                    local v168 = v166:FindFirstChild(p_u_161.Name .. "_WeaponAttachments")
                    if v168 and v168 then
                        debug.profilebegin("CreateWeaponModel.AncestryCleanup.DestroyAttachmentsFolder")
                        v168:Destroy()
                        debug.profileend()
                    end
                end
                local v169 = v_u_13[p_u_161]
                if v169 then
                    v169.ObjectiveKitHolsterModel = nil
                    v169.BombHolsterModel = nil
                    for v170, v171 in pairs(v169) do
                        if v171 and (typeof(v170) == "number" and typeof(v171) == "table") then
                            v169[v170] = nil
                        end
                    end
                    v169.Character = nil
                end
            end
        end)
    end
end
local function v_u_189(p173, p174, p175, p176, p177)
    -- upvalues: (copy) v_u_5, (copy) v_u_13, (copy) v_u_34, (copy) v_u_18, (copy) v_u_148
    local v178 = v_u_5(p176.Weapon)
    if not v178 or v178.ShootingOptions ~= "Dual" then
        local v179 = v_u_13[p173] or {
            ["Character"] = nil
        }
        v_u_13[p173] = v179
        local v180 = v179[p175]
        if v180 then
            if v180.Skin == p176.Skin and (v180.Weapon == p176.Weapon and v180.Model) then
                local v181 = v180.Weapon
                local v182 = v180.Skin
                local v183
                if v181 == p177.Name then
                    v183 = v182 == p177.Skin
                else
                    v183 = false
                end
                v_u_34(v180.Model, not v183)
                return
            end
            local v184 = v180.Model and v180.Model
            if v184 then
                debug.profilebegin("CreateWeaponModel.UpdateCachedWeapon.DestroyOldModel")
                v184:Destroy()
                debug.profileend()
            end
        end
        v179[p175] = nil
        local v185 = p176.Weapon
        local v186 = p176.Skin
        local v187
        if v185 == p177.Name then
            v187 = v186 == p177.Skin
        else
            v187 = false
        end
        v_u_18(p173, "holster slot=%d weapon=%s skin=%s equippedInHand=%s", p175, p176.Weapon, p176.Skin, (tostring(v187)))
        local v188 = v_u_148(p173, p174, p175, p176.Weapon, p176.Skin, p176.Float, p176.StatTrack, p176.NameTag, p176.Charm, p176.Stickers)
        if v188 then
            v_u_34(v188, not v187)
        end
    end
end
local function v_u_205(p190, p191, p192, p193)
    -- upvalues: (copy) v_u_172, (copy) v_u_13, (copy) v_u_189, (copy) v_u_100, (copy) v_u_123
    v_u_172(p190, p191)
    if not p193[1] then
        local v194 = v_u_13[p190]
        local v195 = v194 and v194[1]
        if v195 then
            local v196 = v195.Model
            if v196 and v196 then
                debug.profilebegin("CreateWeaponModel.DestroyCachedWeaponAtSlot.DestroyModel")
                v196:Destroy()
                debug.profileend()
            end
            v194[1] = nil
        end
    end
    if not p193[2] then
        local v197 = v_u_13[p190]
        local v198 = v197 and v197[2]
        if v198 then
            local v199 = v198.Model
            if v199 and v199 then
                debug.profilebegin("CreateWeaponModel.DestroyCachedWeaponAtSlot.DestroyModel")
                v199:Destroy()
                debug.profileend()
            end
            v197[2] = nil
        end
    end
    if not p193[3] then
        local v200 = v_u_13[p190]
        local v201 = v200 and v200[3]
        if v201 then
            local v202 = v201.Model
            if v202 and v202 then
                debug.profilebegin("CreateWeaponModel.DestroyCachedWeaponAtSlot.DestroyModel")
                v202:Destroy()
                debug.profileend()
            end
            v200[3] = nil
        end
    end
    for v203, v204 in pairs(p193) do
        if v204 then
            v_u_189(p190, p191, v203, v204, p192)
        end
    end
    v_u_100(p190, p191)
    v_u_123(p190, p191, p192)
end
local function v_u_214(p206, p207, p208)
    local v209 = Instance.new("Motor6D")
    v209.Name = "WeaponAttachment" .. (p208 or "")
    v209.Parent = p206
    v209.Part0 = p206
    v209.Part1 = p208 and p207:FindFirstChild(p208, true) or p207.PrimaryPart
    local v210 = p207:FindFirstChild("Properties")
    if v210 then
        for _, v211 in ipairs(p208 and { "LEFT", "RIGHT" } or { "" }) do
            local v212 = v210:FindFirstChild("C0" .. v211)
            if v212 then
                v209.C0 = v212.Value
            end
            local v213 = v210:FindFirstChild("C1" .. v211)
            if v213 then
                v209.C1 = v213.Value
            end
        end
    end
    return v209
end
local function v_u_219(p215, p216)
    -- upvalues: (copy) v_u_214
    local v217 = p215:FindFirstChild("RightHand")
    local v218 = p215:FindFirstChild("LeftHand")
    if v217 and v218 then
        v_u_214(v217, p216, "HandleR")
        v_u_214(v218, p216, "HandleL")
    else
        warn("CreateDualMotor6DAttachments: Could not find RightHand or LeftHand for dual weapon")
    end
end
local function v_u_227(p220, p221, p222)
    local v223 = p222:FindFirstChild("WeaponAttachment")
    p221:ClearAllChildren()
    local v224 = workspace:FindFirstChild("Debris")
    if v224 then
        local v225 = v224:FindFirstChild(p220.Name .. "_Weapon")
        if v225 and v225 then
            debug.profilebegin("CreateWeaponModel.CleanupPreviousWeapon.DestroyEquippedWeapon")
            v225:Destroy()
            debug.profileend()
        end
    end
    if v223 and v223 then
        debug.profilebegin("CreateWeaponModel.CleanupPreviousWeapon.DestroyMainAttachment")
        v223:Destroy()
        debug.profileend()
    end
    local v226 = p222:FindFirstChild("WeaponAttachmentHandleR")
    if v226 then
        if not v226 then
            return
        end
        debug.profilebegin("CreateWeaponModel.CleanupPreviousWeapon.DestroyRightAttachment")
        v226:Destroy()
        debug.profileend()
    end
end
local function v_u_250(p228, p229, p230)
    -- upvalues: (copy) v_u_8, (copy) v_u_5, (copy) v_u_227, (copy) v_u_22, (copy) v_u_7, (copy) v_u_18, (copy) v_u_25, (copy) v_u_30, (copy) v_u_219, (copy) v_u_214
    local v231 = p229.Parent
    if not v231 or v231.Name == "Debris" then
        return nil, nil
    end
    local v232 = p230.Name
    local v233 = v_u_8.WEAPON_JOINT_PARTS[v232] or v_u_8.DEFAULT_JOINT_PART
    local v234 = p229:WaitForChild(v233, 10)
    local v235 = ("Failed to get joint part: %* for weapon: %*"):format(v233, v232)
    assert(v234, v235)
    local v236 = v_u_5(p230.Name)
    if not v236 then
        return nil, nil
    end
    local v237 = p229:FindFirstChild("WeaponModel")
    if not v237 then
        return nil, nil
    end
    v_u_227(p228, v237, v234)
    local v238 = p229:FindFirstChild("LeftHand")
    if v238 then
        local v239 = v238:FindFirstChild("WeaponAttachmentHandleL")
        if v239 and v239 then
            debug.profilebegin("CreateWeaponModel.CreateEquippedWeapon.DestroyLeftAttachment")
            v239:Destroy()
            debug.profileend()
        end
    end
    local v240 = nil
    local v241
    if p230.Name == "Smoke Grenade" then
        v241 = p228:GetAttribute("Team")
        if v241 ~= "Counter-Terrorists" and v241 ~= "Terrorists" then
            v241 = v240
        end
    else
        v241 = v240
    end
    if p230.Name == "Zeus x27" then
        v_u_22(p228, "CreateEquippedWeapon start skin=%s character=%s jointPart=%s weaponFolder=%s", p230.Skin, p229.Name, v234.Name, not v237 and "nil" or v237.Name)
    end
    local v242 = v_u_7.GetCharacterModel(p230.Name, p230.Skin, p230.Float, p230.StatTrack, p230.NameTag, p230.Charm, p230.Stickers, v241)
    if not v242 then
        v_u_18(p228, "equipped weapon skipped: SkinHandler returned nil for weapon=%s skin=%s", p230.Name, p230.Skin)
        if p230.Name == "Zeus x27" then
            v_u_22(p228, "CreateEquippedWeapon SkinHandler returned nil")
        end
        return nil, nil
    end
    if p230.Name == "Zeus x27" then
        v_u_22(p228, "CreateEquippedWeapon model=%s primaryPart=%s", v242.Name, not v242.PrimaryPart and "nil" or v242.PrimaryPart.Name)
    end
    v_u_25(v242)
    v_u_30(v242)
    local v243 = p230.IsSuppressed
    local v244 = v242:FindFirstChild("Silencer", true)
    if v244 and v236.HasSuppressor then
        v244.Transparency = v243 and 0 or 1
    end
    if v236.ShootingOptions == "Dual" then
        v_u_219(p229, v242)
    else
        v_u_214(v234, v242, nil)
    end
    if p230.Name == "Zeus x27" then
        local v245 = v234:FindFirstChild("WeaponAttachment")
        v_u_22(p228, "CreateEquippedWeapon motor=%s part0=%s part1=%s", tostring(v245), not (v245 and v245.Part0) and "nil" or v245.Part0.Name, not (v245 and v245.Part1) and "nil" or v245.Part1.Name)
    end
    local v246 = workspace:FindFirstChild("Debris")
    if v246 then
        v242.Parent = v246
        v242.Name = p228.Name .. "_Weapon"
        v242:SetAttribute("PersistentDebris", true)
    end
    if p230.Name == "Zeus x27" then
        local v247 = v_u_22
        local v248 = "CreateEquippedWeapon parented=%s existsInDebris=%s"
        local v249 = v242.Parent and (v242.Parent.Name or "nil") or "nil"
        if v246 then
            v246 = v246:FindFirstChild(p228.Name .. "_Weapon") ~= nil
        end
        v247(p228, v248, v249, (tostring(v246)))
    end
    return v242, v234
end
local function v_u_256(p251, p252, p253)
    -- upvalues: (copy) v_u_250, (copy) v_u_205, (copy) v_u_160
    local v254 = p251.Character
    if v254 then
        local _, v255 = v_u_250(p251, v254, p252)
        if v255 then
            v_u_205(p251, v254, p252, p253)
            return v255, v_u_160
        end
    end
    return nil, nil
end
local v257 = setmetatable({}, {
    ["__call"] = function(_, ...)
        -- upvalues: (copy) v_u_256
        return v_u_256(...)
    end
})
v257.ClearPlayerCache = v_u_160
function v257.RefreshObjectiveKitHolster(p258)
    -- upvalues: (copy) v_u_172, (copy) v_u_100
    local v259 = p258.Character
    if v259 then
        v_u_172(p258, v259)
        v_u_100(p258, v259)
    end
end
function v257.RefreshBombHolster(p260)
    -- upvalues: (copy) v_u_172, (copy) v_u_2, (copy) v_u_123
    local v261 = p260.Character
    if v261 then
        v_u_172(p260, v261)
        local v262 = p260:GetAttribute("CurrentEquipped")
        local v263
        if v262 then
            v263 = v_u_2:JSONDecode(v262)
        else
            v263 = nil
        end
        v_u_123(p260, v261, v263)
    end
end
v3.PlayerRemoving:Connect(function(p264)
    -- upvalues: (copy) v_u_160
    v_u_160(p264)
end)
return v257
