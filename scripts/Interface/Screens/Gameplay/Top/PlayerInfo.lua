-- MODULESCRIPT: PlayerInfo
-- Original Path: game.BAC - 17285.Interface.Screens.Gameplay.Top.PlayerInfo
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("HttpService")
local v_u_6 = require(v_u_2.Packages.Observers)
local v_u_7 = require(v_u_2.Shared.Janitor)
local v8 = require(v_u_2.Database.Security.Remotes)
local v_u_9 = require(v_u_2.Database.Components.GameState)
local v_u_10 = require(v_u_2.Database.Custom.GameStats.Settings.Colors)
require(v_u_2.Database.Custom.Types)
local v_u_11 = TweenInfo.new(0.66, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local v_u_12 = {}
local v_u_13 = {}
local v_u_14 = {}
local v_u_15 = {}
local v_u_16 = {}
local v_u_17 = false
local v_u_18 = v_u_3.LocalPlayer
local function v_u_25(p19, p20)
    -- upvalues: (copy) v_u_2
    local v21 = v_u_2.Database.Custom:FindFirstChild(p19) or v_u_2.Database.Custom.GameStats:FindFirstChild(p19)
    if not (v21 and v21:IsA("Folder")) then
        return nil
    end
    local v22 = v21:FindFirstChild(p20)
    if not (v22 and v22:IsA("ModuleScript")) then
        return nil
    end
    local v23, v24 = pcall(require, v22)
    return v23 and v24 and v24 or nil
end
local function v_u_32(p_u_26)
    -- upvalues: (copy) v_u_5
    if typeof(p_u_26) ~= "string" or p_u_26 == "" then
        return nil
    end
    local v27, v28 = pcall(function()
        -- upvalues: (ref) v_u_5, (copy) p_u_26
        return v_u_5:JSONDecode(p_u_26)
    end)
    if not v27 or typeof(v28) ~= "table" then
        return nil
    end
    local v29 = {}
    local v30 = v28.Type
    v29.Type = tostring(v30) or ""
    local v31 = v28.Health
    v29.Health = tonumber(v31) or 0
    return v29
end
local function v_u_37(p_u_33)
    -- upvalues: (copy) v_u_5
    if typeof(p_u_33) == "string" and p_u_33 ~= "" then
        local v34, v35 = pcall(function()
            -- upvalues: (ref) v_u_5, (copy) p_u_33
            return v_u_5:JSONDecode(p_u_33)
        end)
        if v34 and typeof(v35) == "table" then
            local v36 = v35.Weapon
            if typeof(v36) == "string" and v36 ~= "" then
                return v36
            else
                return nil
            end
        else
            return nil
        end
    else
        return nil
    end
end
local function v_u_48(p38, p39)
    local v40 = p38:FindFirstChild("Health")
    local v41
    if v40 then
        v41 = v40:FindFirstChild("Bar")
    else
        v41 = v40
    end
    local v42 = p38:FindFirstChild("Player")
    local v43 = p38:FindFirstChild("Player")
    if v43 then
        v43 = v43:FindFirstChild("X")
    end
    local v44 = p38:FindFirstChild("Info")
    local v45
    if v44 then
        v45 = v44:FindFirstChild("Weapon")
    else
        v45 = v44
    end
    local v46
    if v44 then
        v46 = v44:FindFirstChild("Grenades")
    else
        v46 = v44
    end
    local v47
    if v44 then
        v47 = v44:FindFirstChild("Items")
    else
        v47 = v44
    end
    if not p39 then
        if v42 then
            v42.ImageTransparency = 0
        end
        if v43 then
            v43.Visible = false
        end
        if v44 then
            v44.BackgroundTransparency = 0
        end
        p38.Transparency = 0
        return v40, v41
    end
    if v41 then
        v41.Size = UDim2.fromScale(0, 1)
    end
    if v40 then
        v40.Visible = false
    end
    if v42 then
        v42.ImageTransparency = 0.5
    end
    if v43 then
        v43.Visible = true
    end
    if v44 then
        v44.BackgroundTransparency = 0.75
        if v45 then
            v45.Visible = false
        end
        if v46 then
            v46.Visible = false
        end
        if v47 then
            v47.Visible = false
        end
    end
    p38.Transparency = 0.5
    return v40, v41
end
local function v_u_58(p49, p50)
    -- upvalues: (copy) v_u_14, (copy) v_u_25
    local v51 = p49:FindFirstChild("Info")
    if v51 then
        local v52 = v51:FindFirstChild("Grenades")
        if v52 then
            local v53 = v_u_14[p50] or {}
            for v54 = 1, 4 do
                local v55 = v52:FindFirstChild((tostring(v54)))
                if v55 then
                    local v56 = v53[v54]
                    if v56 then
                        local v57 = v_u_25("Weapons", v56)
                        v55.Image = v57 and v57.Icon or ""
                        v55.Visible = true
                    else
                        v55.Image = ""
                        v55.Visible = false
                    end
                end
            end
            v52.Visible = true
        end
    else
        return
    end
end
local function v_u_72(p59, p60, p61)
    if p59 and p59.Parent then
        local v62 = p59:FindFirstChild("Info")
        if v62 then
            local v63 = v62:FindFirstChild("Damages")
            if v63 then
                local v64, v65
                if p60 and #p60 ~= 0 then
                    v64 = #p60
                    v65 = 0
                    for _, v66 in p60 do
                        v65 = v65 + v66
                    end
                else
                    v65 = nil
                    v64 = nil
                end
                local v67, v68
                if p61 and #p61 ~= 0 then
                    v67 = #p61
                    v68 = 0
                    for _, v69 in p61 do
                        v68 = v68 + v69
                    end
                else
                    v68 = nil
                    v67 = nil
                end
                v63.Visible = v65 ~= nil and true or v68 ~= nil
                local v70 = v63:FindFirstChild("Outgoing")
                if v70 then
                    if v65 then
                        v70.Text = ("%* in %*"):format(math.min(v65, 100), v64)
                        v70.Visible = true
                    else
                        v70.Text = ""
                        v70.Visible = false
                    end
                end
                local v71 = v63:FindFirstChild("Incoming")
                if v71 then
                    if v68 then
                        v71.Text = ("%* in %*"):format(math.min(v68, 100), v67)
                        v71.Visible = true
                        return
                    end
                    v71.Text = ""
                    v71.Visible = false
                end
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_78(p73, p74)
    local v75 = p73:FindFirstChild("Kills")
    if v75 then
        for v76 = 1, 5 do
            local v77 = v75:FindFirstChild((tostring(v76)))
            if v77 then
                v77.Visible = v76 <= p74
            end
        end
    end
end
local function v_u_87(p79)
    local v80 = p79:FindFirstChild("DefuseKit")
    if v80 then
        v80.Visible = false
    end
    local v81 = p79:FindFirstChild("Bomb")
    if v81 then
        v81.Visible = false
    end
    local v82 = p79:FindFirstChild("Info")
    if v82 then
        local v83 = v82:FindFirstChild("Weapon")
        if v83 then
            v83.Visible = false
        end
        local v84 = v82:FindFirstChild("Cash")
        if v84 then
            v84.Visible = false
        end
        local v85 = v82:FindFirstChild("Items")
        if v85 then
            v85.Visible = false
        end
        local v86 = v82:FindFirstChild("Grenades")
        if v86 then
            v86.Visible = false
        end
    end
end
local v_u_88 = nil
v_u_88 = function(p_u_89, p90, p91)
    -- upvalues: (copy) v_u_13, (copy) v_u_7, (copy) v_u_18, (copy) v_u_37, (copy) v_u_25, (copy) v_u_6, (copy) v_u_32, (copy) v_u_5, (copy) v_u_58, (copy) v_u_87, (copy) v_u_4, (copy) v_u_11
    if p90 and p90.Parent then
        local v_u_92 = p90:FindFirstChild("Info")
        if v_u_92 then
            local v93 = v_u_13[v_u_92]
            if v93 then
                v93:Cleanup()
            else
                v93 = v_u_7.new()
                v93:LinkToInstance(p90)
                v_u_13[v_u_92] = v93
            end
            local v94 = v_u_92:GetAttribute("OriginalSize")
            if not v94 then
                v94 = v_u_92.Size
                v_u_92:SetAttribute("OriginalSize", v94)
                if not p91 then
                    v_u_92.Size = UDim2.fromScale(1, 0)
                end
            end
            if p91 then
                local v95 = v_u_18:GetAttribute("Team")
                local v96 = p_u_89:GetAttribute("Team")
                local v97
                if v95 and v96 then
                    v97 = v95 == v96
                else
                    v97 = false
                end
                if v97 then
                    local v98 = p_u_89.Character
                    if v98 then
                        v98 = v98:GetAttribute("Dead") == true
                    end
                    local v99 = p_u_89:GetAttribute("IsSpectating") == true
                    local v100
                    if v98 == true then
                        v100 = false
                    else
                        v100 = v99 ~= true
                    end
                    local v_u_101 = v_u_92:FindFirstChild("Weapon")
                    if v_u_101 then
                        local function v104()
                            -- upvalues: (ref) v_u_37, (copy) p_u_89, (ref) v_u_25, (copy) v_u_101
                            local v102 = v_u_37(p_u_89:GetAttribute("Slot1")) or (v_u_37(p_u_89:GetAttribute("Slot2")) or v_u_37(p_u_89:GetAttribute("Slot3")))
                            if v102 then
                                local v103 = v_u_25("Weapons", v102)
                                v_u_101.Image = v103 and v103.Icon or ""
                            else
                                v_u_101.Image = ""
                            end
                        end
                        v93:Add(p_u_89:GetAttributeChangedSignal("Slot1"):Connect(v104))
                        v93:Add(p_u_89:GetAttributeChangedSignal("Slot2"):Connect(v104))
                        v93:Add(p_u_89:GetAttributeChangedSignal("Slot3"):Connect(v104))
                        v104()
                        v_u_101.Visible = v100
                    end
                    local v_u_105 = v_u_92:FindFirstChild("Cash")
                    if v_u_105 then
                        v93:Add(v_u_6.observeAttribute(p_u_89, "Money", function(p106)
                            -- upvalues: (copy) v_u_105
                            v_u_105.Text = p106 and ("$%*"):format((tostring(p106):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))) or ""
                            return nil
                        end))
                        v_u_105.Visible = true
                    end
                    local v107 = v_u_92:FindFirstChild("Items")
                    if v107 then
                        local v_u_108 = v107:FindFirstChild("Armor")
                        if v_u_108 then
                            local function v111()
                                -- upvalues: (ref) v_u_32, (copy) p_u_89, (copy) v_u_108
                                local v109 = v_u_32(p_u_89:GetAttribute("Armor"))
                                local v110
                                if v109 == nil then
                                    v110 = false
                                else
                                    v110 = v109.Health > 0
                                end
                                v_u_108.Visible = v110
                            end
                            v93:Add(p_u_89:GetAttributeChangedSignal("Armor"):Connect(v111))
                            local v112 = v_u_32(p_u_89:GetAttribute("Armor"))
                            local v113
                            if v112 == nil then
                                v113 = false
                            else
                                v113 = v112.Health > 0
                            end
                            v_u_108.Visible = v113
                        end
                        local v_u_114 = v107:FindFirstChild("Bomb")
                        if v_u_114 then
                            v93:Add(p_u_89:GetAttributeChangedSignal("Slot5"):Connect(function()
                                -- upvalues: (copy) v_u_114, (copy) p_u_89, (ref) v_u_5
                                local v115 = v_u_114
                                local v116 = p_u_89:GetAttribute("Slot5")
                                local v117 = v116 and v_u_5:JSONDecode(v116 or "[]")
                                if v117 then
                                    v117 = v117.Weapon == "C4"
                                end
                                v115.Visible = v117
                            end))
                            local v118 = p_u_89:GetAttribute("Slot5")
                            local v119 = v118 and v_u_5:JSONDecode(v118 or "[]")
                            if v119 then
                                v119 = v119.Weapon == "C4"
                            end
                            v_u_114.Visible = v119
                        end
                        v107.Visible = true
                    end
                    v_u_58(p90, p_u_89.UserId)
                else
                    v_u_87(p90)
                end
                v_u_92.Visible = true
                v_u_4:Create(v_u_92, v_u_11, {
                    ["Size"] = v94
                }):Play()
            else
                local v120 = v_u_4:Create(v_u_92, v_u_11, {
                    ["Size"] = UDim2.fromScale(1, 0)
                })
                v120:Play()
                v93:Add(v120.Completed:Once(function(p121)
                    -- upvalues: (copy) v_u_92
                    if p121 == Enum.PlaybackState.Completed then
                        v_u_92.Visible = false
                    end
                end))
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_181(p_u_122, p_u_123, p_u_124, _)
    -- upvalues: (copy) v_u_48, (ref) v_u_17, (copy) v_u_12, (ref) v_u_88, (copy) v_u_18, (copy) v_u_15, (copy) v_u_16, (copy) v_u_4, (copy) v_u_6, (copy) v_u_5
    local v_u_125 = p_u_124:GetAttribute("Team")
    local v_u_126 = workspace:GetAttribute("Gamemode")
    local function v167(p127)
        -- upvalues: (copy) p_u_123, (copy) p_u_124, (ref) v_u_48, (ref) v_u_17, (ref) v_u_12, (ref) v_u_88, (ref) v_u_18, (ref) v_u_15, (ref) v_u_16, (copy) p_u_122, (copy) v_u_125, (ref) v_u_4, (ref) v_u_6
        local v_u_128 = p127:WaitForChild("Humanoid", 3)
        if p_u_123 and p_u_123.Parent then
            local function v_u_156()
                -- upvalues: (ref) p_u_123, (ref) p_u_124, (ref) v_u_48, (ref) v_u_17, (ref) v_u_12, (ref) v_u_88, (ref) v_u_18, (ref) v_u_15, (ref) v_u_16
                if p_u_123 and p_u_123.Parent then
                    local v129 = p_u_124.Character
                    local v130
                    if v129 then
                        v130 = v129:GetAttribute("Dead") == true
                    else
                        v130 = v129
                    end
                    local v131 = p_u_124:GetAttribute("IsSpectating") == true
                    local v132 = v130 == true and true or v131 == true
                    local v_u_133, v_u_134 = v_u_48(p_u_123, v132)
                    if not v132 and v_u_17 then
                        local v135 = p_u_124
                        local v136 = v_u_12[v135.UserId]
                        if v136 and v136.Parent then
                            local v137 = v_u_88
                            local v138
                            if workspace:GetAttribute("GameState") == "Warmup" or not v_u_17 then
                                v138 = false
                            else
                                local v139 = v_u_18:GetAttribute("Team")
                                local v140 = v135:GetAttribute("Team")
                                local v141
                                if v139 and v140 then
                                    v141 = v139 == v140
                                else
                                    v141 = false
                                end
                                if v141 then
                                    v138 = true
                                else
                                    local v142 = v_u_15[v135.UserId] or 0
                                    local v143 = v_u_16[v135.UserId] == true
                                    v138 = v142 > 0 and true or v143
                                end
                            end
                            v137(v135, v136, v138)
                        end
                    end
                    if not v132 then
                        local v144 = p_u_124
                        local v145 = v_u_18:GetAttribute("Team")
                        local v146 = v144:GetAttribute("Team")
                        local v147
                        if v145 and v146 then
                            v147 = v145 == v146
                        else
                            v147 = false
                        end
                        if v147 and v129 then
                            local v_u_148 = v129:FindFirstChildOfClass("Humanoid")
                            if v_u_148 and (v_u_133 and v_u_134) then
                                local function v152()
                                    -- upvalues: (copy) v_u_148, (ref) p_u_123, (copy) v_u_134, (copy) v_u_133
                                    if v_u_148 and (v_u_148.Parent and (p_u_123 and (p_u_123.Parent and v_u_134))) then
                                        local v149 = v_u_148.Health
                                        local v150 = math.floor(v149) / v_u_148.MaxHealth
                                        local v151 = math.clamp(v150, 0, 1)
                                        v_u_134.Size = UDim2.fromScale(v151, 1)
                                        v_u_133.Visible = true
                                    end
                                end
                                if v_u_148 and (v_u_148.Parent and (p_u_123 and (p_u_123.Parent and v_u_134))) then
                                    local v153 = v_u_148.Health
                                    local v154 = math.floor(v153) / v_u_148.MaxHealth
                                    local v155 = math.clamp(v154, 0, 1)
                                    v_u_134.Size = UDim2.fromScale(v155, 1)
                                    v_u_133.Visible = true
                                end
                                task.delay(0.5, v152)
                            end
                        end
                    end
                end
            end
            v_u_156()
            local v157 = p_u_123:FindFirstChild("Health")
            local v_u_158
            if v157 then
                v_u_158 = v157:FindFirstChild("Bar")
            else
                v_u_158 = v157
            end
            if v_u_128 then
                p_u_122:Add(v_u_128:GetPropertyChangedSignal("Health"):Connect(function()
                    -- upvalues: (ref) p_u_124, (copy) v_u_128, (ref) v_u_18, (ref) v_u_125, (copy) v_u_158, (ref) v_u_4
                    local v159 = p_u_124.Character
                    if v159 then
                        v159 = v159:GetAttribute("Dead") == true
                    end
                    if not v159 and (p_u_124:GetAttribute("IsSpectating") ~= true and (v_u_128 and (v_u_128.Parent and (v_u_18:GetAttribute("Team") == v_u_125 and v_u_158)))) then
                        local v160 = v_u_4
                        local v161 = v_u_158
                        local v162 = TweenInfo.new(0.25)
                        local v163 = {}
                        local v164 = UDim2.fromScale
                        local v165 = v_u_128.Health
                        local v166 = math.floor(v165) / v_u_128.MaxHealth
                        v163.Size = v164(math.clamp(v166, 0, 1), 1)
                        v160:Create(v161, v162, v163):Play()
                    end
                end))
            end
            if v157 then
                p_u_122:Add(p127:GetAttributeChangedSignal("Dead"):Connect(v_u_156))
            end
            p_u_122:Add(v_u_6.observeAttribute(p_u_124, "IsSpectating", function(_)
                -- upvalues: (copy) v_u_156
                v_u_156()
                return nil
            end))
        end
    end
    if v_u_125 == "Terrorists" then
        p_u_122:Add(v_u_6.observeAttribute(p_u_124, "Slot5", function(p168)
            -- upvalues: (copy) p_u_124, (ref) v_u_18, (ref) v_u_5, (copy) p_u_123
            local v169 = p_u_124:GetAttribute("Team")
            local v170 = v_u_18:GetAttribute("Team")
            local v171 = v_u_5:JSONDecode(p168 or "[]")
            local v172 = p_u_123:FindFirstChild("Bomb")
            if v172 then
                if v169 == v170 then
                    if v171 then
                        v171 = v171.Weapon == "C4"
                    end
                else
                    v171 = false
                end
                v172.Visible = v171
            end
            return function()
                -- upvalues: (ref) p_u_123
                local v173 = p_u_123:FindFirstChild("Bomb")
                if v173 then
                    v173.Visible = false
                end
            end
        end))
    elseif v_u_125 == "Counter-Terrorists" then
        local function v_u_178()
            -- upvalues: (ref) v_u_18, (copy) p_u_124, (copy) v_u_126, (copy) p_u_123
            local v174 = v_u_18:GetAttribute("Team")
            local v175 = p_u_124:GetAttribute("Team")
            local v176
            if v_u_126 == "Hostage Rescue" then
                v176 = p_u_124:GetAttribute("HasRescueKit") == true
            else
                v176 = p_u_124:GetAttribute("HasDefuseKit") == true
            end
            local v177 = p_u_123:FindFirstChild("DefuseKit")
            if v177 then
                if v176 then
                    v176 = v175 == v174
                end
                v177.Visible = v176
            end
        end
        local function v_u_180()
            -- upvalues: (copy) p_u_123
            local v179 = p_u_123:FindFirstChild("DefuseKit")
            if v179 then
                v179.Visible = false
            end
        end
        p_u_122:Add(v_u_6.observeAttribute(p_u_124, "HasDefuseKit", function(_)
            -- upvalues: (copy) v_u_178, (copy) v_u_180
            v_u_178()
            return v_u_180
        end))
        p_u_122:Add(v_u_6.observeAttribute(p_u_124, "HasRescueKit", function(_)
            -- upvalues: (copy) v_u_178, (copy) v_u_180
            v_u_178()
            return v_u_180
        end))
        v_u_178()
    end
    if p_u_124.Character then
        v167(p_u_124.Character)
    else
        v_u_48(p_u_123, true)
    end
    p_u_122:Add(p_u_124.CharacterAdded:Connect(v167))
