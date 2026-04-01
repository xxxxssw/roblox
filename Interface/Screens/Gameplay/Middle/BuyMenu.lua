-- MODULESCRIPT: BuyMenu
-- Original Path: game.BAC - 52404.Interface.Screens.Gameplay.Middle.BuyMenu
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
local v_u_6 = game:GetService("HttpService")
require(script:WaitForChild("Types"))
local v_u_7 = v_u_5.LocalPlayer
local v_u_8 = require(v_u_2.Controllers.InventoryController)
local v_u_9 = require(v_u_2.Controllers.EndScreenController)
local v_u_10 = require(v_u_2.Controllers.CameraController)
local v_u_11 = require(v_u_2.Controllers.DataController)
local v_u_12 = require(v_u_2.Database.Components.Common.AttachGlovesToCharacter)
local v_u_13 = require(v_u_2.Database.Components.Common.RemoveFromArray)
local v_u_14 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_15 = require(v_u_2.Components.Common.GetPreferenceColor)
local v_u_16 = require(v_u_2.Database.Components.Common.IsInBuyArea)
local v_u_17 = require(v_u_2.Components.Common.GetTimerFormat)
local v_u_18 = require(v_u_2.Database.Components.GameState)
local v_u_19 = game:GetService("CollectionService")
local v_u_20 = require(v_u_2.Packages.Observers)
local v21 = require(v_u_2.Shared.Janitor)
local v22 = require(v_u_2.Shared.Spring)
local v_u_23 = require(v_u_2.Database.Security.Remotes)
local v_u_24 = require(v_u_2.Database.Security.Router)
local v_u_25 = require(v_u_2.Database.Custom.GameStats.Grenades)
local v_u_26 = v_u_2.Assets.Characters
local v_u_27 = require(v_u_2.Database.Custom.GameStats.NumberSlots)
local v_u_28 = require(v_u_2.Database.Custom.GameStats.Character.Attachments)
local v_u_29 = require(v_u_2.Database.Custom.GameStats.Character.Viewport)
local v_u_30 = require(v_u_2.Shared.ViewportModel)
local v_u_31 = v21.new()
local v_u_32 = v21.new()
local v_u_33 = v21.new()
local v_u_34 = v22.new(1, 8, 0)
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = nil
local v_u_41 = nil
local v_u_42 = {}
local v_u_43 = nil
local v_u_44 = nil
local v_u_45 = {
    ["1"] = "Kevlar",
    ["2"] = "Kevlar + Helmet"
}
local v_u_46 = {
    ["Kevlar"] = true,
    ["Kevlar + Helmet"] = true,
    ["Defuse Kit"] = true,
    ["Rescue Kit"] = true
}
local v_u_47 = {
    {
        ["Name"] = "Yellow",
        ["Color"] = Color3.fromRGB(255, 221, 51)
    },
    {
        ["Name"] = "Green",
        ["Color"] = Color3.fromRGB(0, 153, 0)
    },
    {
        ["Name"] = "Blue",
        ["Color"] = Color3.fromRGB(0, 102, 204)
    },
    {
        ["Name"] = "Purple",
        ["Color"] = Color3.fromRGB(153, 51, 204)
    },
    {
        ["Name"] = "Orange",
        ["Color"] = Color3.fromRGB(255, 128, 0)
    }
}
local v_u_48 = v21.new()
local v_u_49 = {}
local v_u_50 = {}
local v_u_51 = nil
local v_u_52 = {}
local v_u_53 = {}
local function v_u_57(p54)
    -- upvalues: (copy) v_u_46, (copy) v_u_7
    if v_u_46[p54] and workspace:GetAttribute("ServerGamemode") ~= "Competitive" then
        return false
    elseif p54 == "Defuse Kit" or p54 == "Rescue Kit" then
        local v55 = v_u_7:GetAttribute("Team")
        local v56 = workspace:GetAttribute("Gamemode")
        if v55 == "Counter-Terrorists" then
            if p54 == "Defuse Kit" then
                return v56 == "Bomb Defusal"
            else
                return p54 ~= "Rescue Kit" and true or v56 == "Hostage Rescue"
            end
        else
            return false
        end
    else
        return true
    end
end
local function v_u_62(p58, p59, p60, p61)
    if p58 == nil then
        return nil
    else
        return p59 == "SniperScope" and "Sniper" or (p58 == "Heavy" and (p60 == "MachineGun" and "LMG" or "Heavy") or (p58 == "Equipment" and p61 == "Grenade" and "Grenade" or ({
            ["Pistol"] = "Pistol",
            ["Rifle"] = "Rifle",
            ["SMG"] = "SMG",
            ["Equipment"] = nil,
            ["Miscellaneous"] = nil
        })[p58]))
    end
end
local function v_u_69()
    -- upvalues: (copy) v_u_7, (copy) v_u_6
    local v_u_63 = v_u_7:GetAttribute("Armor")
    if typeof(v_u_63) == "string" and v_u_63 ~= "" then
        local v64, v65 = pcall(function()
            -- upvalues: (ref) v_u_6, (copy) v_u_63
            return v_u_6:JSONDecode(v_u_63)
        end)
        if v64 and typeof(v65) == "table" then
            local v66 = {}
            local v67 = v65.Type or ""
            v66.Type = tostring(v67)
            local v68 = v65.Health
            v66.Health = tonumber(v68) or 0
            return v66
        end
    end
    return {
        ["Type"] = "",
        ["Health"] = 0
    }
end
local function v_u_74(p70, p71)
    -- upvalues: (copy) v_u_18, (copy) v_u_69
    if workspace:GetAttribute("Gamemode") == "Deathmatch" or v_u_18.GetState() == "Warmup" then
        return 0
    end
    if workspace:GetAttribute("VIPInfiniteCashEnabled") == true then
        return 0
    end
    local v72 = p71.Cost
    if p70 == "Kevlar + Helmet" then
        local v73 = v_u_69()
        v72 = v73.Type == "Kevlar" and v73.Health >= 100 and 350 or v72
    end
    return v72
end
local function v_u_79(p75)
    -- upvalues: (copy) v_u_7, (copy) v_u_69
    if p75 == "Defuse Kit" then
        return v_u_7:GetAttribute("HasDefuseKit") == true
    end
    if p75 == "Rescue Kit" then
        return v_u_7:GetAttribute("HasRescueKit") == true
    end
    local v76 = v_u_69()
    if p75 == "Kevlar" then
        local v77
        if v76.Health > 0 then
            v77 = v76.Type == "Kevlar"
        else
            v77 = false
        end
        return v77
    end
    if p75 ~= "Kevlar + Helmet" then
        return false
    end
    local v78
    if v76.Health > 0 then
        v78 = v76.Type == "Kevlar + Helmet"
    else
        v78 = false
    end
    return v78
end
local function v_u_85(p80)
    -- upvalues: (copy) v_u_57, (copy) v_u_79, (copy) v_u_69
    if v_u_57(p80) then
        if p80 == "Defuse Kit" or p80 == "Rescue Kit" then
            return v_u_79(p80)
        else
            local v81 = v_u_69()
            if p80 == "Kevlar" then
                local v82
                if v81.Type == "Kevlar + Helmet" then
                    v82 = v81.Health > 0
                else
                    v82 = false
                end
                local v83
                if v81.Type == "Kevlar" then
                    v83 = v81.Health >= 100
                else
                    v83 = false
                end
                return v82 or v83
            else
                if p80 ~= "Kevlar + Helmet" then
                    return false
                end
                local v84
                if v81.Type == "Kevlar + Helmet" then
                    v84 = v81.Health >= 100
                else
                    v84 = false
                end
                return v84
            end
        end
    else
        return true
    end
end
local function v_u_99()
    -- upvalues: (ref) v_u_43, (copy) v_u_24, (copy) v_u_7, (copy) v_u_1, (copy) v_u_45, (copy) v_u_57, (copy) v_u_46
    for _, v86 in ipairs(v_u_43.Menu.Container:GetDescendants()) do
        if v86:IsA("TextButton") then
            if v86.Parent.Name == "Equipment" then
                if v86.Name == "4" then
                    local v87 = v_u_24.broadcastRouter("GetEquippedInventoryItem", v_u_7, "Equipped.Equipped Zeus x27")
                    if v87 and v87.Name then
                        v_u_1.createTemplate(v86, v87, false, "Equipped.Equipped Zeus x27")
                    else
                        v_u_1.createTemplate(v86, {
                            ["Name"] = "Zeus x27",
                            ["_id"] = "__buymenu_zeus_placeholder__"
                        }, false, "Equipped.Equipped Zeus x27")
                    end
                else
                    local v88 = v86.Name
                    local v89 = v_u_45[v88]
                    if v89 then
                        if not v_u_57(v89) then
                            v89 = nil
                        end
                    elseif v88 == "3" then
                        local v90
                        if v_u_46["Defuse Kit"] and workspace:GetAttribute("ServerGamemode") ~= "Competitive" then
                            v90 = false
                        else
                            local v91 = v_u_7:GetAttribute("Team")
                            local v92 = workspace:GetAttribute("Gamemode")
                            if v91 == "Counter-Terrorists" then
                                v90 = v92 == "Bomb Defusal"
                            else
                                v90 = false
                            end
                        end
                        if v90 then
                            v89 = "Defuse Kit"
                        else
                            local v93
                            if v_u_46["Rescue Kit"] and workspace:GetAttribute("ServerGamemode") ~= "Competitive" then
                                v93 = false
                            else
                                local v94 = v_u_7:GetAttribute("Team")
                                local v95 = workspace:GetAttribute("Gamemode")
                                if v94 == "Counter-Terrorists" then
                                    v93 = v95 == "Hostage Rescue"
                                else
                                    v93 = false
                                end
                            end
                            v89 = v93 and "Rescue Kit" or nil
                        end
                    else
                        v89 = nil
                    end
                    if v89 then
                        v_u_1.createTemplate(v86, {
                            ["Name"] = v89,
                            ["_id"] = ("equipment:%*"):format(v89)
                        }, true, nil)
                    else
                        v86:SetAttribute("IsEquipment", nil)
                        v86:SetAttribute("Weapon", nil)
                        v86.Visible = false
                    end
                end
            else
                local v96 = v_u_1.setupTemplate
                local v97 = v86.Parent.Name
                local v98 = v86.Name
                v96(v86, (("Loadout.%*.Options.%*"):format(v97, (tonumber(v98)))))
            end
        end
    end
