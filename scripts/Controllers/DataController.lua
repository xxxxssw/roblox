-- MODULESCRIPT: DataController
-- Original Path: game.BAC - 52212.Controllers.DataController
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("Players")
require(v2.Database.Custom.Types)
local v_u_5 = require(v2.Database.Components.Libraries.Stock)
local v_u_6 = require(v2.Database.Security.Remotes)
local v_u_7 = require(v2.Shared.Promise)
local v_u_8 = {}
local v_u_9 = {}
local function v_u_15(p10)
    local v11 = {}
    local v12 = ""
    for v13, v14 in ipairs(p10) do
        if v13 <= 1 then
            v12 = v14
        elseif v13 > 1 then
            v12 = ("%*.%*"):format(v12, v14)
        end
        table.insert(v11, v12)
    end
    return v11
end
local function v_u_24(p16, p17)
    -- upvalues: (copy) v_u_15, (copy) v_u_9, (copy) v_u_1, (copy) v_u_7
    local v18 = v_u_15(p17)
    for _, v19 in ipairs(v18) do
        local v20 = v_u_9[p16]
        if v20 then
            local v21 = v20[v19]
            if v21 then
                local v22 = v_u_1.Get(p16, v19)
                for _, v23 in pairs(v21) do
                    v_u_7.try(v23, v22)
                end
            end
        end
    end
end
local function v_u_38(p_u_25)
    -- upvalues: (copy) v_u_3
    local v26, v_u_27 = pcall(function()
        -- upvalues: (ref) v_u_3, (copy) p_u_25
        return v_u_3:JSONEncode(p_u_25)
    end)
    if not (v26 and v_u_27) then
        return p_u_25
    end
    local v28, v29 = pcall(function()
        -- upvalues: (ref) v_u_3, (copy) v_u_27
        return v_u_3:JSONDecode(v_u_27)
    end)
    if not (v28 and v29) then
        return p_u_25
    end
    for _, v30 in ipairs({ "Serial", "Pattern" }) do
        if v29[v30] ~= nil then
            local v31 = v29[v30]
            if typeof(v31) == "string" then
                local v32 = v29[v30]
                v29[v30] = tonumber(v32) or v29[v30]
            end
        end
    end
    if v29.MetaData then
        local v33 = v29.MetaData
        if typeof(v33) == "table" then
            for _, v34 in ipairs({ "OriginalOwner", "Owner" }) do
                if v29.MetaData[v34] ~= nil then
                    local v35 = v29.MetaData[v34]
                    if typeof(v35) == "string" then
                        local v36 = v29.MetaData
                        local v37 = v29.MetaData[v34]
                        v36[v34] = tonumber(v37) or v29.MetaData[v34]
                    end
                end
            end
        end
    end
    return v29
end
local function v_u_45(p39)
    if typeof(p39) ~= "table" then
        return false
    end
    local v40 = p39.Serial
    if typeof(v40) ~= "string" then
        local v41 = p39.Pattern
        if typeof(v41) ~= "string" then
            local v42 = p39.MetaData
            if typeof(v42) == "table" then
                local v43 = v42.OriginalOwner
                if typeof(v43) == "string" then
                    return true
                end
                local v44 = v42.Owner
                if typeof(v44) == "string" then
                    return true
                end
            end
            return false
        end
    end
    return true
end
local function v_u_60(p46, p47, p48)
    -- upvalues: (copy) v_u_8, (copy) v_u_45, (copy) v_u_38, (copy) v_u_24
    local v49 = v_u_8[p46]
    if v49 and v49.Inventory then
        local v50 = false
        if p48 then
            local v51 = {}
            for _, v52 in ipairs(p48) do
                v51[v52] = true
            end
            for v53 = #v49.Inventory, 1, -1 do
                local v54 = v49.Inventory[v53]
                if v54 and (v54._id and v51[v54._id]) then
                    table.remove(v49.Inventory, v53)
                    v50 = true
                end
            end
        end
        local v55 = {}
        for _, v56 in ipairs(v49.Inventory) do
            if v56 and v56._id then
                v55[v56._id] = true
            end
        end
        for _, v58 in ipairs(p47) do
            if v_u_45(v58) then
                local v58 = v_u_38(v58)
            end
            if v58 and (v58._id and not v55[v58._id]) then
                local v59 = v49.Inventory
                table.insert(v59, v58)
                v55[v58._id] = true
                v50 = true
            end
        end
        if v50 then
            v_u_24(p46, { "Inventory" })
        end
    end