end
local function v_u_193(p182, p_u_183, p184, _)
    -- upvalues: (copy) v_u_10, (copy) v_u_6
    local v185 = p184:GetAttribute("Team")
    local v186 = p_u_183:FindFirstChild("Info")
    if v186 then
        local v187 = v186:FindFirstChild("UIStroke")
        if v187 then
            v187.Color = v_u_10["Team Color"][v185]
        end
        local v188 = v186:FindFirstChild("Amount")
        if v188 then
            v188.Text = "0"
        end
    end
    local v189 = p_u_183:FindFirstChild("UIStroke")
    if v189 then
        v189.Color = v_u_10["Team Color"][v185]
    end
    p182:Add(v_u_6.observeAttribute(p184, "Score", function(p190)
        -- upvalues: (copy) p_u_183
        local v191 = p_u_183:FindFirstChild("Info")
        local v192 = v191 and v191:FindFirstChild("Amount")
        if v192 then
            v192.Text = tostring(p190)
        end
        p_u_183.LayoutOrder = -p190
        return nil
    end))
end
local function v_u_204()
    -- upvalues: (copy) v_u_12, (copy) v_u_3, (copy) v_u_18
    for v194, v195 in v_u_12 do
        local v196 = v_u_3:GetPlayerByUserId(v194)
        if v196 and (v195 and v195.Parent) then
            local v197 = v195:FindFirstChild("UIStroke")
            if v197 then
                local v198 = v197:GetAttribute("DefaultStrokeColor")
                if not v198 then
                    v198 = v197.Color
                    v197:SetAttribute("DefaultStrokeColor", v198)
                end
                local v199 = v_u_18:GetAttribute("Team")
                local v200 = v196:GetAttribute("Team")
                local v201
                if v199 and v200 then
                    v201 = v199 == v200
                else
                    v201 = false
                end
                if v201 then
                    local v202 = v196.Character
                    local v203
                    if v202 and v202:IsDescendantOf(workspace) then
                        v203 = v202:GetAttribute("CompetitivePlayerColor")
                    else
                        v203 = nil
                    end
                    if v203 and v197 then
                        v197.Color = v203
                    elseif v198 and v197 then
                        v197.Color = v198
                    end
                elseif v198 then
                    v197.Color = v198
                end
            end
        end
    end