end
local function v_u_104(p100, p101)
    for _, v102 in ipairs(p100) do
        for _, v103 in ipairs(v102._items) do
            if v103.Name == p101 then
                return v103
            end
        end
    end
    return false
end
local function v_u_109(p105, p106)
    -- upvalues: (copy) v_u_42, (copy) v_u_104
    for _, v107 in ipairs(p105) do
        for _, v108 in ipairs(v107._items) do
            if v108.Name == p106 and table.find(v_u_42, v108.Identifier) then
                return v108
            end
        end
    end
    return v_u_104(p105, p106)
end
local function v_u_114(p110, p111)
    if not p110 or #p110._items == 0 then
        return nil
    end
    for _, v112 in ipairs(p110._items) do
        if v112.Name == p111 then
            return v112
        end
    end
    for _, v113 in ipairs(p110._items) do
        if v113.Properties and v113.Properties.Droppable then
            return v113
        end
    end
    return p110._items[1]
end
local function v_u_120(p115, p116)
    local v117 = 0
    for _, v118 in ipairs(p115) do
        for _, v119 in ipairs(v118._items) do
            if v119.Name == p116 then
                v117 = v117 + 1
            end
        end
    end
    return v117
end
local function v_u_128(p121)
    -- upvalues: (copy) v_u_6
    local v_u_122 = p121:GetAttribute("Armor")
    if typeof(v_u_122) == "string" and v_u_122 ~= "" then
        local v123, v124 = pcall(function()
            -- upvalues: (ref) v_u_6, (copy) v_u_122
            return v_u_6:JSONDecode(v_u_122)
        end)
        if v123 and typeof(v124) == "table" then
            local v125 = {}
            local v126 = v124.Type or ""
            v125.Type = tostring(v126)
            local v127 = v124.Health
            v125.Health = tonumber(v127) or 0
            return v125
        end
    end
    return {
        ["Type"] = "",
        ["Health"] = 0
    }
end
local function v_u_134(p129, p130)
    -- upvalues: (copy) v_u_47
    local v131 = p130:GetAttribute("CompetitivePlayerColor")
    if not v131 then
        return nil
    end
    local v132 = p129.Teammates
    for _, v133 in ipairs(v_u_47) do
        if v131 == v133.Color then
            return v132[v133.Name]
        end
    end
    return nil
end
local function v_u_137(p_u_135)
    -- upvalues: (copy) v_u_7, (copy) v_u_5, (copy) v_u_53, (copy) v_u_23
    if p_u_135 == v_u_7 or not p_u_135:IsDescendantOf(v_u_5) then
        return
    elseif v_u_53[p_u_135] then
        return
    else
        local v136 = v_u_7:GetAttribute("Team")
        if workspace:GetAttribute("ServerGamemode") == "Competitive" and p_u_135:GetAttribute("Team") == v136 then
            v_u_53[p_u_135] = true
            v_u_23.Inventory.RequestSpectatedPlayerInventory.Send(p_u_135)
            task.delay(0.15, function()
                -- upvalues: (ref) v_u_53, (copy) p_u_135
                v_u_53[p_u_135] = nil
            end)
        end
    end
end
local function v_u_140()
    -- upvalues: (copy) v_u_7, (copy) v_u_5, (copy) v_u_137
    if workspace:GetAttribute("ServerGamemode") == "Competitive" then
        local v138 = v_u_7:GetAttribute("Team")
        if v138 and (v138 == "Counter-Terrorists" or v138 == "Terrorists") then
            for _, v139 in ipairs(v_u_5:GetPlayers()) do
                if v139 ~= v_u_7 and v139:GetAttribute("Team") == v138 then
                    v_u_137(v139)
                end
            end
        end
    else
        return
    end
end
local function v_u_150(p141, p142, p143)
    -- upvalues: (copy) v_u_7, (copy) v_u_79, (copy) v_u_128, (copy) v_u_8, (copy) v_u_52
    if not p143 then
        local v144
        if p141 == v_u_7 then
            v144 = v_u_8.getCurrentInventory()
        else
            v144 = v_u_52[p141]
        end
        if not v144 then
            return false
        end
        for _, v145 in ipairs(v144) do
            for _, v146 in ipairs(v145._items) do
                if v146.Name == p142 then
                    return true
                end
            end
        end
        return false
    end
    if p141 == v_u_7 then
        return v_u_79(p142)
    end
    if p142 == "Defuse Kit" then
        return p141:GetAttribute("HasDefuseKit") == true
    end
    if p142 == "Rescue Kit" then
        return p141:GetAttribute("HasRescueKit") == true
    end
    local v147 = v_u_128(p141)
    if p142 == "Kevlar" then
        local v148
        if v147.Type == "Kevlar" then
            v148 = v147.Health > 0
        else
            v148 = false
        end
        return v148
    end
    if p142 ~= "Kevlar + Helmet" then
        return false
    end
    local v149
    if v147.Type == "Kevlar + Helmet" then
        v149 = v147.Health > 0
    else
        v149 = false
    end
    return v149
end
local function v_u_159(p151)
    -- upvalues: (copy) v_u_7, (copy) v_u_5, (copy) v_u_52, (copy) v_u_137, (copy) v_u_150, (copy) v_u_134
    local v152 = p151.Teammates
    v152.Visible = false
    v152.Yellow.Visible = false
    v152.Orange.Visible = false
    v152.Blue.Visible = false
    v152.Purple.Visible = false
    v152.Green.Visible = false
    if p151.Visible and workspace:GetAttribute("ServerGamemode") == "Competitive" then
        local v153 = v_u_7:GetAttribute("Team")
        if v153 and (v153 == "Counter-Terrorists" or v153 == "Terrorists") then
            local v154 = p151:GetAttribute("Weapon")
            if v154 then
                local v155 = p151:GetAttribute("IsEquipment") == true
                local v156 = false
                for _, v157 in ipairs(v_u_5:GetPlayers()) do
                    if v157:GetAttribute("Team") == v153 then
                        if v157 ~= v_u_7 and not (v155 or v_u_52[v157]) then
                            v_u_137(v157)
                        end
                        if v_u_150(v157, v154, v155) then
                            local v158 = v_u_134(p151, v157)
                            if v158 then
                                v158.Visible = true
                                v156 = true
                            end
                        end
                    end
                end
                p151.Teammates.Visible = v156
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_161()
    -- upvalues: (ref) v_u_43, (copy) v_u_159
    if v_u_43 then
        for _, v160 in ipairs(v_u_43.Menu.Container:GetDescendants()) do
            if v160:IsA("TextButton") then
                v_u_159(v160)
            end
        end
    end
end
local function v_u_165(p162, p163)
    local v164 = p162:GetAttribute(p163)
    while not v164 do
        v164 = p162:GetAttribute(p163)
        task.wait()
    end
    return v164
end
local function v_u_174()
    -- upvalues: (copy) v_u_18, (ref) v_u_43, (copy) v_u_17
    local v166 = 0
    local v167 = v_u_18.GetState()
    if v167 == "Buy Period" or v167 == "Round In Progress" then
        local v168 = workspace:GetAttribute("BuyTimerRemaining")
        if typeof(v168) == "number" then
            local v169 = math.floor(v168)
            v166 = math.max(0, v169)
        else
            local v170 = workspace:GetAttribute("Timer")
            if typeof(v170) == "number" then
                local v171 = math.floor(v170)
                v166 = math.max(0, v171)
            end
        end
    else
        local v172 = workspace:GetAttribute("Timer")
        if typeof(v172) == "number" then
            local v173 = math.floor(v172)
            v166 = math.max(0, v173)
        end
    end
    v_u_43.Menu.TopFrame.Timer.Text = v_u_17(v166)
end
function v_u_1.purchase(p175, p176, p177)
    -- upvalues: (copy) v_u_2, (copy) v_u_7, (copy) v_u_74, (copy) v_u_85, (copy) v_u_16, (copy) v_u_18, (copy) v_u_25, (copy) v_u_8, (copy) v_u_27, (copy) v_u_114, (copy) v_u_42, (copy) v_u_24, (copy) v_u_23
    local v178 = v_u_2.Database.Custom.Weapons:FindFirstChild(p175) or v_u_2.Database.Custom.GameStats.Equipment:FindFirstChild(p175)
    local v179
    if v178 then
        v179 = require(v178)
    else
        v179 = nil
    end
    if v179 then
        local v180 = v_u_7:GetAttribute("Money")
        local v181 = v_u_74(p175, v179)
        local v182 = workspace:GetAttribute("Gamemode")
        if p177 and v_u_85(p175) then
            return
        elseif v_u_16(v_u_7) then
            local v183 = (v182 == "Deathmatch" or v_u_18.GetState() == "Warmup") and 0 or v181
            local v184 = not p177
            if v184 then
                v184 = v_u_25[p175] ~= nil
            end
            local v185 = v184 and v_u_8.getCurrentInventory()
            if v185 then
                local v186 = v185[v_u_27.Grenade]
                if v186 and #v186._items >= v186._settings._strict_slot_space then
                    return
                end
            end
            if not p177 and (v_u_7:GetAttribute("BuyMenu") and (v182 == "Hostage Rescue" or v182 == "Bomb Defusal")) then
                local v187 = v_u_8.getCurrentInventory()
                local v188 = v_u_2.Database.Custom.Weapons:FindFirstChild(p175) or v_u_2.Database.Custom.GameStats.Equipment:FindFirstChild(p175)
                local v189
                if v188 then
                    v189 = require(v188)
                else
                    v189 = nil
                end
                local v190 = v_u_27[v189.Slot]
                if v187 and v189 then
                    local v191 = v187[v190]
                    if v191 and #v191._items > 0 then
                        local v192 = v_u_114(v191, p175)
                        if v192 and table.find(v_u_42, v192.Identifier) then
                            local v193 = v192.Name
                            local v194 = v_u_2.Database.Custom.Weapons:FindFirstChild(v193) or v_u_2.Database.Custom.GameStats.Equipment:FindFirstChild(v193)
                            local v195
                            if v194 then
                                v195 = require(v194)
                            else
                                v195 = nil
                            end
                            if v195 then
                                local v196 = v195.Cost
                                v183 = v181 - (tonumber(v196) or 0)
                            end
                        end
                    end
                end
            end
            if v180 and v183 <= v180 then
                v_u_24.broadcastRouter("RunInterfaceSound", "Successful Buy Menu Purchase")
                v_u_23.Inventory.BuyMenuPurchase.Send({
                    ["Equipment"] = p177,
                    ["Name"] = p175,
                    ["Path"] = p176 or ""
                })
            end
        end
    else
        return
    end