end
function v_u_1.WaitForDataLoaded(p61)
    -- upvalues: (copy) v_u_8
    local v62 = 0
    while not v_u_8[p61] do
        v62 = v62 + task.wait()
        if v62 >= 60 then
            error((("[DataController] Failed to load player profile for %* after 60 seconds"):format(p61.Name)))
        end
    end
    return v_u_8[p61]
end
function v_u_1.Get(p63, ...)
    -- upvalues: (copy) v_u_8
    local v64 = v_u_8[p63]
    if not v64 then
        return nil
    end
    local v65 = {}
    for _, v66 in table.pack(...) do
        local v67 = v64
        for _, v68 in string.split(v66, ".") do
            v64 = v64[v68]
            if not v64 then
                break
            end
        end
        table.insert(v65, v64)
        v64 = v67
    end
    return table.unpack(v65)
end
function v_u_1.ApplyInventoryDelta(p69, p70, p71)
    -- upvalues: (copy) v_u_60
    v_u_60(p69, p70, p71)
end
function v_u_1.RemoveListener(p72, p73, p74)
    -- upvalues: (copy) v_u_9
    if v_u_9[p72] and v_u_9[p72][p73] then
        v_u_9[p72][p73][p74] = nil
        if next(v_u_9[p72][p73]) == nil then
            v_u_9[p72][p73] = nil
        end
    end
end
function v_u_1.CreateListener(p75, p76, p77)
    -- upvalues: (copy) v_u_3, (copy) v_u_9, (copy) v_u_1, (copy) v_u_7
    local v78 = v_u_3:GenerateGUID(false)
    v_u_9[p75] = v_u_9[p75] or {}
    v_u_9[p75][p76] = v_u_9[p75][p76] or {}
    v_u_9[p75][p76][v78] = p77
    local v79 = v_u_1.Get(p75, p76)
    if v79 ~= nil then
        v_u_7.try(p77, v79)
    end
    return v78
end
function v_u_1.Initialize()
    -- upvalues: (copy) v_u_6, (copy) v_u_9, (copy) v_u_5, (copy) v_u_8, (copy) v_u_1, (copy) v_u_7, (copy) v_u_24
    v_u_6.PlayerData.PlayerDataEvent.Listen(function(p80)
        -- upvalues: (ref) v_u_9, (ref) v_u_5, (ref) v_u_8, (ref) v_u_1, (ref) v_u_7
        local v81 = v_u_9[p80.Player]
        if p80.Data and p80.Data.Inventory then
            v_u_5.InjectStockItems(p80.Data.Inventory)
        end
        v_u_8[p80.Player] = p80.Data
        if v81 then
            for v82, v83 in pairs(v81) do
                local v84 = v_u_1.Get(p80.Player, v82)
                for _, v85 in pairs(v83) do
                    v_u_7.try(v85, v84)
                end
            end
        end
    end)
    v_u_6.PlayerData.PlayerDataChanged.Listen(function(p86)
        -- upvalues: (ref) v_u_8, (ref) v_u_24
        local v87 = p86.Player
        local v88 = v_u_8[v87]
        if v88 then
            for v89, v90 in pairs(p86.Data) do
                local v91 = string.split(v89, ".")
                local v92 = v88
                for v93 = 1, #v91 - 1 do
                    local v94 = v91[v93]
                    local v95 = v88[v94]
                    if typeof(v95) ~= "table" then
                        v88[v94] = {}
                    end
                    v88 = v88[v94]
                end
                v88[v91[#v91]] = v90
                v_u_24(v87, v91)
                v88 = v92
            end
        else
            warn((("[DataController] Received data change for %* but profile not loaded yet. Requesting full profile."):format(v87.Name)))
        end
    end)
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_6, (copy) v_u_4, (copy) v_u_60, (copy) v_u_9, (copy) v_u_8
    v_u_6.PlayerData.RetrieveAllPlayerData.Send()
    v_u_6.Store.NewInventoryItem.Listen(function(p96)
        -- upvalues: (ref) v_u_4, (ref) v_u_60
        local v97 = p96.Player
        local v98 = tonumber(v97)
        if v98 then
            local v99 = v_u_4:GetPlayerByUserId(v98)
            if v99 and v99:IsDescendantOf(v_u_4) then
                v_u_60(v99, p96.Items, p96.DeletedItemIds)
            end
        else
            return
        end
    end)
    v_u_4.PlayerRemoving:Connect(function(p100)
        -- upvalues: (ref) v_u_9, (ref) v_u_8
        v_u_9[p100] = nil
        v_u_8[p100] = nil
    end)
end
return v_u_1
