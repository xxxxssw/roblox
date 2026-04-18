-- MODULESCRIPT: Loadout
-- Original Path: game.BAC - 29052.Interface.Screens.Menu.Loadout
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("ContentProvider")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("GamepadService")
local v_u_6 = game:GetService("TweenService")
local v_u_7 = game:GetService("RunService")
local v_u_8 = game:GetService("GuiService")
local v9 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_10 = v9.LocalPlayer
local v_u_11 = v_u_10:WaitForChild("PlayerGui")
local v_u_12 = require(v_u_2.Controllers.DataController)
local v_u_13 = require(v_u_2.Database.Security.Router)
local v14 = require(v_u_2.Database.Components.Libraries.Collections)
local v_u_15 = require(v_u_2.Database.Components.Libraries.Skins)
require(v_u_2.Database.Components.Libraries.Cases)
local v_u_16 = require(v_u_2.Database.Security.Remotes)
local v_u_17 = require(v_u_2.Interface.MenuState)
local v_u_18 = require(v_u_2.Database.Custom.GameStats.UI.Inventory.WeaponDropShadows)
local v_u_19 = require(v_u_2.Database.Custom.GameStats.UI.Inventory.Sort)
local v_u_20 = require(v_u_2.Components.Common.GetSkinDisplayName)
local v_u_21 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_22 = require(v_u_2.Components.Common.GetResolvedSkinInformation)
local v_u_23 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_24 = v_u_2.Assets.Characters
local v_u_25 = require(v_u_2.Database.Custom.GameStats.Character.Attachments)
local v_u_26 = require(v_u_2.Database.Custom.GameStats.Character.Viewport)
local v_u_27 = require(v_u_2.Database.Components.Common.AttachGlovesToCharacter)
local v_u_28 = "Counter-Terrorists"
local v_u_29 = nil
local v_u_30 = "Newest"
local v_u_31 = false
local v_u_32 = nil
local v_u_33 = nil
local v_u_34 = false
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = nil
local v_u_41 = nil
local v_u_42 = nil
local v_u_43 = false
local v_u_44 = nil
local v_u_45 = false
local v_u_46 = nil
local v_u_47 = nil
local v_u_48 = nil
local v_u_49 = false
local v_u_50 = false
local v_u_51 = false
local v_u_52 = false
local v_u_53 = nil
local v_u_54 = nil
local v_u_55 = nil
local v_u_56 = nil
local function v_u_64(p57, p58)
    -- upvalues: (copy) v_u_12, (copy) v_u_10
    local v59 = v_u_12.Get(v_u_10, "Loadout")
    if not v59 then
        return false
    end
    local v60 = v59[p58]
    if not v60 then
        return false
    end
    if v60.Loadout then
        for _, v61 in pairs(v60.Loadout) do
            if v61 and v61.Options then
                for _, v62 in ipairs(v61.Options) do
                    if v62 == p57 then
                        return true
                    end
                end
            end
        end
    end
    if v60.Equipped then
        for _, v63 in pairs(v60.Equipped) do
            if v63 == p57 then
                return true
            end
        end
    end
    return false
end
local function v_u_72(p65, p66)
    -- upvalues: (copy) v_u_64
    local v67 = p65:FindFirstChild("Status")
    if v67 then
        local v68 = v67:FindFirstChild("Counter-Terrorists")
        local v69 = v67:FindFirstChild("Terrorists")
        if v68 and v69 then
            local v70 = v_u_64(p66, "Counter-Terrorists")
            local v71 = v_u_64(p66, "Terrorists")
            v68.Visible = v70
            v69.Visible = v71
        end
    end
end
local v_u_73 = {}
local v_u_74 = {
    ["CT"] = nil,
    ["T"] = nil
}
local v_u_75 = {
    ["CT"] = nil,
    ["T"] = nil
}
local v_u_76 = {
    ["CT"] = {},
    ["T"] = {}
}
local v_u_77 = {}
local v_u_78 = {
    ["CT"] = nil,
    ["T"] = nil
}
local v_u_79 = {}
local v_u_80 = 0
local v_u_81 = false
local v_u_82 = false
local v_u_83 = UDim2.fromScale(0.2, 0.2)
local v_u_84 = Vector2.new(0, 0)
local v_u_85 = {
    ["Pistol"] = "Pistols",
    ["SMG"] = "Mid Tier",
    ["Heavy"] = "Mid Tier",
    ["Rifle"] = "Rifles"
}
local v_u_86 = {
    ["Incendiary Grenade"] = true,
    ["Decoy Grenade"] = true,
    ["Smoke Grenade"] = true,
    ["HE Grenade"] = true,
    ["Flashbang"] = true,
    ["Molotov"] = true
}
local v_u_87 = {
    ["Charm"] = true,
    ["Charm Capsule"] = true,
    ["Sticker"] = true,
    ["Sticker Capsule"] = true,
    ["Grenade"] = true,
    ["Case"] = true,
    ["Package"] = true
}
local v_u_88 = {
    ["Pistol"] = 1,
    ["SMG"] = 2,
    ["Heavy"] = 3,
    ["Rifle"] = 4,
    ["Equipment"] = 5,
    ["Miscellaneous"] = 6
}
local v_u_89 = {
    ["Glove"] = "Equipped Gloves",
    ["Melee"] = "Equipped Melee",
    ["Zeus x27"] = "Equipped Zeus x27",
    ["Badge"] = "Equipped Badge",
    ["Music Kit"] = "Equipped Music Kit",
    ["Graffiti"] = "Equipped Graffiti"
}
local v_u_90 = {
    ["Equipped Gloves"] = "Gloves",
    ["Equipped Melee"] = "Melee",
    ["Equipped Zeus x27"] = "Zeus",
    ["Equipped Badge"] = "Badge",
    ["Equipped Music Kit"] = "Music Kit",
    ["Equipped Graffiti"] = "Graffiti"
}
local v_u_91 = { "Melee", "Gloves", "Zeus" }
local v_u_92 = {
    ["Terrorists"] = { "Glock-18" },
    ["Counter-Terrorists"] = { "USP-S", "P2000" }
}
local v_u_93 = nil
local function v_u_97(p94, p95)
    for _, v96 in ipairs(p94:GetChildren()) do
        if not table.find(p95, v96.Name) then
            v96:Destroy()
        end
    end
end
local function v_u_102(p98, p99, p100, p101)
    if p98 == nil then
        return nil
    else
        return p99 == "SniperScope" and "Sniper" or (p98 == "Heavy" and (p100 == "MachineGun" and "LMG" or "Heavy") or (p98 == "Equipment" and p101 == "Grenade" and "Grenade" or ({
            ["Pistol"] = "Pistol",
            ["Rifle"] = "Rifle",
            ["SMG"] = "SMG",
            ["Equipment"] = nil,
            ["Miscellaneous"] = nil
        })[p98]))
    end
end
local function v_u_105()
    -- upvalues: (ref) v_u_54, (ref) v_u_93, (copy) v_u_13
    if v_u_54 then
        local v103 = v_u_54
        local v104 = v_u_93.ActionFrame
        if v104 then
            v104.Visible = false
        end
        v_u_54 = nil
        v_u_13.broadcastRouter("WeaponInspect", v103.Name, v103.Skin, v103.Float, v103.StatTrack, v103.NameTag, v103.Charm, v103.Stickers, v103.Type, v103.Pattern, v103._id, v103.Serial, v103.IsTradeable)
    end
end
local _ = {
    ["Pistols"] = 1,
    ["Mid Tier"] = 2,
    ["Rifles"] = 3
}
local _ = {
    ["Equipped Melee"] = 1,
    ["Equipped Gloves"] = 2,
    ["Equipped Badge"] = 3,
    ["Equipped Music Kit"] = 4,
    ["Equipped Graffiti"] = 5,
    ["Equipped Zeus x27"] = 6
}
local v_u_106 = nil
v14.ObserveAvailableCollections(function(p107)
    -- upvalues: (ref) v_u_106
    v_u_106 = p107
end)
local function v_u_152()
    -- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_19, (ref) v_u_30, (ref) v_u_106, (copy) v_u_87, (copy) v_u_86, (copy) v_u_89, (copy) v_u_21, (ref) v_u_28, (ref) v_u_29, (ref) v_u_32, (ref) v_u_33, (ref) v_u_31
    local v108 = v_u_12.Get(v_u_10, "Inventory")
    if not v108 then
        return {}
    end
    local v_u_109 = v_u_19.GetSortComparisonFunction(v_u_30, v_u_10, function()
        -- upvalues: (ref) v_u_106
        return v_u_106
    end)
    local v110 = {}
    local v111 = {}
    for _, v112 in ipairs(v108) do
        if v112 and (v112._id and (not v110[v112._id] and (not v_u_87[v112.Type] and (not v_u_86[v112.Name] and v112.Name)))) then
            local v113 = v112.Name
            if type(v113) == "string" then
                if v_u_89[v112.Type] ~= nil then
                    local v114, v115 = pcall(v_u_21, v112.Name)
                    local v116 = not (v114 and (v115 and v115.Team))
                    local v117 = v112.Name
                    local v118 = v_u_28
                    local v119
                    if v117 and (type(v117) == "string" and v117 ~= "") then
                        local v120, v121 = pcall(v_u_21, v117)
                        if v120 and (v121 and v121.Team) then
                            v119 = v121.Team == "Both" and true or v121.Team == v118
                        else
                            v119 = false
                        end
                    else
                        v119 = false
                    end
                    if v116 or v119 then
                        v110[v112._id] = true
                        table.insert(v111, v112)
                    end
                else
                    local v122 = v112.Name
                    local v123 = v_u_28
                    local v124
                    if v122 and (type(v122) == "string" and v122 ~= "") then
                        local v125, v126 = pcall(v_u_21, v122)
                        if v125 and (v126 and v126.Team) then
                            v124 = v126.Team == "Both" and true or v126.Team == v123
                        else
                            v124 = false
                        end
                    else
                        v124 = false
                    end
                    if v124 then
                        v110[v112._id] = true
                        table.insert(v111, v112)
                    else
                        local v127, v128 = pcall(v_u_21, v112.Name)
                        if not (v127 and (v128 and v128.Team)) then
                            v110[v112._id] = true
                            table.insert(v111, v112)
                        end
                    end
                end
            end
        end
    end
    if v_u_29 then
        v111 = {}
        for _, v129 in ipairs(v111) do
            if v129.Type ~= "Case" and (v129.Type ~= "Package" and (v129.Type ~= "Charm Capsule" and (v129.Type ~= "Sticker Capsule" and v129.Name))) then
                local v130 = v129.Name
                if type(v130) == "string" then
                    local v131, v132 = pcall(v_u_21, v129.Name)
                    if v131 and (v132 and v132.Type == v_u_29) then
                        table.insert(v111, v129)
                    end
                end
            end
        end
    end
    if v_u_32 then
        local v133 = v_u_32.sidebarName
        local v134 = v133 == "Melee" and "Melee" or (v133 == "Gloves" and "Glove" or "Zeus x27")
        local v135 = v_u_32.sidebarName
        local v136 = v135 == "Melee" and "Melee" or (v135 == "Gloves" and "Glove" or nil)
        local v137 = v_u_32.teamKey == "CT" and "Counter-Terrorists" or "Terrorists"
        v111 = {}
        for _, v138 in ipairs(v111) do
            if v138.Type == v134 then
                local v139, v140 = pcall(v_u_21, v138.Name)
                if not v136 or (not v139 or (not v140 or (not v140.Class or v140.Class == v136))) then
                    local v141 = v138.Name
                    if v137 == "Counter-Terrorists" then
                        if v141 ~= "T Knife" and v141 ~= "T Gloves" then
                            ::l97::
                            local v142 = not (v139 and (v140 and v140.Team))
                            local v143 = v138.Name
                            local v144
                            if v143 and (type(v143) == "string" and v143 ~= "") then
                                local v145, v146 = pcall(v_u_21, v143)
                                if v145 and (v146 and v146.Team) then
                                    v144 = v146.Team == "Both" and true or v146.Team == v137
                                else
                                    v144 = false
                                end
                            else
                                v144 = false
                            end
                            if v142 or v144 then
                                table.insert(v111, v138)
                            end
                        end
                    elseif v137 ~= "Terrorists" or v141 ~= "CT Knife" and v141 ~= "CT Gloves" then
                        goto l97
                    end
                end
            end
        end
    end
    if v_u_33 then
        v111 = {}
        for _, v147 in ipairs(v111) do
            if v147.Name == v_u_33.weaponName and (v_u_33.skinName == nil and true or v147.Skin == v_u_33.skinName) then
                table.insert(v111, v147)
            end
        end
    end
    if v_u_109 then
        if v_u_31 then
            table.sort(v111, function(p148, p149)
                -- upvalues: (copy) v_u_109
                local v150, v151 = v_u_109(p148, p149)
                if v151 then
                    return v150
                else
                    return v_u_109(p149, p148)
                end
            end)
            return v111
        end
        table.sort(v111, v_u_109)
    end
    return v111
end
local function v_u_163()
    -- upvalues: (ref) v_u_93, (ref) v_u_80, (ref) v_u_79, (copy) v_u_1
    if not v_u_93 then
        return
    end
    local v153 = v_u_93.Tabs.Container.Container
    local v154 = v_u_80 + 1
    local v155 = v_u_80 + 25
    local v156 = #v_u_79
    local v157 = math.min(v155, v156)
    for v158 = v154, v157 do
        local v159 = v_u_79[v158]
        if v159 and not v153:FindFirstChild(v159._id) then
            v_u_1.CreateItemTemplate(v159)
        end
    end
    v_u_80 = v157
    for _, v160 in ipairs(v153:GetChildren()) do
        if v160:IsA("Frame") and (v160.Name ~= "UIGridLayout" and (v160.Name ~= "UIListLayout" and v160.Name ~= "UIPadding")) then
            for v161, v162 in ipairs(v_u_79) do
                if v162._id == v160.Name then
                    v160.LayoutOrder = v161
                    break
                end
            end
        end
    end