end
function v1.createTemplate(p205, p206)
    -- upvalues: (copy) v_u_12, (copy) v_u_13, (copy) v_u_7, (copy) v_u_2, (copy) v_u_193, (copy) v_u_18, (copy) v_u_181, (copy) v_u_204, (ref) v_u_88, (ref) v_u_17, (copy) v_u_15, (copy) v_u_16
    local v207 = p205.UserId
    local v208 = v_u_12[v207]
    if v208 then
        local v209 = v208:FindFirstChild("Info")
        local v210 = v209 and v_u_13[v209]
        if v210 then
            v210:Destroy()
            v_u_13[v209] = nil
        end
        if v208.Parent then
            v208:Destroy()
        end
        v_u_12[v207] = nil
    end
    local v211 = workspace:GetAttribute("Gamemode")
    local v212 = p205:GetAttribute("Team")
    if v212 ~= "Terrorists" and v212 ~= "Counter-Terrorists" then
        return nil
    end
    local v213 = v_u_7.new()
    local v_u_214
    if v211 == "Deathmatch" then
        v_u_214 = v_u_2.Assets.UI.Deathmatch.PlayerTemplate:Clone()
    else
        if v211 ~= "Bomb Defusal" and v211 ~= "Hostage Rescue" then
            v213:Destroy()
            return nil
        end
        local v215 = v_u_2.Assets.UI.BombDefusal:FindFirstChild(v212)
        if not v215 then
            warn((("[PlayerInfo]: Missing player template for team %*"):format(v212)))
            v213:Destroy()
            return nil
        end
        v_u_214 = v215:Clone()
    end
    if not v_u_214 then
        v213:Destroy()
        return nil
    end
    local v216 = v_u_214:FindFirstChild("Bomb")
    if v216 then
        v216.Visible = false
    end
    local v217 = v_u_214:FindFirstChild("Info")
    if v217 then
        if not v217:GetAttribute("OriginalSize") then
            v217:SetAttribute("OriginalSize", v217.Size)
        end
        v217.Size = UDim2.fromScale(1, 0)
        v217.Visible = false
    end
    local v218 = v_u_214:FindFirstChild("Player")
    if v218 then
        v218.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(p205.UserId)
    end
    v_u_214.Parent = p206
    v_u_12[p205.UserId] = v_u_214
    local v219 = v_u_214:FindFirstChild("UIStroke")
    if v219 then
        v219:SetAttribute("DefaultStrokeColor", v219.Color)
    end
    if v211 == "Deathmatch" then
        v_u_193(v213, v_u_214, p205, p206)
    else
        local v220 = v_u_214:FindFirstChild("Health")
        if v220 then
            v220.Visible = v_u_18:GetAttribute("Team") == v212
        end
        v_u_181(v213, v_u_214, p205, p206)
        v_u_204()
        local v221 = v_u_12[p205.UserId]
        if v221 and v221.Parent then
            local v222 = v_u_88
            local v223
            if workspace:GetAttribute("GameState") == "Warmup" or not v_u_17 then
                v223 = false
            else
                local v224 = v_u_18:GetAttribute("Team")
                local v225 = p205:GetAttribute("Team")
                local v226
                if v224 and v225 then
                    v226 = v224 == v225
                else
                    v226 = false
                end
                if v226 then
                    v223 = true
                else
                    local v227 = v_u_15[p205.UserId] or 0
                    local v228 = v_u_16[p205.UserId] == true
                    v223 = v227 > 0 and true or v228
                end
            end
            v222(p205, v221, v223)
        end
    end
    v213:Add(function()
        -- upvalues: (ref) v_u_214
        v_u_214:Destroy()
    end)
    return v213
