-- MODULESCRIPT: Sort
-- Original Path: game.BAC - 48473.Database.Custom.GameStats.UI.Inventory.Sort
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Controllers.DataController)
local v_u_3 = require(v1.Components.Common.GetWeaponProperties)
local v_u_4 = require(v1.Database.Components.Libraries.Skins)
local v_u_5 = require(v1.Database.Components.Libraries.Cases)
local v_u_6 = require(v1.Database.Custom.GameStats.UI.Inventory.Buttons)
local v_u_7 = {
    ["Forbidden"] = 7,
    ["Special"] = 6,
    ["Red"] = 5,
    ["Pink"] = 4,
    ["Purple"] = 3,
    ["Blue"] = 2,
    ["Stock"] = 1
}
local v_u_8 = {
    ["Sticker Capsule"] = 14,
    ["Charm Capsule"] = 13,
    ["Music Kit"] = 8,
    ["Graffiti"] = 11,
    ["Grenade"] = 16,
    ["Sticker"] = 10,
    ["Zeus x27"] = 3,
    ["Charm"] = 9,
    ["Melee"] = 1,
    ["Glove"] = 2,
    ["Badge"] = 7,
    ["Case"] = 12,
    ["C4"] = 15
}
local v_u_9 = {
    ["Melee"] = 1,
    ["Glove"] = 2,
    ["Case"] = 3,
    ["Charm Capsule"] = 4,
    ["Sticker Capsule"] = 4
}
local v_u_10 = {
    ["Miscellaneous"] = 18,
    ["Equipment"] = 17,
    ["Pistol"] = 3,
    ["Rifle"] = 6,
    ["Heavy"] = 5,
    ["SMG"] = 4
}
local v_u_11 = {
    ["Pistols"] = 1,
    ["Mid Tier"] = 2,
    ["Rifles"] = 3
}
local v_u_12 = {
    ["Equipped Melee"] = 1,
    ["Equipped Gloves"] = 2,
    ["Equipped Badge"] = 3,
    ["Equipped Music Kit"] = 4,
    ["Equipped Graffiti"] = 5,
    ["Equipped Zeus x27"] = 6
}
local function v_u_19(p13, p14)
    -- upvalues: (copy) v_u_6, (copy) v_u_5, (copy) v_u_4
    if v_u_6.IsCapsule(p13) then
        return "Capsules"
    end
    if p13.Type ~= "Case" then
        if not (p13.Name and p13.Skin) then
            return nil
        end
        local v15 = v_u_4.GetSkinInformation(p13.Name, p13.Skin)
        return v15 and v15.collection or nil
    end
    if not p13.Skin then
        return nil
    end
    local v16 = v_u_5.GetCaseByName(p13.Skin)
    if not v16 then
        return nil
    end
    if p14 then
        p14 = p14()
    end
    if not p14 then
        return nil
    end
    for _, v17 in ipairs(p14) do
        if v17.cases then
            for _, v18 in ipairs(v17.cases) do
                if v18 == v16.name then
                    return v17.name
                end
            end
        end
    end
    return nil
end
local function v_u_34(p20, p21)
    -- upvalues: (copy) v_u_2, (copy) v_u_11, (copy) v_u_12
    local v22 = nil
    local v23 = v_u_2.Get(p21, "Loadout")
    if not v23 then
        return nil
    end
    for _, v24 in ipairs({ "Counter-Terrorists", "Terrorists" }) do
        local v25 = v23[v24]
        if v25 and v25.Loadout then
            for v26, v27 in pairs(v_u_11) do
                if v27 and (v25.Loadout[v26] and v25.Loadout[v26].Options) then
                    for v28, v29 in ipairs(v25.Loadout[v26].Options) do
                        if v29 == p20 then
                            local v30 = v27 * 1000 + v28
                            if not v22 or v30 < v22 then
                                v22 = v30
                            end
                        end
                    end
                end
            end
            if v25.Equipped then
                for v31, v32 in pairs(v25.Equipped) do
                    if v32 == p20 then
                        local v33 = v_u_12[v31] or 99
                        if not v22 or v33 < v22 then
                            v22 = v33
                        end
                    end
                end
            end
        end
    end
    return v22