end
local function v_u_167()
    -- upvalues: (ref) v_u_93, (ref) v_u_80, (ref) v_u_79, (copy) v_u_163
    if v_u_93 then
        local v164 = v_u_93.Tabs.Container.Container
        local v165 = v164.CanvasPosition.Y
        local v166 = v164.AbsoluteCanvasSize.Y - v164.AbsoluteSize.Y
        if v166 > 0 and (v_u_80 < #v_u_79 and v166 - v165 < 200) then
            v_u_163()
        end
    else
        return
    end
end
local function v_u_194()
    -- upvalues: (ref) v_u_93
    if not (v_u_93 and v_u_93.Visible) then
        return 50
    end
    local v168 = v_u_93.Tabs.Container.Container
    local v169 = v168:FindFirstChildOfClass("UIGridLayout")
    if not v169 then
        return 50
    end
    local v170 = v168.AbsoluteSize
    local v171 = v170.Y
    local v172 = v170.X
    local v173 = v169.CellSize
    local v174 = v169.CellPadding
    local v175 = v173.Y.Scale * v171 + v173.Y.Offset
    local v176 = v174.Y.Scale * v171 + v174.Y.Offset
    local v177 = v173.X.Scale * v172 + v173.X.Offset
    local v178 = v174.X.Scale * v172 + v174.X.Offset
    local v179 = v168:FindFirstChildOfClass("UIPadding")
    local v180, v181, v182, v183
    if v179 then
        v180 = v179.PaddingTop.Scale * v171 + v179.PaddingTop.Offset
        v181 = v179.PaddingBottom.Scale * v171 + v179.PaddingBottom.Offset
        v182 = v179.PaddingLeft.Scale * v172 + v179.PaddingLeft.Offset
        v183 = v179.PaddingRight.Scale * v172 + v179.PaddingRight.Offset
    else
        v180 = 0
        v181 = 0
        v182 = 0
        v183 = 0
    end
    local v184 = v171 - v180 - v181
    local v185 = v172 - v182 - v183
    local v186 = v177 + v178
    local v187
    if v186 > 0 then
        local v188 = (v185 + v178) / v186
        local v189 = math.floor(v188)
        v187 = math.max(1, v189)
    else
        v187 = 1
    end
    local v190 = v175 + v176
    local v191
    if v190 > 0 then
        local v192 = (v184 + v176) / v190
        local v193 = math.floor(v192)
        v191 = math.max(1, v193)
    else
        v191 = 1
    end
    return v191 * v187 + v187
end
local function v_u_205()
    -- upvalues: (ref) v_u_93, (ref) v_u_80, (copy) v_u_194, (ref) v_u_79, (copy) v_u_1, (ref) v_u_81
    if not (v_u_93 and v_u_93.Visible) then
        return
    end
    local v195 = v_u_93.Tabs.Container.Container
    v_u_80 = 0
    local v196 = v_u_194()
    local v197 = math.max(v196, 50)
    local v198 = #v_u_79
    local v199 = math.min(v197, v198)
    for v200 = 1, v199 do
        local v201 = v_u_79[v200]
        if v201 and not v195:FindFirstChild(v201._id) then
            v_u_1.CreateItemTemplate(v201)
        end
    end
    for _, v202 in ipairs(v195:GetChildren()) do
        if v202:IsA("Frame") and (v202.Name ~= "UIGridLayout" and (v202.Name ~= "UIListLayout" and v202.Name ~= "UIPadding")) then
            for v203, v204 in ipairs(v_u_79) do
                if v204._id == v202.Name then
                    v202.LayoutOrder = v203
                    break
                end
            end
        end
    end
    v_u_80 = v199
    v_u_81 = false
end
local function v_u_210()
    -- upvalues: (ref) v_u_93, (ref) v_u_79, (ref) v_u_80, (ref) v_u_81, (copy) v_u_205
    if v_u_93 then
        local v206 = v_u_93.Tabs.Container.Container
        local v207 = {}
        for _, v208 in ipairs(v_u_79) do
            if v208 and v208._id then
                v207[v208._id] = true
            end
        end
        for _, v209 in ipairs(v206:GetChildren()) do
            if v209:IsA("Frame") and (v209.Name ~= "UIGridLayout" and (v209.Name ~= "UIPadding" and not v207[v209.Name])) then
                v209:Destroy()
            end
        end
        v_u_80 = 0
        v_u_81 = true
        if v_u_93.Visible then
            v_u_205()
        end
    end
end
local function v_u_213(p211, p212)
    -- upvalues: (copy) v_u_6
    v_u_6:Create(p211, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["BackgroundTransparency"] = p212 and 0.85 or 1
    }):Play()
end
local function v_u_219(p214, p215)
    -- upvalues: (copy) v_u_6
    local v216 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v217 = p215 and 0 or 1
    for _, v218 in ipairs(p214:GetChildren()) do
        if v218:IsA("Frame") and (v218:FindFirstChild("Price") and v218:FindFirstChild("WeaponName")) then
            v_u_6:Create(v218:FindFirstChild("Price"), v216, {
                ["TextTransparency"] = v217
            }):Play()
            v_u_6:Create(v218:FindFirstChild("WeaponName"), v216, {
                ["TextTransparency"] = v217
            }):Play()
        end
    end
end
local function v_u_225(p220, p221)
    for _, v222 in ipairs(p220:GetChildren()) do
        if v222:IsA("TextButton") then
            local v223 = v222:FindFirstChild("Frame")
            if v223 then
                local v224 = v222.Name == p221
                v223.BackgroundTransparency = v224 and 0 or 1
                if v224 then
                    v223.BackgroundColor3 = Color3.fromRGB(53, 83, 99)
                end
            end
        end
    end
end
local function v_u_235(p226, p227, p228, p229, p230)
    -- upvalues: (copy) v_u_2, (copy) v_u_213
    local v231 = v_u_2.Assets.UI.Loadout:FindFirstChild("SortingTemplate")
    if not v231 then
        return nil
    end
    local v_u_232 = v231:Clone()
    v_u_232.Name = p227
    v_u_232.LayoutOrder = p229
    v_u_232.Parent = p226
    local v233 = v_u_232:FindFirstChild("Frame")
    if v233 then
        local v234 = v233:FindFirstChild("TextButton")
        if v234 then
            v234.Text = p228
        end
        v233.BackgroundTransparency = 1
        v233.Active = false
    end
    v_u_232.MouseEnter:Connect(function()
        -- upvalues: (ref) v_u_213, (copy) v_u_232
        v_u_213(v_u_232, true)
    end)
    v_u_232.MouseLeave:Connect(function()
        -- upvalues: (ref) v_u_213, (copy) v_u_232
        v_u_213(v_u_232, false)
    end)
    v_u_232.MouseButton1Click:Connect(p230)
    return v_u_232
end
local function v_u_238(p236)
    for _, v237 in ipairs(p236:GetChildren()) do
        if v237:IsA("TextButton") then
            v237:Destroy()
        end
    end
end
local function v_u_248()
    -- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_87, (copy) v_u_86, (copy) v_u_21, (copy) v_u_88
    local v239 = v_u_12.Get(v_u_10, "Inventory")
    if not v239 then
        return {}
    end
    local v240 = {}
    for _, v241 in ipairs(v239) do
        if not (v_u_87[v241.Type] or v_u_86[v241.Name]) then
            local v242, v243 = pcall(v_u_21, v241.Name)
            if v242 and (v243 and v243.Type) then
                v240[v243.Type] = true
            end
        end
    end
    local v244 = {}
    for v245 in pairs(v240) do
        table.insert(v244, v245)
    end
    table.sort(v244, function(p246, p247)
        -- upvalues: (ref) v_u_88
        return (v_u_88[p246] or 99) < (v_u_88[p247] or 99)
    end)
    return v244
end
local function v_u_257(p249)
    -- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_87, (copy) v_u_86, (copy) v_u_21
    local v250 = v_u_12.Get(v_u_10, "Inventory")
    if not v250 then
        return {}
    end
    local v251 = {}
    for _, v252 in ipairs(v250) do
        if not (v_u_87[v252.Type] or v_u_86[v252.Name]) then
            local v253, v254 = pcall(v_u_21, v252.Name)
            if v253 and (v254 and (not p249 or v254.Type == p249)) then
                v251[v252.Name] = true
            end
        end
    end
    local v255 = {}
    for v256 in pairs(v251) do
        table.insert(v255, v256)
    end
    table.sort(v255)
    return v255
end
local function v_u_262(p258)
    -- upvalues: (copy) v_u_11
    local v259 = v_u_11:GetGuiObjectsAtPosition(p258.X, p258.Y)
    for _, v260 in ipairs(v259) do
        if v260.Name ~= "DragIcon" and (v260:IsA("ViewportFrame") and v260.Name == "Player") then
            local v261 = v260.Parent
            if v261 and (v261.Name == "CT" or v261.Name == "T") then
                return true
            end
        end
    end
    return false
end
local function v_u_267(p263)
    -- upvalues: (copy) v_u_22, (copy) v_u_15, (copy) v_u_83
    local v264 = v_u_22(p263.Name, p263.Skin)
    if not v264 then
        return nil
    end
    local v265 = v_u_15.GetWearImageForFloat(v264, p263.Float or 0.9999) or v264.imageAssetId or ""
    local v266 = Instance.new("ImageLabel")
    v266.Name = "DragIcon"
    v266.Size = v_u_83
    v266.AnchorPoint = Vector2.new(0.5, 0.5)
    v266.BackgroundTransparency = 1
    v266.Image = v265
    v266.ScaleType = Enum.ScaleType.Fit
    v266.ZIndex = 100
    v266.Active = false
    return v266
end
local function v_u_279(p268, p269)
    -- upvalues: (ref) v_u_93, (ref) v_u_28, (copy) v_u_92
    local v270 = v_u_93.Teams
    local v271 = (v_u_28 == "Counter-Terrorists" and v270.GunsCT or v270.GunsT):FindFirstChild(p268)
    if v271 then
        local v272 = 0
        for _, v273 in ipairs(v271:GetChildren()) do
            if v273:IsA("Frame") and (v273.Name ~= "Frame" and v273:FindFirstChild("Button")) then
                v272 = v272 + 1
                local v274
                if p268 == "Pistols" and (v272 == 1 and p269) then
                    local v275 = v_u_92[v_u_28]
                    if v275 then
                        v274 = table.find(v275, p269) ~= nil
                    else
                        v274 = false
                    end
                else
                    v274 = true
                end
                local v276 = v273:FindFirstChild("MoveFrame")
                if v276 and v276:IsA("GuiObject") then
                    v276.Visible = v274
                end
                if v274 then
                    local v277 = v273:FindFirstChild("Weapon")
                    if v277 then
                        local v278 = v277:FindFirstChild("Icon")
                        if v278 then
                            v278.Size = UDim2.fromScale(0.9, 0.85)
                        end
                    end
                end
            end
        end
    end
end
local function v_u_283()
    -- upvalues: (ref) v_u_93, (ref) v_u_28
    local v280 = v_u_93.Teams:FindFirstChild(v_u_28 == "Counter-Terrorists" and "CT" or "T")
    local v281 = v280 and v280:FindFirstChild("Player")
    if v281 then
        local v282 = v281:FindFirstChild("MoveFrame")
        if v282 and v282:IsA("GuiObject") then
            v282.Visible = true
        end
    end
end
local function v_u_296()
    -- upvalues: (ref) v_u_93
    local v284 = v_u_93.Teams
    for _, v285 in ipairs({ v284.GunsCT, v284.GunsT }) do
        for _, v286 in ipairs({ "Mid Tier", "Pistols", "Rifles" }) do
            local v287 = v285:FindFirstChild(v286)
            if v287 then
                for _, v288 in ipairs(v287:GetChildren()) do
                    if v288:IsA("Frame") and v288.Name ~= "Frame" then
                        local v289 = v288:FindFirstChild("MoveFrame")
                        if v289 and v289:IsA("GuiObject") then
                            v289.Visible = false
                        end
                        local v290 = v288:FindFirstChild("Weapon")
                        if v290 then
                            local v291 = v290:FindFirstChild("Icon")
                            if v291 then
                                v291.Size = UDim2.fromScale(1, 0.95)
                            end
                        end
                    end
                end
            end
        end
    end
    for _, v292 in ipairs({ "CT", "T" }) do
        local v293 = v284:FindFirstChild(v292)
        if v293 then
            local v294 = v293:FindFirstChild("Player")
            if v294 then
                local v295 = v294:FindFirstChild("MoveFrame")
                if v295 and v295:IsA("GuiObject") then
                    v295.Visible = false
                end
            end
        end
    end
end
local function v_u_303(p297)
    local v298 = p297.Parent
    if not (v298 and v298:IsA("Frame")) then
        return nil, nil
    end
    local v299 = v298.Parent
    if not (v299 and v299:IsA("Frame")) then
        return nil, nil
    end
    local v300 = v299.Name
    if v300 ~= "Mid Tier" and (v300 ~= "Pistols" and v300 ~= "Rifles") then
        return nil, nil
    end
    local v301 = 0
    for _, v302 in ipairs(v299:GetChildren()) do
        if v302:IsA("Frame") and (v302.Name ~= "Frame" and v302:FindFirstChild("Button")) then
            v301 = v301 + 1
            if v302 == v298 then
                return v300, v301
            end
        end
    end
    return nil, nil
end
local function v_u_312(p304)
    -- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_303
    local v305 = v_u_12.Get(v_u_10, "Inventory")
    if not v305 then
        return nil, nil, nil
    end
    local v306 = p304.Parent
    if v306 and v306:IsA("Frame") then
        local v307 = v306.Name
        local v308, v309 = v_u_303(p304)
        if v308 and v309 then
            for _, v311 in ipairs(v305) do
                if v311._id == v307 then
                    ::l11::
                    return v311, v308, v309
                end
            end
            local v311 = nil
            goto l11
        end
    end
    return nil, nil, nil
end
local function v_u_328(p_u_313)
    -- upvalues: (copy) v_u_12, (copy) v_u_10, (ref) v_u_44, (ref) v_u_45, (ref) v_u_46, (ref) v_u_47, (ref) v_u_48, (ref) v_u_50, (copy) v_u_8, (copy) v_u_5, (ref) v_u_93, (copy) v_u_21, (copy) v_u_85, (copy) v_u_279, (copy) v_u_89, (copy) v_u_283, (copy) v_u_312
    local v314 = v_u_12.Get(v_u_10, "Inventory")
    local v318
    if v314 then
        local v316 = p_u_313.Parent
        if not (v316 and v316:IsA("Frame")) then
            v318 = nil
            goto l3
        end
        local v317 = v316.Name
        for _, v318 in ipairs(v314) do
            if v318._id == v317 then
                goto l3
            end
        end
        v318 = nil
        goto l3
    else
        v318 = nil
        ::l3::
        if v318 then
            v_u_44 = v318
            v_u_45 = false
            v_u_46 = p_u_313
            v_u_47 = nil
            v_u_48 = nil
            if not v_u_50 then
                v_u_50 = true
                v_u_8.AutoSelectGuiEnabled = false
                v_u_8.SelectedObject = nil
                pcall(function()
                    -- upvalues: (ref) v_u_5, (copy) p_u_313, (ref) v_u_93
                    v_u_5:EnableGamepadCursor(p_u_313 or v_u_93)
                end)
            end
            local v319 = v318.Name
            local v320, v321 = pcall(v_u_21, v319)
            local v322
            if v320 and (v321 and v321.Type) then
                v322 = v_u_85[v321.Type]
            else
                v322 = nil
            end
            if v322 then
                v_u_279(v322, v318.Name)
                return
            elseif v_u_89[v318.Type] then
                v_u_283()
            else
                local v323, v324 = pcall(v_u_21, v318.Name)
                if v323 and (v324 and (v324.Class == "Melee" or v324.Class == "Glove")) then
                    v_u_283()
                end
            end
        else
            local v325, v326, v327 = v_u_312(p_u_313)
            if v325 and (v326 and v327) then
                v_u_44 = v325
                v_u_45 = true
                v_u_46 = p_u_313
                v_u_47 = v326
                v_u_48 = v327
                if not v_u_50 then
                    v_u_50 = true
                    v_u_8.AutoSelectGuiEnabled = false
                    v_u_8.SelectedObject = nil
                    pcall(function()
                        -- upvalues: (ref) v_u_5, (copy) p_u_313, (ref) v_u_93
                        v_u_5:EnableGamepadCursor(p_u_313 or v_u_93)
                    end)
                end
                v_u_279(v326, v325.Name)
            end
        end
    end
