-- MODULESCRIPT: Stock
-- Original Path: game.BAC - 33020.Database.Components.Libraries.Stock
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
require(v_u_2.Database.Custom.Types)
local v_u_3 = {
    "USP-S",
    "Glock-18",
    "P250",
    "Desert Eagle",
    "Tec-9",
    "CZ75-Auto",
    "Five-SeveN",
    "Dual Berettas",
    "R8 Revolver",
    "MAC-10",
    "MP9",
    "MP7",
    "MP5-SD",
    "UMP-45",
    "P90",
    "PP-Bizon",
    "AK-47",
    "M4A1-S",
    "M4A4",
    "AUG",
    "SG 553",
    "FAMAS",
    "Galil AR",
    "AWP",
    "SSG 08",
    "SCAR-20",
    "G3SG1",
    "XM1014",
    "Nova",
    "MAG-7",
    "Sawed-Off",
    "Negev",
    "M249",
    "CT Knife",
    "T Knife",
    "CT Glove",
    "T Glove",
    "Molotov",
    "Incendiary Grenade",
    "HE Grenade",
    "Flashbang",
    "Smoke Grenade",
    "Decoy Grenade",
    "C4",
    "Zeus x27"
}
local function v_u_7(p4)
    -- upvalues: (copy) v_u_2
    if p4 == "Zeus x27" then
        return "Zeus x27"
    end
    if p4 == "C4" then
        return "C4"
    end
    local v5 = v_u_2.Database.Custom.Weapons:FindFirstChild(p4)
    if not v5 then
        return "Weapon"
    end
    local v6 = require(v5).Class
    return v6 == "Weapon" and "Weapon" or (v6 == "Melee" and "Melee" or (v6 == "Glove" and "Glove" or (v6 == "Grenade" and "Grenade" or (v6 == "C4" and "C4" or "Weapon"))))
end
local function v_u_10(p8)
    -- upvalues: (copy) v_u_7
    local v9 = {
        ["_id"] = p8 .. "_Stock",
        ["Type"] = v_u_7(p8),
        ["Serial"] = 0,
        ["Name"] = p8,
        ["Skin"] = "Stock",
        ["Float"] = 0,
        ["StatTrack"] = false,
        ["IsTradeable"] = false,
        ["NameTag"] = false,
        ["Charm"] = false,
        ["Stickers"] = {},
        ["MetaData"] = {
            ["LastTradeAt"] = 0,
            ["CreatedAt"] = 0,
            ["TradeHistory"] = {},
            ["OriginalOwner"] = 0,
            ["Owner"] = 0,
            ["Origin"] = "Stock"
        }
    }
    return v9
end
function v_u_1.IsStockIdentifier(p11)
    return string.sub(p11, -6) == "_Stock"
end
function v_u_1.GetWeaponNameFromStockId(p12)
    -- upvalues: (copy) v_u_1
    if v_u_1.IsStockIdentifier(p12) then
        return string.sub(p12, 1, -7)
    else
        return nil
    end
end
function v_u_1.GetStockInventoryItem(p13)
    -- upvalues: (copy) v_u_3, (copy) v_u_10
    if table.find(v_u_3, p13) then
        return v_u_10(p13)
    else
        return nil
    end
end
function v_u_1.GenerateStockInventoryItems()
    -- upvalues: (copy) v_u_3, (copy) v_u_10
    local v14 = {}
    for _, v15 in ipairs(v_u_3) do
        local v16 = v_u_10(v15)
        table.insert(v14, v16)
    end
    return v14
end
function v_u_1.InjectStockItems(p17)
    -- upvalues: (copy) v_u_1
    local v18 = v_u_1.GenerateStockInventoryItems()
    local v19 = {}
    local v20 = {}
    for _, v21 in ipairs(p17) do
        v19[v21._id] = true
        if v21.Skin == "Stock" then
            v20[v21.Name] = true
        end
    end
    for _, v22 in ipairs(v18) do
        if not (v19[v22._id] or v20[v22.Name]) then
            table.insert(p17, v22)
        end
    end
    return p17
end
return v_u_1

>> Batch #18 complete. Yielding...