end
function v1.cleanupTemplate(p229)
    -- upvalues: (copy) v_u_12, (copy) v_u_13, (copy) v_u_15, (copy) v_u_16, (copy) v_u_204
    local v230 = p229.UserId
    local v231 = v_u_12[v230]
    if v231 then
        local v232 = v231:FindFirstChild("Info")
        local v233 = v232 and v_u_13[v232]
        if v233 then
            v233:Destroy()
            v_u_13[v232] = nil
        end
        if v231.Parent then
            v231:Destroy()
        end
        v_u_12[v230] = nil
    end
    v_u_12[v230] = nil
    v_u_15[v230] = nil
    v_u_16[v230] = nil
    v_u_204()
end
function v1.refreshCompetitiveColors()
    -- upvalues: (copy) v_u_204
    v_u_204()
end
function v1.applyTemplateLifeState(p234, p235)
    -- upvalues: (copy) v_u_48
    return v_u_48(p234, p235)
end
function v1.setTeammateInfoRevealed(p236)
    -- upvalues: (ref) v_u_17, (copy) v_u_12, (copy) v_u_3, (ref) v_u_88, (copy) v_u_18, (copy) v_u_15, (copy) v_u_16
    if workspace:GetAttribute("ServerGamemode") ~= "Competitive" then
        p236 = false
    end
    v_u_17 = p236
    for v237, v238 in v_u_12 do
        local v239 = v_u_3:GetPlayerByUserId(v237)
        if v239 and (v238 and v238.Parent) then
            local v240 = v_u_12[v239.UserId]
            if v240 then
                if v240.Parent then
                    local v241 = v_u_88
                    local v242
                    if workspace:GetAttribute("GameState") == "Warmup" or not v_u_17 then
                        v242 = false
                    else
                        local v243 = v_u_18:GetAttribute("Team")
                        local v244 = v239:GetAttribute("Team")
                        local v245
                        if v243 and v244 then
                            v245 = v243 == v244
                        else
                            v245 = false
                        end
                        if v245 then
                            v242 = true
                        else
                            local v246 = v_u_15[v239.UserId] or 0
                            local v247 = v_u_16[v239.UserId] == true
                            v242 = v246 > 0 and true or v247
                        end
                    end
                    v241(v239, v240, v242)
                end
            end
        end
    end