end
local function v_u_338(p329)
    -- upvalues: (copy) v_u_11
    local v330 = v_u_11:GetGuiObjectsAtPosition(p329.X, p329.Y)
    for _, v331 in ipairs(v330) do
        if v331.Name ~= "DragIcon" and (v331:IsA("ImageButton") and (v331.Name == "Button" and v331.Parent)) then
            local v332 = v331.Parent
            if v332:IsA("Frame") and v332.Parent then
                local v333 = v332.Parent
                if v333:IsA("Frame") then
                    local v334 = v333.Name
                    if v334 == "Mid Tier" or (v334 == "Pistols" or v334 == "Rifles") then
                        local v335 = 0
                        local v336 = 1
                        for _, v337 in ipairs(v333:GetChildren()) do
                            if v337:IsA("Frame") and (v337.Name ~= "Frame" and v337:FindFirstChild("Button")) then
                                v335 = v335 + 1
                                if v337 == v332 then
                                    v336 = v335
                                    break
                                end
                            end
                        end
                        return v334, v336, v331
                    end
                end
            end
        end
    end
    return nil, nil, nil
end
local function v_u_346(p339, p340)
    -- upvalues: (copy) v_u_12, (copy) v_u_10, (ref) v_u_28
    local v341 = v_u_12.Get(v_u_10, "Loadout")
    if not v341 then
        return false, nil
    end
    local v342 = v341[v_u_28]
    if not (v342 and (v342.Loadout and v342.Loadout[p340])) then
        return false, nil
    end
    local v343 = v342.Loadout[p340].Options
    for v344, v345 in ipairs(v343) do
        if v345 == p339 then
            return true, v344
        end
    end
    return false, nil
end
local function v_u_347()
    -- upvalues: (copy) v_u_12, (copy) v_u_10, (ref) v_u_28
    -- failed to decompile
end
local function v_u_351(p348, p349, p350)
    -- upvalues: (ref) v_u_52, (copy) v_u_16, (ref) v_u_28
    if v_u_52 then
        return false
    end
    v_u_52 = true
    v_u_16.Inventory.EquipLoadoutSkin.Send({
        ["Type"] = p348,
        ["Slot"] = p349 - 1,
        ["Team"] = v_u_28,
        ["Identifier"] = p350
    })
    task.delay(5, function()
        -- upvalues: (ref) v_u_52
        v_u_52 = false
    end)
    return true
end
local function v_u_355(p352, p353, p354)
    -- upvalues: (ref) v_u_52, (copy) v_u_16, (ref) v_u_28
    if v_u_52 then
        return false
    end
    v_u_52 = true
    v_u_16.Inventory.SwapLoadoutSkins.Send({
        ["Type"] = p352,
        ["SlotOne"] = p353 - 1,
        ["SlotTwo"] = p354 - 1,
        ["Team"] = v_u_28
    })
    task.delay(5, function()
        -- upvalues: (ref) v_u_52
        v_u_52 = false
    end)
    return true
end
local function v_u_359(p356, p357)
    -- upvalues: (ref) v_u_52, (copy) v_u_16, (ref) v_u_28
    if v_u_52 then
        return false
    end
    v_u_52 = true
    local v358 = {
        ["Path"] = p356,
        ["Team"] = v_u_28,
        ["Identifier"] = p357
    }
    v_u_16.Inventory.EquipSpecialItem.Send(v358)
    task.delay(5, function()
        -- upvalues: (ref) v_u_52
        v_u_52 = false
    end)
    return true
end
local function v_u_384()
    -- upvalues: (ref) v_u_44, (copy) v_u_4, (copy) v_u_8, (copy) v_u_338, (ref) v_u_28, (copy) v_u_21, (ref) v_u_45, (ref) v_u_46, (ref) v_u_47, (ref) v_u_48, (ref) v_u_51, (ref) v_u_50, (copy) v_u_5, (copy) v_u_296, (copy) v_u_85, (copy) v_u_346, (copy) v_u_355, (copy) v_u_347, (copy) v_u_351, (copy) v_u_89, (copy) v_u_262, (copy) v_u_359
    if v_u_44 then
        local v360 = v_u_4:GetMouseLocation()
        local v361 = v_u_8:GetGuiInset()
        local v362 = Vector2.new(v360.X - v361.X, v360.Y - v361.Y)
        local v363, v364, _ = v_u_338(v362)
        if v363 and v364 then
            local v365 = v_u_44.Name
            local v366 = v_u_28
            local v367
            if v365 and (type(v365) == "string" and v365 ~= "") then
                local v368, v369 = pcall(v_u_21, v365)
                if v368 and (v369 and v369.Team) then
                    v367 = v369.Team == "Both" and true or v369.Team == v366
                else
                    v367 = false
                end
            else
                v367 = false
            end
            if v367 then
                local v370 = v_u_44.Name
                local v371, v372 = pcall(v_u_21, v370)
                local v373
                if v371 and (v372 and v372.Type) then
                    v373 = v_u_85[v372.Type]
                else
                    v373 = nil
                end
                if v373 == v363 then
                    local v374, v375 = v_u_346(v_u_44._id, v363)
                    if v374 and v375 then
                        if v375 ~= v364 then
                            v_u_355(v363, v375, v364)
                        end
                    else
                        local v376, v377 = v_u_347(v_u_44.Name, v363)
                        if v376 and v377 then
                            v_u_351(v363, v377, v_u_44._id)
                        else
                            v_u_351(v363, v364, v_u_44._id)
                        end
                    end
                    v_u_44 = nil
                    v_u_45 = false
                    v_u_46 = nil
                    v_u_47 = nil
                    v_u_48 = nil
                    v_u_51 = false
                    if v_u_50 then
                        v_u_50 = false
                        pcall(function()
                            -- upvalues: (ref) v_u_5
                            v_u_5:DisableGamepadCursor()
                        end)
                        v_u_8.AutoSelectGuiEnabled = true
                    end
                    v_u_296()
                else
                    v_u_44 = nil
                    v_u_45 = false
                    v_u_46 = nil
                    v_u_47 = nil
                    v_u_48 = nil
                    v_u_51 = false
                    if v_u_50 then
                        v_u_50 = false
                        pcall(function()
                            -- upvalues: (ref) v_u_5
                            v_u_5:DisableGamepadCursor()
                        end)
                        v_u_8.AutoSelectGuiEnabled = true
                    end
                    v_u_296()
                end
            else
                v_u_44 = nil
                v_u_45 = false
                v_u_46 = nil
                v_u_47 = nil
                v_u_48 = nil
                v_u_51 = false
                if v_u_50 then
                    v_u_50 = false
                    pcall(function()
                        -- upvalues: (ref) v_u_5
                        v_u_5:DisableGamepadCursor()
                    end)
                    v_u_8.AutoSelectGuiEnabled = true
                end
                v_u_296()
                return
            end
        else
            local v378 = v_u_44.Type
            if v378 then
                v378 = v_u_89[v_u_44.Type]
            end
            if not v378 then
                local v379, v380 = pcall(v_u_21, v_u_44.Name)
                v378 = v379 and (v380 and (v380.Class == "Melee" or v380.Class == "Glove")) and true or v378
            end
            if v378 and v_u_262(v362) then
                local v381 = v_u_89[v_u_44.Type]
                if not v381 then
                    local v382, v383 = pcall(v_u_21, v_u_44.Name)
                    if v382 and v383 then
                        v381 = v383.Class == "Melee" and "Equipped Melee" or (v383.Class == "Glove" and "Equipped Gloves" or v381)
                    end
                end
                if v381 then
                    v_u_359(v381, v_u_44._id)
                end
                v_u_44 = nil
                v_u_45 = false
                v_u_46 = nil
                v_u_47 = nil
                v_u_48 = nil
                v_u_51 = false
                if v_u_50 then
                    v_u_50 = false
                    pcall(function()
                        -- upvalues: (ref) v_u_5
                        v_u_5:DisableGamepadCursor()
                    end)
                    v_u_8.AutoSelectGuiEnabled = true
                end
                v_u_296()
            else
                v_u_44 = nil
                v_u_45 = false
                v_u_46 = nil
                v_u_47 = nil
                v_u_48 = nil
                v_u_51 = false
                if v_u_50 then
                    v_u_50 = false
                    pcall(function()
                        -- upvalues: (ref) v_u_5
                        v_u_5:DisableGamepadCursor()
                    end)
                    v_u_8.AutoSelectGuiEnabled = true
                end
                v_u_296()
            end
        end
    else
        return
    end
end
local function v_u_385()
    -- upvalues: (ref) v_u_93, (ref) v_u_44, (ref) v_u_45, (ref) v_u_46, (ref) v_u_47, (ref) v_u_48, (ref) v_u_51, (ref) v_u_50, (copy) v_u_5, (copy) v_u_8, (copy) v_u_296
    if v_u_93 and v_u_93.Visible then
        if v_u_44 then
            v_u_44 = nil
            v_u_45 = false
            v_u_46 = nil
            v_u_47 = nil
            v_u_48 = nil
            v_u_51 = false
            if v_u_50 then
                v_u_50 = false
                pcall(function()
                    -- upvalues: (ref) v_u_5
                    v_u_5:DisableGamepadCursor()
                end)
                v_u_8.AutoSelectGuiEnabled = true
            end
            v_u_296()
        end
    end
end
function v_u_1.HandleSpecialItemDrop()
    -- upvalues: (ref) v_u_36, (ref) v_u_38, (copy) v_u_89, (ref) v_u_37, (copy) v_u_21, (copy) v_u_359
    if v_u_36 and v_u_38 then
        local v386 = v_u_89[v_u_38]
        if not v386 and v_u_37 then
            local v387, v388 = pcall(v_u_21, v_u_37)
            if v387 and v388 then
                v386 = v388.Class == "Melee" and "Equipped Melee" or (v388.Class == "Glove" and "Equipped Gloves" or v386)
            end
        end
        if v386 then
            v_u_359(v386, v_u_36)
        end
    else
        return
    end
end
function v_u_1.HandleDrop(p389, p390)
    -- upvalues: (ref) v_u_36, (ref) v_u_37, (ref) v_u_28, (copy) v_u_21, (copy) v_u_85, (copy) v_u_12, (copy) v_u_10, (copy) v_u_346, (copy) v_u_355, (copy) v_u_347, (copy) v_u_351
    if v_u_36 and v_u_37 then
        local v391 = v_u_37
        local v392 = v_u_28
        local v393
        if v391 and (type(v391) == "string" and v391 ~= "") then
            local v394, v395 = pcall(v_u_21, v391)
            if v394 and (v395 and v395.Team) then
                v393 = v395.Team == "Both" and true or v395.Team == v392
            else
                v393 = false
            end
        else
            v393 = false
        end
        if v393 then
            local v396 = v_u_37
            local v397, v398 = pcall(v_u_21, v396)
            local v399
            if v397 and (v398 and v398.Type) then
                v399 = v_u_85[v398.Type]
            else
                v399 = nil
            end
            if v399 == p389 then
                local v400 = v_u_12.Get(v_u_10, "Loadout")
                if v400 then
                    local v401 = v400[v_u_28]
                    if v401 and (v401.Loadout and v401.Loadout[p389]) then
                        local v402 = v401.Loadout[p389].Options
                        if p390 < 1 or #v402 < p390 then
                            return
                        else
                            local v403, v404 = v_u_346(v_u_36, p389)
                            if v403 and v404 then
                                if v404 ~= p390 then
                                    v_u_355(p389, v404, p390)
                                end
                                return
                            else
                                local v405, v406 = v_u_347(v_u_37, p389)
                                if v405 and v406 then
                                    v_u_351(p389, v406, v_u_36)
                                else
                                    v_u_351(p389, p390, v_u_36)
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
        else
            return
        end
    else
        return
    end
end
local function v_u_418(p407)
    -- upvalues: (ref) v_u_42, (ref) v_u_40, (ref) v_u_41, (ref) v_u_43, (ref) v_u_34, (copy) v_u_267, (ref) v_u_35, (ref) v_u_36, (ref) v_u_37, (ref) v_u_38, (copy) v_u_21, (copy) v_u_85, (copy) v_u_279, (copy) v_u_89, (copy) v_u_283, (copy) v_u_11, (copy) v_u_4, (copy) v_u_84, (ref) v_u_39, (copy) v_u_7
    if v_u_42 then
        v_u_42:Disconnect()
        v_u_42 = nil
    end
    v_u_40 = nil
    v_u_41 = nil
    v_u_43 = false
    if v_u_34 then
        return
    else
        local v408 = v_u_267(p407)
        if v408 then
            v_u_34 = true
            v_u_35 = v408
            v_u_36 = p407._id
            v_u_37 = p407.Name
            v_u_38 = p407.Type
            local v409 = p407.Name
            local v410, v411 = pcall(v_u_21, v409)
            local v412
            if v410 and (v411 and v411.Type) then
                v412 = v_u_85[v411.Type]
            else
                v412 = nil
            end
            if v412 then
                v_u_279(v412, p407.Name)
            elseif v_u_89[p407.Type] then
                v_u_283()
            else
                local v413, v414 = pcall(v_u_21, p407.Name)
                if v413 and (v414 and (v414.Class == "Melee" or v414.Class == "Glove")) then
                    v_u_283()
                end
            end
            local v415 = v_u_11:FindFirstChild("MainGui")
            if v415 then
                v408.Parent = v415
            else
                v408.Parent = v_u_11
            end
            local v416 = v_u_4:GetMouseLocation()
            v408.Position = UDim2.fromOffset(v416.X + v_u_84.X, v416.Y + v_u_84.Y)
            v_u_39 = v_u_7.RenderStepped:Connect(function()
                -- upvalues: (ref) v_u_35, (ref) v_u_4, (ref) v_u_84
                if v_u_35 then
                    local v417 = v_u_4:GetMouseLocation()
                    v_u_35.Position = UDim2.fromOffset(v417.X + v_u_84.X, v417.Y + v_u_84.Y)
                end
            end)
        end
    end
