-- MODULESCRIPT: EquipInventorySlot
-- Original Path: game.BAC - 15337.Components.Common.UserInput.EquipInventorySlot
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Controllers.InventoryController)
local function v_u_11(p3, p4)
    local v5 = {}
    if p3 ~= 3 then
        for v6 = 1, #p4 do
            table.insert(v5, v6)
        end
        return v5
    end
    for v7, v8 in ipairs(p4) do
        if v8.Name ~= "Zeus x27" then
            table.insert(v5, v7)
        end
    end
    for v9, v10 in ipairs(p4) do
        if v10.Name == "Zeus x27" then
            table.insert(v5, v9)
        end
    end
    return v5
end
local function v_u_22(p12, p13, p14)
    -- upvalues: (copy) v_u_11
    local v15 = v_u_11(p12, p13)
    local v16 = v15[1]
    if not v16 then
        return 0
    end
    if not p14 then
        return v16
    end
    for v21, v18 in ipairs(p13) do
        if v18.Identifier == p14 then
            ::l8::
            if v21 == 0 then
                return v16
            end
            for v19, v20 in ipairs(v15) do
                if v20 == v21 then
                    return v15[v19 + 1] or v16
                end
            end
            return v16
        end
    end
    local v21 = 0
    goto l8
end
return function(p23)
    -- upvalues: (copy) v_u_2, (copy) v_u_22, (copy) v_u_11
    local v24 = v_u_2.getCurrentEquipped()
    local v25 = v_u_2.getInventorySlot(p23)
    if v25 then
        if v24 then
            if (v24.Slot or 1) == p23 then
                local v26 = v_u_22(p23, v25._items, v24.Identifier)
                if v26 > 0 then
                    v_u_2.equip(p23, v26)
                    return
                end
            else
                local v27 = v_u_11(p23, v25._items)[1] or 0
                if v27 > 0 then
                    v_u_2.equip(p23, v27)
                    return
                end
            end
        else
            local v28 = v_u_11(p23, v25._items)[1] or 0
            if v28 > 0 then
                v_u_2.equip(p23, v28)
            end
        end
    end
end

>> Batch #16 complete. Yielding...