end
function v1.updateTeammateGrenades(p248)
    -- upvalues: (copy) v_u_14, (copy) v_u_3, (copy) v_u_12, (copy) v_u_18, (copy) v_u_58
    for _, v249 in p248 do
        local v250 = v249.userId
        local v251 = tonumber(v250)
        if v251 then
            v_u_14[v251] = v249.grenades or {}
            local v252 = v_u_3:GetPlayerByUserId(v251)
            local v253 = v_u_12[v251]
            if v252 and (v253 and v253.Parent) then
                local v254 = v_u_18:GetAttribute("Team")
                local v255 = v252:GetAttribute("Team")
                local v256
                if v254 and v255 then
                    v256 = v254 == v255
                else
                    v256 = false
                end
                if v256 then
                    v_u_58(v253, v251)
                end
            end
        end
    end
end
function v1.incrementTemplateKills(p257)
    -- upvalues: (copy) v_u_9, (copy) v_u_15, (copy) v_u_12, (copy) v_u_78, (copy) v_u_3, (ref) v_u_88, (ref) v_u_17, (copy) v_u_18, (copy) v_u_16
    if v_u_9.GetState() ~= "Warmup" then
        v_u_15[p257] = (v_u_15[p257] or 0) + 1
        local v258 = v_u_12[p257]
        if v258 and v258.Parent then
            v_u_78(v258, v_u_15[p257])
        end
        local v259 = v_u_3:GetPlayerByUserId(p257)
        local v260 = v259 and v_u_12[v259.UserId]
        if v260 then
            if not v260.Parent then
                return
            end
            local v261 = v_u_88
            local v262
            if workspace:GetAttribute("GameState") == "Warmup" or not v_u_17 then
                v262 = false
            else
                local v263 = v_u_18:GetAttribute("Team")
                local v264 = v259:GetAttribute("Team")
                local v265
                if v263 and v264 then
                    v265 = v263 == v264
                else
                    v265 = false
                end
                if v265 then
                    v262 = true
                else
                    local v266 = v_u_15[v259.UserId] or 0
                    local v267 = v_u_16[v259.UserId] == true
                    v262 = v266 > 0 and true or v267
                end
            end
            v261(v259, v260, v262)
        end
    end