end
function v_u_1.OnItemMouseDown(p419, p420)
    -- upvalues: (ref) v_u_44, (ref) v_u_50, (ref) v_u_34, (ref) v_u_40, (ref) v_u_41, (copy) v_u_4, (ref) v_u_43, (ref) v_u_42, (copy) v_u_7, (copy) v_u_418
    if v_u_44 or v_u_50 then
        return
    elseif not (v_u_34 or v_u_40) then
        v_u_40 = p419
        v_u_41 = v_u_4:GetMouseLocation()
        v_u_43 = p420 or false
        v_u_42 = v_u_7.RenderStepped:Connect(function()
            -- upvalues: (ref) v_u_40, (ref) v_u_41, (ref) v_u_4, (ref) v_u_42, (ref) v_u_43, (ref) v_u_418
            if v_u_40 and (v_u_41 and (v_u_4:GetMouseLocation() - v_u_41).Magnitude >= 10) then
                local v421 = v_u_40
                if v_u_42 then
                    v_u_42:Disconnect()
                    v_u_42 = nil
                end
                v_u_40 = nil
                v_u_41 = nil
                v_u_43 = false
                v_u_418(v421)
            end
        end)
    end
end
function v_u_1.OnItemClick(p422)
    -- upvalues: (ref) v_u_32, (copy) v_u_21, (ref) v_u_29, (ref) v_u_93, (copy) v_u_1
    local v423 = p422.Name
    v_u_32 = nil
    local v424, v425 = pcall(v_u_21, v423)
    if v424 and (v425 and v425.Type) then
        v_u_29 = v425.Type
        v_u_93.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = v425.Type
        v_u_1.PopulateWeaponDropdown()
    end
    v_u_1.SortByWeapon(v423)
end
function v_u_1.EndDrag()
    -- upvalues: (ref) v_u_40, (ref) v_u_34, (ref) v_u_43, (ref) v_u_42, (ref) v_u_41, (copy) v_u_1, (copy) v_u_4, (copy) v_u_8, (ref) v_u_38, (copy) v_u_89, (ref) v_u_37, (copy) v_u_21, (copy) v_u_262, (copy) v_u_338, (ref) v_u_39, (ref) v_u_35, (ref) v_u_36, (copy) v_u_296
    if v_u_40 and not v_u_34 then
        local v426 = v_u_40
        local v427 = v_u_43
        if v_u_42 then
            v_u_42:Disconnect()
            v_u_42 = nil
        end
        v_u_40 = nil
        v_u_41 = nil
        v_u_43 = false
        if v427 then
            v_u_1.OnItemClick(v426)
        end
        return
    elseif v_u_34 then
        local v428 = v_u_4:GetMouseLocation()
        local v429 = v_u_8:GetGuiInset()
        local v430 = Vector2.new(v428.X - v429.X, v428.Y - v429.Y)
        local v431 = v_u_38
        if v431 then
            v431 = v_u_89[v_u_38]
        end
        if not v431 and v_u_37 then
            local v432, v433 = pcall(v_u_21, v_u_37)
            v431 = v432 and (v433 and (v433.Class == "Melee" or v433.Class == "Glove")) and true or v431
        end
        if v431 and v_u_262(v430) then
            v_u_1.HandleSpecialItemDrop()
        else
            local v434, v435 = v_u_338(v430)
            if v434 and v435 then
                v_u_1.HandleDrop(v434, v435)
            end
        end
        if v_u_42 then
            v_u_42:Disconnect()
            v_u_42 = nil
        end
        v_u_40 = nil
        v_u_41 = nil
        v_u_43 = false
        if v_u_39 then
            v_u_39:Disconnect()
            v_u_39 = nil
        end
        if v_u_35 then
            v_u_35:Destroy()
            v_u_35 = nil
        end
        v_u_34 = false
        v_u_36 = nil
        v_u_37 = nil
        v_u_38 = nil
        v_u_296()
    end