end
return {
    ["GetSortComparisonFunction"] = function(p35, p_u_36, p_u_37)
        -- upvalues: (copy) v_u_19, (copy) v_u_6, (copy) v_u_9, (copy) v_u_4, (copy) v_u_7, (copy) v_u_34, (copy) v_u_8, (copy) v_u_3, (copy) v_u_10
        return p35 == "Alphabetical" and function(p38, p39)
            local v40 = (p38.Skin == "Stock" or p38.MetaData and p38.MetaData.Origin == "Stock") and true or false
            local v41 = (p39.Skin == "Stock" or p39.MetaData and p39.MetaData.Origin == "Stock") and true or false
            if v40 == v41 then
                local v42
                if p38.Type == "Case" then
                    v42 = p38.Skin or ""
                else
                    v42 = (p38.Name or "") .. "|" .. (p38.Skin or "")
                end
                local v43
                if p39.Type == "Case" then
                    v43 = p39.Skin or ""
                else
                    v43 = (p39.Name or "") .. "|" .. (p39.Skin or "")
                end
                if v42 == v43 then
                    local v44 = p38.MetaData
                    if v44 then
                        v44 = p38.MetaData.CreatedAt
                    end
                    local v45 = v44 or 0
                    local v46 = p39.MetaData
                    if v46 then
                        v46 = p39.MetaData.CreatedAt
                    end
                    local v47 = v46 or 0
                    if v45 == v47 then
                        return (p38._id or "") < (p39._id or "")
                    else
                        return v47 < v45
                    end
                else
                    return v42 < v43
                end
            else
                return v41, true
            end
        end or (p35 == "Collection" and function(p48, p49)
            -- upvalues: (ref) v_u_19, (copy) p_u_37, (ref) v_u_6, (ref) v_u_9, (ref) v_u_4, (ref) v_u_7
            local v50 = (p48.Skin == "Stock" or p48.MetaData and p48.MetaData.Origin == "Stock") and true or false
            local v51 = (p49.Skin == "Stock" or p49.MetaData and p49.MetaData.Origin == "Stock") and true or false
            if v50 ~= v51 then
                return v51, true
            end
            local v52 = v_u_19(p48, p_u_37) or ""
            local v53 = v_u_19(p49, p_u_37) or ""
            if v52 ~= v53 then
                return v52 < v53
            end
            local v54 = v_u_6.GetEffectiveItemType(p48)
            local v55 = v_u_6.GetEffectiveItemType(p49)
            local v56 = v_u_9[v54] or 4
            local v57 = v_u_9[v55] or 4
            if v56 ~= v57 then
                return v56 < v57
            end
            local v58
            if p48.Name and p48.Skin then
                v58 = v_u_4.GetSkinInformation(p48.Name, p48.Skin) or nil
            else
                v58 = nil
            end
            local v59
            if p49.Name and p49.Skin then
                v59 = v_u_4.GetSkinInformation(p49.Name, p49.Skin) or nil
            else
                v59 = nil
            end
            local v60 = v58 and v_u_7[v58.rarity] or 0
            local v61 = v59 and v_u_7[v59.rarity] or 0
            if v60 ~= v61 then
                return v61 < v60
            end
            local v62
            if p48.Type == "Case" then
                v62 = p48.Skin or ""
            else
                v62 = (p48.Name or "") .. "|" .. (p48.Skin or "")
            end
            local v63
            if p49.Type == "Case" then
                v63 = p49.Skin or ""
            else
                v63 = (p49.Name or "") .. "|" .. (p49.Skin or "")
            end
            if v62 ~= v63 then
                return v62 < v63
            end
            local v64 = p48.MetaData
            if v64 then
                v64 = p48.MetaData.CreatedAt
            end
            local v65 = v64 or 0
            local v66 = p49.MetaData
            if v66 then
                v66 = p49.MetaData.CreatedAt
            end
            return (v66 or 0) < v65
        end or (p35 == "Equipped" and function(p67, p68)
            -- upvalues: (ref) v_u_34, (copy) p_u_36
            local v69 = (p67.Skin == "Stock" or p67.MetaData and p67.MetaData.Origin == "Stock") and true or false
            local v70 = (p68.Skin == "Stock" or p68.MetaData and p68.MetaData.Origin == "Stock") and true or false
            if v69 ~= v70 then
                return v70, true
            end
            local v71
            if p67._id then
                v71 = v_u_34(p67._id, p_u_36) or nil
            else
                v71 = nil
            end
            local v72
            if p68._id then
                v72 = v_u_34(p68._id, p_u_36) or nil
            else
                v72 = nil
            end
            if v71 ~= nil ~= (v72 ~= nil) then
                return v71 ~= nil
            end
            if not (v71 and v72) then
                local v73
                if p67.Type == "Case" then
                    v73 = p67.Skin or ""
                else
                    v73 = (p67.Name or "") .. "|" .. (p67.Skin or "")
                end
                local v74
                if p68.Type == "Case" then
                    v74 = p68.Skin or ""
                else
                    v74 = (p68.Name or "") .. "|" .. (p68.Skin or "")
                end
                if v73 ~= v74 then
                    return v73 < v74
                end
                local v75 = p67.MetaData
                if v75 then
                    v75 = p67.MetaData.CreatedAt
                end
                local v76 = v75 or 0
                local v77 = p68.MetaData
                if v77 then
                    v77 = p68.MetaData.CreatedAt
                end
                return (v77 or 0) < v76
            end
            if v71 ~= v72 then
                return v71 < v72
            end
            local v78
            if p67.Type == "Case" then
                v78 = p67.Skin or ""
            else
                v78 = (p67.Name or "") .. "|" .. (p67.Skin or "")
            end
            local v79
            if p68.Type == "Case" then
                v79 = p68.Skin or ""
            else
                v79 = (p68.Name or "") .. "|" .. (p68.Skin or "")
            end
            if v78 ~= v79 then
                return v78 < v79
            end
            local v80 = p67.MetaData
            if v80 then
                v80 = p67.MetaData.CreatedAt
            end
            local v81 = v80 or 0
            local v82 = p68.MetaData
            if v82 then
                v82 = p68.MetaData.CreatedAt
            end
            return (v82 or 0) < v81
        end or (p35 == "Newest" and function(p83, p84)
            local v85 = (p83.Skin == "Stock" or p83.MetaData and p83.MetaData.Origin == "Stock") and true or false
            local v86 = (p84.Skin == "Stock" or p84.MetaData and p84.MetaData.Origin == "Stock") and true or false
            if v85 == v86 then
                local v87 = p83.MetaData
                if v87 then
                    v87 = p83.MetaData.CreatedAt
                end
                local v88 = v87 or 0
                local v89 = p84.MetaData
                if v89 then
                    v89 = p84.MetaData.CreatedAt
                end
                local v90 = v89 or 0
                if v88 == v90 then
                    local v91
                    if p83.Type == "Case" then
                        v91 = p83.Skin or ""
                    else
                        v91 = (p83.Name or "") .. "|" .. (p83.Skin or "")
                    end
                    local v92
                    if p84.Type == "Case" then
                        v92 = p84.Skin or ""
                    else
                        v92 = (p84.Name or "") .. "|" .. (p84.Skin or "")
                    end
                    if v91 == v92 then
                        return (p83._id or "") < (p84._id or "")
                    else
                        return v91 < v92
                    end
                else
                    return v90 < v88
                end
            else
                return v86, true
            end
        end or (p35 == "Quality" and function(p93, p94)
            -- upvalues: (ref) v_u_4, (ref) v_u_7
            local v95 = (p93.Skin == "Stock" or p93.MetaData and p93.MetaData.Origin == "Stock") and true or false
            local v96 = (p94.Skin == "Stock" or p94.MetaData and p94.MetaData.Origin == "Stock") and true or false
            if v95 ~= v96 then
                return v96, true
            end
            local v97
            if p93.Name and p93.Skin then
                v97 = v_u_4.GetSkinInformation(p93.Name, p93.Skin) or nil
            else
                v97 = nil
            end
            local v98
            if p94.Name and p94.Skin then
                v98 = v_u_4.GetSkinInformation(p94.Name, p94.Skin) or nil
            else
                v98 = nil
            end
            local v99 = v97 and v_u_7[v97.rarity] or 0
            local v100 = v98 and v_u_7[v98.rarity] or 0
            if v99 ~= v100 then
                return v100 < v99
            end
            local v101
            if p93.Type == "Case" then
                v101 = p93.Skin or ""
            else
                v101 = (p93.Name or "") .. "|" .. (p93.Skin or "")
            end
            local v102
            if p94.Type == "Case" then
                v102 = p94.Skin or ""
            else
                v102 = (p94.Name or "") .. "|" .. (p94.Skin or "")
            end
            if v101 ~= v102 then
                return v101 < v102
            end
            local v103 = p93.MetaData
            if v103 then
                v103 = p93.MetaData.CreatedAt
            end
            local v104 = v103 or 0
            local v105 = p94.MetaData
            if v105 then
                v105 = p94.MetaData.CreatedAt
            end
            return (v105 or 0) < v104
        end or (p35 == "Type" and function(p106, p107)
            -- upvalues: (ref) v_u_6, (ref) v_u_8, (ref) v_u_3, (ref) v_u_10
            local v108 = (p106.Skin == "Stock" or p106.MetaData and p106.MetaData.Origin == "Stock") and true or false
            local v109 = (p107.Skin == "Stock" or p107.MetaData and p107.MetaData.Origin == "Stock") and true or false
            if v108 ~= v109 then
                return v109, true
            end
            local v110 = v_u_6.GetEffectiveItemType(p106)
            local v111 = v_u_6.GetEffectiveItemType(p107)
            local v112 = v_u_8[v110]
            local v113
            if v112 or v110 ~= "Weapon" then
                v113 = v112 or 99
            elseif p106.Name then
                local v114, v115 = pcall(v_u_3, p106.Name)
                v113 = v114 and (v115 and v115.Type) and (v_u_10[v115.Type] or 99) or 99
            else
                v113 = 99
            end
            local v116 = v_u_8[v111]
            local v117
            if v116 or v111 ~= "Weapon" then
                v117 = v116 or 99
            elseif p107.Name then
                local v118, v119 = pcall(v_u_3, p107.Name)
                v117 = v118 and (v119 and v119.Type) and (v_u_10[v119.Type] or 99) or 99
            else
                v117 = 99
            end
            if v113 ~= v117 then
                return v113 < v117
            end
            local v120
            if p106.Type == "Case" then
                v120 = p106.Skin or ""
            else
                v120 = (p106.Name or "") .. "|" .. (p106.Skin or "")
            end
            local v121
            if p107.Type == "Case" then
                v121 = p107.Skin or ""
            else
                v121 = (p107.Name or "") .. "|" .. (p107.Skin or "")
            end
            if v120 ~= v121 then
                return v120 < v121
            end
            local v122 = p106.MetaData
            if v122 then
                v122 = p106.MetaData.CreatedAt
            end
            local v123 = v122 or 0
            local v124 = p107.MetaData
            if v124 then
                v124 = p107.MetaData.CreatedAt
            end
            return (v124 or 0) < v123
        end or (p35 == "Float" and function(p125, p126)
            local v127 = (p125.Skin == "Stock" or p125.MetaData and p125.MetaData.Origin == "Stock") and true or false
            local v128 = (p126.Skin == "Stock" or p126.MetaData and p126.MetaData.Origin == "Stock") and true or false
            if v127 ~= v128 then
                return v128, true
            end
            local v129 = p125.Name == "Badge"
            local v130 = p126.Name == "Badge"
            if v129 ~= v130 then
                return v130, true
            end
            local v131 = p125.Name == "Charm"
            local v132 = p126.Name == "Charm"
            if v131 ~= v132 then
                return v132, true
            end
            local v133 = p125.Float
            local v134 = p126.Float
            if v133 ~= nil and v134 ~= nil then
                if v133 ~= v134 then
                    return v133 < v134
                end
                local v135
                if p125.Type == "Case" then
                    v135 = p125.Skin or ""
                else
                    v135 = (p125.Name or "") .. "|" .. (p125.Skin or "")
                end
                local v136
                if p126.Type == "Case" then
                    v136 = p126.Skin or ""
                else
                    v136 = (p126.Name or "") .. "|" .. (p126.Skin or "")
                end
                if v135 ~= v136 then
                    return v135 < v136
                end
                local v137 = p125.MetaData
                if v137 then
                    v137 = p125.MetaData.CreatedAt
                end
                local v138 = v137 or 0
                local v139 = p126.MetaData
                if v139 then
                    v139 = p126.MetaData.CreatedAt
                end
                return (v139 or 0) < v138
            end
            if v133 ~= nil then
                return true
            end
            if v134 ~= nil then
                return false
            end
            local v140
            if p125.Type == "Case" then
                v140 = p125.Skin or ""
            else
                v140 = (p125.Name or "") .. "|" .. (p125.Skin or "")
            end
            local v141
            if p126.Type == "Case" then
                v141 = p126.Skin or ""
            else
                v141 = (p126.Name or "") .. "|" .. (p126.Skin or "")
            end
            if v140 ~= v141 then
                return v140 < v141
            end
            local v142 = p125.MetaData
            if v142 then
                v142 = p125.MetaData.CreatedAt
            end
            local v143 = v142 or 0
            local v144 = p126.MetaData
            if v144 then
                v144 = p126.MetaData.CreatedAt
            end
            return (v144 or 0) < v143
        end or nil))))))
    end
}