end
function v1.updateRoundDamageMatrix(p268)
    -- upvalues: (copy) v_u_3, (copy) v_u_16, (copy) v_u_12, (copy) v_u_72, (ref) v_u_88, (ref) v_u_17, (copy) v_u_18, (copy) v_u_15
    local v269 = p268.outgoing or {}
    local v270 = p268.incoming or {}
    for _, v271 in v_u_3:GetPlayers() do
        local v272 = v271.UserId
        local v273 = tostring(v272)
        local v274 = v269[v273] or nil
        local v275 = v270[v273] or nil
        local v276
        if v274 == nil then
            v276 = false
        else
            v276 = #v274 > 0
        end
        local v277
        if v275 == nil then
            v277 = false
        else
            v277 = #v275 > 0
        end
        v_u_16[v271.UserId] = v276 or v277
        v_u_72(v_u_12[v271.UserId], v274, v275)
        local v278 = v_u_12[v271.UserId]
        if v278 then
            if v278.Parent then
                local v279 = v_u_88
                local v280
                if workspace:GetAttribute("GameState") == "Warmup" or not v_u_17 then
                    v280 = false
                else
                    local v281 = v_u_18:GetAttribute("Team")
                    local v282 = v271:GetAttribute("Team")
                    local v283
                    if v281 and v282 then
                        v283 = v281 == v282
                    else
                        v283 = false
                    end
                    if v283 then
                        v280 = true
                    else
                        local v284 = v_u_15[v271.UserId] or 0
                        local v285 = v_u_16[v271.UserId] == true
                        v280 = v284 > 0 and true or v285
                    end
                end
                v279(v271, v278, v280)
            end
        end
    end