end
function v_u_1.CreateItemTemplate(p_u_436)
    -- upvalues: (copy) v_u_22, (copy) v_u_2, (copy) v_u_23, (ref) v_u_93, (copy) v_u_15, (copy) v_u_20, (copy) v_u_18, (copy) v_u_6, (copy) v_u_1, (ref) v_u_44, (copy) v_u_328, (copy) v_u_72
    local v437 = v_u_22(p_u_436.Name, p_u_436.Skin)
    if v437 then
        local v_u_438 = v_u_2.Assets.UI.Inventory.ItemTemplate:Clone()
        v_u_438.Main.RarityFrame.UIGradient.Color = v_u_23[v437.rarity].ColorSequence
        v_u_438.Main.Glow.UIGradient.Color = v_u_23[v437.rarity].ColorSequence
        v_u_438.Parent = v_u_93.Tabs.Container.Container
        local v439 = v_u_15.GetWearImageForFloat(v437, p_u_436.Float or 0.9999) or (v437.imageAssetId or "")
        v_u_438.Main.Icon.Image = v439
        local v440 = p_u_436.StatTrack and "KillTrak\226\132\162 " .. p_u_436.Name or p_u_436.Name
        if p_u_436.Type == "Melee" then
            v440 = "\226\152\133 " .. v440
        end
        v_u_438.Information.Weapon.Text = v440
        v_u_438.Information.Skin.Text = v_u_20(p_u_436.Skin)
        v_u_438.Name = p_u_436._id
        local v441
        if typeof(v439) == "string" and v439 ~= "" then
            v441 = v439:gsub("^rbxassetid://", "")
        else
            v441 = nil
        end
        local v442 = not (v_u_18[p_u_436.Name] or v_u_18[p_u_436.Skin]) and (not (v439 and v_u_18[v439]) and v441)
        if v442 then
            v442 = v_u_18[v441]
        end
        local v_u_443
        if v442 then
            v_u_443 = v_u_438.Main.Icon:Clone()
            v_u_443.Name = "DropShadow"
            v_u_443.Image = v442
            v_u_443.ImageTransparency = 1
            v_u_443.ZIndex = v_u_438.Main.Icon.ZIndex - 1
            v_u_443.Parent = v_u_438.Main
        else
            v_u_443 = nil
        end
        local v_u_444 = v_u_438.Main.Icon
        local v_u_445 = v_u_444.Position
        local v_u_446 = UDim2.new(0, 0, -0.05, 0)
        local v_u_447 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v_u_438.Button.MouseEnter:Connect(function()
            -- upvalues: (copy) v_u_445, (copy) v_u_446, (ref) v_u_6, (copy) v_u_444, (copy) v_u_447, (ref) v_u_443
            v_u_6:Create(v_u_444, v_u_447, {
                ["Position"] = UDim2.new(v_u_445.X.Scale + v_u_446.X.Scale, v_u_445.X.Offset + v_u_446.X.Offset, v_u_445.Y.Scale + v_u_446.Y.Scale, v_u_445.Y.Offset + v_u_446.Y.Offset)
            }):Play()
            if v_u_443 then
                v_u_6:Create(v_u_443, v_u_447, {
                    ["ImageTransparency"] = 0.3
                }):Play()
            end
        end)
        v_u_438.Button.MouseLeave:Connect(function()
            -- upvalues: (ref) v_u_6, (copy) v_u_444, (copy) v_u_447, (copy) v_u_445, (ref) v_u_443
            v_u_6:Create(v_u_444, v_u_447, {
                ["Position"] = v_u_445
            }):Play()
            if v_u_443 then
                v_u_6:Create(v_u_443, v_u_447, {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end)
        v_u_438.Button.MouseButton1Down:Connect(function()
            -- upvalues: (ref) v_u_1, (copy) p_u_436
            v_u_1.OnItemMouseDown(p_u_436)
        end)
        v_u_438.Button.Selectable = true
        v_u_438.Button.SelectionGained:Connect(function()
            -- upvalues: (copy) v_u_445, (copy) v_u_446, (ref) v_u_6, (copy) v_u_444, (copy) v_u_447, (ref) v_u_443
            v_u_6:Create(v_u_444, v_u_447, {
                ["Position"] = UDim2.new(v_u_445.X.Scale + v_u_446.X.Scale, v_u_445.X.Offset + v_u_446.X.Offset, v_u_445.Y.Scale + v_u_446.Y.Scale, v_u_445.Y.Offset + v_u_446.Y.Offset)
            }):Play()
            if v_u_443 then
                v_u_6:Create(v_u_443, v_u_447, {
                    ["ImageTransparency"] = 0.3
                }):Play()
            end
        end)
        v_u_438.Button.SelectionLost:Connect(function()
            -- upvalues: (ref) v_u_6, (copy) v_u_444, (copy) v_u_447, (copy) v_u_445, (ref) v_u_443
            v_u_6:Create(v_u_444, v_u_447, {
                ["Position"] = v_u_445
            }):Play()
            if v_u_443 then
                v_u_6:Create(v_u_443, v_u_447, {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end)
        v_u_438.Button.Activated:Connect(function(p448)
            -- upvalues: (ref) v_u_44, (ref) v_u_328, (copy) v_u_438
            if p448 and (p448.UserInputType == Enum.UserInputType.Gamepad1 and not v_u_44) then
                v_u_328(v_u_438.Button)
            end
        end)
        v_u_72(v_u_438, p_u_436._id)
    end
end
function v_u_1.CreateLoadoutTemplate(p449, p_u_450, p451)
    -- upvalues: (copy) v_u_22, (copy) v_u_21, (copy) v_u_2, (copy) v_u_23, (copy) v_u_15, (copy) v_u_18, (copy) v_u_6, (ref) v_u_53, (copy) v_u_1, (ref) v_u_44, (copy) v_u_328
    local v452 = v_u_22(p_u_450.Name, p_u_450.Skin)
    local v453, v454 = pcall(v_u_21, p_u_450.Name)
    local v455 = v453 and (v454 and v454.Cost) or 0
    if v452 then
        local v456 = p451 == "Counter-Terrorists" and "LoadoutTemplateCT" or "LoadoutTemplateT"
        local v_u_457 = v_u_2.Assets.UI.Loadout:FindFirstChild(v456):Clone()
        v_u_457:WaitForChild("Weapon")
        v_u_457.Weapon:WaitForChild("Icon")
        v_u_457.Weapon.Rarity.UIGradient.Color = v_u_23[v452.rarity].ColorSequence
        v_u_457.Weapon.Glow.ImageColor3 = v_u_23[v452.rarity].Color
        v_u_457.Parent = p449
        v_u_457.Name = p_u_450._id
        local v458 = v_u_15.GetWearImageForFloat(v452, p_u_450.Float or 0.9999) or (v452.imageAssetId or "")
        v_u_457.Price.Text = "$" .. tostring(v455)
        v_u_457.WeaponName.Text = p_u_450.Name
        v_u_457.Weapon.Icon.Image = v458
        local v459
        if typeof(v458) == "string" and v458 ~= "" then
            v459 = v458:gsub("^rbxassetid://", "")
        else
            v459 = nil
        end
        local v460 = not (v_u_18[p_u_450.Name] or v_u_18[p_u_450.Skin]) and (not (v458 and v_u_18[v458]) and v459)
        if v460 then
            v460 = v_u_18[v459]
        end
        local v_u_461
        if v460 then
            v_u_461 = v_u_457.Weapon.Icon:Clone()
            v_u_461.Name = "DropShadow"
            v_u_461.Image = v460
            v_u_461.ImageTransparency = 1
            v_u_461.ZIndex = v_u_457.Weapon.Icon.ZIndex - 1
            v_u_461.Parent = v_u_457.Weapon
        else
            v_u_461 = nil
        end
        local v_u_462 = v_u_457.Weapon.Icon
        local v_u_463 = v_u_462.Position
        local v_u_464 = UDim2.new(0, 0, -0.05, 0)
        local v_u_465 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v_u_457.Button.MouseEnter:Connect(function()
            -- upvalues: (copy) v_u_463, (copy) v_u_464, (ref) v_u_6, (copy) v_u_462, (copy) v_u_465, (ref) v_u_461
            v_u_6:Create(v_u_462, v_u_465, {
                ["Position"] = UDim2.new(v_u_463.X.Scale + v_u_464.X.Scale, v_u_463.X.Offset + v_u_464.X.Offset, v_u_463.Y.Scale + v_u_464.Y.Scale, v_u_463.Y.Offset + v_u_464.Y.Offset)
            }):Play()
            if v_u_461 then
                v_u_6:Create(v_u_461, v_u_465, {
                    ["ImageTransparency"] = 0.3
                }):Play()
            end
        end)
        v_u_457.Button.MouseLeave:Connect(function()
            -- upvalues: (ref) v_u_6, (copy) v_u_462, (copy) v_u_465, (copy) v_u_463, (ref) v_u_461
            v_u_6:Create(v_u_462, v_u_465, {
                ["Position"] = v_u_463
            }):Play()
            if v_u_461 then
                v_u_6:Create(v_u_461, v_u_465, {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end)
        local v466 = v_u_53 == p449.Name
        v_u_457.Price.TextTransparency = v466 and 0 or 1
        v_u_457.WeaponName.TextTransparency = v466 and 0 or 1
        v_u_457.Button.MouseButton1Down:Connect(function()
            -- upvalues: (ref) v_u_1, (copy) p_u_450
            v_u_1.OnItemMouseDown(p_u_450, true)
        end)
        v_u_457.Button.MouseEnter:Connect(function()
            -- upvalues: (ref) v_u_1, (copy) p_u_450
            v_u_1.OnLoadoutItemHover(p_u_450)
        end)
        v_u_457.Button.MouseLeave:Connect(function()
            -- upvalues: (ref) v_u_1
            v_u_1.OnLoadoutItemUnhover()
        end)
        v_u_457.Button.Selectable = true
        v_u_457.Button.SelectionGained:Connect(function()
            -- upvalues: (ref) v_u_1, (copy) p_u_450, (copy) v_u_463, (copy) v_u_464, (ref) v_u_6, (copy) v_u_462, (copy) v_u_465, (ref) v_u_461
            v_u_1.OnLoadoutItemHover(p_u_450)
            v_u_6:Create(v_u_462, v_u_465, {
                ["Position"] = UDim2.new(v_u_463.X.Scale + v_u_464.X.Scale, v_u_463.X.Offset + v_u_464.X.Offset, v_u_463.Y.Scale + v_u_464.Y.Scale, v_u_463.Y.Offset + v_u_464.Y.Offset)
            }):Play()
            if v_u_461 then
                v_u_6:Create(v_u_461, v_u_465, {
                    ["ImageTransparency"] = 0.3
                }):Play()
            end
        end)
        v_u_457.Button.SelectionLost:Connect(function()
            -- upvalues: (ref) v_u_6, (copy) v_u_462, (copy) v_u_465, (copy) v_u_463, (ref) v_u_461
            v_u_6:Create(v_u_462, v_u_465, {
                ["Position"] = v_u_463
            }):Play()
            if v_u_461 then
                v_u_6:Create(v_u_461, v_u_465, {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end)
        v_u_457.Button.Activated:Connect(function(p467)
            -- upvalues: (ref) v_u_44, (ref) v_u_328, (copy) v_u_457
            if p467 and (p467.UserInputType == Enum.UserInputType.Gamepad1 and not v_u_44) then
                v_u_328(v_u_457.Button)
            end
        end)
    end
end
function v_u_1.PopulateCategoryDropdown()
    -- upvalues: (ref) v_u_93, (copy) v_u_238, (copy) v_u_235, (copy) v_u_1, (copy) v_u_225, (copy) v_u_248
    local v_u_468 = v_u_93.Tabs.Container.WeaponSort.Category.ScrollingFrame
    if v_u_468 then
        v_u_238(v_u_468)
        v_u_235(v_u_468, "All", "All Categories", 0, function()
            -- upvalues: (ref) v_u_1, (ref) v_u_225, (copy) v_u_468
            v_u_1.SortByCategory(nil)
            v_u_225(v_u_468, "All")
            v_u_468.Visible = false
        end)
        local v469 = v_u_248()
        for v470, v_u_471 in ipairs(v469) do
            v_u_235(v_u_468, v_u_471, v_u_471, v470, function()
                -- upvalues: (ref) v_u_1, (copy) v_u_471, (ref) v_u_225, (copy) v_u_468
                v_u_1.SortByCategory(v_u_471)
                v_u_225(v_u_468, v_u_471)
                v_u_468.Visible = false
            end)
        end
        v_u_225(v_u_468, "All")
    end
end
function v_u_1.PopulateWeaponDropdown()
    -- upvalues: (ref) v_u_93, (copy) v_u_238, (copy) v_u_235, (copy) v_u_1, (copy) v_u_225, (copy) v_u_257, (ref) v_u_29
    local v_u_472 = v_u_93.Tabs.Container.WeaponSort.Weapon:FindFirstChild("Options")
    if v_u_472 and (v_u_472:IsA("Frame") or v_u_472:IsA("ScrollingFrame")) then
        v_u_238(v_u_472)
        v_u_235(v_u_472, "All", "All Weapons", 0, function()
            -- upvalues: (ref) v_u_1, (ref) v_u_225, (copy) v_u_472, (copy) v_u_472
            v_u_1.SortByWeapon(nil)
            v_u_225(v_u_472, "All")
            v_u_472.Visible = false
        end)
        local v473 = v_u_257(v_u_29)
        for v474, v_u_475 in ipairs(v473) do
            v_u_235(v_u_472, v_u_475, v_u_475, v474, function()
                -- upvalues: (ref) v_u_1, (copy) v_u_475, (ref) v_u_225, (copy) v_u_472, (copy) v_u_472
                v_u_1.SortByWeapon(v_u_475)
                v_u_225(v_u_472, v_u_475)
                v_u_472.Visible = false
            end)
        end
        v_u_225(v_u_472, "All")
    end
end
function v_u_1.SortByCategory(p476)
    -- upvalues: (ref) v_u_29, (ref) v_u_33, (ref) v_u_93, (copy) v_u_1, (copy) v_u_21, (copy) v_u_88, (ref) v_u_82, (ref) v_u_81, (ref) v_u_79, (copy) v_u_152, (copy) v_u_210
    v_u_29 = p476
    v_u_33 = nil
    local _ = v_u_93.Tabs.Container.Container
    v_u_93.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = p476 or "All Categories"
    v_u_1.PopulateWeaponDropdown()
    v_u_93.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
    local v477 = v_u_93.Tabs.Container.WeaponSort:FindFirstChild("Reset")
    if v477 then
        local v478 = v_u_93.Tabs.Container.WeaponSort.Weapon
        v477.Visible = v_u_29 ~= nil and true or v478.Frame.TextLabel.Text ~= "All Weapons"
    end
    if v_u_93 and v_u_93.Visible then
        v_u_79 = v_u_152()
        v_u_210()
    else
        v_u_82 = true
        v_u_81 = true
    end
end
function v_u_1.SortByWeapon(p479, p480)
    -- upvalues: (ref) v_u_33, (ref) v_u_93, (copy) v_u_19, (ref) v_u_30, (copy) v_u_10, (ref) v_u_106, (ref) v_u_82, (ref) v_u_81, (ref) v_u_79, (copy) v_u_152, (copy) v_u_210, (ref) v_u_29
    v_u_33 = p479 and ({
        ["weaponName"] = p479,
        ["skinName"] = p480
    } or nil) or nil
    local _ = v_u_93.Tabs.Container.Container
    v_u_93.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = p479 or "All Weapons"
    if v_u_19.GetSortComparisonFunction(v_u_30, v_u_10, function()
        -- upvalues: (ref) v_u_106
        return v_u_106
    end) then
        if v_u_93 and v_u_93.Visible then
            v_u_79 = v_u_152()
            v_u_210()
        else
            v_u_82 = true
            v_u_81 = true
        end
    end
    local v481 = v_u_93.Tabs.Container.WeaponSort:FindFirstChild("Reset")
    if v481 then
        local v482 = v_u_93.Tabs.Container.WeaponSort.Weapon
        v481.Visible = v_u_29 ~= nil and true or v482.Frame.TextLabel.Text ~= "All Weapons"
    end
end
function v_u_1.SortBySkinMetadata(p483)
    -- upvalues: (ref) v_u_30, (ref) v_u_93, (copy) v_u_19, (copy) v_u_10, (ref) v_u_106, (ref) v_u_82, (ref) v_u_81, (ref) v_u_79, (copy) v_u_152, (copy) v_u_210
    v_u_30 = p483
    local _ = v_u_93.Tabs.Container.Container
    v_u_93.Tabs.Container.SkinSort.Sort.Frame.TextLabel.Text = p483
    if v_u_19.GetSortComparisonFunction(p483, v_u_10, function()
        -- upvalues: (ref) v_u_106
        return v_u_106
    end) then
        if not (v_u_93 and v_u_93.Visible) then
            v_u_82 = true
            v_u_81 = true
            return
        end
        v_u_79 = v_u_152()
        v_u_210()
    end
end
function v_u_1.UpdateInventoryContainer()
    -- upvalues: (ref) v_u_93, (ref) v_u_82, (ref) v_u_81, (ref) v_u_44, (ref) v_u_45, (ref) v_u_46, (ref) v_u_47, (ref) v_u_48, (ref) v_u_51, (ref) v_u_50, (copy) v_u_5, (copy) v_u_8, (copy) v_u_296, (copy) v_u_12, (copy) v_u_10, (copy) v_u_1, (ref) v_u_30
    if v_u_93 then
        if v_u_93.Visible then
            v_u_44 = nil
            v_u_45 = false
            v_u_46 = nil
            v_u_47 = nil
            v_u_48 = nil
            v_u_51 = false
            if v_u_50 then
                v_u_50 = false
                pcall(function()
                    -- upvalues: (ref) v_u_5
                    v_u_5:DisableGamepadCursor()
                end)
                v_u_8.AutoSelectGuiEnabled = true
            end
            v_u_296()
            local v484 = v_u_12.Get(v_u_10, "Inventory")
            local v485 = {}
            for _, v486 in ipairs(v484) do
                if v486 and v486._id then
                    v485[v486._id] = true
                end
            end
            local v487 = v_u_93.Tabs.Container.Container
            for _, v488 in ipairs(v487:GetChildren()) do
                if v488:IsA("Frame") and (v488.Name ~= "UIGridLayout" and (v488.Name ~= "UIPadding" and not v485[v488.Name])) then
                    v488:Destroy()
                end
            end
            v_u_1.PopulateCategoryDropdown()
            v_u_1.PopulateWeaponDropdown()
            v_u_1.SortBySkinMetadata(v_u_30)
        else
            v_u_82 = true
            v_u_81 = true
        end
    else
        return
    end
end
function v_u_1.UpdateLoadoutContainer()
    -- upvalues: (ref) v_u_44, (ref) v_u_45, (ref) v_u_46, (ref) v_u_47, (ref) v_u_48, (ref) v_u_51, (ref) v_u_50, (copy) v_u_5, (copy) v_u_8, (copy) v_u_296, (copy) v_u_12, (copy) v_u_10, (ref) v_u_93, (ref) v_u_28, (copy) v_u_97, (copy) v_u_1
    -- failed to decompile
end
function v_u_1.UpdateSidebarFrames(p489, p490)
    -- upvalues: (copy) v_u_12, (copy) v_u_10, (ref) v_u_28, (ref) v_u_93, (copy) v_u_90, (copy) v_u_22, (copy) v_u_15, (copy) v_u_23
    local v491 = v_u_12.Get(v_u_10, "Inventory")
    local v492 = p490 or v_u_28
    local v493 = v492 == "Counter-Terrorists" and "CT" or "T"
    local v494 = v_u_93.Teams:FindFirstChild(v493)
    if not v494 then
        return
    end
    local v495 = v494:FindFirstChild("Sidebar")
    if not v495 then
        return
    end
    local v496 = p489[v492]
    if not (v496 and v496.Equipped) then
        return
    end
    for v497, v498 in pairs(v_u_90) do
        local v499 = v496.Equipped[v497]
        local v500 = v495:FindFirstChild(v498)
        if v500 then
            local v501 = v500:FindFirstChild("Weapon")
            local v502
            if v501 then
                v502 = v501:FindFirstChild("Icon")
            else
                v502 = v501
            end
            local v503
            if v501 then
                v503 = v501:FindFirstChild("Rarity")
            else
                v503 = v501
            end
            local v504
            if v501 then
                v504 = v501:FindFirstChild("Glow")
            else
                v504 = v501
            end
            local v505 = nil
            local v506 = false
            local v508
            if v499 and v499 ~= "" then
                for _, v508 in ipairs(v491) do
                    if v508._id == v499 then
                        goto l28
                    end
                end
                v508 = nil
                ::l28::
                if v508 then
                    local v509 = v_u_22(v508.Name, v508.Skin)
                    if v509 then
                        v506 = true
                        if v502 then
                            v502.Image = v_u_15.GetWearImageForFloat(v509, v508.Float or 0.9999) or (v509.imageAssetId or "")
                            v502.Visible = true
                        end
                        if v503 then
                            v503.Visible = true
                            local v510 = v503:FindFirstChild("UIGradient")
                            if v510 then
                                v510.Color = v_u_23[v509.rarity].ColorSequence
                            end
                        end
                        if v504 then
                            v504.Visible = true
                            v504.ImageColor3 = v_u_23[v509.rarity].Color
                        end
                    end
                else
                    v508 = v505
                end
            else
                v508 = v505
            end
            if not v506 then
                if v502 then
                    v502.Visible = false
                end
                if v503 then
                    v503.Visible = false
                end
                if v504 then
                    v504.Visible = false
                end
            end
            if v501 and (v498 == "Melee" or (v498 == "Gloves" or v498 == "Zeus")) then
                if v508 then
                    v501:SetAttribute("EquippedItemId", v508._id)
                else
                    v501:SetAttribute("EquippedItemId", nil)
                end
                v501:SetAttribute("SidebarName", v498)
                v501:SetAttribute("TeamKey", v492 == "Counter-Terrorists" and "CT" or "T")
            end
        end
    end
end
local function v_u_526()
    -- upvalues: (ref) v_u_93, (copy) v_u_26, (copy) v_u_24, (copy) v_u_73
    local v511 = v_u_93.Teams
    for _, v512 in ipairs({ "CT", "T" }) do
        local v513 = v_u_26.VIEWPORT_CHARACTER_CONFIG[v512]
        local v514 = v511:FindFirstChild(v512)
        if v514 then
            local v515 = v514:FindFirstChild("Player")
            if v515 then
                for _, v516 in ipairs(v515:GetChildren()) do
                    if v516:IsA("WorldModel") or v516:IsA("Camera") then
                        v516:Destroy()
                    end
                end
                local v517 = v_u_24:FindFirstChild(v513.Character)
                if v517 then
                    local v518 = Instance.new("WorldModel")
                    v518.Name = "CharacterWorldModel"
                    v518.Parent = v515
                    local v519 = v517:Clone()
                    v519.Name = "ViewportCharacter"
                    v519.Parent = v518
                    v_u_73[v512] = v519
                    local v520 = v513.CharacterOffset or CFrame.new(0, 0, 0)
                    if v519.PrimaryPart then
                        v519:SetPrimaryPartCFrame(v520)
                    else
                        v519:PivotTo(v520)
                    end
                    local v521 = v519:FindFirstChildOfClass("Humanoid")
                    if v521 and v513.IdleAnimation then
                        local v522 = v521:FindFirstChildOfClass("Animator")
                        if not v522 then
                            v522 = Instance.new("Animator")
                            v522.Parent = v521
                        end
                        local v523 = Instance.new("Animation")
                        v523.AnimationId = v513.IdleAnimation
                        local v524 = v522:LoadAnimation(v523)
                        v524.Looped = true
                        v524:Play()
                    end
                    local v525 = Instance.new("Camera")
                    v525.Name = "ViewportCamera"
                    v525.CameraType = Enum.CameraType.Scriptable
                    v525.FieldOfView = 50
                    v525.CFrame = CFrame.new(0, 0, 0) * v513.CameraOffset
                    v525.Parent = v515
                    v515.CurrentCamera = v525
                end
            end
        end
    end
end
local function v_u_538(p527)
    -- upvalues: (copy) v_u_73, (copy) v_u_76, (copy) v_u_12, (copy) v_u_10, (copy) v_u_15, (copy) v_u_27
    local v528 = v_u_73[p527]
    if not v528 then
        return
    end
    local v529 = v_u_76[p527]
    if v529 then
        for _, v530 in ipairs(v529) do
            if v530 and v530.Parent then
                v530:Destroy()
            end
        end
        v_u_76[p527] = {}
    end
    local v531 = p527 == "CT" and "Counter-Terrorists" or "Terrorists"
    local v532 = v_u_12.Get(v_u_10, "Loadout")
    if not (v532 and v532[v531]) then
        return
    end
    local v533 = v532[v531].Equipped
    if v533 then
        v533 = v532[v531].Equipped["Equipped Gloves"]
    end
    if not v533 then
        return
    end
    local v534 = v_u_12.Get(v_u_10, "Inventory")
    local v535 = nil
    for _, v536 in ipairs(v534) do
        if v536._id == v533 then
            v535 = v536
            break
        end
    end
    if v535 then
        local v537 = v_u_15.GetGloves(v535.Name, v535.Skin, v535.Float)
        if v537 then
            v_u_76[p527] = v_u_27(v537:GetChildren(), v528, v528)
            v537:Destroy()
        end
    else
        return
    end
end
local function v_u_592(p539, p540)
    -- upvalues: (copy) v_u_73, (copy) v_u_78, (copy) v_u_75, (copy) v_u_21, (copy) v_u_102, (copy) v_u_26, (copy) v_u_74, (copy) v_u_25, (copy) v_u_15
    local v541 = v_u_73[p539]
    if v541 then
        if p540 and v_u_78[p539] == p540._id then
            local v542 = v_u_75[p539]
            if not (v542 and v542.IsPlaying) then
                local v543 = v541:FindFirstChildOfClass("Humanoid")
                local v544 = v543 and v543:FindFirstChildOfClass("Animator")
                if v544 then
                    local v545 = nil
                    if p540.Type == "Melee" then
                        v545 = "Melee"
                    else
                        local v546, v547 = pcall(v_u_21, p540.Name)
                        if v546 and v547 then
                            v545 = v_u_102(v547.Type, v547.AimingOptions, v547.MuzzleType, v547.Class)
                        end
                    end
                    if v545 then
                        local v548 = p540.Name
                        local v549
                        if v545 and v_u_26.ANIMATION_MAPPING[v545] then
                            local v550 = v_u_26.ANIMATION_MAPPING[v545]
                            if v548 and v550[v548] then
                                v549 = v550[v548]
                            else
                                v549 = v550.Default
                            end
                        else
                            v549 = nil
                        end
                        if v549 then
                            local v551 = v544:LoadAnimation(v549)
                            v551.Looped = true
                            v551.Priority = Enum.AnimationPriority.Action
                            v551:Play()
                            v_u_75[p539] = v551
                        end
                    end
                end
            end
            return
        else
            local v552 = v_u_75[p539]
            if v552 then
                v552:Stop()
                v_u_75[p539] = nil
            end
            local v553 = v_u_74[p539]
            if v553 then
                v553:Destroy()
                v_u_74[p539] = nil
            end
            v_u_78[p539] = nil
            for _, v554 in pairs({ v_u_25.DEFAULT_JOINT_PART, "UpperTorso", "LeftHand" }) do
                local v555 = v541:FindFirstChild(v554)
                if v555 then
                    local v556 = v555:FindFirstChild("WeaponAttachment")
                    if v556 then
                        v556:Destroy()
                    end
                    local v557 = v555:FindFirstChild("WeaponAttachmentHandleR")
                    if v557 then
                        v557:Destroy()
                    end
                    local v558 = v555:FindFirstChild("WeaponAttachmentHandleL")
                    if v558 then
                        v558:Destroy()
                    end
                end
            end
            if p540 then
                local v559 = v_u_15.GetCharacterModel(p540.Name, p540.Skin, p540.Float, p540.StatTrack, p540.NameTag)
                if v559 then
                    v559.Name = p540.Name
                    local v560 = v541:FindFirstChild(v_u_25.WEAPON_JOINT_PARTS[p540.Name] or v_u_25.DEFAULT_JOINT_PART)
                    if v560 then
                        if not v559.PrimaryPart then
                            local v561 = v559:FindFirstChild("Weapon")
                            if v561 then
                                v561 = v561:FindFirstChild("Insert")
                            end
                            if v561 then
                                v559.PrimaryPart = v561
                            else
                                local v562 = v559:FindFirstChild("Insert", true)
                                if v562 then
                                    v559.PrimaryPart = v562
                                end
                            end
                        end
                        if v559.PrimaryPart then
                            for _, v563 in ipairs(v559:GetDescendants()) do
                                if v563:IsA("BasePart") then
                                    v563.CanCollide = false
                                    v563.CanQuery = false
                                    v563.CanTouch = false
                                    v563.Anchored = false
                                    v563.Massless = true
                                end
                            end
                            v559.Parent = v541
                            local v564, v565 = pcall(v_u_21, p540.Name)
                            local v566
                            if v564 and v565 then
                                v566 = v565.ShootingOptions == "Dual"
                            else
                                v566 = false
                            end
                            local v567 = v559:FindFirstChild("Properties")
                            if not v567 then
                                local v568 = v559:FindFirstChild("Weapon")
                                if v568 then
                                    v567 = v568:FindFirstChild("Properties")
                                end
                            end
                            local v569 = v567 or v559:FindFirstChild("Properties", true)
                            if v566 then
                                local v570 = v541:FindFirstChild("RightHand")
                                local v571 = v541:FindFirstChild("LeftHand")
                                if v570 and v571 then
                                    local v572 = v559:FindFirstChild("HandleR", true)
                                    if v572 then
                                        local v573 = Instance.new("Motor6D")
                                        v573.Name = "WeaponAttachmentHandleR"
                                        v573.Part0 = v570
                                        v573.Part1 = v572
                                        v573.Parent = v570
                                        if v569 then
                                            local v574 = v569:FindFirstChild("C0RIGHT")
                                            if v574 then
                                                v573.C0 = v574.Value
                                            end
                                            local v575 = v569:FindFirstChild("C1RIGHT")
                                            if v575 then
                                                v573.C1 = v575.Value
                                            end
                                        end
                                    end
                                    local v576 = v559:FindFirstChild("HandleL", true)
                                    if v576 then
                                        local v577 = Instance.new("Motor6D")
                                        v577.Name = "WeaponAttachmentHandleL"
                                        v577.Part0 = v571
                                        v577.Part1 = v576
                                        v577.Parent = v571
                                        if v569 then
                                            local v578 = v569:FindFirstChild("C0LEFT")
                                            if v578 then
                                                v577.C0 = v578.Value
                                            end
                                            local v579 = v569:FindFirstChild("C1LEFT")
                                            if v579 then
                                                v577.C1 = v579.Value
                                            end
                                        end
                                    end
                                end
                            else
                                local v580 = Instance.new("Motor6D")
                                v580.Name = "WeaponAttachment"
                                v580.Part0 = v560
                                v580.Part1 = v559.PrimaryPart
                                v580.Parent = v560
                                if v569 then
                                    local v581 = v569:FindFirstChild("C0")
                                    if v581 then
                                        v580.C0 = v581.Value
                                    end
                                    local v582 = v569:FindFirstChild("C1")
                                    if v582 then
                                        v580.C1 = v582.Value
                                    end
                                end
                            end
                            v_u_74[p539] = v559
                            v_u_78[p539] = p540._id
                            local v583 = v541:FindFirstChildOfClass("Humanoid")
                            if v583 then
                                local v584 = v583:FindFirstChildOfClass("Animator")
                                if v584 then
                                    local v585 = nil
                                    if p540.Type == "Melee" then
                                        v585 = "Melee"
                                    elseif v565 then
                                        v585 = v_u_102(v565.Type, v565.AimingOptions, v565.MuzzleType, v565.Class)
                                    else
                                        local v586, v587 = pcall(v_u_21, p540.Name)
                                        if v586 and v587 then
                                            v585 = v_u_102(v587.Type, v587.AimingOptions, v587.MuzzleType, v587.Class)
                                        end
                                    end
                                    if v585 then
                                        local v588 = p540.Name
                                        local v589
                                        if v585 and v_u_26.ANIMATION_MAPPING[v585] then
                                            local v590 = v_u_26.ANIMATION_MAPPING[v585]
                                            if v588 and v590[v588] then
                                                v589 = v590[v588]
                                            else
                                                v589 = v590.Default
                                            end
                                        else
                                            v589 = nil
                                        end
                                        if v589 then
                                            local v591 = v584:LoadAnimation(v589)
                                            v591.Looped = true
                                            v591.Priority = Enum.AnimationPriority.Action
                                            v591:Play()
                                            v_u_75[p539] = v591
                                        end
                                    end
                                end
                            else
                                return
                            end
                        else
                            v559:Destroy()
                            return
                        end
                    else
                        v559:Destroy()
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
local function v_u_601(p593)
    -- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_592
    local v594 = p593 == "CT" and "Counter-Terrorists" or "Terrorists"
    local v595 = v_u_12.Get(v_u_10, "Loadout")
    local v596 = v_u_12.Get(v_u_10, "Inventory")
    if not (v595 and v596) then
        return
    end
    local v597 = v595[v594]
    if not (v597 and v597.Equipped) then
        return
    end
    local v598 = v597.Equipped["Equipped Melee"]
    if v598 and v598 ~= "" then
        for _, v600 in ipairs(v596) do
            if v600._id == v598 then
                goto l16
            end
        end
        local v600 = nil
        ::l16::
        if v600 then
            v_u_592(p593, v600)
            return
        end
    end
    v_u_592(p593, {
        ["_id"] = "default_knife",
        ["Type"] = "Melee",
        ["Serial"] = 0,
        ["Name"] = p593 == "CT" and "CT Knife" or "T Knife",
        ["Skin"] = "Stock",
        ["Float"] = 0,
        ["StatTrack"] = false,
        ["IsTradeable"] = false,
        ["NameTag"] = false,
        ["Charm"] = false
    })
end
function v_u_1.OnLoadoutItemHover(p602)
    -- upvalues: (ref) v_u_28, (copy) v_u_592
    v_u_592(v_u_28 == "Counter-Terrorists" and "CT" or "T", p602)
end
function v_u_1.OnLoadoutItemUnhover() end
local function v_u_620()
    -- upvalues: (copy) v_u_12, (copy) v_u_10, (ref) v_u_93, (copy) v_u_91, (copy) v_u_77, (copy) v_u_592, (copy) v_u_601
    local v_u_603 = v_u_12.Get(v_u_10, "Inventory")
    if v_u_603 then
        local v604 = v_u_93.Teams
        for _, v_u_605 in ipairs({ "CT", "T" }) do
            local v606 = v604:FindFirstChild(v_u_605)
            if v606 then
                local v607 = v606:FindFirstChild("Sidebar")
                if v607 then
                    for _, v_u_608 in ipairs(v_u_91) do
                        local v609 = v607:FindFirstChild(v_u_608)
                        if v609 then
                            local v610 = v609:FindFirstChild("Weapon")
                            if v610 then
                                local v611 = v_u_605 .. "_" .. v_u_608
                                local v612 = v_u_77[v611]
                                if v612 then
                                    if v612.MouseEnter then
                                        v612.MouseEnter:Disconnect()
                                    end
                                    if v612.MouseLeave then
                                        v612.MouseLeave:Disconnect()
                                    end
                                end
                                local v_u_613 = v610:GetAttribute("EquippedItemId")
                                local v_u_614 = v610:GetAttribute("TeamKey")
                                v_u_77[v611] = {
                                    ["MouseEnter"] = v610.MouseEnter:Connect(function()
                                        -- upvalues: (copy) v_u_613, (copy) v_u_603, (copy) v_u_608, (ref) v_u_592, (copy) v_u_614, (copy) v_u_605, (ref) v_u_601
                                        if not v_u_613 or v_u_613 == "" then
                                            if v_u_608 == "Melee" then
                                                v_u_601(v_u_614 or v_u_605)
                                            end
                                            goto l10
                                        end
                                        local v615 = v_u_603
                                        local v616 = v_u_613
                                        for _, v618 in ipairs(v615) do
                                            if v618._id == v616 then
                                                goto l7
                                            end
                                        end
                                        local v618 = nil
                                        ::l7::
                                        if v618 then
                                            local v619 = v_u_608
                                            if v619 == "Melee" and true or v619 == "Zeus" then
                                                v_u_592(v_u_614 or v_u_605, v618)
                                                return
                                            end
                                        end
                                        ::l10::
                                    end),
                                    ["MouseLeave"] = v610.MouseLeave:Connect(function() end)
                                }
                            end
                        end
                    end
                end
            end
        end
    end
end
function v_u_1.SelectTeam(p621)
    -- upvalues: (ref) v_u_93, (ref) v_u_55, (ref) v_u_56, (copy) v_u_6, (ref) v_u_28, (ref) v_u_29, (ref) v_u_33, (ref) v_u_32, (copy) v_u_12, (copy) v_u_10, (copy) v_u_1
    local v622 = v_u_93.Teams
    v622.GunsCT.Visible = p621 == "CT"
    v622.GunsT.Visible = p621 == "T"
    if v_u_55 == nil then
        v_u_55 = v_u_93.Teams.CT.BackgroundTransparency
    end
    if v_u_56 == nil then
        v_u_56 = v_u_93.Teams.T.BackgroundTransparency
    end
    v_u_93.Teams.CT.Visible = true
    v_u_93.Teams.T.Visible = true
    local v623 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v624 = v_u_93.Teams.CT:FindFirstChild("Sidebar")
    local v625 = v_u_93.Teams.T:FindFirstChild("Sidebar")
    local v626 = v_u_93.Teams.CT:FindFirstChild("Equip")
    local v627 = v_u_93.Teams.T:FindFirstChild("Equip")
    local v628
    if v626 then
        v628 = v626:FindFirstChild("Frame")
    else
        v628 = v626
    end
    local v629
    if v627 then
        v629 = v627:FindFirstChild("Frame")
    else
        v629 = v627
    end
    local v630
    if v628 then
        v630 = v628:FindFirstChild("UIStroke")
    else
        v630 = v628
    end
    local v631
    if v629 then
        v631 = v629:FindFirstChild("UIStroke")
    else
        v631 = v629
    end
    if v626 then
        v626 = v626:FindFirstChild("skin")
    end
    if v627 then
        v627 = v627:FindFirstChild("skin")
    end
    local v632 = v_u_93.Teams.CT:FindFirstChild("Player")
    local v633 = v_u_93.Teams.T:FindFirstChild("Player")
    local v634 = Color3.fromRGB(104, 140, 175)
    local v635 = Color3.fromRGB(136, 115, 56)
    local v636 = Color3.fromRGB(0, 0, 0)
    if p621 == "CT" then
        local v637 = {
            ["BackgroundTransparency"] = v_u_55
        }
        v_u_6:Create(v_u_93.Teams.CT, v623, v637):Play()
        v_u_93.Teams.CT.Border.Visible = true
        v_u_6:Create(v_u_93.Teams.T, v623, {
            ["BackgroundTransparency"] = 1
        }):Play()
        v_u_93.Teams.T.Frame.Visible = false
        if v624 then
            v_u_6:Create(v624, v623, {
                ["GroupTransparency"] = 0
            }):Play()
        end
        if v625 then
            v_u_6:Create(v625, v623, {
                ["GroupTransparency"] = 0.65
            }):Play()
        end
        if v632 then
            v_u_6:Create(v632, v623, {
                ["ImageTransparency"] = 0
            }):Play()
        end
        if v633 then
            v_u_6:Create(v633, v623, {
                ["ImageTransparency"] = 0.6
            }):Play()
        end
        if v628 then
            v_u_6:Create(v628, v623, {
                ["BackgroundTransparency"] = 0
            }):Play()
        end
        if v630 then
            v_u_6:Create(v630, v623, {
                ["Transparency"] = 0
            }):Play()
        end
        if v626 then
            v_u_6:Create(v626, v623, {
                ["TextColor3"] = v636
            }):Play()
        end
        if v629 then
            v_u_6:Create(v629, v623, {
                ["BackgroundTransparency"] = 1
            }):Play()
        end
        if v631 then
            v_u_6:Create(v631, v623, {
                ["Transparency"] = 0.6
            }):Play()
        end
        if v627 then
            v_u_6:Create(v627, v623, {
                ["TextColor3"] = v635
            }):Play()
        end
    else
        local v638 = {
            ["BackgroundTransparency"] = v_u_56
        }
        v_u_6:Create(v_u_93.Teams.T, v623, v638):Play()
        v_u_93.Teams.T.Frame.Visible = true
        v_u_6:Create(v_u_93.Teams.CT, v623, {
            ["BackgroundTransparency"] = 1
        }):Play()
        v_u_93.Teams.CT.Border.Visible = false
        if v624 then
            v_u_6:Create(v624, v623, {
                ["GroupTransparency"] = 0.65
            }):Play()
        end
        if v625 then
            v_u_6:Create(v625, v623, {
                ["GroupTransparency"] = 0
            }):Play()
        end
        if v632 then
            v_u_6:Create(v632, v623, {
                ["ImageTransparency"] = 0.6
            }):Play()
        end
        if v633 then
            v_u_6:Create(v633, v623, {
                ["ImageTransparency"] = 0
            }):Play()
        end
        if v629 then
            v_u_6:Create(v629, v623, {
                ["BackgroundTransparency"] = 0
            }):Play()
        end
        if v631 then
            v_u_6:Create(v631, v623, {
                ["Transparency"] = 0
            }):Play()
        end
        if v627 then
            v_u_6:Create(v627, v623, {
                ["TextColor3"] = v636
            }):Play()
        end
        if v628 then
            v_u_6:Create(v628, v623, {
                ["BackgroundTransparency"] = 1
            }):Play()
        end
        if v630 then
            v_u_6:Create(v630, v623, {
                ["Transparency"] = 0.6
            }):Play()
        end
        if v626 then
            v_u_6:Create(v626, v623, {
                ["TextColor3"] = v634
            }):Play()
        end
    end
    v_u_28 = p621 == "CT" and "Counter-Terrorists" or (p621 == "T" and "Terrorists" or false)
    v_u_29 = nil
    v_u_33 = nil
    v_u_32 = nil
    v_u_93.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = "All Categories"
    v_u_93.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
    local v639 = v_u_12.Get(v_u_10, "Loadout")
    v_u_1.UpdateLoadoutContainer(v639)
    v_u_1.UpdateSidebarFrames(v639)
    v_u_1.UpdateInventoryContainer()
    v_u_1.PopulateCategoryDropdown()
    v_u_1.PopulateWeaponDropdown()
end
function v_u_1.Initialize(p640, p641)
    -- upvalues: (ref) v_u_93, (ref) v_u_42, (ref) v_u_40, (ref) v_u_41, (ref) v_u_43, (ref) v_u_39, (ref) v_u_35, (ref) v_u_34, (ref) v_u_36, (ref) v_u_37, (ref) v_u_38, (copy) v_u_296, (ref) v_u_44, (ref) v_u_45, (ref) v_u_46, (ref) v_u_47, (ref) v_u_48, (ref) v_u_51, (ref) v_u_50, (copy) v_u_5, (copy) v_u_8, (ref) v_u_82, (copy) v_u_1, (ref) v_u_30, (ref) v_u_81, (copy) v_u_205, (ref) v_u_80, (ref) v_u_79, (copy) v_u_163, (copy) v_u_167, (ref) v_u_54, (copy) v_u_17, (copy) v_u_13, (copy) v_u_105, (copy) v_u_16, (copy) v_u_4, (copy) v_u_18, (copy) v_u_3, (copy) v_u_526, (copy) v_u_538, (copy) v_u_601, (ref) v_u_53, (copy) v_u_219, (copy) v_u_12, (copy) v_u_10, (ref) v_u_52, (copy) v_u_620, (copy) v_u_72, (ref) v_u_385, (ref) v_u_384, (ref) v_u_49, (copy) v_u_213, (copy) v_u_225, (ref) v_u_31, (copy) v_u_238, (ref) v_u_29, (ref) v_u_33
    v_u_93 = p641
    v_u_93:GetPropertyChangedSignal("Visible"):Connect(function()
        -- upvalues: (ref) v_u_93, (ref) v_u_42, (ref) v_u_40, (ref) v_u_41, (ref) v_u_43, (ref) v_u_39, (ref) v_u_35, (ref) v_u_34, (ref) v_u_36, (ref) v_u_37, (ref) v_u_38, (ref) v_u_296, (ref) v_u_44, (ref) v_u_45, (ref) v_u_46, (ref) v_u_47, (ref) v_u_48, (ref) v_u_51, (ref) v_u_50, (ref) v_u_5, (ref) v_u_8, (ref) v_u_82, (ref) v_u_1, (ref) v_u_30, (ref) v_u_81, (ref) v_u_205
        if v_u_93.Visible then
            if v_u_82 then
                v_u_82 = false
                v_u_1.SortBySkinMetadata(v_u_30)
            end
            if v_u_81 then
                v_u_205()
            end
        else
            if v_u_42 then
                v_u_42:Disconnect()
                v_u_42 = nil
            end
            v_u_40 = nil
            v_u_41 = nil
            v_u_43 = false
            if v_u_39 then
                v_u_39:Disconnect()
                v_u_39 = nil
            end
            if v_u_35 then
                v_u_35:Destroy()
                v_u_35 = nil
            end
            v_u_34 = false
            v_u_36 = nil
            v_u_37 = nil
            v_u_38 = nil
            v_u_296()
            v_u_44 = nil
            v_u_45 = false
            v_u_46 = nil
            v_u_47 = nil
            v_u_48 = nil
            v_u_51 = false
            if v_u_50 then
                v_u_50 = false
                pcall(function()
                    -- upvalues: (ref) v_u_5
                    v_u_5:DisableGamepadCursor()
                end)
                v_u_8.AutoSelectGuiEnabled = true
            end
            v_u_296()
        end
    end)
    local v642 = v_u_93.Tabs.Container.Container
    v642:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        -- upvalues: (ref) v_u_93, (ref) v_u_80, (ref) v_u_79, (ref) v_u_163
        if v_u_93 then
            local v643 = v_u_93.Tabs.Container.Container
            local v644 = v643.CanvasPosition.Y
            local v645 = v643.AbsoluteCanvasSize.Y - v643.AbsoluteSize.Y
            if v645 > 0 and (v_u_80 < #v_u_79 and v645 - v644 < 200) then
                v_u_163()
            end
        else
            return
        end
    end)
    v642:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
        -- upvalues: (ref) v_u_167
        task.defer(v_u_167)
    end)
    local v_u_646 = p640:FindFirstChild("Menu")
    if v_u_646 then
        v_u_646:GetPropertyChangedSignal("Visible"):Connect(function()
            -- upvalues: (copy) v_u_646, (ref) v_u_42, (ref) v_u_40, (ref) v_u_41, (ref) v_u_43, (ref) v_u_39, (ref) v_u_35, (ref) v_u_34, (ref) v_u_36, (ref) v_u_37, (ref) v_u_38, (ref) v_u_296, (ref) v_u_44, (ref) v_u_45, (ref) v_u_46, (ref) v_u_47, (ref) v_u_48, (ref) v_u_51, (ref) v_u_50, (ref) v_u_5, (ref) v_u_8, (ref) v_u_93, (ref) v_u_54, (ref) v_u_17, (ref) v_u_13
            if not v_u_646.Visible then
                if v_u_42 then
                    v_u_42:Disconnect()
                    v_u_42 = nil
                end
                v_u_40 = nil
                v_u_41 = nil
                v_u_43 = false
                if v_u_39 then
                    v_u_39:Disconnect()
                    v_u_39 = nil
                end
                if v_u_35 then
                    v_u_35:Destroy()
                    v_u_35 = nil
                end
                v_u_34 = false
                v_u_36 = nil
                v_u_37 = nil
                v_u_38 = nil
                v_u_296()
                v_u_44 = nil
                v_u_45 = false
                v_u_46 = nil
                v_u_47 = nil
                v_u_48 = nil
                v_u_51 = false
                if v_u_50 then
                    v_u_50 = false
                    pcall(function()
                        -- upvalues: (ref) v_u_5
                        v_u_5:DisableGamepadCursor()
                    end)
                    v_u_8.AutoSelectGuiEnabled = true
                end
                v_u_296()
                local v647 = v_u_93.ActionFrame
                if v647 then
                    v647.Visible = false
                end
                v_u_54 = nil
                if v_u_17.IsInspectActive() then
                    v_u_13.broadcastRouter("WeaponInspectClose")
                end
            end
        end)
    end
    local v_u_648 = v_u_93.ActionFrame
    if v_u_648 then
        v_u_648.Visible = false
        local v649 = v_u_648:FindFirstChild("Inspect")
        if v649 then
            v649.MouseButton1Click:Connect(v_u_105)
        end
        local v650 = v_u_648:FindFirstChild("Charm")
        if v650 then
            v650.MouseButton1Click:Connect(function()
                -- upvalues: (ref) v_u_54, (ref) v_u_93, (ref) v_u_16
                if v_u_54 then
                    local v651 = v_u_54
                    local v652
                    if v651.Charm == nil or v651.Charm == false then
                        v652 = false
                    else
                        local v653 = v651.Charm
                        if type(v653) == "string" or v651.Charm == true then
                            v652 = true
                        else
                            local v654 = v651.Charm
                            v652 = type(v654) == "table"
                        end
                    end
                    local v655 = v_u_93.ActionFrame
                    if v655 then
                        v655.Visible = false
                    end
                    v_u_54 = nil
                    if v652 then
                        v_u_16.Inventory.RemoveWeaponCharm.Send({
                            ["WeaponId"] = v651._id
                        })
                    end
                end
            end)
        end
        v_u_4.InputBegan:Connect(function(p656, p657)
            -- upvalues: (copy) v_u_648, (ref) v_u_54, (ref) v_u_4, (ref) v_u_93
            if not p657 then
                if p656.UserInputType == Enum.UserInputType.MouseButton1 or (p656.UserInputType == Enum.UserInputType.MouseButton2 or p656.UserInputType == Enum.UserInputType.Touch) then
                    task.defer(function()
                        -- upvalues: (ref) v_u_648, (ref) v_u_54, (ref) v_u_4, (ref) v_u_93
                        if v_u_648.Visible and v_u_54 then
                            local v658 = v_u_4:GetMouseLocation()
                            local v659 = v_u_648.AbsolutePosition
                            local v660 = v_u_648.AbsoluteSize
                            local v661
                            if v658.X >= v659.X then
                                v661 = v658.X <= v659.X + v660.X
                            else
                                v661 = false
                            end
                            local v662
                            if v658.Y >= v659.Y then
                                v662 = v658.Y <= v659.Y + v660.Y
                            else
                                v662 = false
                            end
                            if not (v661 and v662) then
                                local v663 = v_u_93.ActionFrame
                                if v663 then
                                    v663.Visible = false
                                end
                                v_u_54 = nil
                            end
                        end
                    end)
                end
            end
        end)
    end
    task.spawn(function()
        -- upvalues: (ref) v_u_18, (ref) v_u_3
        local v664 = {}
        for _, v665 in pairs(v_u_18) do
            table.insert(v664, v665)
        end
        v_u_3:PreloadAsync(v664)
    end)
    v_u_526()
    v_u_538("CT")
    v_u_538("T")
    v_u_601("CT")
    v_u_601("T")
    local v666 = v_u_93.Teams
    for _, v667 in ipairs({ v666.GunsCT, v666.GunsT }) do
        for _, v_u_668 in ipairs({ "Mid Tier", "Pistols", "Rifles" }) do
            local v_u_669 = v667:FindFirstChild(v_u_668)
            if v_u_669 and v_u_669:IsA("Frame") then
                v_u_669.MouseEnter:Connect(function()
                    -- upvalues: (ref) v_u_53, (copy) v_u_668, (ref) v_u_219, (copy) v_u_669
                    v_u_53 = v_u_668
                    v_u_219(v_u_669, true)
                end)
                v_u_669.MouseLeave:Connect(function()
                    -- upvalues: (ref) v_u_53, (ref) v_u_219, (copy) v_u_669
                    v_u_53 = nil
                    v_u_219(v_u_669, false)
                end)
            end
        end
    end
    v_u_12.CreateListener(v_u_10, "Loadout", function(p670)
        -- upvalues: (ref) v_u_52, (ref) v_u_1, (ref) v_u_538, (ref) v_u_620, (ref) v_u_93, (ref) v_u_72
        v_u_52 = false
        v_u_1.UpdateLoadoutContainer(p670)
        v_u_1.UpdateSidebarFrames(p670, "Counter-Terrorists")
        v_u_1.UpdateSidebarFrames(p670, "Terrorists")
        v_u_538("CT")
        v_u_538("T")
        v_u_620()
        if v_u_93 and v_u_93.Visible then
            local v671 = v_u_93.Tabs.Container.Container
            for _, v672 in ipairs(v671:GetChildren()) do
                if v672:IsA("Frame") and (v672.Name ~= "UIGridLayout" and (v672.Name ~= "UIListLayout" and v672.Name ~= "UIPadding")) then
                    v_u_72(v672, v672.Name)
                end
            end
        end
    end)
    v_u_16.Inventory.LoadoutResponse.Listen(function()
        -- upvalues: (ref) v_u_52
        v_u_52 = false
    end)
    v_u_12.CreateListener(v_u_10, "Inventory", function()
        -- upvalues: (ref) v_u_1, (ref) v_u_93, (ref) v_u_72
        v_u_1.UpdateInventoryContainer()
        if v_u_93 and v_u_93.Visible then
            local v673 = v_u_93.Tabs.Container.Container
            for _, v674 in ipairs(v673:GetChildren()) do
                if v674:IsA("Frame") and (v674.Name ~= "UIGridLayout" and (v674.Name ~= "UIListLayout" and v674.Name ~= "UIPadding")) then
                    v_u_72(v674, v674.Name)
                end
            end
        end
    end)
    v_u_4.InputEnded:Connect(function(p675, _)
        -- upvalues: (ref) v_u_34, (ref) v_u_40, (ref) v_u_1
        if (p675.UserInputType == Enum.UserInputType.MouseButton1 or p675.UserInputType == Enum.UserInputType.Touch) and (v_u_34 or v_u_40) then
            v_u_1.EndDrag()
        end
    end)
    v_u_4.InputBegan:Connect(function(p676, _)
        -- upvalues: (ref) v_u_44, (ref) v_u_50, (ref) v_u_51, (ref) v_u_385
        if p676.UserInputType == Enum.UserInputType.Gamepad1 then
            if p676.KeyCode == Enum.KeyCode.ButtonA then
                if v_u_44 and v_u_50 then
                    v_u_51 = true
                    return
                end
            elseif p676.KeyCode == Enum.KeyCode.ButtonB then
                v_u_385()
            end
        end
    end)
    v_u_4.InputEnded:Connect(function(p677, _)
        -- upvalues: (ref) v_u_44, (ref) v_u_50, (ref) v_u_51, (ref) v_u_384
        if p677.UserInputType == Enum.UserInputType.Gamepad1 then
            if p677.KeyCode == Enum.KeyCode.ButtonA and (v_u_44 and (v_u_50 and v_u_51)) then
                v_u_384()
            end
        end
    end)
    v_u_4.LastInputTypeChanged:Connect(function(p678)
        -- upvalues: (ref) v_u_49, (ref) v_u_44, (ref) v_u_45, (ref) v_u_46, (ref) v_u_47, (ref) v_u_48, (ref) v_u_51, (ref) v_u_50, (ref) v_u_5, (ref) v_u_8, (ref) v_u_296, (ref) v_u_42, (ref) v_u_40, (ref) v_u_41, (ref) v_u_43, (ref) v_u_39, (ref) v_u_35, (ref) v_u_34, (ref) v_u_36, (ref) v_u_37, (ref) v_u_38
        local v679 = v_u_49
        v_u_49 = p678 == Enum.UserInputType.Gamepad1
        if v679 and not v_u_49 then
            v_u_44 = nil
            v_u_45 = false
            v_u_46 = nil
            v_u_47 = nil
            v_u_48 = nil
            v_u_51 = false
            if v_u_50 then
                v_u_50 = false
                pcall(function()
                    -- upvalues: (ref) v_u_5
                    v_u_5:DisableGamepadCursor()
                end)
                v_u_8.AutoSelectGuiEnabled = true
            end
            v_u_296()
        end
        if not v679 and v_u_49 then
            if v_u_42 then
                v_u_42:Disconnect()
                v_u_42 = nil
            end
            v_u_40 = nil
            v_u_41 = nil
            v_u_43 = false
            if v_u_39 then
                v_u_39:Disconnect()
                v_u_39 = nil
            end
            if v_u_35 then
                v_u_35:Destroy()
                v_u_35 = nil
            end
            v_u_34 = false
            v_u_36 = nil
            v_u_37 = nil
            v_u_38 = nil
            v_u_296()
        end
    end)
    v_u_49 = v_u_4:GetLastInputType() == Enum.UserInputType.Gamepad1
    local v680 = v_u_93.Tabs.Container.SkinSort.Sort
    local v_u_681 = v680.Options
    v680.MouseButton1Click:Connect(function()
        -- upvalues: (copy) v_u_681, (ref) v_u_93
        local v682 = v_u_681.Visible
        local v683 = v_u_93.Tabs.Container.SkinSort.Sort.Options
        local v684 = v_u_93.Tabs.Container.WeaponSort.Category
        local v685 = v_u_93.Tabs.Container.WeaponSort.Weapon
        v683.Visible = false
        if v684.ScrollingFrame then
            v684.ScrollingFrame.Visible = false
        end
        local v686 = v685:FindFirstChild("Options")
        if v686 then
            v686.Visible = false
        end
        v_u_681.Visible = not v682
    end)
    for _, v_u_687 in ipairs(v_u_681:GetChildren()) do
        if v_u_687:IsA("TextButton") then
            v_u_687.MouseEnter:Connect(function()
                -- upvalues: (ref) v_u_213, (copy) v_u_687
                v_u_213(v_u_687, true)
            end)
            v_u_687.MouseLeave:Connect(function()
                -- upvalues: (ref) v_u_213, (copy) v_u_687
                v_u_213(v_u_687, false)
            end)
            v_u_687.MouseButton1Click:Connect(function()
                -- upvalues: (ref) v_u_1, (copy) v_u_687, (ref) v_u_225, (copy) v_u_681
                v_u_1.SortBySkinMetadata(v_u_687.Name)
                v_u_225(v_u_681, v_u_687.Name)
                v_u_681.Visible = false
            end)
        end
    end
    local v688 = v_u_93.Tabs.Container.SkinSort.ReverseSort
    if v688 then
        local v_u_689 = v688:FindFirstChildOfClass("ImageLabel")
        local function v690()
            -- upvalues: (ref) v_u_31, (copy) v_u_689, (ref) v_u_1, (ref) v_u_30, (ref) v_u_13
            v_u_31 = not v_u_31
            if v_u_689 then
                v_u_689.Rotation = v_u_31 and 180 or 0
            end
            v_u_1.SortBySkinMetadata(v_u_30)
            v_u_13.broadcastRouter("RunInterfaceSound", "UI Click")
        end
        v688.Selectable = true
        v688.MouseButton1Click:Connect(v690)
        v688.Activated:Connect(function(p691)
            -- upvalues: (ref) v_u_31, (copy) v_u_689, (ref) v_u_1, (ref) v_u_30, (ref) v_u_13
            if p691 and p691.UserInputType == Enum.UserInputType.Gamepad1 then
                v_u_31 = not v_u_31
                if v_u_689 then
                    v_u_689.Rotation = v_u_31 and 180 or 0
                end
                v_u_1.SortBySkinMetadata(v_u_30)
                v_u_13.broadcastRouter("RunInterfaceSound", "UI Click")
            end
        end)
    end
    local v_u_692 = v_u_93.Tabs.Container.WeaponSort.Category
    local v_u_693 = v_u_692.ScrollingFrame
    if v_u_693 then
        v_u_238(v_u_693)
        v_u_692.MouseButton1Click:Connect(function()
            -- upvalues: (copy) v_u_693, (ref) v_u_93
            local v694 = v_u_693.Visible
            local v695 = v_u_93.Tabs.Container.SkinSort.Sort.Options
            local v696 = v_u_93.Tabs.Container.WeaponSort.Category
            local v697 = v_u_93.Tabs.Container.WeaponSort.Weapon
            v695.Visible = false
            if v696.ScrollingFrame then
                v696.ScrollingFrame.Visible = false
            end
            local v698 = v697:FindFirstChild("Options")
            if v698 then
                v698.Visible = false
            end
            v_u_693.Visible = not v694
        end)
    end
    local v_u_699 = v_u_93.Tabs.Container.WeaponSort.Weapon
    local v_u_700 = v_u_699:FindFirstChild("Options")
    if v_u_700 and (v_u_700:IsA("Frame") or v_u_700:IsA("ScrollingFrame")) then
        v_u_238(v_u_700)
        v_u_699.MouseButton1Click:Connect(function()
            -- upvalues: (copy) v_u_700, (ref) v_u_93
            local v701 = v_u_700.Visible
            local v702 = v_u_93.Tabs.Container.SkinSort.Sort.Options
            local v703 = v_u_93.Tabs.Container.WeaponSort.Category
            local v704 = v_u_93.Tabs.Container.WeaponSort.Weapon
            v702.Visible = false
            if v703.ScrollingFrame then
                v703.ScrollingFrame.Visible = false
            end
            local v705 = v704:FindFirstChild("Options")
            if v705 then
                v705.Visible = false
            end
            v_u_700.Visible = not v701
        end)
    end
    local v_u_706 = v_u_93.Tabs.Container.WeaponSort:FindFirstChild("Reset")
    if v_u_706 then
        v_u_706.Visible = false
        v_u_706.MouseButton1Click:Connect(function()
            -- upvalues: (ref) v_u_29, (ref) v_u_33, (copy) v_u_692, (copy) v_u_699, (copy) v_u_706, (ref) v_u_1, (ref) v_u_93, (ref) v_u_30
            v_u_29 = nil
            v_u_33 = nil
            v_u_692.Frame.TextLabel.Text = "All Categories"
            v_u_699.Frame.TextLabel.Text = "All Weapons"
            v_u_706.Visible = false
            v_u_1.PopulateWeaponDropdown()
            local v707 = v_u_93.Tabs.Container.Container
            for _, v708 in ipairs(v707:GetChildren()) do
                if v708:IsA("Frame") then
                    v708.Visible = true
                end
            end
            v_u_1.SortBySkinMetadata(v_u_30)
        end)
    end
end
function v_u_1.ViewInLoadout(p709)
    -- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_21, (ref) v_u_29, (ref) v_u_93, (copy) v_u_1, (copy) v_u_17
    local v710 = v_u_12.Get(v_u_10, "Inventory")
    for _, v712 in ipairs(v710) do
        if v712._id == p709 then
            goto l4
        end
    end
    local v712 = nil
    ::l4::
    if v712 then
        local v713 = v712.Name
        local v714 = v712.Skin
        local v715, v716 = pcall(v_u_21, v713)
        if v715 and (v716 and v716.Type) then
            v_u_29 = v716.Type
            v_u_93.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = v716.Type
            v_u_1.PopulateWeaponDropdown()
        end
        v_u_93.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = v713
        v_u_1.SortByWeapon(v713, v714)
        local v717 = v_u_93.Tabs.Container.WeaponSort:FindFirstChild("Reset")
        if v717 then
            local v718 = v_u_93.Tabs.Container.WeaponSort.Weapon
            v717.Visible = v_u_29 ~= nil and true or v718.Frame.TextLabel.Text ~= "All Weapons"
        end
        if not v_u_93.Visible then
            v_u_17.SetScreen("Loadout")
            v_u_93.Visible = true
        end
    else
        return
    end
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_1, (copy) v_u_620, (copy) v_u_225, (ref) v_u_93, (ref) v_u_29, (ref) v_u_33, (ref) v_u_32, (ref) v_u_30, (copy) v_u_91, (ref) v_u_28
    v_u_12.WaitForDataLoaded(v_u_10)
    v_u_1.SelectTeam("CT")
    local v719 = v_u_12.Get(v_u_10, "Loadout")
    if v719 then
        v_u_1.UpdateSidebarFrames(v719, "Counter-Terrorists")
        v_u_1.UpdateSidebarFrames(v719, "Terrorists")
        v_u_620()
    end
    v_u_1.PopulateCategoryDropdown()
    v_u_1.PopulateWeaponDropdown()
    v_u_1.SortBySkinMetadata("Newest")
    v_u_225(v_u_93.Tabs.Container.SkinSort.Sort.Options, "Newest")
    local function v_u_724()
        -- upvalues: (ref) v_u_29, (ref) v_u_33, (ref) v_u_32, (ref) v_u_93, (ref) v_u_1, (ref) v_u_30
        v_u_29 = nil
        v_u_33 = nil
        v_u_32 = nil
        v_u_93.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = "All Categories"
        v_u_93.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
        local v720 = v_u_93.Tabs.Container.Container
        for _, v721 in ipairs(v720:GetChildren()) do
            if v721:IsA("Frame") then
                v721.Visible = true
            end
        end
        v_u_1.SortBySkinMetadata(v_u_30)
        local v722 = v_u_93.Tabs.Container.WeaponSort:FindFirstChild("Reset")
        if v722 then
            local v723 = v_u_93.Tabs.Container.WeaponSort.Weapon
            v722.Visible = v_u_29 ~= nil and true or v723.Frame.TextLabel.Text ~= "All Weapons"
        end
    end
    local v_u_725 = {}
    local function v_u_738()
        -- upvalues: (ref) v_u_93, (ref) v_u_91, (ref) v_u_32, (copy) v_u_724, (ref) v_u_29, (ref) v_u_33, (ref) v_u_1, (ref) v_u_30, (copy) v_u_725
        local v726 = v_u_93.Teams
        for _, v_u_727 in ipairs({ "CT", "T" }) do
            local v728 = v726:FindFirstChild(v_u_727)
            if v728 then
                local v729 = v728:FindFirstChild("Sidebar")
                if v729 then
                    for _, v_u_730 in ipairs(v_u_91) do
                        local v731 = v729:FindFirstChild(v_u_730)
                        if v731 then
                            local v732 = v731:FindFirstChild("Button")
                            if v732 then
                                local function v736()
                                    -- upvalues: (ref) v_u_32, (copy) v_u_727, (copy) v_u_730, (ref) v_u_724, (ref) v_u_29, (ref) v_u_33, (ref) v_u_93, (ref) v_u_1, (ref) v_u_30
                                    local v733 = v_u_32
                                    if v733 then
                                        if v_u_32.teamKey == v_u_727 then
                                            v733 = v_u_32.sidebarName == v_u_730
                                        else
                                            v733 = false
                                        end
                                    end
                                    if v733 then
                                        v_u_32 = nil
                                        v_u_724()
                                    else
                                        v_u_29 = nil
                                        v_u_33 = nil
                                        v_u_93.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = "All Categories"
                                        v_u_93.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
                                        v_u_32 = {
                                            ["teamKey"] = v_u_727,
                                            ["sidebarName"] = v_u_730
                                        }
                                        v_u_1.SortBySkinMetadata(v_u_30)
                                        local v734 = v_u_93.Tabs.Container.WeaponSort:FindFirstChild("Reset")
                                        if v734 then
                                            local v735 = v_u_93.Tabs.Container.WeaponSort.Weapon
                                            v734.Visible = v_u_29 ~= nil and true or v735.Frame.TextLabel.Text ~= "All Weapons"
                                        end
                                    end
                                end
                                local v737 = ("%*_%*"):format(v_u_727, v_u_730)
                                if v_u_725[v737] then
                                    v_u_725[v737]:Disconnect()
                                end
                                v_u_725[v737] = v732.MouseButton1Click:Connect(v736)
                            end
                        end
                    end
                end
            end
        end
    end
    v_u_738()
    v_u_93.Teams.ButtonCT.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_28, (ref) v_u_1, (ref) v_u_93, (ref) v_u_32, (ref) v_u_29, (ref) v_u_33, (ref) v_u_30, (copy) v_u_738
        if v_u_28 ~= "Counter-Terrorists" then
            v_u_1.SelectTeam("CT")
            v_u_93.Teams.ButtonCT.Interactable = false
            v_u_93.Teams.ButtonT.Interactable = true
            v_u_32 = nil
            v_u_29 = nil
            v_u_33 = nil
            v_u_93.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = "All Categories"
            v_u_93.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
            local v739 = v_u_93.Tabs.Container.Container
            for _, v740 in ipairs(v739:GetChildren()) do
                if v740:IsA("Frame") then
                    v740.Visible = true
                end
            end
            v_u_1.SortBySkinMetadata(v_u_30)
            local v741 = v_u_93.Tabs.Container.WeaponSort:FindFirstChild("Reset")
            if v741 then
                local v742 = v_u_93.Tabs.Container.WeaponSort.Weapon
                v741.Visible = v_u_29 ~= nil and true or v742.Frame.TextLabel.Text ~= "All Weapons"
            end
            task.defer(v_u_738)
        end
    end)
    v_u_93.Teams.ButtonT.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_28, (ref) v_u_1, (ref) v_u_93, (ref) v_u_32, (copy) v_u_724, (copy) v_u_738
        if v_u_28 ~= "Terrorists" then
            v_u_1.SelectTeam("T")
            v_u_93.Teams.ButtonT.Interactable = false
            v_u_93.Teams.ButtonCT.Interactable = true
            v_u_32 = nil
            v_u_724()
            task.defer(v_u_738)
        end
    end)
    v_u_93.Teams.ButtonCT.Interactable = false
    v_u_93.Teams.ButtonT.Interactable = true
end
return v_u_1
