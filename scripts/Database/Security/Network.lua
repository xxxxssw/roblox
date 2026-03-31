-- MODULESCRIPT: Network
-- Original Path: game.BAC - 29092.Database.Security.Network
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {}
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("ReplicatedStorage")
local v4 = game:GetService("RunService")
local v_u_5 = game:GetService("HttpService")
local v_u_6 = require(v_u_3.Shared.DebugFlags)
local v_u_7 = v4:IsServer()
local v_u_8 = {}
local function v_u_18(p9, p10, p_u_11, p12)
    -- upvalues: (copy) v_u_6, (copy) v_u_5, (copy) v_u_7
    if v_u_6.IsEnabled("NetworkPackets") then
        local v13, v14 = pcall(function()
            -- upvalues: (ref) v_u_5, (copy) p_u_11
            return v_u_5:JSONEncode(p_u_11)
        end)
        local v15 = not v13 and "unknown" or string.format("%.3f KB", #v14 / 1024)
        local v16 = v_u_7 and "[SERVER]" or "[CLIENT]"
        local v17 = not p12 and "" or (" | Player: %*"):format(p12.Name)
        print(string.format("%s %s %s | Size: %s%s | Data: %s", v16, p9, p10, v15, v17, not v13 and "{}" or v14))
    end
end
local function v_u_25(p19, p20)
    -- upvalues: (copy) v_u_2
    local v21 = {}
    for _, v22 in ipairs(v_u_2:GetPlayers()) do
        local v23 = v22.Character
        local v24
        if v23 then
            v24 = v23:FindFirstChild("HumanoidRootPart")
        else
            v24 = nil
        end
        if v24 and (v24:IsA("BasePart") and (v24.Position - p19).Magnitude <= p20) then
            table.insert(v21, v22)
        end
    end
    return v21
end
local function v_u_30(p26)
    -- upvalues: (copy) v_u_3, (copy) v_u_7
    local v27 = v_u_3:FindFirstChild("NetworkRemotes")
    if not (v27 and v27:IsA("Folder")) then
        if v_u_7 then
            v27 = Instance.new("Folder")
            v27.Name = "NetworkRemotes"
            v27.Parent = v_u_3
        else
            v27 = v_u_3:WaitForChild("NetworkRemotes")
        end
    end
    local v28 = v27:FindFirstChild(p26)
    if v28 and v28:IsA("Folder") then
        return v28
    end
    if not v_u_7 then
        return v27:WaitForChild(p26)
    end
    local v29 = Instance.new("Folder")
    v29.Name = p26
    v29.Parent = v27
    return v29
end
local function v_u_37(p31, p32)
    local v_u_33 = p32 == "Unreliable" and "UnreliableRemoteEvent" or "RemoteEvent"
    local v34, v35 = pcall(function()
        -- upvalues: (copy) v_u_33
        return Instance.new(v_u_33)
    end)
    local v36 = v34 and v35 and v35 or Instance.new("RemoteEvent")
    v36.Name = p31
    return v36
end
local function v_u_55(p38, p39, p40, p41, p42, p43)
    -- upvalues: (copy) v_u_7, (copy) v_u_30, (copy) v_u_18
    if v_u_7 then
        if p38 == "Store" and p39 == "OpenCase" then
            local v44 = v_u_30("Store")
            local v45 = v44:FindFirstChild("CaseOpenDenied")
            if not v45 then
                if v_u_7 then
                    local v_u_46 = "RemoteEvent"
                    local v47, v48 = pcall(function()
                        -- upvalues: (copy) v_u_46
                        return Instance.new(v_u_46)
                    end)
                    v45 = v47 and v48 and v48 or Instance.new("RemoteEvent")
                    v45.Name = "CaseOpenDenied"
                    v45.Parent = v44
                else
                    v45 = v44:WaitForChild("CaseOpenDenied")
                end
            end
            local v49
            if typeof(p41) == "table" then
                local v50 = p41.RequestId
                if typeof(v50) == "string" then
                    v49 = p41.RequestId
                else
                    v49 = nil
                end
            else
                v49 = nil
            end
            local v51 = {
                ["Reason"] = p42,
                ["RequestId"] = v49
            }
            local v52
            if p43 then
                local v53 = p43 * 1000
                local v54 = math.round(v53)
                v52 = math.max(0, v54) or nil
            else
                v52 = nil
            end
            v51.RetryAfterMs = v52
            v_u_18("OUTGOING", "Store.CaseOpenDenied", v51, p40)
            v45:FireClient(p40, v51)
        end
    end
end
local function v_u_67(p56, p57, p58)
    -- upvalues: (copy) v_u_8
    local v59 = p58.maximum_requests_per_second
    local v60 = v59 == nil and 10 or v59
    if v60 <= 0 then
        return true, nil
    end
    local v61 = os.clock()
    local v62 = v_u_8[p56]
    if not v62 then
        v62 = {}
        v_u_8[p56] = v62
    end
    local v63 = v62[p57]
    local v64 = math.max(1, v60)
    if not v63 then
        v63 = {
            ["tokens"] = v64,
            ["lastRefill"] = v61
        }
        v62[p57] = v63
    end
    local v65 = v61 - v63.lastRefill
    if v65 > 0 then
        local v66 = v63.tokens + v65 * v60
        v63.tokens = math.min(v64, v66)
        v63.lastRefill = v61
    end
    if v63.tokens < 1 then
        return false, (1 - v63.tokens) / v60
    end
    v63.tokens = v63.tokens - 1
    return true, nil
end
local function v_u_68(_)
    return true
end
local function v_u_117(p69)
    -- upvalues: (copy) v_u_68, (copy) v_u_117
    if p69 == nil then
        return v_u_68
    end
    if type(p69) ~= "table" then
        return v_u_68
    end
    local v70 = p69._kind
    if v70 == nil then
        return v_u_68
    end
    if v70 == "Unknown" then
        return v_u_68
    end
    if v70 == "Nothing" then
        return function(p71)
            return p71 == nil
        end
    end
    if v70 == "String" then
        return function(p72)
            return typeof(p72) == "string"
        end
    end
    if v70 == "Bool" then
        return function(p73)
            return typeof(p73) == "boolean"
        end
    end
    if v70 == "Instance" then
        return function(p74)
            return typeof(p74) == "Instance"
        end
    end
    if v70 == "CFrame" then
        return function(p75)
            return typeof(p75) == "CFrame"
        end
    end
    if v70 == "Vec3" then
        return function(p76)
            return typeof(p76) == "Vector3"
        end
    end
    if v70 == "Vec2" then
        return function(p77)
            return typeof(p77) == "Vector2"
        end
    end
    if v70 == "Float32" or v70 == "Float64" then
        return function(p78)
            local v79
            if typeof(p78) == "number" and (p78 == p78 and p78 ~= (1 / 0)) then
                v79 = p78 ~= (-1 / 0)
            else
                v79 = false
            end
            return v79
        end
    end
    if v70 == "Uint8" then
        return function(p80)
            local v81
            if typeof(p80) == "number" and (p80 == p80 and p80 ~= (1 / 0)) then
                v81 = p80 ~= (-1 / 0)
            else
                v81 = false
            end
            if v81 then
                v81 = p80 == math.floor(p80)
            end
            if v81 then
                if p80 >= 0 then
                    v81 = p80 <= 255
                else
                    v81 = false
                end
            end
            return v81
        end
    end
    if v70 == "Uint16" then
        return function(p82)
            local v83
            if typeof(p82) == "number" and (p82 == p82 and p82 ~= (1 / 0)) then
                v83 = p82 ~= (-1 / 0)
            else
                v83 = false
            end
            if v83 then
                v83 = p82 == math.floor(p82)
            end
            if v83 then
                if p82 >= 0 then
                    v83 = p82 <= 65535
                else
                    v83 = false
                end
            end
            return v83
        end
    end
    if v70 == "Uint32" then
        return function(p84)
            local v85
            if typeof(p84) == "number" and (p84 == p84 and p84 ~= (1 / 0)) then
                v85 = p84 ~= (-1 / 0)
            else
                v85 = false
            end
            if v85 then
                v85 = p84 == math.floor(p84)
            end
            if v85 then
                if p84 >= 0 then
                    v85 = p84 <= 4294967295
                else
                    v85 = false
                end
            end
            return v85
        end
    end
    if v70 == "Int8" then
        return function(p86)
            local v87
            if typeof(p86) == "number" and (p86 == p86 and p86 ~= (1 / 0)) then
                v87 = p86 ~= (-1 / 0)
            else
                v87 = false
            end
            if v87 then
                v87 = p86 == math.floor(p86)
            end
            if v87 then
                if p86 >= -128 then
                    v87 = p86 <= 127
                else
                    v87 = false
                end
            end
            return v87
        end
    end
    if v70 == "Int16" then
        return function(p88)
            local v89
            if typeof(p88) == "number" and (p88 == p88 and p88 ~= (1 / 0)) then
                v89 = p88 ~= (-1 / 0)
            else
                v89 = false
            end
            if v89 then
                v89 = p88 == math.floor(p88)
            end
            if v89 then
                if p88 >= -32768 then
                    v89 = p88 <= 32767
                else
                    v89 = false
                end
            end
            return v89
        end
    end
    if v70 == "Int32" then
        return function(p90)
            local v91
            if typeof(p90) == "number" and (p90 == p90 and p90 ~= (1 / 0)) then
                v91 = p90 ~= (-1 / 0)
            else
                v91 = false
            end
            if v91 then
                v91 = p90 == math.floor(p90)
            end
            if v91 then
                if p90 >= -2147483648 then
                    v91 = p90 <= 2147483647
                else
                    v91 = false
                end
            end
            return v91
        end
    end
    if v70 == "Optional" then
        local v_u_92 = v_u_117(p69.value)
        return function(p93)
            -- upvalues: (copy) v_u_92
            return p93 == nil and true or v_u_92(p93)
        end
    end
    if v70 == "Array" then
        local v_u_94 = v_u_117(p69.value)
        return function(p95)
            -- upvalues: (copy) v_u_94
            if typeof(p95) ~= "table" then
                return false
            end
            local v96 = #p95
            for v97, v98 in pairs(p95) do
                if typeof(v97) ~= "number" or (v97 < 1 or (v96 < v97 or v97 % 1 ~= 0)) then
                    return false
                end
                if not v_u_94(v98) then
                    return false
                end
            end
            for v99 = 1, v96 do
                if p95[v99] == nil then
                    return false
                end
            end
            return true
        end
    end
    if v70 == "Map" then
        local v_u_100 = v_u_117(p69.key)
        local v_u_101 = v_u_117(p69.value)
        return function(p102)
            -- upvalues: (copy) v_u_100, (copy) v_u_101
            if typeof(p102) ~= "table" then
                return false
            end
            for v103, v104 in pairs(p102) do
                if not (v_u_100(v103) and v_u_101(v104)) then
                    return false
                end
            end
            return true
        end
    end
    if v70 ~= "Struct" then
        return v_u_68
    end
    local v105 = p69.value
    if typeof(v105) ~= "table" then
        return function(p106)
            return typeof(p106) == "table"
        end
    end
    local v_u_107 = {}
    local v_u_108 = {}
    for v109, v110 in pairs(v105) do
        if typeof(v109) == "string" then
            v_u_107[v109] = v_u_117(v110)
            local v111
            if type(v110) == "table" then
                v111 = v110._kind == "Optional"
            else
                v111 = false
            end
            v_u_108[v109] = not v111
        end
    end
    return function(p112)
        -- upvalues: (copy) v_u_107, (copy) v_u_108
        if typeof(p112) ~= "table" then
            return false
        end
        for v113, v114 in pairs(v_u_107) do
            local v115 = p112[v113]
            if v115 == nil then
                if v_u_108[v113] then
                    return false
                end
            elseif not v114(v115) then
                return false
            end
        end
        for v116, _ in pairs(p112) do
            if typeof(v116) ~= "string" or v_u_107[v116] == nil then
                return false
            end
        end
        return true
    end
end
function v1.DefinePacket(p118)
    return p118
end
function v1.DefineNamespace(_, p119)
    return p119()
end
function v1.CreatePacket(p_u_120, p_u_121, p122, p123)
    -- upvalues: (copy) v_u_117, (copy) v_u_30, (copy) v_u_7, (copy) v_u_37, (copy) v_u_18, (copy) v_u_2, (copy) v_u_25, (copy) v_u_67, (copy) v_u_55
    local v_u_124 = p123 or {}
    local v_u_125
    if v_u_124.name and v_u_124.name ~= "" then
        v_u_125 = v_u_124.name
    else
        v_u_125 = ("%*.%*"):format(p_u_120, p_u_121)
    end
    local v126 = v_u_117
    local v127
    if p122 then
        v127 = p122.Value
    else
        v127 = p122
    end
    local v_u_128 = v126(v127)
    local v129 = p122.ReliabilityType
    local v130 = v_u_30(p_u_120)
    local v_u_131 = v130:FindFirstChild(p_u_121)
    if not v_u_131 then
        if v_u_7 then
            v_u_131 = v_u_37(p_u_121, v129)
            v_u_131.Parent = v130
        else
            v_u_131 = v130:WaitForChild(p_u_121)
        end
    end
    local v_u_158 = {
        ["Send"] = function(p132)
            -- upvalues: (ref) v_u_7, (ref) v_u_18, (copy) v_u_125, (ref) v_u_2, (copy) v_u_131
            if not v_u_7 then
                v_u_18("OUTGOING", v_u_125, p132, v_u_2.LocalPlayer)
                v_u_131:FireServer(p132)
            end
        end,
        ["SendTo"] = function(p133, p134)
            -- upvalues: (ref) v_u_7, (ref) v_u_18, (copy) v_u_125, (copy) v_u_131
            if v_u_7 then
                if p134 then
                    v_u_18("OUTGOING", v_u_125, p133, p134)
                    v_u_131:FireClient(p134, p133)
                end
            else
                return
            end
        end,
        ["SendToAll"] = function(p135)
            -- upvalues: (ref) v_u_7, (ref) v_u_18, (copy) v_u_125, (copy) v_u_131
            if v_u_7 then
                v_u_18("OUTGOING", v_u_125, p135, nil)
                v_u_131:FireAllClients(p135)
            end
        end,
        ["SendToAllExcept"] = function(p136, p137)
            -- upvalues: (ref) v_u_7, (ref) v_u_2, (copy) v_u_131, (ref) v_u_18, (copy) v_u_125
            if v_u_7 then
                for _, v138 in ipairs(v_u_2:GetPlayers()) do
                    if v138 ~= p137 then
                        v_u_131:FireClient(v138, p136)
                    end
                end
                v_u_18("OUTGOING", v_u_125, p136, nil)
            end
        end,
        ["SendToList"] = function(p139, p140)
            -- upvalues: (ref) v_u_7, (copy) v_u_131, (ref) v_u_18, (copy) v_u_125
            if v_u_7 then
                if p140 and #p140 ~= 0 then
                    for _, v141 in ipairs(p140) do
                        if v141 then
                            v_u_131:FireClient(v141, p139)
                        end
                    end
                    v_u_18("OUTGOING", v_u_125, p139, nil)
                end
            else
                return
            end
        end,
        ["SendToProximity"] = function(p142, p143)
            -- upvalues: (ref) v_u_7, (ref) v_u_25, (copy) v_u_131, (ref) v_u_18, (copy) v_u_125
            if v_u_7 then
                local v144 = v_u_25(p143.position, p143.range or 60)
                for _, v145 in ipairs(v144) do
                    v_u_131:FireClient(v145, p142)
                end
                if #v144 > 0 then
                    v_u_18("OUTGOING", v_u_125, p142, nil)
                end
            end
        end,
        ["Listen"] = function(p_u_146)
            -- upvalues: (ref) v_u_7, (copy) v_u_131, (ref) v_u_67, (copy) v_u_125, (copy) v_u_124, (ref) v_u_55, (copy) p_u_120, (copy) p_u_121, (copy) v_u_128, (ref) v_u_18
            if v_u_7 then
                local v_u_152 = v_u_131.OnServerEvent:Connect(function(p147, p148)
                    -- upvalues: (ref) v_u_67, (ref) v_u_125, (ref) v_u_124, (ref) v_u_55, (ref) p_u_120, (ref) p_u_121, (ref) v_u_128, (ref) v_u_18, (copy) p_u_146
                    local v149, v150 = v_u_67(p147, v_u_125, v_u_124)
                    if v149 then
                        if v_u_128(p148) then
                            local v151 = v_u_124.middleware
                            if (not v151 or v151(p148, p147)) and true or false then
                                v_u_18("INCOMING", v_u_125, p148, p147)
                                p_u_146(p148, p147)
                            end
                        else
                            return
                        end
                    else
                        v_u_55(p_u_120, p_u_121, p147, p148, "RateLimited", v150)
                        return
                    end
                end)
                return function()
                    -- upvalues: (copy) v_u_152
                    v_u_152:Disconnect()
                end
            else
                local v_u_154 = v_u_131.OnClientEvent:Connect(function(p153)
                    -- upvalues: (ref) v_u_128, (ref) v_u_18, (ref) v_u_125, (copy) p_u_146
                    if v_u_128(p153) then
                        v_u_18("INCOMING", v_u_125, p153, nil)
                        p_u_146(p153, nil)
                    end
                end)
                return function()
                    -- upvalues: (copy) v_u_154
                    v_u_154:Disconnect()
                end
            end
        end,
        ["Connect"] = function(p155)
            -- upvalues: (copy) v_u_158
            return v_u_158.Listen(p155)
        end,
        ["Wait"] = function()
            -- upvalues: (ref) v_u_7, (copy) v_u_131
            if not v_u_7 then
                return v_u_131.OnClientEvent:Wait(), nil
            end
            local v156, v157 = v_u_131.OnServerEvent:Wait()
            return v157, v156
        end
    }
    return v_u_158
end
v1.Nothing = table.freeze({
    ["_kind"] = "Nothing"
})
v1.Unknown = table.freeze({
    ["_kind"] = "Unknown"
})
v1.String = table.freeze({
    ["_kind"] = "String"
})
v1.Bool = table.freeze({
    ["_kind"] = "Bool"
})
v1.Instance = table.freeze({
    ["_kind"] = "Instance"
})
v1.CFrame = table.freeze({
    ["_kind"] = "CFrame"
})
v1.Vec3 = table.freeze({
    ["_kind"] = "Vec3"
})
v1.Vec2 = table.freeze({
    ["_kind"] = "Vec2"
})
v1.Float32 = table.freeze({
    ["_kind"] = "Float32"
})
v1.Float64 = table.freeze({
    ["_kind"] = "Float64"
})
v1.Uint8 = table.freeze({
    ["_kind"] = "Uint8"
})
v1.Uint16 = table.freeze({
    ["_kind"] = "Uint16"
})
v1.Uint32 = table.freeze({
    ["_kind"] = "Uint32"
})
v1.Int8 = table.freeze({
    ["_kind"] = "Int8"
})
v1.Int16 = table.freeze({
    ["_kind"] = "Int16"
})
v1.Int32 = table.freeze({
    ["_kind"] = "Int32"
})
function v1.Array(p159)
    return {
        ["_kind"] = "Array",
        ["value"] = p159
    }
end
function v1.Map(p160, p161)
    return {
        ["_kind"] = "Map",
        ["key"] = p160,
        ["value"] = p161
    }
end
function v1.Struct(p162)
    return {
        ["_kind"] = "Struct",
        ["value"] = p162
    }
end
function v1.Optional(p163)
    return {
        ["_kind"] = "Optional",
        ["value"] = p163
    }
end
if v_u_7 then
    v_u_2.PlayerRemoving:Connect(function(p164)
        -- upvalues: (copy) v_u_8
        v_u_8[p164] = nil
    end)
end
return v1
