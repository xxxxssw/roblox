-- MODULESCRIPT: NormalizeInventoryItemForRemote
-- Original Path: game.BAC - 15337.Database.Components.Common.NormalizeInventoryItemForRemote
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("HttpService")
return function(p_u_2)
    -- upvalues: (copy) v_u_1
    local v3, v_u_4 = pcall(function()
        -- upvalues: (ref) v_u_1, (copy) p_u_2
        return v_u_1:JSONEncode(p_u_2)
    end)
    if not (v3 and v_u_4) then
        return p_u_2
    end
    local v5, v6 = pcall(function()
        -- upvalues: (ref) v_u_1, (copy) v_u_4
        return v_u_1:JSONDecode(v_u_4)
    end)
    if not (v5 and v6) then
        return p_u_2
    end
    for _, v7 in ipairs({
        "_id",
        "Type",
        "Name",
        "Skin",
        "Rarity",
        "OriginalOwner"
    }) do
        if v6[v7] ~= nil then
            local v8 = v6[v7]
            if typeof(v8) == "number" then
                local v9 = v6[v7]
                v6[v7] = tostring(v9)
            end
        end
    end
    if v6.MetaData then
        local v10 = v6.MetaData
        if typeof(v10) == "table" then
            for _, v11 in ipairs({ "LastTradeAt", "CreatedAt" }) do
                if v6.MetaData[v11] ~= nil then
                    local v12 = v6.MetaData[v11]
                    if typeof(v12) == "string" then
                        local v13 = v6.MetaData[v11]
                        local v14 = tonumber(v13)
                        if v14 == nil then
                            v6.MetaData[v11] = nil
                        else
                            v6.MetaData[v11] = v14
                        end
                    end
                end
            end
            for _, v15 in ipairs({ "OriginalOwner", "Owner", "Origin" }) do
                if v6.MetaData[v15] ~= nil then
                    local v16 = v6.MetaData[v15]
                    if typeof(v16) == "number" then
                        local v17 = v6.MetaData
                        local v18 = v6.MetaData[v15]
                        v17[v15] = tostring(v18)
                    end
                end
            end
        end
    end
    return v6
end

>> Batch #17 complete. Yielding...
