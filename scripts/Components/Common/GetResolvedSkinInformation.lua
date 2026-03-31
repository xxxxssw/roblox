-- MODULESCRIPT: GetResolvedSkinInformation
-- Original Path: game.BAC - 15337.Components.Common.GetResolvedSkinInformation
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Database.Components.Libraries.Skins)
local v_u_3 = require(script.Parent.GetWeaponProperties)
local function v_u_7(p4)
    -- upvalues: (copy) v_u_3
    local v5, v6 = pcall(v_u_3, p4)
    if v5 then
        return v6 and {
            ["paintId"] = "stock",
            ["type"] = v6.Class,
            ["name"] = p4,
            ["skin"] = "Stock",
            ["rarity"] = "Stock",
            ["floatRange"] = {
                ["min"] = 0,
                ["max"] = 0.07
            },
            ["floatChances"] = {
                {
                    ["wear"] = "Factory New",
                    ["chance"] = 100
                }
            },
            ["charmImages"] = {},
            ["wearImages"] = {},
            ["supportsStatTrak"] = false,
            ["statTrakChance"] = 0,
            ["isEnabled"] = true,
            ["isMarketplaceVisible"] = false,
            ["collection"] = nil,
            ["description"] = "Standard issue finish.",
            ["caseRarity"] = "Stock",
            ["imageAssetId"] = v6.Icon or v6.ReverseIcon
        } or nil
    else
        return nil
    end
end
return function(p8, p9)
    -- upvalues: (copy) v_u_2, (copy) v_u_7
    local v10 = v_u_2.GetSkinInformation(p8, p9)
    if v10 or p9 ~= "Stock" then
        return v10
    else
        return v_u_7(p8)
    end
end