end
function v1.getTemplateByUserId(p286)
    -- upvalues: (copy) v_u_12
    return v_u_12[p286]
end
v8.UI.TeammateGrenades.Listen(v1.updateTeammateGrenades)
v8.UI.RoundDamageMatrix.Listen(v1.updateRoundDamageMatrix)
v_u_9.ListenToState(function(p287, p288)
    -- upvalues: (copy) v_u_12, (copy) v_u_15, (copy) v_u_16, (copy) v_u_78, (copy) v_u_3, (ref) v_u_88, (ref) v_u_17, (copy) v_u_18
    if p287 == "Buy Period" and p288 ~= "Buy Period" then
        for v289, v290 in v_u_12 do
            v_u_15[v289] = nil
            v_u_16[v289] = nil
            if v290 and v290.Parent then
                v_u_78(v290, 0)
            end
        end
    end
    for v291, v292 in v_u_12 do
        local v293 = v_u_3:GetPlayerByUserId(v291)
        if v293 and (v292 and v292.Parent) then
            local v294 = v_u_12[v293.UserId]
            if v294 then
                if v294.Parent then
                    local v295 = v_u_88
                    local v296
                    if workspace:GetAttribute("GameState") == "Warmup" or not v_u_17 then
                        v296 = false
                    else
                        local v297 = v_u_18:GetAttribute("Team")
                        local v298 = v293:GetAttribute("Team")
                        local v299
                        if v297 and v298 then
                            v299 = v297 == v298
                        else
                            v299 = false
                        end
                        if v299 then
                            v296 = true
                        else
                            local v300 = v_u_15[v293.UserId] or 0
                            local v301 = v_u_16[v293.UserId] == true
                            v296 = v300 > 0 and true or v301
                        end
                    end
                    v295(v293, v294, v296)
                end
            end
        end
    end
end)
return v1