end
function v_u_1.createTemplate(p_u_197, p198, p_u_199, p_u_200)
    -- upvalues: (copy) v_u_7, (copy) v_u_2, (copy) v_u_74, (copy) v_u_85, (copy) v_u_15, (copy) v_u_8, (copy) v_u_79, (copy) v_u_120, (copy) v_u_25, (copy) v_u_18, (copy) v_u_31, (copy) v_u_24, (copy) v_u_104, (copy) v_u_3, (ref) v_u_37, (copy) v_u_1, (copy) v_u_16, (copy) v_u_23, (copy) v_u_109, (copy) v_u_159
    local v_u_201 = p198.Name == "Molotov" and v_u_7:GetAttribute("Team") == "Counter-Terrorists" and {
        ["Name"] = "Incendiary Grenade",
        ["_id"] = p198._id
    } or p198
    local v202 = v_u_201.Name
    local v203 = v_u_2.Database.Custom.Weapons:FindFirstChild(v202) or v_u_2.Database.Custom.GameStats.Equipment:FindFirstChild(v202)
    local v204
    if v203 then
        v204 = require(v203)
    else
        v204 = nil
    end
    if v204 then
        local v205 = workspace:GetAttribute("Gamemode")
        local v206 = v_u_74(v_u_201.Name, v204)
        local v207 = v204.ReverseIcon or v204.Icon
        p_u_197.Icon.Image = v207
        p_u_197.Cost.Text = "$" .. tostring(v206):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        local v208 = p_u_197.Keybind
        local v209 = p_u_197.Name
        local v210 = tonumber(v209)
        v208.Text = tostring(v210)
        p_u_197.Cost.Visible = v205 ~= "Deathmatch"
        local v211 = p_u_197.Name
        p_u_197.LayoutOrder = tonumber(v211)
        p_u_197.ItemName.Text = v_u_201.Name
        p_u_197.Teammates.Visible = false
        p_u_197.Visible = true
        local v212 = v_u_7
        local v213 = tonumber(v212:GetAttribute("Money")) or 0
        local v214
        if p_u_199 then
            v214 = v_u_85(v_u_201.Name)
        else
            v214 = p_u_199
        end
        local v215 = (v213 < v206 or v214) and Color3.fromRGB(149, 149, 149) or v_u_15()
        p_u_197.ItemName.TextColor3 = v215
        p_u_197.Keybind.TextColor3 = v215
        p_u_197.Icon.ImageColor3 = v215
        p_u_197.Cost.TextColor3 = v215
        p_u_197:SetAttribute("Weapon", v_u_201.Name)
        p_u_197:SetAttribute("IsEquipment", p_u_199)
        p_u_197:SetAttribute("InventoryItemId", v_u_201._id)
        local v216 = v_u_8.getCurrentInventory()
        local v217 = false
        local v218 = false
        if p_u_199 then
            v217 = v_u_79(v_u_201.Name)
        elseif v216 then
            v217 = v_u_120(v216, v_u_201.Name) > 0
            local v219 = v_u_201.Name
            local v220 = v_u_120(v216, v219)
            local v221 = v_u_25[v219]
            if v221 then
                v218 = v220 < v221
            elseif v220 == 0 then
                v218 = true
            else
                v218 = false
            end
        end
        local v222 = p_u_197.Return
        local v223
        if v217 then
            if v_u_18.GetState() == "Warmup" or v205 == "Deathmatch" then
                v223 = false
            elseif p_u_199 then
                v223 = p_u_199
            else
                local v224
                if p_u_197.Parent.Name == "Pistols" then
                    v224 = p_u_197.Name == "1"
                else
                    v224 = false
                end
                v223 = not v224
            end
        else
            v223 = v217
        end
        v222.Visible = v223
        p_u_197.Hover.Visible = v217
        p_u_197.Hover.UIStroke.Transparency = v217 and not v218 and 0 or 1
        v_u_31:Add(p_u_197.MouseEnter:Connect(function()
            -- upvalues: (ref) v_u_8, (ref) v_u_24, (copy) p_u_199, (ref) v_u_79, (ref) v_u_201, (ref) v_u_104, (copy) p_u_197, (ref) v_u_3, (ref) v_u_37
            local v225 = v_u_8.getCurrentInventory()
            v_u_24.broadcastRouter("RunInterfaceSound", "UI Highlight")
            local v226 = p_u_199 and v_u_79(v_u_201.Name)
            if v226 then
                v225 = v226
            elseif v225 then
                v225 = v_u_104(v225, v_u_201.Name)
            end
            if not v225 then
                p_u_197.Hover.UIStroke.Transparency = 1
                p_u_197.Hover.Visible = true
                v_u_3:Create(p_u_197.Hover.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Transparency"] = 0.8
                }):Play()
            end
            v_u_3:Create(p_u_197.Icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.fromScale(0.7, 0.7)
            }):Play()
            if not p_u_199 then
                v_u_37 = v_u_201._id
            end
        end))
        v_u_31:Add(p_u_197.MouseLeave:Connect(function()
            -- upvalues: (ref) v_u_8, (copy) p_u_199, (ref) v_u_79, (ref) v_u_201, (ref) v_u_104, (copy) p_u_197, (ref) v_u_3, (ref) v_u_37
            local v227 = v_u_8.getCurrentInventory()
            local v228 = p_u_199 and v_u_79(v_u_201.Name)
            if v228 then
                v227 = v228
            elseif v227 then
                v227 = v_u_104(v227, v_u_201.Name)
            end
            if not v227 then
                p_u_197.Hover.UIStroke.Transparency = 1
                p_u_197.Hover.Visible = false
            end
            v_u_3:Create(p_u_197.Icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.fromScale(0.75, 0.75)
            }):Play()
            if not p_u_199 and v_u_37 == v_u_201._id then
                v_u_37 = nil
            end
        end))
        v_u_31:Add(p_u_197.MouseButton1Down:Connect(function()
            -- upvalues: (ref) v_u_3, (copy) p_u_197
            v_u_3:Create(p_u_197.Icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.fromScale(0.65, 0.65)
            }):Play()
        end))
        v_u_31:Add(p_u_197.MouseButton1Up:Connect(function()
            -- upvalues: (ref) v_u_3, (copy) p_u_197
            v_u_3:Create(p_u_197.Icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.fromScale(0.7, 0.7)
            }):Play()
        end))
        v_u_31:Add(p_u_197.MouseButton1Click:Connect(function()
            -- upvalues: (ref) v_u_1, (ref) v_u_201, (copy) p_u_200, (copy) p_u_199
            v_u_1.purchase(v_u_201.Name, p_u_200, p_u_199)
        end))
        v_u_31:Add(p_u_197.Return.MouseButton1Click:Connect(function()
            -- upvalues: (copy) p_u_199, (ref) v_u_16, (ref) v_u_7, (ref) v_u_23, (ref) v_u_201, (ref) v_u_8, (ref) v_u_109
            if p_u_199 then
                if v_u_16(v_u_7) then
                    v_u_23.Inventory.ReturnBuyMenuPurchase.Send({
                        ["Identifier"] = v_u_201.Name,
                        ["Equipment"] = true
                    })
                end
                return
            else
                local v229 = v_u_8.getCurrentInventory()
                if v229 then
                    local v230 = v_u_109(v229, v_u_201.Name)
                    if v230 and v_u_16(v_u_7) then
                        v_u_23.Inventory.ReturnBuyMenuPurchase.Send({
                            ["Identifier"] = v230.Identifier,
                            ["Equipment"] = false
                        })
                    end
                end
            end
        end))
        v_u_159(p_u_197)
    else
        p_u_197.Visible = false
    end
end
function v_u_1.setupTemplate(p231, p232)
    -- upvalues: (copy) v_u_24, (copy) v_u_7, (copy) v_u_1
    local v233 = v_u_24.broadcastRouter("GetEquippedInventoryItem", v_u_7, p232)
    if v233 and v233.Name then
        v_u_1.createTemplate(p231, v233, false, p232)
    else
        p231:SetAttribute("IsEquipment", nil)
        p231:SetAttribute("Weapon", nil)
        p231.Visible = false
    end
end
function v_u_1.updateBuyMenuTemplate(p234, p235)
    -- upvalues: (copy) v_u_2, (copy) v_u_74, (copy) v_u_7, (copy) v_u_85, (copy) v_u_15, (copy) v_u_79, (copy) v_u_120, (copy) v_u_25, (copy) v_u_18, (copy) v_u_3, (copy) v_u_159
    local v236 = p235:GetAttribute("IsEquipment")
    local v237 = p235:GetAttribute("Weapon")
    if v237 then
        local v238 = v_u_2.Database.Custom.Weapons:FindFirstChild(v237) or v_u_2.Database.Custom.GameStats.Equipment:FindFirstChild(v237)
        local v239
        if v238 then
            v239 = require(v238)
        else
            v239 = nil
        end
        if v239 then
            local v240 = v_u_74(v237, v239)
            p235.Cost.Text = "$" .. tostring(v240):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
            local v241 = v_u_7:GetAttribute("Money")
            local v242
            if v236 then
                v242 = v_u_85(v237)
            else
                v242 = v236
            end
            if v241 then
                local v243 = (v241 < v240 or v242) and Color3.fromRGB(149, 149, 149) or v_u_15()
                p235.ItemName.TextColor3 = v243
                p235.Keybind.TextColor3 = v243
                p235.Icon.ImageColor3 = v243
                p235.Cost.TextColor3 = v243
            end
        end
        if p235.Visible then
            local v244 = false
            local v245 = false
            if v236 then
                v244 = v_u_79(v237)
            elseif p234 then
                v244 = v_u_120(p234, v237) > 0
                local v246 = v_u_120(p234, v237)
                local v247 = v_u_25[v237]
                if v247 then
                    v245 = v246 < v247
                elseif v246 == 0 then
                    v245 = true
                else
                    v245 = false
                end
            end
            local v248 = workspace:GetAttribute("Gamemode")
            local v249 = p235.Return
            if v244 then
                if v248 == "Deathmatch" or v_u_18.GetState() == "Warmup" then
                    v236 = false
                elseif not v236 then
                    local v250
                    if p235.Parent.Name == "Pistols" then
                        v250 = p235.Name == "1"
                    else
                        v250 = false
                    end
                    v236 = not v250
                end
            else
                v236 = v244
            end
            v249.Visible = v236
            p235.Hover.Visible = v244
            if not v244 then
                p235.Hover.UIStroke.Transparency = 1
                v_u_159(p235)
                return
            end
            v_u_3:Create(p235.Hover.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Transparency"] = v245 and 1 or 0
            }):Play()
        end
        v_u_159(p235)
    else
        local v251 = p235.Teammates
        v251.Visible = false
        v251.Yellow.Visible = false
        v251.Orange.Visible = false
        v251.Blue.Visible = false
        v251.Purple.Visible = false
        v251.Green.Visible = false
    end
end
local function v_u_303(p252)
    -- upvalues: (ref) v_u_39, (ref) v_u_36, (ref) v_u_35, (copy) v_u_14, (copy) v_u_62, (copy) v_u_29, (ref) v_u_38, (copy) v_u_28, (ref) v_u_40, (copy) v_u_2
    local v253 = v_u_39
    if v253 then
        if p252 and v_u_36 == p252._id then
            local v254 = v_u_35
            if not (v254 and v254.IsPlaying) then
                local v255 = v253:FindFirstChildOfClass("Humanoid")
                local v256 = v255 and v255:FindFirstChildOfClass("Animator")
                if v256 then
                    local v257 = nil
                    if p252.Type == "Melee" then
                        v257 = "Melee"
                    else
                        local v258, v259 = pcall(v_u_14, p252.Name)
                        if v258 and v259 then
                            v257 = v_u_62(v259.Type, v259.AimingOptions, v259.MuzzleType, v259.Class)
                        end
                    end
                    if v257 then
                        local v260 = p252.Name
                        local v261
                        if v257 and v_u_29.ANIMATION_MAPPING[v257] then
                            local v262 = v_u_29.ANIMATION_MAPPING[v257]
                            if v260 and v262[v260] then
                                v261 = v262[v260]
                            else
                                v261 = v262.Default
                            end
                        else
                            v261 = nil
                        end
                        if v261 then
                            local v263 = v256:LoadAnimation(v261)
                            v263.Looped = true
                            v263.Priority = Enum.AnimationPriority.Action
                            v263:Play()
                            v_u_35 = v263
                        end
                    end
                end
            end
            return
        else
            if v_u_35 then
                v_u_35:Stop()
                v_u_35 = nil
            end
            if v_u_38 then
                v_u_38:Destroy()
                v_u_38 = nil
            end
            v_u_36 = nil
            for _, v264 in pairs({ v_u_28.DEFAULT_JOINT_PART, "UpperTorso", "LeftHand" }) do
                local v265 = v253:FindFirstChild(v264)
                if v265 then
                    for _, v266 in ipairs(v265:GetChildren()) do
                        if v266:IsA("Motor6D") and (v266.Name == "WeaponAttachment" or (v266.Name == "WeaponAttachmentHandleR" or v266.Name == "WeaponAttachmentHandleL")) then
                            v266:Destroy()
                        end
                    end
                end
            end
            local v267 = { v253, v_u_40 }
            for _, v268 in ipairs(v267) do
                if v268 then
                    for _, v269 in ipairs(v268:GetChildren()) do
                        if v269:IsA("Model") and (v269 ~= v253 and v269.Name ~= "CharacterArmor") and (v269:FindFirstChild("Insert", true) or v269:FindFirstChild("Weapon", true)) then
                            v269:Destroy()
                        end
                    end
                end
            end
            if p252 then
                local v270 = require(v_u_2.Database.Components.Libraries.Skins).GetCharacterModel(p252.Name, p252.Skin, p252.Float, p252.StatTrack, p252.NameTag)
                if v270 then
                    v270.Name = p252.Name
                    local v271 = v253:FindFirstChild(v_u_28.WEAPON_JOINT_PARTS[p252.Name] or v_u_28.DEFAULT_JOINT_PART)
                    if v271 then
                        if not v270.PrimaryPart then
                            local v272 = v270:FindFirstChild("Weapon")
                            if v272 then
                                v272 = v272:FindFirstChild("Insert")
                            end
                            if v272 then
                                v270.PrimaryPart = v272
                            else
                                local v273 = v270:FindFirstChild("Insert", true)
                                if v273 then
                                    v270.PrimaryPart = v273
                                end
                            end
                        end
                        if v270.PrimaryPart then
                            for _, v274 in ipairs(v270:GetDescendants()) do
                                if v274:IsA("BasePart") then
                                    v274.CanCollide = false
                                    v274.CanQuery = false
                                    v274.CanTouch = false
                                    v274.Anchored = false
                                    v274.Massless = true
                                end
                            end
                            v270.Parent = v_u_40
                            local v275, v276 = pcall(v_u_14, p252.Name)
                            local v277
                            if v275 and v276 then
                                v277 = v276.ShootingOptions == "Dual"
                            else
                                v277 = false
                            end
                            local v278 = v270:FindFirstChild("Properties")
                            if not v278 then
                                local v279 = v270:FindFirstChild("Weapon")
                                if v279 then
                                    v278 = v279:FindFirstChild("Properties")
                                end
                            end
                            local v280 = v278 or v270:FindFirstChild("Properties", true)
                            if v277 then
                                local v281 = v253:FindFirstChild("RightHand")
                                local v282 = v253:FindFirstChild("LeftHand")
                                if v281 and v282 then
                                    local v283 = v270:FindFirstChild("HandleR", true)
                                    if v283 then
                                        local v284 = Instance.new("Motor6D")
                                        v284.Name = "WeaponAttachmentHandleR"
                                        v284.Part0 = v281
                                        v284.Part1 = v283
                                        v284.Parent = v281
                                        if v280 then
                                            local v285 = v280:FindFirstChild("C0RIGHT")
                                            if v285 then
                                                v284.C0 = v285.Value
                                            end
                                            local v286 = v280:FindFirstChild("C1RIGHT")
                                            if v286 then
                                                v284.C1 = v286.Value
                                            end
                                        end
                                    end
                                    local v287 = v270:FindFirstChild("HandleL", true)
                                    if v287 then
                                        local v288 = Instance.new("Motor6D")
                                        v288.Name = "WeaponAttachmentHandleL"
                                        v288.Part0 = v282
                                        v288.Part1 = v287
                                        v288.Parent = v282
                                        if v280 then
                                            local v289 = v280:FindFirstChild("C0LEFT")
                                            if v289 then
                                                v288.C0 = v289.Value
                                            end
                                            local v290 = v280:FindFirstChild("C1LEFT")
                                            if v290 then
                                                v288.C1 = v290.Value
                                            end
                                        end
                                    end
                                end
                            else
                                local v291 = Instance.new("Motor6D")
                                v291.Name = "WeaponAttachment"
                                v291.Part0 = v271
                                v291.Part1 = v270.PrimaryPart
                                v291.Parent = v271
                                if v280 then
                                    local v292 = v280:FindFirstChild("C0")
                                    if v292 then
                                        v291.C0 = v292.Value
                                    end
                                    local v293 = v280:FindFirstChild("C1")
                                    if v293 then
                                        v291.C1 = v293.Value
                                    end
                                end
                            end
                            v_u_38 = v270
                            v_u_36 = p252._id
                            local v294 = v253:FindFirstChildOfClass("Humanoid")
                            if v294 then
                                local v295 = v294:FindFirstChildOfClass("Animator")
                                if v295 then
                                    local v296 = nil
                                    if p252.Type == "Melee" then
                                        v296 = "Melee"
                                    elseif v276 then
                                        v296 = v_u_62(v276.Type, v276.AimingOptions, v276.MuzzleType, v276.Class)
                                    else
                                        local v297, v298 = pcall(v_u_14, p252.Name)
                                        if v297 and v298 then
                                            v296 = v_u_62(v298.Type, v298.AimingOptions, v298.MuzzleType, v298.Class)
                                        end
                                    end
                                    if v296 then
                                        local v299 = p252.Name
                                        local v300
                                        if v296 and v_u_29.ANIMATION_MAPPING[v296] then
                                            local v301 = v_u_29.ANIMATION_MAPPING[v296]
                                            if v299 and v301[v299] then
                                                v300 = v301[v299]
                                            else
                                                v300 = v301.Default
                                            end
                                        else
                                            v300 = nil
                                        end
                                        if v300 then
                                            local v302 = v295:LoadAnimation(v300)
                                            v302.Looped = true
                                            v302.Priority = Enum.AnimationPriority.Action
                                            v302:Play()
                                            v_u_35 = v302
                                        end
                                    end
                                end
                            else
                                return
                            end
                        else
                            v270:Destroy()
                            return
                        end
                    else
                        v270:Destroy()
                        return
                    end
                else
                    return
                end
            else
                return
            end
        end
    else
        return
    end
end
local function v_u_313()
    -- upvalues: (ref) v_u_39, (copy) v_u_7, (copy) v_u_11, (copy) v_u_2, (copy) v_u_12
    local v304 = v_u_39
    if not v304 then
        return
    end
    local v305 = v_u_7:GetAttribute("Team")
    if not v305 or v305 ~= "Counter-Terrorists" and v305 ~= "Terrorists" then
        return
    end
    local v306 = (v305 == "Counter-Terrorists" and "CT" or "T") == "CT" and "Counter-Terrorists" or "Terrorists"
    local v307 = v_u_11.Get(v_u_7, "Loadout")
    if not (v307 and v307[v306]) then
        return
    end
    local v308 = v307[v306].Equipped
    if v308 then
        v308 = v307[v306].Equipped["Equipped Gloves"]
    end
    if not v308 then
        return
    end
    local v309 = v_u_11.Get(v_u_7, "Inventory")
    local v310 = nil
    if v309 and type(v309) == "table" then
        for _, v311 in ipairs(v309) do
            if v311 and v311._id == v308 then
                v310 = v311
                break
            end
        end
    end
    if v310 then
        local v312 = require(v_u_2.Database.Components.Libraries.Skins).GetGloves(v310.Name, v310.Skin, v310.Float)
        if v312 then
            v_u_12(v312:GetChildren(), v304, v304)
            v312:Destroy()
        end
    else
        return
    end
end
local function v_u_328()
    -- upvalues: (copy) v_u_11, (copy) v_u_7, (ref) v_u_37, (copy) v_u_303, (copy) v_u_8
    v_u_11.WaitForDataLoaded(v_u_7)
    if v_u_37 then
        local v314 = v_u_11.Get(v_u_7, "Inventory")
        if v314 and type(v314) == "table" then
            for _, v316 in ipairs(v314) do
                if v316 and v316._id == v_u_37 then
                    if v316.Name == "Molotov" then
                        local v316 = v_u_7:GetAttribute("Team") == "Counter-Terrorists" and {
                            ["_id"] = v316._id,
                            ["Name"] = "Incendiary Grenade",
                            ["Skin"] = v316.Skin,
                            ["Float"] = v316.Float,
                            ["StatTrack"] = v316.StatTrack,
                            ["NameTag"] = v316.NameTag,
                            ["Charm"] = v316.Charm,
                            ["Stickers"] = v316.Stickers
                        } or v316
                    end
                    v_u_303(v316)
                    return
                end
            end
        end
        return
    end
    local v317 = v_u_8.getCurrentInventory()
    local v318 = v_u_11.Get(v_u_7, "Inventory")
    if not v317 or (not v318 or type(v318) ~= "table") then
        return
    end
    local v327 = nil
    local v320 = v317[1]
    if v320 and (v320._items and #v320._items > 0) then
        local v321 = v320._items[1]
        if not (v321 and v321._id) then
            goto l19
        end
        local v322 = v321._id
        for _, v327 in ipairs(v318) do
            if v327._id == v322 then
                goto l19
            end
        end
        v327 = nil
        goto l19
    else
        ::l19::
        if v327 then
            ::l29::
            if v327 then
                v_u_303(v327)
            end
            return
        else
            local v324 = v317[2]
            if not v324 or (not v324._items or #v324._items <= 0) then
                goto l29
            end
            local v325 = v324._items[1]
            if not (v325 and v325._id) then
                goto l29
            end
            local v326 = v325._id
            for _, v327 in ipairs(v318) do
                if v327._id == v326 then
                    goto l29
                end
            end
            v327 = nil
            goto l29
        end
    end
end
local function v_u_346()
    -- upvalues: (ref) v_u_43, (copy) v_u_7, (copy) v_u_29, (ref) v_u_39, (ref) v_u_40, (ref) v_u_41, (copy) v_u_26, (copy) v_u_32, (copy) v_u_30, (copy) v_u_313, (copy) v_u_328, (ref) v_u_36, (ref) v_u_35, (ref) v_u_38
    local v329 = v_u_43.Player
    if v329 then
        local v330 = v_u_7:GetAttribute("Team")
        if v330 and (v330 == "Counter-Terrorists" or v330 == "Terrorists") then
            local v331 = v330 == "Counter-Terrorists" and "CT" or "T"
            local v332 = v_u_29.VIEWPORT_CHARACTER_CONFIG[v331]
            if v332 then
                if v_u_39 and v_u_39.Parent then
                    return
                else
                    if v_u_40 then
                        v_u_40:Destroy()
                        v_u_40 = nil
                    end
                    if v_u_41 then
                        v_u_41:Destroy()
                        v_u_41 = nil
                    end
                    for _, v333 in ipairs(v329:GetChildren()) do
                        if v333:IsA("WorldModel") or v333:IsA("Camera") then
                            v333:Destroy()
                        end
                    end
                    local v334 = v_u_26:FindFirstChild(v332.Character)
                    if v334 then
                        local v335 = Instance.new("WorldModel")
                        v335.Name = "CharacterWorldModel"
                        v335.Parent = v329
                        v_u_40 = v335
                        local v336 = v334:Clone()
                        v336.Name = "BuyMenuCharacter"
                        v336.Parent = v335
                        v_u_39 = v336
                        if v336.PrimaryPart then
                            v336:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
                        end
                        local v337 = -v336:GetBoundingBox().Y
                        local v338 = CFrame.new(0, v337, 0.4)
                        if v336.PrimaryPart then
                            v336:SetPrimaryPartCFrame(v338)
                        end
                        local v339 = Instance.new("Camera")
                        v339.CameraType = Enum.CameraType.Scriptable
                        v339.Name = "ViewportCamera"
                        v339.FieldOfView = 55
                        v339.Parent = v329
                        v329.CurrentCamera = v339
                        v_u_41 = v339
                        local v340 = v336:FindFirstChildOfClass("Humanoid")
                        if v340 and v332.IdleAnimation then
                            local v341 = v340:FindFirstChildOfClass("Animator")
                            if not v341 then
                                v341 = Instance.new("Animator")
                                v341.Parent = v340
                            end
                            local v342 = Instance.new("Animation")
                            v342.AnimationId = v332.IdleAnimation
                            local v343 = v341:LoadAnimation(v342)
                            v343.Looped = true
                            v343:Play()
                            v_u_32:Add(v343, "Stop", "BuyMenuIdleAnimTrack")
                            v_u_32:Add(v342, "Destroy", "BuyMenuIdleAnim")
                        end
                        local v344 = v_u_30.new(v329, v339)
                        v344:SetModel(v336)
                        local v345 = v344:GetMinimumFitCFrame(CFrame.new(0, v337, 0) * CFrame.Angles(0, -3.141592653589793, 0))
                        v339.CFrame = CFrame.new(0, v337, v345.Position.Z) * CFrame.Angles(0, -3.141592653589793, 0)
                        v_u_313()
                        v_u_328()
                        v_u_32:Add(function()
                            -- upvalues: (ref) v_u_40, (ref) v_u_41, (ref) v_u_39, (ref) v_u_36, (ref) v_u_35, (ref) v_u_38
                            if v_u_40 then
                                v_u_40:Destroy()
                                v_u_40 = nil
                            end
                            if v_u_41 then
                                v_u_41:Destroy()
                                v_u_41 = nil
                            end
                            if v_u_39 then
                                v_u_39:Destroy()
                                v_u_39 = nil
                            end
                            v_u_36 = nil
                            v_u_35 = nil
                            v_u_38 = nil
                        end, true, "BuyMenuCharacter")
                    end
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_348()
    -- upvalues: (ref) v_u_43, (ref) v_u_39, (copy) v_u_346, (ref) v_u_41, (copy) v_u_328
    local v347 = v_u_43.Player
    if v347 then
        if v347.Visible and (v347.AbsoluteSize.X > 0 and v347.AbsoluteSize.Y > 0) then
            if not (v_u_39 and v_u_39.Parent) then
                v_u_346()
            end
            if v_u_41 and v_u_41.Parent then
                v347.CurrentCamera = v_u_41
            end
            v_u_328()
        end
    else
        return
    end
end
local function v_u_352(p349)
    local v350 = 0
    for _, v351 in ipairs(p349:GetChildren()) do
        if v351:IsA("Frame") and v351.Name ~= "Template" then
            v350 = v350 + 1
        end
    end
    return v350
end
local function v_u_362(p353, p354)
    local v355 = p353:FindFirstChild("ImageLabel")
    local v356 = p353:FindFirstChild("TextLabel")
    if p354 then
        p353:SetAttribute("_OrigBG", p353.BackgroundColor3)
        p353.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        if v355 then
            v355:SetAttribute("_OrigColor", v355.ImageColor3)
            v355:SetAttribute("_OrigTrans", v355.ImageTransparency)
            v355.ImageColor3 = Color3.new(1, 1, 1)
            v355.ImageTransparency = 0.6
        end
        if v356 then
            v356:SetAttribute("_OrigColor", v356.TextColor3)
            v356:SetAttribute("_OrigTrans", v356.TextTransparency)
            v356.TextColor3 = Color3.new(1, 1, 1)
            v356.TextTransparency = 0.8
            return
        end
    else
        local v357 = p353:GetAttribute("_OrigBG")
        if v357 then
            p353.BackgroundColor3 = v357
        end
        if v355 then
            local v358 = v355:GetAttribute("_OrigColor")
            local v359 = v355:GetAttribute("_OrigTrans")
            if v358 then
                v355.ImageColor3 = v358
            end
            if v359 ~= nil then
                v355.ImageTransparency = v359
            end
        end
        if v356 then
            local v360 = v356:GetAttribute("_OrigColor")
            local v361 = v356:GetAttribute("_OrigTrans")
            if v360 then
                v356.TextColor3 = v360
            end
            if v361 ~= nil then
                v356.TextTransparency = v361
            end
        end
    end
end
local function v_u_379(p363, p364)
    -- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_25, (copy) v_u_14, (copy) v_u_27, (copy) v_u_23, (ref) v_u_51
    local v365 = v_u_7.Character
    if v365 then
        v365 = v_u_7.Character:FindFirstChild("HumanoidRootPart")
    end
    local v366
    if p363 then
        v366 = p363.PrimaryPart
    else
        v366 = p363
    end
    local v367
    if v365 and v366 then
        v367 = (v365.Position - v366.Position).Magnitude <= 45
    else
        v367 = false
    end
    if v367 then
        if p363:GetAttribute("CanPickup") then
            local v368 = p364 == "Pistols" and 2 or ((p364 == "Mid Tier" or p364 == "Rifles") and 1 or (p364 == "Grenades" and 4 or nil))
            if v368 then
                local v369 = v_u_8.getCurrentInventory()
                if v369 then
                    local v370 = v369[v368]
                    if v370 then
                        if p364 == "Grenades" then
                            local v371 = p363:GetAttribute("Weapon")
                            if #v370._items >= v370._settings._strict_slot_space then
                                return
                            end
                            if v_u_25[v371] then
                                local v372 = 0
                                for _, v373 in ipairs(v370._items) do
                                    if v373.Name == v371 then
                                        v372 = v372 + 1
                                    end
                                end
                                if v_u_25[v371] <= v372 then
                                    return
                                end
                            end
                        elseif #v370._items >= v370._settings._strict_slot_space then
                            local v374 = v_u_8.getCurrentEquipped()
                            local v375 = false
                            if v374 then
                                local v376 = v_u_14(v374.Name)
                                if v376 and (v_u_27[v376.Slot] == v368 and v374.drop) then
                                    v374:drop()
                                    v375 = true
                                end
                            end
                            if not v375 then
                                local v377 = v370._items[1]
                                if not (v377 and (v377.Properties and v377.Properties.Droppable)) then
                                    return
                                end
                                if v374 and v374.Identifier == v377.Identifier then
                                    v374:unequip()
                                end
                                v_u_23.Inventory.DropWeapon.Send({
                                    ["Direction"] = workspace.CurrentCamera.CFrame.LookVector,
                                    ["Identifier"] = v377.Identifier
                                })
                            end
                        end
                        if p364 ~= "Grenades" then
                            v_u_51 = v368
                        end
                        local v378 = {
                            ["Identity"] = p363.Name,
                            ["AllowAutoEquip"] = true
                        }
                        v_u_23.Inventory.PickupWeapon.Send(v378)
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_386(p380)
    -- upvalues: (copy) v_u_7
    local v381 = v_u_7.Character
    if v381 then
        v381 = v_u_7.Character:FindFirstChild("HumanoidRootPart")
    end
    if not v381 then
        return nil
    end
    local v382 = (1 / 0)
    local v383 = nil
    for v384 in pairs(p380.models) do
        if v384 and (v384.Parent and (v384.PrimaryPart and v384:GetAttribute("CanPickup"))) then
            local v385 = (v381.Position - v384.PrimaryPart.Position).Magnitude
            if v385 <= 45 and v385 < v382 then
                v383 = v384
                v382 = v385
            end
        end
    end
    return v383
end
local function v_u_390(p387)
    -- upvalues: (copy) v_u_7
    local v388 = v_u_7.Character
    if v388 then
        v388 = v_u_7.Character:FindFirstChild("HumanoidRootPart")
    end
    if not v388 then
        return false
    end
    for v389 in pairs(p387.models) do
        if v389 and (v389.Parent and (v389.PrimaryPart and (v388.Position - v389.PrimaryPart.Position).Magnitude <= 45)) then
            return true
        end
    end
    return false
end
local function v_u_402()
    -- upvalues: (copy) v_u_49, (copy) v_u_390, (copy) v_u_362
    for _, v391 in pairs(v_u_49) do
        if next(v391.models) then
            local v392 = v_u_390(v391)
            local v393 = v391.template:GetAttribute("_OutOfRange")
            if v392 or v393 then
                if v392 and v393 then
                    v391.template:SetAttribute("_OutOfRange", nil)
                    local v394 = v391.template
                    local v395 = v394:FindFirstChild("ImageLabel")
                    local v396 = v394:FindFirstChild("TextLabel")
                    local v397 = v394:GetAttribute("_OrigBG")
                    if v397 then
                        v394.BackgroundColor3 = v397
                    end
                    if v395 then
                        local v398 = v395:GetAttribute("_OrigColor")
                        local v399 = v395:GetAttribute("_OrigTrans")
                        if v398 then
                            v395.ImageColor3 = v398
                        end
                        if v399 ~= nil then
                            v395.ImageTransparency = v399
                        end
                    end
                    if v396 then
                        local v400 = v396:GetAttribute("_OrigColor")
                        local v401 = v396:GetAttribute("_OrigTrans")
                        if v400 then
                            v396.TextColor3 = v400
                        end
                        if v401 ~= nil then
                            v396.TextTransparency = v401
                        end
                    end
                end
            else
                v391.template:SetAttribute("_OutOfRange", true)
                v_u_362(v391.template, true)
            end
        end
    end
end
local function v_u_434(p403)
    -- upvalues: (copy) v_u_7, (copy) v_u_14, (copy) v_u_49, (copy) v_u_50, (ref) v_u_43, (copy) v_u_352, (copy) v_u_15, (copy) v_u_386, (copy) v_u_24, (copy) v_u_379, (copy) v_u_48
    if workspace:GetAttribute("Gamemode") == "Deathmatch" then
        return
    else
        local v404 = p403:GetAttribute("Weapon")
        if v404 then
            if p403:GetAttribute("DroppedByTeam") == v_u_7:GetAttribute("Team") then
                local v405 = v_u_14(v404)
                if v405 then
                    local v406 = v405.Slot
                    local v_u_407
                    if v406 == "Grenade" then
                        v_u_407 = "Grenades"
                    elseif v406 == "Secondary" then
                        v_u_407 = "Pistols"
                    elseif v406 == "Primary" then
                        local v408 = v405.Type
                        v_u_407 = (v408 == "SMG" or v408 == "Heavy") and "Mid Tier" or "Rifles"
                    else
                        v_u_407 = nil
                    end
                    if v_u_407 then
                        local v409 = v_u_407 .. "::" .. v404
                        local v410 = v_u_49[v409]
                        if v410 then
                            v410.models[p403] = true
                            v_u_50[p403] = v409
                            v410.template:SetAttribute("_OutOfRange", nil)
                            local v411 = v410.template
                            local v412 = v411:FindFirstChild("ImageLabel")
                            local v413 = v411:FindFirstChild("TextLabel")
                            local v414 = v411:GetAttribute("_OrigBG")
                            if v414 then
                                v411.BackgroundColor3 = v414
                            end
                            if v412 then
                                local v415 = v412:GetAttribute("_OrigColor")
                                local v416 = v412:GetAttribute("_OrigTrans")
                                if v415 then
                                    v412.ImageColor3 = v415
                                end
                                if v416 ~= nil then
                                    v412.ImageTransparency = v416
                                end
                            end
                            if v413 then
                                local v417 = v413:GetAttribute("_OrigColor")
                                local v418 = v413:GetAttribute("_OrigTrans")
                                if v417 then
                                    v413.TextColor3 = v417
                                end
                                if v418 ~= nil then
                                    v413.TextTransparency = v418
                                end
                            end
                            local v419 = v410.template:FindFirstChild("TextLabel")
                            if v419 then
                                local v420 = v410.models
                                local v421 = 0
                                for _ in pairs(v420) do
                                    v421 = v421 + 1
                                end
                                if v421 > 1 then
                                    v419.Text = ("x%* %*"):format(v421, v410.weaponName)
                                else
                                    v419.Text = v410.weaponName
                                end
                            end
                            local v422 = v410.template:FindFirstChild("ImageButton")
                            if v422 then
                                v422.Active = true
                            end
                            return
                        else
                            local v423 = v_u_43.Menu:FindFirstChild("Dropped")
                            if v423 then
                                local v424 = v423:FindFirstChild("Container")
                                if v424 then
                                    local v425 = v424:FindFirstChild(v_u_407)
                                    if v425 then
                                        if v_u_352(v425) >= 4 then
                                            return
                                        else
                                            local v426 = v424:FindFirstChild("Template")
                                            if v426 then
                                                local v427 = v426:Clone()
                                                v427.Name = v409
                                                v427.Visible = true
                                                v427.Parent = v425
                                                local v428 = v405.ReverseIcon or v405.Icon
                                                local v429 = v427:FindFirstChild("ImageLabel")
                                                local v430 = v427:FindFirstChild("TextLabel")
                                                local v431 = v427:FindFirstChild("ImageButton")
                                                if v429 then
                                                    v429.Image = v428
                                                    v429.ImageColor3 = v_u_15()
                                                end
                                                if v430 then
                                                    v430.Text = v404
                                                    v430.TextColor3 = v_u_15()
                                                end
                                                local v_u_432 = {
                                                    ["template"] = v427,
                                                    ["category"] = v_u_407,
                                                    ["weaponName"] = v404,
                                                    ["models"] = {
                                                        [p403] = true
                                                    }
                                                }
                                                v_u_49[v409] = v_u_432
                                                v_u_50[p403] = v409
                                                if v431 then
                                                    v_u_48:Add((v431.MouseButton1Click:Connect(function()
                                                        -- upvalues: (ref) v_u_386, (copy) v_u_432, (ref) v_u_24, (ref) v_u_379, (copy) v_u_407
                                                        local v433 = v_u_386(v_u_432)
                                                        if v433 then
                                                            v_u_24.broadcastRouter("RunInterfaceSound", "UI Click")
                                                            v_u_379(v433, v_u_407)
                                                        end
                                                    end)))
                                                end
                                            end
                                        end
                                    else
                                        return
                                    end
                                else
                                    return
                                end
                            else
                                return
                            end
                        end
                    else
                        return
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    end
end
local function v_u_442(p435)
    -- upvalues: (copy) v_u_50, (copy) v_u_49, (copy) v_u_362
    local v436 = v_u_50[p435]
    if v436 then
        v_u_50[p435] = nil
        local v437 = v_u_49[v436]
        if v437 then
            v437.models[p435] = nil
            if next(v437.models) then
                local v438 = v437.template:FindFirstChild("TextLabel")
                if not v438 then
                    return
                end
                local v439 = v437.models
                local v440 = 0
                for _ in pairs(v439) do
                    v440 = v440 + 1
                end
                if v440 > 1 then
                    v438.Text = ("x%* %*"):format(v440, v437.weaponName)
                    return
                end
                v438.Text = v437.weaponName
            else
                v437.template:SetAttribute("_OutOfRange", nil)
                v_u_362(v437.template, true)
                local v441 = v437.template:FindFirstChild("ImageButton")
                if v441 then
                    v441.Active = false
                    return
                end
            end
        end
    else
        return
    end
end
local function v_u_448()
    -- upvalues: (copy) v_u_49, (copy) v_u_50, (copy) v_u_48, (ref) v_u_43
    for _, v443 in pairs(v_u_49) do
        v443.template:Destroy()
    end
    table.clear(v_u_49)
    table.clear(v_u_50)
    v_u_48:Cleanup()
    local v444 = v_u_43 and v_u_43.Menu
    if v444 then
        v444 = v_u_43.Menu:FindFirstChild("Dropped")
    end
    if v444 then
        local v445 = v444:FindFirstChild("Container")
        if v445 then
            for _, v446 in ipairs(v445:GetChildren()) do
                if v446:IsA("Frame") and v446.Name ~= "Template" then
                    for _, v447 in ipairs(v446:GetChildren()) do
                        if v447:IsA("Frame") then
                            v447:Destroy()
                        end
                    end
                end
            end
        end
    else
        return
    end
end
function v_u_1.openFrame()
    -- upvalues: (copy) v_u_9, (copy) v_u_7, (copy) v_u_16, (ref) v_u_43, (copy) v_u_10, (ref) v_u_44, (ref) v_u_37, (copy) v_u_348, (copy) v_u_140, (copy) v_u_161
    if v_u_9.IsActive() then
        return
    else
        local v449 = v_u_7:GetAttribute("BuyMenu")
        if v_u_16(v_u_7) then
            if v449 and not v_u_43.Visible then
                v_u_10.setForceLockOverride("BuyMenu", true)
                v_u_10.setPerspective(true, true)
                v_u_44.Gameplay.Bottom.Health.Visible = false
                v_u_44.Gameplay.Bottom.Middle.Visible = false
                v_u_44.Gameplay.Bottom.Armor.Visible = false
                v_u_44.Gameplay.Bottom.Money.Visible = false
                v_u_44.Gameplay.Bottom.Ammo.Visible = false
                v_u_43.Visible = true
                v_u_37 = nil
                v_u_348()
                v_u_140()
                v_u_161()
            end
        else
            return
        end
    end
end
function v_u_1.closeFrame()
    -- upvalues: (ref) v_u_43, (copy) v_u_10, (ref) v_u_44, (copy) v_u_69, (ref) v_u_37
    if v_u_43.Visible then
        v_u_10.setForceLockOverride("BuyMenu", false)
        v_u_10.setPerspective(true, false)
        v_u_44.Gameplay.Bottom.Health.Visible = true
        v_u_44.Gameplay.Bottom.Middle.Visible = true
        v_u_44.Gameplay.Bottom.Armor.Visible = v_u_69().Health > 0
        v_u_44.Gameplay.Bottom.Money.Visible = true
        v_u_44.Gameplay.Bottom.Ammo.Visible = true
        v_u_43.Visible = false
        v_u_37 = nil
    end
end
function v_u_1.toggleFrame()
    -- upvalues: (copy) v_u_9, (copy) v_u_7, (ref) v_u_43, (copy) v_u_1
    if v_u_9.IsActive() then
        return
    elseif v_u_7:GetAttribute("BuyMenu") and not v_u_43.Visible then
        v_u_1.openFrame()
        return
    elseif v_u_43.Visible then
        v_u_1.closeFrame()
    end
end
function v_u_1.characterAdded(_)
    -- upvalues: (copy) v_u_165, (copy) v_u_7, (copy) v_u_31, (copy) v_u_346, (copy) v_u_99
    if v_u_165(v_u_7, "Money") then
        v_u_31:Cleanup()
        v_u_346()
        v_u_99()
    end
end
function v_u_1.characterRemoving(_)
    -- upvalues: (copy) v_u_32, (ref) v_u_38, (ref) v_u_35, (ref) v_u_36, (ref) v_u_37, (ref) v_u_39, (ref) v_u_40, (ref) v_u_41
    v_u_32:Cleanup()
    if v_u_38 then
        v_u_38:Destroy()
        v_u_38 = nil
    end
    if v_u_35 then
        v_u_35:Stop()
        v_u_35 = nil
    end
    v_u_36 = nil
    v_u_37 = nil
    v_u_39 = nil
    v_u_40 = nil
    v_u_41 = nil
end
function v_u_1.Initialize(p450, p451)
    -- upvalues: (ref) v_u_44, (ref) v_u_43, (copy) v_u_174, (copy) v_u_8, (copy) v_u_1, (copy) v_u_161, (copy) v_u_7, (copy) v_u_33, (copy) v_u_52, (copy) v_u_137, (copy) v_u_53, (copy) v_u_5, (copy) v_u_23, (copy) v_u_140, (copy) v_u_20, (copy) v_u_448, (ref) v_u_39, (copy) v_u_346, (copy) v_u_348, (copy) v_u_31, (copy) v_u_99, (copy) v_u_42, (ref) v_u_51, (copy) v_u_13, (copy) v_u_34, (copy) v_u_18, (copy) v_u_4, (copy) v_u_15, (copy) v_u_16, (copy) v_u_402, (copy) v_u_328, (copy) v_u_11, (copy) v_u_32, (copy) v_u_19, (copy) v_u_434, (copy) v_u_442, (copy) v_u_49
    v_u_44 = p450
    v_u_43 = p451
    v_u_174()
    local function v_u_454()
        -- upvalues: (ref) v_u_8, (ref) v_u_43, (ref) v_u_1, (ref) v_u_161
        local v452 = v_u_8.getCurrentInventory()
        for _, v453 in ipairs(v_u_43.Menu.Container:GetDescendants()) do
            if v453:IsA("TextButton") then
                v_u_1.updateBuyMenuTemplate(v452, v453)
            end
        end
        v_u_161()
    end
    local function v_u_457(p_u_455)
        -- upvalues: (ref) v_u_7, (ref) v_u_33, (ref) v_u_52, (ref) v_u_137, (ref) v_u_161
        if p_u_455 ~= v_u_7 then
            v_u_33:Add(p_u_455:GetAttributeChangedSignal("Team"):Connect(function()
                -- upvalues: (copy) p_u_455, (ref) v_u_7, (ref) v_u_52, (ref) v_u_137, (ref) v_u_161
                if p_u_455:GetAttribute("Team") ~= v_u_7:GetAttribute("Team") then
                    v_u_52[p_u_455] = nil
                end
                v_u_137(p_u_455)
                v_u_161()
            end))
            v_u_33:Add(p_u_455:GetAttributeChangedSignal("CompetitivePlayerColor"):Connect(function()
                -- upvalues: (ref) v_u_161
                v_u_161()
            end))
            v_u_33:Add(p_u_455:GetAttributeChangedSignal("Armor"):Connect(function()
                -- upvalues: (ref) v_u_161
                v_u_161()
            end))
            v_u_33:Add(p_u_455:GetAttributeChangedSignal("HasDefuseKit"):Connect(function()
                -- upvalues: (ref) v_u_161
                v_u_161()
            end))
            v_u_33:Add(p_u_455:GetAttributeChangedSignal("HasRescueKit"):Connect(function()
                -- upvalues: (ref) v_u_161
                v_u_161()
            end))
            for v456 = 1, 5 do
                v_u_33:Add(p_u_455:GetAttributeChangedSignal("Slot" .. v456):Connect(function()
                    -- upvalues: (ref) v_u_137, (copy) p_u_455, (ref) v_u_161
                    v_u_137(p_u_455)
                    v_u_161()
                end))
            end
        end
    end
    (function()
        -- upvalues: (ref) v_u_33, (ref) v_u_52, (ref) v_u_53, (ref) v_u_5, (copy) v_u_457, (ref) v_u_137, (ref) v_u_161, (ref) v_u_23, (ref) v_u_7, (ref) v_u_140
        v_u_33:Cleanup()
        table.clear(v_u_52)
        table.clear(v_u_53)
        v_u_33:Add(v_u_5.PlayerAdded:Connect(function(p458)
            -- upvalues: (ref) v_u_457, (ref) v_u_137, (ref) v_u_161
            v_u_457(p458)
            v_u_137(p458)
            v_u_161()
        end))
        v_u_33:Add(v_u_5.PlayerRemoving:Connect(function(p459)
            -- upvalues: (ref) v_u_52, (ref) v_u_53, (ref) v_u_161
            v_u_52[p459] = nil
            v_u_53[p459] = nil
            v_u_161()
        end))
        v_u_33:Add(v_u_23.Inventory.SpectatedPlayerInventory.Listen(function(p460)
            -- upvalues: (ref) v_u_7, (ref) v_u_52, (ref) v_u_53, (ref) v_u_161
            if p460.Player ~= v_u_7 then
                v_u_52[p460.Player] = p460.Inventory
                v_u_53[p460.Player] = nil
                v_u_161()
            end
        end))
        for _, v461 in ipairs(v_u_5:GetPlayers()) do
            v_u_457(v461)
        end
        v_u_140()
        v_u_161()
    end)()
    v_u_20.observeAttribute(v_u_7, "Team", function(_)
        -- upvalues: (ref) v_u_448, (ref) v_u_52, (ref) v_u_53, (ref) v_u_39, (ref) v_u_7, (ref) v_u_1, (ref) v_u_346, (ref) v_u_43, (ref) v_u_348, (ref) v_u_31, (ref) v_u_99, (copy) v_u_454, (ref) v_u_140
        v_u_448()
        table.clear(v_u_52)
        table.clear(v_u_53)
        if v_u_39 and v_u_7.Character then
            v_u_1.characterRemoving(v_u_7.Character)
        end
        if v_u_7.Character then
            v_u_346()
            if v_u_43.Visible then
                v_u_348()
            end
        end
        v_u_31:Cleanup()
        v_u_99()
        v_u_454()
        v_u_140()
    end)
    v_u_20.observeAttribute(workspace, "Gamemode", function()
        -- upvalues: (ref) v_u_31, (ref) v_u_99, (copy) v_u_454, (ref) v_u_140
        v_u_31:Cleanup()
        v_u_99()
        v_u_454()
        v_u_140()
    end)
    v_u_20.observeAttribute(workspace, "ServerGamemode", function()
        -- upvalues: (ref) v_u_52, (ref) v_u_53, (ref) v_u_31, (ref) v_u_99, (copy) v_u_454, (ref) v_u_140
        table.clear(v_u_52)
        table.clear(v_u_53)
        v_u_31:Cleanup()
        v_u_99()
        v_u_454()
        v_u_140()
    end)
    v_u_23.Inventory.NewInventoryItem.Listen(function(p462)
        -- upvalues: (ref) v_u_42, (ref) v_u_51, (ref) v_u_8
        local v463 = v_u_42
        local v464 = p462.identifier
        table.insert(v463, v464)
        if v_u_51 then
            local v_u_465 = v_u_51
            v_u_51 = nil
            task.defer(function()
                -- upvalues: (ref) v_u_8, (copy) v_u_465
                v_u_8.equip(v_u_465, 1)
            end)
        end
    end)
    v_u_23.Inventory.RemoveInventoryItem.Listen(function(p_u_466)
        -- upvalues: (ref) v_u_13, (ref) v_u_42
        v_u_13(v_u_42, function(_, p467)
            -- upvalues: (copy) p_u_466
            return p467 == p_u_466
        end)
    end)
    v_u_20.observeAttribute(v_u_7, "MinimumNextRoundIncome", function(p468)
        -- upvalues: (ref) v_u_43
        v_u_43.Menu.TopFrame.NextRoundMoney.Text = "Next Round Minimum:  $" .. tostring(p468):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end)
    v_u_20.observeAttribute(v_u_7, "Money", function(p469)
        -- upvalues: (ref) v_u_34, (copy) v_u_454
        v_u_34:setGoal(p469)
        v_u_454()
    end)
    v_u_20.observeAttribute(v_u_7, "Armor", function()
        -- upvalues: (copy) v_u_454
        v_u_454()
    end)
    v_u_20.observeAttribute(v_u_7, "HasDefuseKit", function()
        -- upvalues: (copy) v_u_454
        v_u_454()
    end)
    v_u_20.observeAttribute(v_u_7, "HasRescueKit", function()
        -- upvalues: (copy) v_u_454
        v_u_454()
    end)
    v_u_20.observeAttribute(workspace, "VIPInfiniteCashEnabled", function()
        -- upvalues: (copy) v_u_454
        v_u_454()
    end)
    v_u_20.observeAttribute(v_u_7, "BuyMenu", function(_)
        -- upvalues: (ref) v_u_1
        return function()
            -- upvalues: (ref) v_u_1
            v_u_1.closeFrame()
        end
    end)
    v_u_20.observeAttribute(workspace, "Timer", function()
        -- upvalues: (ref) v_u_174
        v_u_174()
    end)
    v_u_20.observeAttribute(workspace, "BuyTimerRemaining", function()
        -- upvalues: (ref) v_u_174
        v_u_174()
    end)
    v_u_18.ListenToState(function(_, p470)
        -- upvalues: (ref) v_u_42, (ref) v_u_174
        if p470 == "Buy Period" then
            table.clear(v_u_42)
        end
        v_u_174()
    end)
    v_u_4.Heartbeat:Connect(function(p471)
        -- upvalues: (ref) v_u_34, (ref) v_u_43, (ref) v_u_15, (ref) v_u_16, (ref) v_u_7, (ref) v_u_1, (ref) v_u_402
        local v472 = v_u_34:getPosition()
        local v473 = math.round(v472)
        local v474 = tostring(v473):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        v_u_43.Menu.TopFrame.Money.TextColor3 = v_u_15()
        v_u_43.Menu.TopFrame.Money.Text = "$" .. v474
        v_u_34:update(p471)
        if v_u_43.Visible and not v_u_16(v_u_7) then
            local v475 = workspace:GetAttribute("Gamemode")
            if v475 == "Bomb Defusal" or v475 == "Hostage Rescue" then
                v_u_1.closeFrame()
                return
            end
        end
        v_u_402()
    end)
    v_u_8.OnInventoryChanged:Connect(function(p476)
        -- upvalues: (ref) v_u_43, (ref) v_u_1, (ref) v_u_328
        for _, v477 in ipairs(v_u_43.Menu.Container:GetDescendants()) do
            if v477:IsA("TextButton") then
                v_u_1.updateBuyMenuTemplate(p476, v477)
            end
        end
        if v_u_43.Visible then
            task.defer(v_u_328)
        end
    end)
    v_u_11.CreateListener(v_u_7, "Settings.Game.HUD.Color", function()
        -- upvalues: (copy) v_u_454
        v_u_454()
    end)
    v_u_11.CreateListener(v_u_7, "Loadout", function()
        -- upvalues: (ref) v_u_7, (ref) v_u_31, (ref) v_u_32, (ref) v_u_99, (copy) v_u_454
        if v_u_7.Character then
            v_u_31:Cleanup()
            v_u_32:Cleanup()
            v_u_99()
            v_u_454()
        end
    end)
    v_u_19:GetInstanceAddedSignal("WeaponDropped"):Connect(function(p478)
        -- upvalues: (ref) v_u_434
        if p478:IsA("Model") then
            v_u_434(p478)
        end
    end)
    v_u_19:GetInstanceRemovedSignal("WeaponDropped"):Connect(function(p479)
        -- upvalues: (ref) v_u_442
        if p479:IsA("Model") then
            v_u_442(p479)
        end
    end)
    for _, v480 in ipairs(v_u_19:GetTagged("WeaponDropped")) do
        if v480:IsA("Model") then
            task.spawn(v_u_434, v480)
        end
    end
    v_u_20.observeAttribute(workspace, "Gamemode", function()
        -- upvalues: (ref) v_u_43, (ref) v_u_448
        local v481 = v_u_43 and v_u_43.Menu
        if v481 then
            v481 = v_u_43.Menu:FindFirstChild("Dropped")
        end
        if v481 then
            v481.Visible = workspace:GetAttribute("Gamemode") ~= "Deathmatch"
        end
        v_u_448()
    end)
    local v482 = v_u_43 and v_u_43.Menu
    if v482 then
        v482 = v_u_43.Menu:FindFirstChild("Dropped")
    end
    if v482 then
        v482.Visible = workspace:GetAttribute("Gamemode") ~= "Deathmatch"
    end
    v_u_18.ListenToState(function(_, p483)
        -- upvalues: (ref) v_u_448
        if p483 == "Buy Period" then
            v_u_448()
        end
    end)
    v_u_11.CreateListener(v_u_7, "Settings.Game.HUD.Color", function()
        -- upvalues: (ref) v_u_49, (ref) v_u_15
        for _, v484 in pairs(v_u_49) do
            local v485 = v484.template
            local v486 = v485:FindFirstChild("ImageLabel")
            local v487 = v485:FindFirstChild("TextLabel")
            if not v485:GetAttribute("_OrigBG") then
                if v486 then
                    v486.ImageColor3 = v_u_15()
                end
                if v487 then
                    v487.TextColor3 = v_u_15()
                end
            end
        end
    end)
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_7, (copy) v_u_1
    if v_u_7.Character then
        v_u_1.characterAdded(v_u_7.Character)
    end
    v_u_7.CharacterAdded:Connect(function(p488)
        -- upvalues: (ref) v_u_1
        v_u_1.characterAdded(p488)
    end)
    v_u_7.CharacterRemoving:Connect(function(p489)
        -- upvalues: (ref) v_u_1
        v_u_1.characterRemoving(p489)
    end)
end
return v_u_1
