-- MODULESCRIPT: Inventory
-- Original Path: game.BAC - 20621.Interface.Screens.Menu.Inventory
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("TextService")
local v_u_6 = game:GetService("RunService")
local v_u_7 = game:GetService("GuiService")
local v_u_8 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_9 = v_u_8.LocalPlayer
local v_u_10 = v_u_9:GetMouse()
local v_u_11 = require(v_u_2.Controllers.DataController)
local v_u_12 = require(v_u_2.Database.Components.Libraries.Collections)
local v13 = require(v_u_2.Components.Common.GetUserPlatform)
local v_u_14 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_15 = require(v_u_2.Database.Components.Libraries.Cases)
local v_u_16 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_17 = require(v_u_2.Components.Common.GetSkinDisplayName)
local v_u_18 = require(v_u_2.Components.Common.GetResolvedSkinInformation)
local v_u_19 = require(v_u_2.Database.Security.Remotes)
local v_u_20 = require(v_u_2.Database.Security.Router)
local v_u_21 = require(v_u_2.Database.Custom.GameStats.UI.Inventory.Buttons)
local v_u_22 = require(v_u_2.Database.Custom.GameStats.UI.Inventory.Sort)
local v_u_23 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_24 = require(v_u_2.Database.Custom.GameStats.Grenades)
local v_u_25 = require(script.Parent.UseItemFrame)
local v_u_26 = require(script.Parent.Loadout)
local v_u_27 = require(script.Parent.Store)
local v_u_28 = require(v_u_2.Interface.Screens.Menu.Top)
local v_u_29 = require(v_u_2.Shared.CloseButtonRegistry)
local v_u_30 = require(v_u_2.Interface.MenuState)
local v_u_31 = Color3.fromRGB(53, 83, 99)
local v_u_32 = Color3.fromRGB(243, 243, 243)
local v_u_33 = Color3.fromRGB(125, 206, 243)
local v_u_34 = {}
local v_u_35 = table.find(v13(), "PC") ~= nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = 0
local v_u_41 = false
local v_u_42 = nil
local v_u_43 = nil
local v_u_44 = false
local v_u_45 = false
local v_u_46 = false
local v_u_47 = false
local v_u_48 = nil
local v_u_49 = 0
local v_u_50 = nil
local v_u_51 = nil
local v_u_52 = {}
local v_u_53 = nil
local v_u_54 = nil
local v_u_55 = nil
local v_u_56 = {}
local v_u_57 = false
local v_u_58 = {
    ["Charm Capsule"] = "Charm Pack",
    ["Package"] = "Package"
}
local v_u_59 = {
    ["Glove"] = "Equipped Gloves",
    ["Badge"] = "Equipped Badge",
    ["Zeus x27"] = "Equipped Zeus x27"
}
local function v_u_61()
    -- upvalues: (ref) v_u_53
    if not v_u_53 then
        return false
    end
    if v_u_53.Charm and v_u_53.Charm.Visible then
        return true
    end
    if v_u_53.Inspect and v_u_53.Inspect.Visible then
        return true
    end
    if v_u_53.ReplaceCT and v_u_53.ReplaceCT.Visible then
        return true
    end
    if v_u_53.ReplaceT and v_u_53.ReplaceT.Visible then
        return true
    end
    if v_u_53.Unlock and v_u_53.Unlock.Visible then
        return true
    end
    local v60 = v_u_53:FindFirstChild("QuickUnlock")
    return v60 and v60.Visible and true or false
end
local function v_u_66(p62, p63)
    local v64 = p62:GetChildren()
    for _, v65 in ipairs(v64) do
        if v65.ClassName == p63 then
            v65:Destroy()
        end
    end
end
local function v_u_74(p67, p68)
    -- upvalues: (copy) v_u_11, (copy) v_u_9
    local v69 = v_u_11.Get(v_u_9, "Loadout")
    if not v69 then
        return false
    end
    local v70 = v69[p68]
    if not v70 then
        return false
    end
    if v70.Loadout then
        for _, v71 in pairs(v70.Loadout) do
            if v71 and v71.Options then
                for _, v72 in ipairs(v71.Options) do
                    if v72 == p67 then
                        return true
                    end
                end
            end
        end
    end
    if v70.Equipped then
        for _, v73 in pairs(v70.Equipped) do
            if v73 == p67 then
                return true
            end
        end
    end
    return false
end
local function v_u_82(p75, p76)
    -- upvalues: (copy) v_u_74
    local v77 = p75:FindFirstChild("Status")
    if v77 then
        local v78 = v77:FindFirstChild("Counter-Terrorists")
        local v79 = v77:FindFirstChild("Terrorists")
        if v78 and v79 then
            local v80 = v_u_74(p76, "Counter-Terrorists")
            local v81 = v_u_74(p76, "Terrorists")
            v78.Visible = v80
            v79.Visible = v81
        end
    end
end
local function v_u_83()
    -- upvalues: (copy) v_u_11, (copy) v_u_9
    -- failed to decompile
end
local function v_u_102(p84, p85)
    -- upvalues: (copy) v_u_16, (copy) v_u_83, (copy) v_u_19, (copy) v_u_28, (copy) v_u_9, (copy) v_u_26, (copy) v_u_59
    if p84.Type == "Weapon" then
        local v_u_86 = p84.Name
        local v87 = {
            ["Pistol"] = "Pistols",
            ["SMG"] = "Mid Tier",
            ["Heavy"] = "Mid Tier",
            ["Rifle"] = "Rifles"
        }
        local v88, v89 = pcall(v_u_16, v_u_86)
        local v90
        if v88 and (v89 and v89.Type) then
            v90 = v87[v89.Type]
        else
            v90 = nil
        end
        if v90 then
            local v91, v92 = v_u_83(v_u_86, p85, v90)
            if v91 and v92 then
                v_u_19.Inventory.EquipLoadoutSkin.Send({
                    ["Type"] = v90,
                    ["Slot"] = v92 - 1,
                    ["Team"] = p85,
                    ["Identifier"] = p84._id
                })
            else
                v_u_28.openFrame("Loadout")
                local v93 = v_u_9:WaitForChild("PlayerGui"):FindFirstChild("MainGui")
                if v93 then
                    local v94 = v93:FindFirstChild("Menu")
                    if v94 then
                        local v95 = v94:FindFirstChild("Top")
                        if v95 and v95.Buttons then
                            local v96 = v95.Buttons:FindFirstChild("Loadout")
                            if v96 and v96:IsA("TextButton") then
                                local v97 = game:GetService("TweenService")
                                local v98 = Color3.fromRGB(150, 220, 239)
                                local v99 = Color3.fromRGB(255, 255, 255)
                                for _, v100 in ipairs(v95.Buttons:GetChildren()) do
                                    if v100:IsA("TextButton") and v100 ~= v96 then
                                        v97:Create(v100.TextLabel, TweenInfo.new(0.15), {
                                            ["TextColor3"] = v99
                                        }):Play()
                                    end
                                end
                                v97:Create(v96.TextLabel, TweenInfo.new(0.15), {
                                    ["TextColor3"] = v98
                                }):Play()
                            end
                        end
                    end
                end
                local v101 = p85 == "Counter-Terrorists" and "CT" or "T"
                v_u_26.SelectTeam(v101)
                v_u_26.SortByCategory(nil)
                v_u_26.SortByWeapon(v_u_86)
                task.defer(function()
                    -- upvalues: (ref) v_u_26, (copy) v_u_86
                    v_u_26.SortByWeapon(v_u_86)
                end)
            end
        else
            return
        end
    elseif p84.Type == "Melee" then
        if p84.Name == "CT Knife" then
            if p85 == "Terrorists" then
                return
            end
        elseif p84.Name == "T Knife" and p85 == "Counter-Terrorists" then
            return
        end
        v_u_19.Inventory.EquipSpecialItem.Send({
            ["Identifier"] = p84._id,
            ["Path"] = "Equipped Melee",
            ["Team"] = p85
        })
    elseif v_u_59[p84.Type] then
        v_u_19.Inventory.EquipSpecialItem.Send({
            ["Identifier"] = p84._id,
            ["Path"] = v_u_59[p84.Type],
            ["Team"] = p85
        })
    end
end
local function v_u_109()
    -- upvalues: (copy) v_u_10, (ref) v_u_54, (ref) v_u_53
    local v103 = Vector2.new(v_u_10.X, v_u_10.Y)
    if v_u_54.ItemNotification.Visible then
        return true
    end
    local v104 = v_u_54.Tabs.Inventory.Sort.Button.Options
    if v104.Visible then
        local v105 = v104.AbsolutePosition
        local v106 = v104.AbsoluteSize
        if v103.X >= v105.X and (v103.X <= v105.X + v106.X and (v103.Y >= v105.Y and v103.Y <= v105.Y + v106.Y)) then
            return true
        end
    end
    if v_u_53.Visible then
        local v107 = v_u_53.AbsolutePosition
        local v108 = v_u_53.AbsoluteSize
        if v103.X >= v107.X and (v103.X <= v107.X + v108.X and (v103.Y >= v107.Y and v103.Y <= v107.Y + v108.Y)) then
            return true
        end
    end
    return false
end
local function v_u_125(p110)
    -- upvalues: (ref) v_u_54, (copy) v_u_7
    local v111 = v_u_54.AbsolutePosition
    local v112 = v_u_54.Hover.AbsoluteSize
    local v113 = p110.AbsolutePosition
    local v114 = v_u_54.AbsoluteSize
    local v115 = p110.AbsoluteSize
    local v116 = v113.X - v111.X
    local v117 = v113.Y - v111.Y
    local v118 = v114.X - (v116 + v115.X) >= v112.X + 8 and (v116 + v115.X + 8 + v112.X / 2) / v114.X or (v116 - 8 - v112.X / 2) / v114.X
    local v119 = (v117 + v115.Y / 2) / v114.Y
    local v120 = v112.Y / 2 / v114.Y
    local v121 = math.max(v119, v120)
    local v122 = 1 - v112.Y / 2 / v114.Y
    local v123 = math.min(v121, v122)
    if v_u_7:GetGuiInset().Y >= v111.Y + v123 * v114.Y - v112.Y / 2 then
        local v124 = v123 + 30 / v114.Y
        v123 = math.min(v124, v122)
    end
    return UDim2.fromScale(v118, v123)
end
local function v_u_131(p126, p127, p128)
    -- upvalues: (copy) v_u_14
    if not p127 then
        return ""
    end
    if p128 then
        return p127.imageAssetId or ""
    end
    if p126.Type ~= "Charm" then
        return v_u_14.GetWearImageForFloat(p127, p126.Float or 0.9999) or p127.imageAssetId or ""
    end
    local v129 = p126.Pattern
    if v129 and p127.charmImages then
        for _, v130 in ipairs(p127.charmImages) do
            if v130.pattern == v129 then
                return v130.assetId
            end
        end
    end
    return p127.imageAssetId or ""
end
local function v_u_137(p132)
    -- upvalues: (copy) v_u_15, (ref) v_u_42, (copy) v_u_18
    if p132.Type ~= "Case" then
        local v133 = v_u_18(p132.Name, p132.Skin)
        return v133 and v133.collection or nil
    end
    local v134 = v_u_15.GetCaseByName(p132.Skin)
    if not (v134 and v_u_42) then
        return nil
    end
    for _, v135 in ipairs(v_u_42) do
        if v135.cases then
            for _, v136 in ipairs(v135.cases) do
                if v136 == v134.name then
                    return v135.name
                end
            end
        end
    end
    return nil
end
local function v_u_150()
    -- upvalues: (copy) v_u_11, (copy) v_u_9, (ref) v_u_43, (ref) v_u_54, (copy) v_u_22, (ref) v_u_42, (copy) v_u_24, (ref) v_u_44
    local v138 = v_u_11.Get(v_u_9, "Inventory")
    if not v138 then
        return {}
    end
    local v139 = v_u_43 or (v_u_54.Tabs.Inventory.Sort.Button.Frame.TextLabel.Text or "Newest")
    local v_u_140 = v_u_22.GetSortComparisonFunction(v139, v_u_9, function()
        -- upvalues: (ref) v_u_42
        return v_u_42
    end)
    local v141 = {}
    for _, v142 in v138 do
        local v143
        if v142 then
            v143 = v_u_24[v142.Name]
        else
            v143 = v142
        end
        local v144
        if v142 then
            v144 = v142.Type == "Case" and true or v142.Type == "Package"
        else
            v144 = v142
        end
        local v145 = v142 and (v142._id and v142.Name)
        if v145 then
            v145 = v144 or v142.Skin
        end
        if v145 and not v143 then
            table.insert(v141, v142)
        end
    end
    if v_u_140 then
        if v_u_44 then
            table.sort(v141, function(p146, p147)
                -- upvalues: (copy) v_u_140
                local v148, v149 = v_u_140(p146, p147)
                if v149 then
                    return v148
                else
                    return v_u_140(p147, p146)
                end
            end)
            return v141
        end
        table.sort(v141, v_u_140)
    end
    return v141
end
local function v_u_160(p151, p152)
    -- upvalues: (copy) v_u_21, (copy) v_u_16
    if not p152 or #p152 == 0 then
        return true
    end
    local v153 = v_u_21.GetEffectiveItemType(p151)
    local v154 = v_u_21.IsCapsule(p151)
    for _, v155 in ipairs(p152) do
        if v153 == v155 then
            return true
        end
        if p151.Type and (p151.Type == v155 and not v154) then
            return true
        end
        local v156
        if p151.Name then
            v156 = v_u_16(p151.Name)
        else
            v156 = nil
        end
        if string.find(v155, ":") then
            local v157 = string.split(v155, ":")
            local v158 = v157[1]
            local v159 = v157[2]
            if v158 == "Weapon" and (v156 and (v156.Class == "Weapon" and v156.Type == v159)) then
                return true
            end
        elseif v156 and v156.Class == v155 then
            return true
        end
    end
    return false
end
local function v_u_164(p161)
    -- upvalues: (copy) v_u_52
    CurrentSearchQuery = p161
    table.clear(v_u_52)
    if p161 ~= "" then
        for _, v162 in ipairs(string.split(string.lower(p161), " ")) do
            if v162 ~= "" then
                local v163 = v_u_52
                table.insert(v163, v162)
            end
        end
    end
end
local function v_u_169(p165)
    -- upvalues: (copy) v_u_52
    if #v_u_52 == 0 then
        return true
    end
    local v166 = string.lower(p165.Name or "")
    local v167 = string.lower(p165.Skin or "")
    for _, v168 in ipairs(v_u_52) do
        if string.find(v166, v168, 1, true) == nil and string.find(v167, v168, 1, true) == nil then
            return false
        end
    end
    return true
end
local function v_u_187(p170)
    -- upvalues: (ref) v_u_54, (copy) v_u_21, (copy) v_u_11, (copy) v_u_9, (copy) v_u_160, (copy) v_u_52, (copy) v_u_169
    local v171 = nil
    local v172 = nil
    for _, v173 in ipairs(v_u_54.Top.Filter:GetChildren()) do
        if v173:IsA("TextButton") and v173:GetAttribute("Selected") then
            v172 = v173.Name
            break
        end
    end
    for _, v174 in ipairs(v_u_54.Top.Categories:GetChildren()) do
        if v174:IsA("TextButton") and v174:GetAttribute("Selected") then
            v171 = v174.Name
            break
        end
    end
    local v175 = nil
    if v172 and v171 then
        local v176 = v_u_21[v171]
        if v176 and v176[v172] then
            v175 = v176[v172].Search
        end
    end
    local v177 = {}
    local v178 = v_u_11.Get(v_u_9, "Inventory")
    if v178 then
        for _, v179 in ipairs(v178) do
            if v179.Charm then
                local v180 = v179.Charm
                local v181 = type(v180) == "table" and v179.Charm._id
                if not v181 then
                    local v182 = v179.Charm
                    if type(v182) == "string" then
                        v181 = v179.Charm
                    else
                        v181 = false
                    end
                end
                if v181 then
                    v177[v181] = true
                end
            end
        end
    end
    local v183 = {}
    for _, v184 in ipairs(p170) do
        local v185 = v_u_160(v184, v175)
        if v185 and (v184.Type == "Charm" and v177[v184._id]) then
            v185 = false
        end
        if v185 then
            table.insert(v183, v184)
        end
    end
    if #v_u_52 > 0 then
        v183 = {}
        for _, v186 in ipairs(v183) do
            if v_u_169(v186) then
                table.insert(v183, v186)
            end
        end
    end
    return v183
end
local function v_u_198()
    -- upvalues: (ref) v_u_54, (ref) v_u_49, (ref) v_u_34, (copy) v_u_1
    if v_u_54 then
        local v188 = v_u_54.Tabs.Inventory.Container
        local v189 = v_u_49 + 1
        local v190 = v_u_49 + 25
        local v191 = #v_u_34
        local v192 = math.min(v190, v191)
        for v193 = v189, v192 do
            local v194 = v_u_34[v193]
            if v194 and not v188:FindFirstChild(v194._id) then
                v_u_1.CreateItemTemplate(v194)
            end
        end
        v_u_49 = v192
        for _, v195 in ipairs(v188:GetChildren()) do
            if v195:IsA("Frame") and (v195.Name ~= "UIGridLayout" and (v195.Name ~= "UIListLayout" and v195.Name ~= "UIPadding")) then
                for v196, v197 in ipairs(v_u_34) do
                    if v197._id == v195.Name then
                        v195.LayoutOrder = v196
                        break
                    end
                end
            end
        end
    end
end
local function v_u_201()
    -- upvalues: (ref) v_u_54, (ref) v_u_49, (ref) v_u_34, (copy) v_u_198
    if v_u_54 then
        local v199 = v_u_54.Tabs.Inventory.Container.CanvasPosition.Y
        local v200 = v_u_54.Tabs.Inventory.Container.AbsoluteCanvasSize.Y - v_u_54.Tabs.Inventory.Container.AbsoluteSize.Y
        if v200 > 0 and (v_u_49 < #v_u_34 and v200 - v199 < 200) then
            v_u_198()
            return
        end
    end
end
local function v_u_228()
    -- upvalues: (ref) v_u_54
    if not (v_u_54 and v_u_54.Visible) then
        return 50
    end
    local v202 = v_u_54.Tabs.Inventory.Container
    local v203 = v202:FindFirstChildOfClass("UIGridLayout")
    if not v203 then
        return 50
    end
    local v204 = v202.AbsoluteSize
    local v205 = v204.Y
    local v206 = v204.X
    local v207 = v203.CellSize
    local v208 = v203.CellPadding
    local v209 = v207.Y.Scale * v205 + v207.Y.Offset
    local v210 = v208.Y.Scale * v205 + v208.Y.Offset
    local v211 = v207.X.Scale * v206 + v207.X.Offset
    local v212 = v208.X.Scale * v206 + v208.X.Offset
    local v213 = v202:FindFirstChildOfClass("UIPadding")
    local v214, v215, v216, v217
    if v213 then
        v214 = v213.PaddingTop.Scale * v205 + v213.PaddingTop.Offset
        v215 = v213.PaddingBottom.Scale * v205 + v213.PaddingBottom.Offset
        v216 = v213.PaddingLeft.Scale * v206 + v213.PaddingLeft.Offset
        v217 = v213.PaddingRight.Scale * v206 + v213.PaddingRight.Offset
    else
        v214 = 0
        v215 = 0
        v216 = 0
        v217 = 0
    end
    local v218 = v205 - v214 - v215
    local v219 = v206 - v216 - v217
    local v220 = v211 + v212
    local v221
    if v220 > 0 then
        local v222 = (v219 + v212) / v220
        local v223 = math.floor(v222)
        v221 = math.max(1, v223)
    else
        v221 = 1
    end
    local v224 = v209 + v210
    local v225
    if v224 > 0 then
        local v226 = (v218 + v210) / v224
        local v227 = math.floor(v226)
        v225 = math.max(1, v227)
    else
        v225 = 1
    end
    return v225 * v221 + v221
end
local function v_u_239()
    -- upvalues: (ref) v_u_54, (ref) v_u_49, (copy) v_u_228, (ref) v_u_34, (copy) v_u_1, (ref) v_u_45
    if not (v_u_54 and v_u_54.Visible) then
        return
    end
    local v229 = v_u_54.Tabs.Inventory.Container
    v_u_49 = 0
    local v230 = v_u_228()
    local v231 = math.max(v230, 50)
    local v232 = #v_u_34
    local v233 = math.min(v231, v232)
    for v234 = 1, v233 do
        local v235 = v_u_34[v234]
        if v235 and not v229:FindFirstChild(v235._id) then
            v_u_1.CreateItemTemplate(v235)
        end
    end
    for _, v236 in ipairs(v229:GetChildren()) do
        if v236:IsA("Frame") and (v236.Name ~= "UIGridLayout" and (v236.Name ~= "UIListLayout" and v236.Name ~= "UIPadding")) then
            for v237, v238 in ipairs(v_u_34) do
                if v238._id == v236.Name then
                    v236.LayoutOrder = v237
                    break
                end
            end
        end
    end
    v_u_49 = v233
    v_u_45 = false
end
local function v_u_243()
    -- upvalues: (ref) v_u_54, (ref) v_u_49, (ref) v_u_45, (copy) v_u_239
    if v_u_54 then
        local v240 = v_u_54.Tabs.Inventory.Container
        for _, v241 in ipairs(v240:GetChildren()) do
            local v242 = v241:IsA("Frame")
            if v242 then
                if v241.Name == "UIGridLayout" or (v241.Name == "UIListLayout" or (v241.Name == "UIPadding" or v241.Name == "Title")) then
                    v242 = false
                else
                    v242 = v241.Name ~= "Label"
                end
            end
            if v242 then
                v241:Destroy()
            end
        end
        v_u_49 = 0
        v_u_45 = true
        if v_u_54.Visible then
            v_u_239()
        end
    end
end
local function v_u_251(p_u_244, p_u_245, p_u_246, p_u_247, _)
    -- upvalues: (copy) v_u_4, (copy) v_u_20, (ref) v_u_53, (ref) v_u_43, (ref) v_u_54, (ref) v_u_46, (ref) v_u_45, (ref) v_u_34, (copy) v_u_150, (copy) v_u_187, (copy) v_u_243
    p_u_245.MouseEnter:Connect(function()
        -- upvalues: (ref) v_u_4, (copy) p_u_245
        v_u_4:Create(p_u_245, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["BackgroundTransparency"] = 0.85
        }):Play()
    end)
    p_u_245.MouseLeave:Connect(function()
        -- upvalues: (ref) v_u_4, (copy) p_u_245
        v_u_4:Create(p_u_245, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["BackgroundTransparency"] = 1
        }):Play()
    end)
    p_u_245.Selectable = true
    local function v_u_249()
        -- upvalues: (ref) v_u_20, (ref) v_u_53, (ref) v_u_43, (copy) p_u_246, (ref) v_u_54, (ref) v_u_46, (ref) v_u_45, (ref) v_u_34, (ref) v_u_150, (ref) v_u_187, (ref) v_u_243, (copy) p_u_247, (copy) p_u_244, (copy) p_u_245
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_53 then
            v_u_53.Visible = false
        end
        v_u_43 = p_u_246
        if v_u_54 then
            if v_u_54.Visible then
                v_u_34 = v_u_150()
                v_u_34 = v_u_187(v_u_34)
                v_u_243()
            else
                v_u_46 = true
                v_u_45 = true
            end
        end
        p_u_247.Text = p_u_246
        for _, v248 in ipairs(p_u_244:GetChildren()) do
            if v248:IsA("TextButton") then
                v248.Frame.BackgroundTransparency = v248 == p_u_245 and 0 or 1
            end
        end
        p_u_244.Visible = false
    end
    p_u_245.MouseButton1Click:Connect(v_u_249)
    p_u_245.Activated:Connect(function(p250)
        -- upvalues: (copy) v_u_249
        if p250 and p250.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_249()
        end
    end)
end
local function v_u_276(p_u_252)
    -- upvalues: (copy) v_u_4
    local v_u_253 = p_u_252:FindFirstChild("HoverFrame")
    local v_u_254 = p_u_252.Size
    p_u_252.MouseEnter:Connect(function()
        -- upvalues: (ref) v_u_4, (copy) p_u_252, (copy) v_u_254, (copy) v_u_253
        local v255 = v_u_4
        local v256 = p_u_252
        local v257 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v258 = {}
        local v259 = v_u_254
        v258.Size = UDim2.new(v259.X.Scale * 0.95, v259.X.Offset, v259.Y.Scale * 0.95, v259.Y.Offset)
        v255:Create(v256, v257, v258):Play()
        if v_u_253 and not p_u_252:GetAttribute("Selected") then
            v_u_253.BackgroundTransparency = 1
            v_u_253.Visible = true
            v_u_4:Create(v_u_253, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["BackgroundTransparency"] = 0.85
            }):Play()
        end
    end)
    p_u_252.MouseLeave:Connect(function()
        -- upvalues: (ref) v_u_4, (copy) p_u_252, (copy) v_u_254, (copy) v_u_253
        local v260 = v_u_4
        local v261 = p_u_252
        local v262 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v263 = {}
        local v264 = v_u_254
        v263.Size = UDim2.new(v264.X.Scale * 1, v264.X.Offset, v264.Y.Scale * 1, v264.Y.Offset)
        v260:Create(v261, v262, v263):Play()
        if v_u_253 and not p_u_252:GetAttribute("Selected") then
            local v265 = v_u_4:Create(v_u_253, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["BackgroundTransparency"] = 1
            })
            v265:Play()
            v265.Completed:Once(function()
                -- upvalues: (ref) v_u_253
                v_u_253.Visible = false
            end)
        end
    end)
    p_u_252.MouseButton1Down:Connect(function()
        -- upvalues: (ref) v_u_4, (copy) p_u_252, (copy) v_u_254
        local v266 = v_u_4
        local v267 = p_u_252
        local v268 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v269 = {}
        local v270 = v_u_254
        v269.Size = UDim2.new(v270.X.Scale * 0.9, v270.X.Offset, v270.Y.Scale * 0.9, v270.Y.Offset)
        v266:Create(v267, v268, v269):Play()
    end)
    p_u_252.MouseButton1Up:Connect(function()
        -- upvalues: (ref) v_u_4, (copy) p_u_252, (copy) v_u_254
        local v271 = v_u_4
        local v272 = p_u_252
        local v273 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v274 = {}
        local v275 = v_u_254
        v274.Size = UDim2.new(v275.X.Scale * 0.95, v275.X.Offset, v275.Y.Scale * 0.95, v275.Y.Offset)
        v271:Create(v272, v273, v274):Play()
    end)
end
function v_u_1.CreateItemTemplate(p_u_277)
    -- upvalues: (copy) v_u_15, (copy) v_u_18, (copy) v_u_23, (copy) v_u_131, (copy) v_u_2, (ref) v_u_54, (copy) v_u_16, (copy) v_u_58, (copy) v_u_17, (copy) v_u_82, (copy) v_u_109, (copy) v_u_11, (copy) v_u_9, (copy) v_u_20, (ref) v_u_39, (ref) v_u_36, (copy) v_u_1, (copy) v_u_61, (ref) v_u_53, (copy) v_u_3, (copy) v_u_10, (ref) v_u_38, (ref) v_u_48, (copy) v_u_35, (ref) v_u_37
    if p_u_277 and p_u_277._id then
        local v278 = p_u_277.Type == "Case" and true or p_u_277.Type == "Package"
        local v279 = v278 and v_u_15.GetCaseByName(p_u_277.Skin) or v_u_18(p_u_277.Name, p_u_277.Skin)
        if v279 then
            local v280 = v_u_23[v278 and v279.caseRarity or v279.rarity]
            local v281 = v_u_131(p_u_277, v279, v278)
            local v_u_282 = v_u_2.Assets.UI.Inventory.ItemTemplate:Clone()
            v_u_282.Main.RarityFrame.UIGradient.Color = v280.ColorSequence
            v_u_282.Main.Glow.UIGradient.Color = v280.ColorSequence
            v_u_282.Parent = v_u_54.Tabs.Inventory.Container
            v_u_282.Main.Icon.Image = v281
            v_u_282.Name = p_u_277._id
            local v283 = v_u_16(p_u_277.Name)
            if v283 and v283.InventoryIconData then
                v_u_282.Main.Icon.ScaleType = v283.InventoryIconData.ScaleType or v_u_282.Main.Icon.ScaleType
                v_u_282.Main.Icon.Position = v283.InventoryIconData.Position or v_u_282.Main.Icon.Position
                v_u_282.Main.Icon.Size = v283.InventoryIconData.Size or v_u_282.Main.Icon.Size
            elseif p_u_277.Type == "Case" then
                v_u_282.Main.Icon.ScaleType = Enum.ScaleType.Crop
                v_u_282.Main.Icon.Position = UDim2.fromScale(0.5, 0.45)
                v_u_282.Main.Icon.Size = UDim2.fromScale(1, 1)
            elseif p_u_277.Type == "Package" then
                v_u_282.Main.Icon.ScaleType = Enum.ScaleType.Crop
                v_u_282.Main.Icon.Size = UDim2.fromScale(1, 1)
            end
            local v284 = v278 and v279.caseType and v_u_58[v279.caseType] or v278 and v279.caseType or (p_u_277.StatTrack and "KillTrak\226\132\162 " .. p_u_277.Name or p_u_277.Name)
            local v285 = v_u_17(v278 and v279.skin or (p_u_277.Skin or ""))
            if p_u_277.Type == "Melee" then
                v284 = "\226\152\133 " .. v284
            end
            v_u_282.Information.Weapon.Text = v284
            v_u_282.Information.Skin.Text = v285
            v_u_82(v_u_282, p_u_277._id)
            v_u_282.Button.Selectable = true
            local function v_u_305(p_u_286)
                -- upvalues: (ref) v_u_54, (ref) v_u_109, (ref) v_u_11, (ref) v_u_9, (ref) p_u_277, (ref) v_u_20, (ref) v_u_39, (copy) v_u_282, (ref) v_u_36, (ref) v_u_1, (ref) v_u_61, (ref) v_u_53, (ref) v_u_3, (ref) v_u_10, (ref) v_u_38, (ref) v_u_48
                if v_u_54.ItemNotification.Visible or v_u_109() then
                    return
                end
                local v287 = v_u_11.Get(v_u_9, "Inventory")
                if v287 then
                    for _, v288 in ipairs(v287) do
                        if v288._id == p_u_277._id then
                            p_u_277 = v288
                            break
                        end
                    end
                end
                local v289 = p_u_277.Type == "Case" and true or p_u_277.Type == "Package"
                local v290 = p_u_277.Type == "Charm Capsule" and true or p_u_277.Type == "Sticker Capsule"
                v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                v_u_39 = v_u_282
                v_u_36 = p_u_277
                v_u_1.SetupInformationFrame(p_u_277)
                if v_u_61() then
                    local function v304()
                        -- upvalues: (ref) v_u_53, (ref) v_u_3, (copy) p_u_286, (ref) v_u_282, (ref) v_u_10
                        local v291 = v_u_53.Parent
                        local v292 = v291.AbsolutePosition
                        local v293 = v291.AbsoluteSize
                        local v294, v295
                        if v_u_3:GetLastInputType() == Enum.UserInputType.Gamepad1 or p_u_286 then
                            if v_u_282 and v_u_282:IsA("GuiObject") then
                                local v296 = v_u_282.AbsolutePosition
                                local v297 = v_u_282.AbsoluteSize
                                local v298 = v296.X + v297.X / 2
                                local v299 = v296.Y + v297.Y / 2
                                local v300 = (v298 - v292.X) / v293.X
                                v294 = (v299 - v292.Y) / v293.Y + v_u_53.Size.Y.Scale / 2
                                if 1 - v300 >= v_u_53.Size.X.Scale + 0.01 then
                                    v295 = v300 + v_u_53.Size.X.Scale / 2 + 0.01
                                else
                                    v295 = v300 - v_u_53.Size.X.Scale / 2 - 0.01
                                end
                            else
                                v295 = 0.5
                                v294 = 0.5
                            end
                        else
                            local v301 = v_u_10.X
                            local v302 = v_u_10.Y
                            local v303 = (v301 - v292.X) / v293.X
                            v294 = (v302 - v292.Y) / v293.Y + v_u_53.Size.Y.Scale / 2
                            if 1 - v303 >= v_u_53.Size.X.Scale + 0.01 then
                                v295 = v303 + v_u_53.Size.X.Scale / 2 + 0.01
                            else
                                v295 = v303 - v_u_53.Size.X.Scale / 2 - 0.01
                            end
                        end
                        v_u_53.Position = UDim2.fromScale(v295, v294)
                    end
                    if v289 or v290 then
                        v_u_53.Visible = true
                        v304()
                        v_u_54.Hover.Visible = false
                        if p_u_286 then
                            task.defer(function()
                                -- upvalues: (ref) v_u_1
                                v_u_1.SetupInformationFrameNavigation()
                                v_u_1.SelectFirstInformationFrameButton()
                            end)
                        end
                        return
                    else
                        if p_u_286 then
                            v_u_53.Visible = true
                        else
                            v_u_53.Visible = not v_u_53.Visible
                        end
                        if v_u_53.Visible then
                            v304()
                            v_u_54.Hover.Visible = false
                            task.defer(function()
                                -- upvalues: (ref) v_u_1, (copy) p_u_286
                                v_u_1.SetupInformationFrameNavigation()
                                if p_u_286 then
                                    v_u_1.SelectFirstInformationFrameButton()
                                end
                            end)
                        elseif v_u_38 then
                            v_u_48 = tick()
                        end
                    end
                else
                    v_u_53.Visible = false
                    return
                end
            end
            v_u_282.Button.MouseButton1Click:Connect(function()
                -- upvalues: (copy) v_u_305
                v_u_305(false)
            end)
            v_u_282.Button.Activated:Connect(function(p306)
                -- upvalues: (copy) v_u_305
                if p306 and p306.UserInputType == Enum.UserInputType.Gamepad1 then
                    v_u_305(true)
                end
            end)
            if v_u_35 then
                v_u_282.MouseEnter:Connect(function()
                    -- upvalues: (ref) v_u_37, (ref) p_u_277, (ref) v_u_38, (copy) v_u_282, (ref) v_u_48
                    v_u_37 = p_u_277
                    v_u_38 = v_u_282
                    v_u_48 = tick()
                end)
                v_u_282.MouseLeave:Connect(function()
                    -- upvalues: (ref) v_u_38, (ref) v_u_37, (ref) v_u_48
                    v_u_38 = nil
                    v_u_37 = nil
                    v_u_48 = nil
                end)
            end
        else
            print((("[Inventory] Skipping template creation for item: %* | %* (Type: %*) - No item information found"):format(p_u_277.Name, p_u_277.Skin, p_u_277.Type)))
        end
    else
        return
    end
end
function v_u_1.UpdateInventoryFilter()
    -- upvalues: (ref) v_u_54, (ref) v_u_46, (ref) v_u_45, (ref) v_u_34, (copy) v_u_150, (copy) v_u_187, (copy) v_u_243
    if v_u_54 then
        if v_u_54.Visible then
            v_u_34 = v_u_150()
            v_u_34 = v_u_187(v_u_34)
            v_u_243()
        else
            v_u_46 = true
            v_u_45 = true
        end
    else
        return
    end
end
function v_u_1.UpdateInventory(p307)
    -- upvalues: (ref) v_u_54, (ref) v_u_46, (ref) v_u_45, (ref) v_u_36, (ref) v_u_39, (ref) v_u_37, (ref) v_u_53, (ref) v_u_34, (copy) v_u_150, (copy) v_u_187, (copy) v_u_243
    if v_u_54 then
        if p307 and type(p307) == "table" then
            if v_u_54.Visible then
                local v308 = v_u_54.Tabs.Inventory.Container
                local v309 = {}
                for _, v310 in ipairs(p307) do
                    if v310 and v310._id then
                        v309[v310._id] = true
                    end
                end
                if v_u_36 and (v_u_36._id and not v309[v_u_36._id]) then
                    v_u_36 = nil
                    v_u_39 = nil
                    v_u_37 = nil
                    if v_u_53 then
                        v_u_53.Visible = false
                    end
                end
                for _, v311 in ipairs(v308:GetChildren()) do
                    local v312 = v311:IsA("Frame")
                    if v312 then
                        if v311.Name == "UIGridLayout" or (v311.Name == "UIListLayout" or (v311.Name == "UIPadding" or v311.Name == "Title")) then
                            v312 = false
                        else
                            v312 = v311.Name ~= "Label"
                        end
                    end
                    if v312 and not v309[v311.Name] then
                        v311:Destroy()
                    end
                end
                if v_u_54 then
                    if v_u_54.Visible then
                        v_u_34 = v_u_150()
                        v_u_34 = v_u_187(v_u_34)
                        v_u_243()
                    else
                        v_u_46 = true
                        v_u_45 = true
                    end
                else
                    return
                end
            else
                v_u_46 = true
                v_u_45 = true
                return
            end
        else
            print("UpdateInventory received invalid inventory data:", p307)
            return
        end
    else
        return
    end
end
function v_u_1.UpdateTemplates(p313)
    -- upvalues: (ref) v_u_54, (copy) v_u_18, (copy) v_u_23, (copy) v_u_131, (copy) v_u_82
    if v_u_54 and v_u_54.Visible then
        local v314 = v_u_54.Tabs.Inventory.Container
        if p313 then
            for _, v315 in ipairs(p313) do
                local v316 = v314:FindFirstChild(v315._id)
                if v316 and v316:IsA("Frame") then
                    local v317 = v_u_18(v315.Name, v315.Skin)
                    if v317 then
                        v316.Main.RarityFrame.UIGradient.Color = v_u_23[v317.rarity].ColorSequence
                        v316.Main.Glow.UIGradient.Color = v_u_23[v317.rarity].ColorSequence
                        v316.Main.Icon.Image = v_u_131(v315, v317, false)
                    end
                    v_u_82(v316, v315._id)
                end
            end
        end
    end
end
function v_u_1.SetupInformationFrameNavigation()
    -- upvalues: (ref) v_u_53
    if v_u_53 then
        local v318 = {}
        if v_u_53.Charm and v_u_53.Charm.Visible then
            local v319 = {
                ["button"] = v_u_53.Charm,
                ["order"] = v_u_53.Charm.LayoutOrder
            }
            table.insert(v318, v319)
        end
        if v_u_53.Inspect and v_u_53.Inspect.Visible then
            local v320 = {
                ["button"] = v_u_53.Inspect,
                ["order"] = v_u_53.Inspect.LayoutOrder
            }
            table.insert(v318, v320)
        end
        if v_u_53.ReplaceCT and v_u_53.ReplaceCT.Visible then
            local v321 = {
                ["button"] = v_u_53.ReplaceCT,
                ["order"] = v_u_53.ReplaceCT.LayoutOrder
            }
            table.insert(v318, v321)
        end
        if v_u_53.ReplaceT and v_u_53.ReplaceT.Visible then
            local v322 = {
                ["button"] = v_u_53.ReplaceT,
                ["order"] = v_u_53.ReplaceT.LayoutOrder
            }
            table.insert(v318, v322)
        end
        if v_u_53.Unlock and v_u_53.Unlock.Visible then
            local v323 = {
                ["button"] = v_u_53.Unlock,
                ["order"] = v_u_53.Unlock.LayoutOrder
            }
            table.insert(v318, v323)
        end
        local v324 = v_u_53:FindFirstChild("QuickUnlock")
        if v324 and v324.Visible then
            local v325 = {
                ["button"] = v324,
                ["order"] = v324.LayoutOrder
            }
            table.insert(v318, v325)
        end
        table.sort(v318, function(p326, p327)
            return p326.order < p327.order
        end)
        local v328 = {}
        for _, v329 in ipairs(v318) do
            local v330 = v329.button
            table.insert(v328, v330)
        end
        for v331, v332 in ipairs(v328) do
            v332.NextSelectionUp = v328[v331 > 1 and v331 - 1 or #v328]
            v332.NextSelectionDown = v328[v331 < #v328 and v331 + 1 or 1]
            v332.NextSelectionLeft = nil
            v332.NextSelectionRight = nil
        end
    end
end
function v_u_1.SetupItemNotificationNavigation()
    -- upvalues: (ref) v_u_54
    if v_u_54 and v_u_54.ItemNotification then
        local v333 = v_u_54.ItemNotification.Holder
        local v334 = {}
        if v333.ViewLoadout and v333.ViewLoadout.Visible then
            local v335 = {
                ["button"] = v333.ViewLoadout,
                ["order"] = v333.ViewLoadout.LayoutOrder or 1
            }
            table.insert(v334, v335)
        end
        if v333.Continue and v333.Continue.Visible then
            local v336 = {
                ["button"] = v333.Continue,
                ["order"] = v333.Continue.LayoutOrder or 2
            }
            table.insert(v334, v336)
        end
        if #v334 ~= 0 then
            table.sort(v334, function(p337, p338)
                return p337.order < p338.order
            end)
            for v339, v340 in ipairs(v334) do
                local v341 = v340.button
                v341.NextSelectionUp = v334[v339 > 1 and v339 - 1 or #v334].button
                v341.NextSelectionDown = v334[v339 < #v334 and v339 + 1 or 1].button
                v341.NextSelectionLeft = nil
                v341.NextSelectionRight = nil
            end
        end
    else
        return
    end
end
function v_u_1.SelectFirstItemNotificationButton()
    -- upvalues: (copy) v_u_3, (ref) v_u_54, (copy) v_u_7
    if v_u_3.GamepadEnabled then
        if v_u_54 and (v_u_54.ItemNotification and v_u_54.ItemNotification.Visible) then
            local v342 = v_u_54.ItemNotification.Holder
            if v342.ViewLoadout and (v342.ViewLoadout.Visible and v342.ViewLoadout.Selectable) then
                v_u_7.SelectedObject = v342.ViewLoadout
            elseif v342.Continue and (v342.Continue.Visible and v342.Continue.Selectable) then
                v_u_7.SelectedObject = v342.Continue
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.SelectFirstInformationFrameButton()
    -- upvalues: (ref) v_u_53, (copy) v_u_1, (copy) v_u_7
    if v_u_53 and v_u_53.Visible then
        v_u_1.SetupInformationFrameNavigation()
        if v_u_53.Charm and v_u_53.Charm.Visible then
            v_u_7.SelectedObject = v_u_53.Charm
            return
        elseif v_u_53.Inspect and v_u_53.Inspect.Visible then
            v_u_7.SelectedObject = v_u_53.Inspect
            return
        elseif v_u_53.ReplaceCT and v_u_53.ReplaceCT.Visible then
            v_u_7.SelectedObject = v_u_53.ReplaceCT
            return
        elseif v_u_53.ReplaceT and v_u_53.ReplaceT.Visible then
            v_u_7.SelectedObject = v_u_53.ReplaceT
            return
        elseif v_u_53.Unlock and v_u_53.Unlock.Visible then
            v_u_7.SelectedObject = v_u_53.Unlock
        else
            local v343 = v_u_53:FindFirstChild("QuickUnlock")
            if v343 and v343.Visible then
                v_u_7.SelectedObject = v343
            end
        end
    else
        return
    end
end
function v_u_1.SetupInformationFrame(p344)
    -- upvalues: (ref) v_u_53, (copy) v_u_16, (copy) v_u_74
    local v345 = p344.Type == "Weapon"
    local v346 = p344.Type == "Melee"
    local v347 = p344.Type == "Glove"
    local v348 = p344.Type == "Badge"
    local v349 = p344.Type == "Zeus x27"
    v_u_53.Inspect.Visible = v345 or (v347 or (v346 or (v349 or (p344.Type == "Charm" and true or v348))))
    v_u_53.Unlock.Visible = p344.Type == "Case" and true or p344.Type == "Package"
    v_u_53.Loadout.Visible = false
    local v350 = v_u_53:FindFirstChild("QuickUnlock")
    if v350 then
        v350.Visible = false
    end
    local v351 = v_u_53:FindFirstChild("UnlockDivider")
    if v351 then
        v351.Visible = false
    end
    local v352 = v345 or p344.Type == "Charm"
    if not v_u_53.Charm then
        warn("[Inventory] InformationFrame.Charm element not found - item type:", p344.Type)
    end
    if v_u_53.Charm then
        v_u_53.Charm.Visible = v352
        local v353 = v352 and v_u_53.Charm:FindFirstChild("TextLabel")
        if v353 then
            if p344.Type == "Charm" then
                v353.Text = "Attach to Weapon"
            else
                local v354
                if p344.Charm == nil or p344.Charm == false then
                    v354 = false
                else
                    local v355 = p344.Charm
                    if type(v355) == "string" or p344.Charm == true then
                        v354 = true
                    else
                        local v356 = p344.Charm
                        v354 = type(v356) == "table"
                    end
                end
                if v354 then
                    v353.Text = "Detach Charm"
                else
                    v353.Text = "Attach Charm"
                end
            end
        end
    end
    local v357 = false
    local v358 = false
    if v345 then
        local v359, v360 = pcall(v_u_16, p344.Name)
        if v359 and (v360 and v360.Team) then
            if v360.Team == "Both" then
                v357 = true
                v358 = true
            elseif v360.Team == "Counter-Terrorists" then
                v357 = true
            elseif v360.Team == "Terrorists" then
                v358 = true
            end
        end
    elseif v346 then
        if p344.Name == "CT Knife" then
            v357 = true
            v358 = false
        elseif p344.Name == "T Knife" then
            v357 = false
            v358 = true
        else
            v357 = true
            v358 = true
        end
    elseif v347 then
        local v361 = v_u_16(p344.Name)
        if v361 and v361.Team then
            if v361.Team == "Both" then
                v357 = true
                v358 = true
            elseif v361.Team == "Counter-Terrorists" then
                v357 = true
            elseif v361.Team == "Terrorists" then
                v358 = true
            end
        end
    elseif v348 then
        v357 = true
        v358 = true
    elseif v349 then
        v357 = true
        v358 = true
    end
    local v362 = v_u_74(p344._id, "Counter-Terrorists")
    local v363 = v_u_74(p344._id, "Terrorists")
    local v364 = v345 or (v346 or (v347 or (v348 or v349)))
    if v_u_53.ReplaceCT then
        local v365 = v_u_53.ReplaceCT
        if v364 then
            if v357 then
                v357 = not v362
            end
        else
            v357 = v364
        end
        v365.Visible = v357
    end
    if v_u_53.ReplaceT then
        local v366 = v_u_53.ReplaceT
        if v364 then
            if v358 then
                v358 = not v363
            end
        else
            v358 = v364
        end
        v366.Visible = v358
    end
    local v367 = {
        {
            ["dividerName"] = "CharmDivider",
            ["action"] = v_u_53.Charm
        },
        {
            ["dividerName"] = "InspectDivider",
            ["action"] = v_u_53.Inspect
        },
        {
            ["dividerName"] = "ReplaceCTDivider",
            ["action"] = v_u_53.ReplaceCT
        },
        {
            ["dividerName"] = "ReplaceTDivider",
            ["action"] = v_u_53.ReplaceT
        },
        {
            ["dividerName"] = "LoadoutDivider",
            ["action"] = v_u_53.Loadout
        }
    }
    local v368 = { "UnlockDivider" }
    for _, v369 in ipairs(v367) do
        local v370 = v369.dividerName
        table.insert(v368, v370)
    end
    for _, v371 in ipairs(v367) do
        local v372 = v_u_53:FindFirstChild(v371.dividerName)
        if v372 and v371.action then
            if v371.action.Visible then
                local v373 = v372.LayoutOrder
                local v374 = false
                for _, v375 in ipairs(v_u_53:GetChildren()) do
                    local v376 = false
                    for _, v377 in ipairs(v368) do
                        if v375.Name == v377 then
                            v376 = true
                            break
                        end
                    end
                    if not v376 and (v375 ~= v372 and (v375 ~= v371.action and (v375:IsA("Frame") or v375:IsA("TextButton")))) and (v375.LayoutOrder < v373 and v375.Visible) then
                        v374 = true
                    end
                end
                v372.Visible = v374
            else
                v372.Visible = false
            end
        end
    end
end
function v_u_1.SelectOption(p378, p379)
    -- upvalues: (ref) v_u_53, (ref) v_u_54, (copy) v_u_32, (copy) v_u_31, (copy) v_u_33, (copy) v_u_1
    if v_u_53 then
        v_u_53.Visible = false
    end
    p378.HoverFrame.BackgroundTransparency = 0
    p378.HoverFrame.Visible = true
    for _, v380 in ipairs(v_u_54.Top.Filter:GetChildren()) do
        if v380:IsA("TextButton") then
            v380.HoverFrame.Visible = v380.Name == p379
            v380.HoverFrame.BackgroundColor3 = v_u_32
            v380.TextLabel.TextColor3 = v_u_32
            v380:SetAttribute("Selected", nil)
            if v380.HoverFrame.Visible then
                v380.HoverFrame.BackgroundColor3 = v_u_31
                v380.TextLabel.TextColor3 = v_u_33
                v380:SetAttribute("Selected", true)
            end
        end
    end
    v_u_1.UpdateInventoryFilter()
end
function v_u_1.ShowNewItemNotification(p381)
    -- upvalues: (copy) v_u_56, (ref) v_u_54, (copy) v_u_1
    local v382 = false
    local v383 = 0
    for v384, v385 in ipairs(v_u_56) do
        if v385._id == p381._id then
            v383 = v384
            v382 = true
            break
        end
    end
    if not v382 then
        local v386 = v_u_56
        table.insert(v386, p381)
        v383 = #v_u_56
    end
    v_u_54.Visible = true
    v_u_1.NextInventoryItem(v383)
end
function v_u_1.NextInventoryItem(p387)
    -- upvalues: (copy) v_u_56, (ref) v_u_40, (copy) v_u_15, (copy) v_u_18, (copy) v_u_23, (copy) v_u_131, (ref) v_u_54, (ref) v_u_57, (copy) v_u_20, (copy) v_u_1
    local v388 = v_u_56[p387]
    v_u_40 = p387
    if v388 then
        local v389 = v388.Type == "Case" and true or v388.Type == "Package"
        local v390 = v389 and v_u_15.GetCaseByName(v388.Skin) or v_u_18(v388.Name, v388.Skin)
        local v391 = v_u_23[v390 and (v389 and v390.caseRarity or v390.rarity) or (v388.Rarity or "Blue")] or v_u_23.Blue
        local v392 = v389 and v390 and v390.Skin or ("%* | %*"):format(v388.Name, v388.Skin)
        local v393 = v_u_131(v388, v390, v389)
        local v394 = v_u_54.ItemNotification.Holder.ViewLoadout
        local v395
        if v388.Type == "Case" then
            v395 = false
        else
            v395 = v388.Type ~= "Package"
        end
        v394.Visible = v395
        v_u_54.ItemNotification.Holder.RarityFrame.UIGradient.Color = v391.ColorSequence
        v_u_54.ItemNotification.Holder.Background.ImageColor3 = v391.Color
        v_u_54.ItemNotification.Holder.IconShadow.Image = v393
        v_u_54.ItemNotification.Holder.Light.ImageColor3 = v391.Color
        v_u_54.ItemNotification.Holder.WeaponName.Text = v392
        v_u_54.ItemNotification.Holder.Icon.Image = v393
        v_u_54.ItemNotification.Visible = true
        if not v_u_57 then
            v_u_57 = true
            v_u_20.broadcastRouter("RunInterfaceSound", "New Item Reveal")
        end
        v_u_54.ItemNotification.Holder.Title.TextColor3 = Color3.new(v391.Color.R * 0.56, v391.Color.G * 0.56, v391.Color.B * 0.56)
        task.defer(function()
            -- upvalues: (ref) v_u_1
            v_u_1.SetupItemNotificationNavigation()
            v_u_1.SelectFirstItemNotificationButton()
        end)
    end
end
function v_u_1.SelectCategory(p396)
    -- upvalues: (ref) v_u_53, (copy) v_u_21, (copy) v_u_66, (ref) v_u_54, (copy) v_u_32, (copy) v_u_31, (copy) v_u_33, (copy) v_u_2, (copy) v_u_5, (copy) v_u_1, (copy) v_u_276, (copy) v_u_20
    if v_u_53 then
        v_u_53.Visible = false
    end
    local v397 = v_u_21[p396]
    if v397 then
        v_u_66(v_u_54.Top.Filter, "TextButton")
        for _, v398 in ipairs(v_u_54.Top.Categories:GetChildren()) do
            if v398:IsA("TextButton") and v398:GetAttribute("IsCategoryButton") then
                v398.HoverFrame.Visible = v398.Name == p396
                v398.HoverFrame.BackgroundColor3 = v_u_32
                v398.TextLabel.TextColor3 = v_u_32
                v398:SetAttribute("Selected", nil)
                if v398.HoverFrame.Visible then
                    v398.HoverFrame.BackgroundColor3 = v_u_31
                    v398.TextLabel.TextColor3 = v_u_33
                    v398:SetAttribute("Selected", true)
                end
            end
        end
        for v_u_399, v400 in pairs(v397) do
            local v_u_401 = v_u_2.Assets.UI.Inventory.OptionTemplate:Clone()
            v_u_401.HoverFrame.BackgroundColor3 = v_u_32
            v_u_401.TextLabel.TextColor3 = v_u_32
            v_u_401.LayoutOrder = v400.LayoutOrder
            v_u_401.Parent = v_u_54.Top.Filter
            v_u_401.Visible = v_u_399 ~= "Default"
            v_u_401.TextLabel.Text = v_u_399
            v_u_401.HoverFrame.Visible = false
            v_u_401.Name = v_u_399
            local v402 = v_u_5:GetTextSize(v_u_399, v_u_401.TextLabel.TextSize, v_u_401.TextLabel.Font, Vector2.new((1 / 0), (1 / 0))).X + 16
            v_u_401.Size = UDim2.new(0, v402, v_u_401.Size.Y.Scale, v_u_401.Size.Y.Offset)
            if v400.LayoutOrder == 0 then
                v_u_1.SelectOption(v_u_401, v_u_399)
            end
            v_u_276(v_u_401)
            v_u_401.Selectable = true
            local function v403()
                -- upvalues: (ref) v_u_1, (copy) v_u_401, (copy) v_u_399, (ref) v_u_20
                v_u_1.SelectOption(v_u_401, v_u_399)
                v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            end
            v_u_401.MouseButton1Click:Connect(v403)
            v_u_401.Activated:Connect(function(p404)
                -- upvalues: (ref) v_u_1, (copy) v_u_401, (copy) v_u_399, (ref) v_u_20
                if p404 and p404.UserInputType == Enum.UserInputType.Gamepad1 then
                    v_u_1.SelectOption(v_u_401, v_u_399)
                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                end
            end)
        end
    else
        warn((("[Inventory] Category \"%*\" not found in InventoryButtons"):format(p396)))
    end
end
function v_u_1.SetupCategoryButton(p_u_405)
    -- upvalues: (copy) v_u_276, (copy) v_u_1, (copy) v_u_20
    v_u_276(p_u_405)
    p_u_405.Selectable = true
    local function v408()
        -- upvalues: (ref) v_u_1, (copy) p_u_405, (ref) v_u_20
        local v406 = v_u_1.SelectCategory
        local v407 = p_u_405.Name
        v406((tostring(v407)))
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
    end
    p_u_405.MouseButton1Click:Connect(v408)
    p_u_405.Activated:Connect(function(p409)
        -- upvalues: (ref) v_u_1, (copy) p_u_405, (ref) v_u_20
        if p409 and p409.UserInputType == Enum.UserInputType.Gamepad1 then
            local v410 = v_u_1.SelectCategory
            local v411 = p_u_405.Name
            v410((tostring(v411)))
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        end
    end)
end
function v_u_1.UpdateHoverFrame(_)
    -- upvalues: (ref) v_u_48, (copy) v_u_109, (ref) v_u_54, (ref) v_u_53, (ref) v_u_38, (ref) v_u_37, (copy) v_u_125, (copy) v_u_15, (copy) v_u_18, (copy) v_u_58, (copy) v_u_17, (copy) v_u_137, (copy) v_u_12, (copy) v_u_11, (copy) v_u_9, (copy) v_u_2, (copy) v_u_23, (copy) v_u_14, (copy) v_u_16
    local v412 = tick() - (v_u_48 or 0)
    local v413 = v_u_109()
    if v_u_54.Visible and (not v413 and (not v_u_53.Visible and (v_u_38 and (v_u_37 and v412 > 0.75)))) then
        v_u_54.Hover.Position = v_u_125(v_u_38)
        local v414 = v_u_37
        local v415 = v414.Type == "Case" and true or v414.Type == "Package"
        local v416 = v415 and v_u_15.GetCaseByName(v414.Skin) or v_u_18(v414.Name, v414.Skin)
        if v416 then
            local v417 = v415 and v416.caseType and v_u_58[v416.caseType] or v415 and v416.caseType or (v414.StatTrack and "KillTrak\226\132\162 " .. v414.Name or v414.Name)
            local v418 = v_u_17(v415 and v416.skin or v414.Skin)
            local v419 = v418 == "Vanilla" and "" or (" | " .. v418 or "")
            local v420 = (v414.Type == "Melee" and "\226\152\133 " or "") .. v417
            v_u_54.Hover.ItemName.Frame.ItemName.Text = v420 .. v419
            local v421 = v_u_137(v414)
            v_u_54.Hover.ItemName.Frame.Collection.Text = v421 or ""
            local v422 = v_u_54.Hover.ItemName.CollectionIcon
            if v421 then
                local v423 = v_u_12.GetCollectionByName(v421)
                if v423 and v423.imageAssetId then
                    v422.Image = v423.imageAssetId
                    v422.Visible = true
                else
                    v422.Visible = false
                end
            else
                v422.Visible = false
            end
            local v424 = v_u_54.Hover:FindFirstChild("CollectionName")
            if v424 then
                if v421 then
                    v424.Text = v421 .. ":"
                    v424.Visible = true
                else
                    v424.Visible = false
                end
            end
            if v421 and not v415 then
                local v425 = v_u_12.GetCollectionByName(v421)
                if v425 and v425.items then
                    local v426 = v_u_54.Hover.Collection
                    local v427 = v_u_11.Get(v_u_9, "Inventory")
                    for _, v428 in ipairs(v426:GetChildren()) do
                        if v428:IsA("Frame") and v428.Name ~= "UIListLayout" then
                            v428:Destroy()
                        end
                    end
                    local v429 = {}
                    if v427 then
                        for _, v430 in ipairs(v427) do
                            if v430.Name and v430.Skin then
                                v429[v430.Name .. "|" .. v430.Skin] = true
                            end
                        end
                    end
                    local v431 = {
                        ["Blue"] = 1,
                        ["Purple"] = 2,
                        ["Pink"] = 3,
                        ["Red"] = 4,
                        ["Special"] = 5,
                        ["Forbidden"] = 6,
                        ["Stock"] = 7
                    }
                    local v432 = {}
                    for _, v433 in ipairs(v425.items) do
                        if v433.itemName and v433.skinName then
                            local v434 = v_u_18(v433.itemName, v433.skinName)
                            if v434 then
                                local v435 = {
                                    ["item"] = v433,
                                    ["rarity"] = v434.rarity,
                                    ["rarityOrder"] = v431[v434.rarity] or 99
                                }
                                table.insert(v432, v435)
                            end
                        end
                    end
                    table.sort(v432, function(p436, p437)
                        if p436.rarityOrder == p437.rarityOrder then
                            return p436.item.itemName < p437.item.itemName
                        else
                            return p436.rarityOrder < p437.rarityOrder
                        end
                    end)
                    local v438 = v_u_2.Assets.UI.Inventory.CollectionNameTemplate
                    for v439, v440 in ipairs(v432) do
                        local v441 = v440.item
                        local v442 = v_u_18(v441.itemName, v441.skinName)
                        if v442 and v438 then
                            local v443 = v438:Clone()
                            v443.Parent = v426
                            v443.LayoutOrder = v439
                            v443.Visible = true
                            local v444 = v443:FindFirstChild("CollectionName") or v443:FindFirstChild("gun")
                            if v444 then
                                v444.Text = "[" .. v441.itemName .. "] | " .. v441.skinName
                                local v445 = v442.rarity
                                if v445 then
                                    v445 = v_u_23[v442.rarity]
                                end
                                if v445 then
                                    v444.TextColor3 = v445.Color
                                end
                                v444.Visible = true
                            end
                            local v446 = v443:FindFirstChild("ImageLabel")
                            if v446 then
                                v446.Visible = v429[v441.itemName .. "|" .. v441.skinName] == true
                            end
                        end
                    end
                    if v424 then
                        v424.Visible = true
                    end
                    v426.Visible = true
                    local v447 = v_u_54.Hover:FindFirstChild("CollectionSpacer")
                    if v447 then
                        v447.Visible = true
                    end
                else
                    local v448 = v_u_54.Hover.Collection
                    if v448 then
                        for _, v449 in ipairs(v448:GetChildren()) do
                            if v449:IsA("Frame") and v449.Name ~= "UIListLayout" then
                                v449:Destroy()
                            end
                        end
                        v448.Visible = false
                    end
                    local v450 = v_u_54.Hover:FindFirstChild("CollectionName")
                    if v450 then
                        v450.Visible = false
                    end
                    local v451 = v_u_54.Hover:FindFirstChild("CollectionSpacer")
                    if v451 then
                        v451.Visible = false
                    end
                end
            else
                local v452 = v_u_54.Hover.Collection
                if v452 then
                    for _, v453 in ipairs(v452:GetChildren()) do
                        if v453:IsA("Frame") and v453.Name ~= "UIListLayout" then
                            v453:Destroy()
                        end
                    end
                    v452.Visible = false
                end
                local v454 = v_u_54.Hover:FindFirstChild("CollectionName")
                if v454 then
                    v454.Visible = false
                end
                local v455 = v_u_54.Hover:FindFirstChild("CollectionSpacer")
                if v455 then
                    v455.Visible = false
                end
            end
            if v415 or v414.Type ~= "Weapon" and (v414.Type ~= "Melee" and (v414.Type ~= "Glove" and v414.Type ~= "Zeus x27")) then
                if v415 then
                    if v416.description then
                        v_u_54.Hover.Description.Text = v416.description
                    else
                        v_u_54.Hover.Description.Text = ""
                    end
                elseif v416.description then
                    v_u_54.Hover.Description.Text = v416.description
                else
                    v_u_54.Hover.Description.Text = ""
                end
            else
                local v456 = v414.Name
                local v457 = v_u_18(v414.Type == "Melee" and "T Knife" or (v414.Type == "Glove" and "T Glove" or v456), "Stock")
                if v457 and v457.description then
                    v_u_54.Hover.Description.Text = v457.description
                else
                    v_u_54.Hover.Description.Text = ""
                end
            end
            if v415 or (v414.Type == "Charm Capsule" and true or v414.Type == "Sticker Capsule") then
                v_u_54.Hover.Information.Visible = false
            else
                v_u_54.Hover.Information.Visible = true
            end
            local v458 = v415 and v416.caseRarity or v416.rarity
            if v458 then
                local v459 = v_u_23[v458]
                if v459 then
                    local v460 = ({
                        ["Blue"] = "Blue",
                        ["Purple"] = "Purple",
                        ["Pink"] = "Pink",
                        ["Red"] = "Red",
                        ["Special"] = "\226\152\133 Special",
                        ["Forbidden"] = "\226\152\133 Special"
                    })[v458] or v458
                    v_u_54.Hover.Information.Rarity.Label.Text = v460
                    v_u_54.Hover.Information.Rarity.Label.TextColor3 = v459.Color
                else
                    v_u_54.Hover.Information.Rarity.Label.Text = ""
                end
            else
                v_u_54.Hover.Information.Rarity.Label.Text = ""
            end
            local v461 = v_u_54.Hover.Information.Exterior
            if v415 then
                v461.Visible = false
            else
                local v462 = v_u_14.GetWearNameForFloat(v416, v414.Float or v416.floatRange.max)
                if v462 then
                    v461.Label.Text = v462
                    v461.Visible = true
                else
                    v461.Visible = false
                end
            end
            local v463 = v_u_54.Hover.Information.Team.Team
            if (v414.Type == "Melee" or (v414.Type == "Glove" or (v414.Type == "Badge" or v414.Type == "Charm"))) and true or v414.Type == "Zeus x27" then
                v463.CT.Visible = true
                v463.T.Visible = true
                v463.Label.Visible = true
                v463.Label.Text = "Both"
            elseif v414.Type == "Weapon" then
                local v464 = v_u_16(v414.Name)
                if v464 and v464.Team then
                    local v465 = v464.Team
                    if v465 == "Counter-Terrorists" then
                        v463.CT.Visible = true
                        v463.T.Visible = false
                        v463.Label.Visible = true
                        v463.Label.Text = "Counter-Terrorists"
                    elseif v465 == "Terrorists" then
                        v463.CT.Visible = false
                        v463.T.Visible = true
                        v463.Label.Visible = true
                        v463.Label.Text = "Terrorists"
                    else
                        v463.CT.Visible = true
                        v463.T.Visible = true
                        v463.Label.Visible = true
                        v463.Label.Text = "Both"
                    end
                end
            end
        end
        v_u_54.Hover.Visible = true
    else
        v_u_54.Hover.Visible = false
    end
end
function v_u_1.Initialize(p466, p467)
    -- upvalues: (ref) v_u_55, (ref) v_u_54, (ref) v_u_53, (copy) v_u_29, (copy) v_u_20, (ref) v_u_39, (copy) v_u_7, (copy) v_u_12, (ref) v_u_42, (ref) v_u_36, (copy) v_u_19, (copy) v_u_25, (copy) v_u_30, (ref) v_u_47, (copy) v_u_15, (copy) v_u_27, (copy) v_u_102, (ref) v_u_40, (copy) v_u_1, (copy) v_u_56, (ref) v_u_57, (copy) v_u_26, (ref) v_u_44, (ref) v_u_46, (ref) v_u_45, (ref) v_u_34, (copy) v_u_150, (copy) v_u_187, (copy) v_u_243, (copy) v_u_251, (copy) v_u_276, (copy) v_u_4, (copy) v_u_164, (ref) v_u_50, (copy) v_u_239, (copy) v_u_52, (ref) v_u_49, (copy) v_u_201
    v_u_55 = p466
    v_u_54 = p467
    v_u_53 = p467.Information
    v_u_29.Add(v_u_53, nil, function()
        -- upvalues: (ref) v_u_20, (ref) v_u_53, (ref) v_u_39, (ref) v_u_7
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_53.Visible = false
        if v_u_39 and v_u_39:FindFirstChild("Button") then
            local v468 = v_u_39:FindFirstChild("Button")
            if v468 and v468:IsA("GuiButton") then
                v_u_7.SelectedObject = v468
                return
            end
        end
    end)
    v_u_12.ObserveAvailableCollections(function(p469)
        -- upvalues: (ref) v_u_42
        v_u_42 = p469
    end)
    v_u_53.Inspect.Selectable = true
    local function v470()
        -- upvalues: (ref) v_u_20, (ref) v_u_36, (ref) v_u_53
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_36 then
            v_u_53.Visible = false
            v_u_20.broadcastRouter("WeaponInspect", v_u_36.Name, v_u_36.Skin, v_u_36.Float, v_u_36.StatTrack, v_u_36.NameTag, v_u_36.Charm, v_u_36.Stickers, v_u_36.Type, v_u_36.Pattern, v_u_36._id, v_u_36.Serial, v_u_36.IsTradeable)
        end
    end
    v_u_53.Inspect.MouseButton1Click:Connect(v470)
    v_u_53.Inspect.Activated:Connect(function(p471)
        -- upvalues: (ref) v_u_20, (ref) v_u_36, (ref) v_u_53
        if p471 and p471.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_36 then
                v_u_53.Visible = false
                v_u_20.broadcastRouter("WeaponInspect", v_u_36.Name, v_u_36.Skin, v_u_36.Float, v_u_36.StatTrack, v_u_36.NameTag, v_u_36.Charm, v_u_36.Stickers, v_u_36.Type, v_u_36.Pattern, v_u_36._id, v_u_36.Serial, v_u_36.IsTradeable)
            end
        else
            return
        end
    end)
    if v_u_53.Charm then
        v_u_53.Charm.Selectable = true
        local function v_u_475()
            -- upvalues: (ref) v_u_20, (ref) v_u_36, (ref) v_u_53, (ref) v_u_19, (ref) v_u_54, (ref) v_u_25
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_36 then
                local v472
                if v_u_36.Charm == nil or v_u_36.Charm == false then
                    v472 = false
                else
                    local v473 = v_u_36.Charm
                    if type(v473) == "string" or v_u_36.Charm == true then
                        v472 = true
                    else
                        local v474 = v_u_36.Charm
                        v472 = type(v474) == "table"
                    end
                end
                v_u_53.Visible = false
                if v472 then
                    v_u_19.Inventory.RemoveWeaponCharm.Send({
                        ["WeaponId"] = v_u_36._id
                    })
                    return
                end
                v_u_54.Visible = false
                v_u_25.TriggerAction("AttachCharm", v_u_36)
            end
        end
        v_u_53.Charm.MouseButton1Click:Connect(v_u_475)
        v_u_53.Charm.Activated:Connect(function(p476)
            -- upvalues: (copy) v_u_475
            if p476 and p476.UserInputType == Enum.UserInputType.Gamepad1 then
                v_u_475()
            end
        end)
    end
    v_u_25.OnItemSelected:Connect(function(p477, p478)
        -- upvalues: (ref) v_u_25
        local v479 = v_u_25.GetActions().Get(p478.ActionType)
        if v479 then
            v479.OnItemSelected(p477, p478)
        end
    end)
    v_u_25.OnClosed:Connect(function(_)
        -- upvalues: (ref) v_u_30, (ref) v_u_54
        if v_u_30.GetCurrentScreen() == "Inventory" then
            v_u_54.Visible = true
        end
    end)
    v_u_53.Unlock.Selectable = true
    local function v481()
        -- upvalues: (ref) v_u_47, (ref) v_u_20, (ref) v_u_36, (ref) v_u_15, (ref) v_u_27, (ref) v_u_53, (ref) v_u_54
        if v_u_47 then
            return
        else
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_36 then
                local v480 = v_u_15.GetCaseByName(v_u_36.Skin)
                v_u_27.OpenCaseContent(v480.caseId, "Open", v_u_36._id)
                v_u_53.Visible = false
                v_u_54.Visible = false
            end
        end
    end
    v_u_53.Unlock.MouseButton1Click:Connect(v481)
    v_u_53.Unlock.Activated:Connect(function(p482)
        -- upvalues: (ref) v_u_47, (ref) v_u_20, (ref) v_u_36, (ref) v_u_15, (ref) v_u_27, (ref) v_u_53, (ref) v_u_54
        if p482 and p482.UserInputType == Enum.UserInputType.Gamepad1 then
            if v_u_47 then
                return
            end
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_36 then
                local v483 = v_u_15.GetCaseByName(v_u_36.Skin)
                v_u_27.OpenCaseContent(v483.caseId, "Open", v_u_36._id)
                v_u_53.Visible = false
                v_u_54.Visible = false
                return
            end
        end
    end)
    if v_u_53.ReplaceT then
        v_u_53.ReplaceT.Selectable = true
        local function v484()
            -- upvalues: (ref) v_u_20, (ref) v_u_36, (ref) v_u_53, (ref) v_u_102
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_36 then
                v_u_53.Visible = false
                v_u_102(v_u_36, "Terrorists")
            end
        end
        v_u_53.ReplaceT.MouseButton1Click:Connect(v484)
        v_u_53.ReplaceT.Activated:Connect(function(p485)
            -- upvalues: (ref) v_u_20, (ref) v_u_36, (ref) v_u_53, (ref) v_u_102
            if p485 and p485.UserInputType == Enum.UserInputType.Gamepad1 then
                v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                if v_u_36 then
                    v_u_53.Visible = false
                    v_u_102(v_u_36, "Terrorists")
                end
            end
        end)
    end
    if v_u_53.ReplaceCT then
        v_u_53.ReplaceCT.Selectable = true
        local function v486()
            -- upvalues: (ref) v_u_20, (ref) v_u_36, (ref) v_u_53, (ref) v_u_102
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_36 then
                v_u_53.Visible = false
                v_u_102(v_u_36, "Counter-Terrorists")
            end
        end
        v_u_53.ReplaceCT.MouseButton1Click:Connect(v486)
        v_u_53.ReplaceCT.Activated:Connect(function(p487)
            -- upvalues: (ref) v_u_20, (ref) v_u_36, (ref) v_u_53, (ref) v_u_102
            if p487 and p487.UserInputType == Enum.UserInputType.Gamepad1 then
                v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                if v_u_36 then
                    v_u_53.Visible = false
                    v_u_102(v_u_36, "Counter-Terrorists")
                end
            end
        end)
    end
    v_u_54.ItemNotification.Holder.Left.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_20, (ref) v_u_40, (ref) v_u_1
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_40 > 0 then
            v_u_1.NextInventoryItem(v_u_40 - 1)
        end
    end)
    v_u_54.ItemNotification.Holder.Right.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_20, (ref) v_u_40, (ref) v_u_56, (ref) v_u_1
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_40 <= #v_u_56 then
            v_u_1.NextInventoryItem(v_u_40 + 1)
        end
    end)
    v_u_54.ItemNotification.Holder.Continue.Selectable = true
    v_u_54.ItemNotification.Holder.ViewLoadout.Selectable = true
    local function v488()
        -- upvalues: (ref) v_u_20, (ref) v_u_54, (ref) v_u_40, (ref) v_u_56, (ref) v_u_57
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_54.ItemNotification.Visible = false
        v_u_40 = 0
        table.clear(v_u_56)
        v_u_57 = false
    end
    v_u_54.ItemNotification.Holder.Continue.MouseButton1Click:Connect(v488)
    v_u_54.ItemNotification.Holder.Continue.Activated:Connect(function(p489)
        -- upvalues: (ref) v_u_20, (ref) v_u_54, (ref) v_u_40, (ref) v_u_56, (ref) v_u_57
        if p489 and p489.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_54.ItemNotification.Visible = false
            v_u_40 = 0
            table.clear(v_u_56)
            v_u_57 = false
        end
    end)
    local function v_u_491()
        -- upvalues: (ref) v_u_56, (ref) v_u_40, (ref) v_u_20, (ref) v_u_54, (ref) v_u_57, (ref) v_u_26
        local v490 = v_u_56[v_u_40]
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_54.ItemNotification.Visible = false
        v_u_40 = 0
        table.clear(v_u_56)
        v_u_57 = false
        if v490 and (v490.Type == "Melee" or (v490.Type == "Glove" or (v490.Type == "Weapon" or v490.Type == "Zeus x27"))) and true or false then
            v_u_54.Visible = false
            v_u_26.ViewInLoadout(v490._id)
        end
    end
    v_u_54.ItemNotification.Holder.ViewLoadout.MouseButton1Click:Connect(v_u_491)
    v_u_54.ItemNotification.Holder.ViewLoadout.Activated:Connect(function(p492)
        -- upvalues: (copy) v_u_491
        if p492 and p492.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_491()
        end
    end)
    v_u_54.Tabs.Inventory.Sort.Button.Selectable = true
    local function v493()
        -- upvalues: (ref) v_u_54, (ref) v_u_20
        v_u_54.Tabs.Inventory.Sort.Button.Options.Visible = not v_u_54.Tabs.Inventory.Sort.Button.Options.Visible
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
    end
    v_u_54.Tabs.Inventory.Sort.Button.MouseButton1Click:Connect(v493)
    v_u_54.Tabs.Inventory.Sort.Button.Activated:Connect(function(p494)
        -- upvalues: (ref) v_u_54, (ref) v_u_20
        if p494 and p494.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_54.Tabs.Inventory.Sort.Button.Options.Visible = not v_u_54.Tabs.Inventory.Sort.Button.Options.Visible
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        end
    end)
    local v495 = v_u_54.Tabs.Inventory.Sort.ReverseSort
    local v_u_496 = v495:FindFirstChildOfClass("ImageLabel")
    local function v497()
        -- upvalues: (ref) v_u_44, (copy) v_u_496, (ref) v_u_54, (ref) v_u_46, (ref) v_u_45, (ref) v_u_34, (ref) v_u_150, (ref) v_u_187, (ref) v_u_243, (ref) v_u_20
        v_u_44 = not v_u_44
        if v_u_496 then
            v_u_496.Rotation = v_u_44 and 180 or 0
        end
        if v_u_54 then
            if v_u_54.Visible then
                v_u_34 = v_u_150()
                v_u_34 = v_u_187(v_u_34)
                v_u_243()
            else
                v_u_46 = true
                v_u_45 = true
            end
        end
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
    end
    v495.Selectable = true
    v495.MouseButton1Click:Connect(v497)
    v495.Activated:Connect(function(p498)
        -- upvalues: (ref) v_u_44, (copy) v_u_496, (ref) v_u_54, (ref) v_u_46, (ref) v_u_45, (ref) v_u_34, (ref) v_u_150, (ref) v_u_187, (ref) v_u_243, (ref) v_u_20
        if p498 and p498.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_44 = not v_u_44
            if v_u_496 then
                v_u_496.Rotation = v_u_44 and 180 or 0
            end
            if v_u_54 then
                if v_u_54.Visible then
                    v_u_34 = v_u_150()
                    v_u_34 = v_u_187(v_u_34)
                    v_u_243()
                else
                    v_u_46 = true
                    v_u_45 = true
                end
            end
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        end
    end)
    for _, v499 in {
        "Alphabetical",
        "Collection",
        "Equipped",
        "Newest",
        "Quality",
        "Type",
        "Float"
    } do
        local v500 = v_u_54.Tabs.Inventory.Sort.Button.Options:FindFirstChild(v499)
        if v500 then
            v_u_251(v_u_54.Tabs.Inventory.Sort.Button.Options, v500, v499, v_u_54.Tabs.Inventory.Sort.Button.Frame.TextLabel, v_u_54.Tabs.Inventory.Container)
        end
    end
    for _, v501 in v_u_54.Top.Categories:GetChildren() do
        if v501:IsA("TextButton") and v501:GetAttribute("IsCategoryButton") then
            v_u_1.SetupCategoryButton(v501)
        end
    end
    local v502 = v_u_54.Top.Categories.Search
    local v_u_503 = v_u_54.Top.Categories.SearchBar
    local v_u_504 = v_u_54.Top.Categories.SearchBar.TextBox
    v_u_276(v502)
    v502.Selectable = true
    v_u_503.Visible = false
    v_u_503.Size = UDim2.new(0, 0, 1, 0)
    local v_u_505 = nil
    local v_u_506 = nil
    local function v_u_508()
        -- upvalues: (copy) v_u_503, (copy) v_u_504, (ref) v_u_506, (ref) v_u_505, (ref) v_u_4, (ref) v_u_20
        if v_u_503.Visible then
            v_u_504:CaptureFocus()
        else
            if v_u_506 then
                v_u_506:Disconnect()
                v_u_506 = nil
            end
            if v_u_505 then
                v_u_505:Cancel()
                v_u_505 = nil
            end
            v_u_503.Size = UDim2.new(0, 0, 1, 0)
            v_u_503.Visible = true
            local v507 = v_u_4:Create(v_u_503, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.new(0.3, 0, 1, 0)
            })
            v_u_505 = v507
            v507:Play()
            v_u_504:CaptureFocus()
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        end
    end
    v502.MouseButton1Click:Connect(v_u_508)
    v502.Activated:Connect(function(p509)
        -- upvalues: (copy) v_u_508
        if p509 and p509.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_508()
        end
    end)
    v_u_504:GetPropertyChangedSignal("Text"):Connect(function()
        -- upvalues: (ref) v_u_54, (ref) v_u_164, (copy) v_u_504, (ref) v_u_46, (ref) v_u_45, (ref) v_u_34, (ref) v_u_150, (ref) v_u_187, (ref) v_u_243
        if v_u_54.Visible then
            v_u_164(v_u_504.Text)
            if v_u_54 then
                if v_u_54.Visible then
                    v_u_34 = v_u_150()
                    v_u_34 = v_u_187(v_u_34)
                    v_u_243()
                else
                    v_u_46 = true
                    v_u_45 = true
                end
            else
                return
            end
        else
            return
        end
    end)
    v_u_54:GetPropertyChangedSignal("Visible"):Connect(function()
        -- upvalues: (ref) v_u_54, (ref) v_u_50, (ref) v_u_46, (ref) v_u_45, (ref) v_u_34, (ref) v_u_150, (ref) v_u_187, (ref) v_u_243, (ref) v_u_239, (ref) v_u_56, (ref) v_u_40, (ref) v_u_1, (ref) v_u_52, (copy) v_u_504, (ref) v_u_506, (ref) v_u_505, (copy) v_u_503, (ref) v_u_49
        if v_u_54.Visible then
            if v_u_50 then
                task.cancel(v_u_50)
                v_u_50 = nil
            end
            if v_u_46 then
                v_u_46 = false
                if v_u_54 then
                    if v_u_54.Visible then
                        v_u_34 = v_u_150()
                        v_u_34 = v_u_187(v_u_34)
                        v_u_243()
                    else
                        v_u_46 = true
                        v_u_45 = true
                    end
                end
            end
            if v_u_45 then
                v_u_239()
            end
            local v510 = #v_u_56
            if v510 > 0 and v_u_40 < v510 then
                v_u_1.NextInventoryItem(v_u_40 + 1)
                return
            end
        else
            CurrentSearchQuery = ""
            table.clear(v_u_52)
            v_u_504.Text = ""
            if v_u_506 then
                v_u_506:Disconnect()
                v_u_506 = nil
            end
            if v_u_505 then
                v_u_505:Cancel()
                v_u_505 = nil
            end
            v_u_503.Visible = false
            v_u_503.Size = UDim2.new(0, 0, 1, 0)
            v_u_46 = true
            if v_u_50 then
                task.cancel(v_u_50)
                v_u_50 = nil
            end
            v_u_50 = task.spawn(function()
                -- upvalues: (ref) v_u_54, (ref) v_u_49, (ref) v_u_45, (ref) v_u_50
                task.wait(20)
                if not v_u_54 or v_u_54.Visible then
                    return
                end
                local v511 = v_u_54.Tabs.Inventory.Container
                v511.CanvasPosition = Vector2.new(0, 0)
                local v512 = {}
                for _, v513 in ipairs(v511:GetChildren()) do
                    local v514 = v513:IsA("Frame")
                    if v514 then
                        if v513.Name == "UIGridLayout" or (v513.Name == "UIListLayout" or (v513.Name == "UIPadding" or v513.Name == "Title")) then
                            v514 = false
                        else
                            v514 = v513.Name ~= "Label"
                        end
                    end
                    if v514 then
                        table.insert(v512, v513)
                    end
                end
                table.sort(v512, function(p515, p516)
                    return p515.LayoutOrder > p516.LayoutOrder
                end)
                for v517 = 1, #v512 do
                    if v_u_54.Visible then
                        break
                    end
                    v512[v517]:Destroy()
                    if v_u_49 > 0 then
                        v_u_49 = v_u_49 - 1
                    end
                    task.wait(1)
                end
                v_u_45 = true
                v_u_50 = nil
            end)
        end
    end)
    v_u_54.Tabs.Inventory.Container:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        -- upvalues: (ref) v_u_201
        v_u_201()
    end)
    v_u_54.Tabs.Inventory.Container:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
        -- upvalues: (ref) v_u_201
        task.defer(v_u_201)
    end)
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_11, (copy) v_u_9, (copy) v_u_1, (copy) v_u_3, (ref) v_u_54, (copy) v_u_7, (copy) v_u_20, (ref) v_u_40, (copy) v_u_56, (ref) v_u_57, (ref) v_u_53, (copy) v_u_6, (ref) v_u_55, (copy) v_u_35, (copy) v_u_14, (copy) v_u_19, (copy) v_u_8, (ref) v_u_51, (copy) v_u_27, (ref) v_u_47, (ref) v_u_41, (ref) v_u_43, (ref) v_u_46, (ref) v_u_45, (ref) v_u_34, (copy) v_u_150, (copy) v_u_187, (copy) v_u_243, (copy) v_u_82, (copy) v_u_30
    v_u_11.WaitForDataLoaded(v_u_9)
    v_u_1.SelectCategory("Everything")
    local v_u_518 = nil
    local v_u_519 = nil
    if v_u_54 then
        v_u_54:GetPropertyChangedSignal("Visible"):Connect(function()
            -- upvalues: (ref) v_u_54, (ref) v_u_518, (ref) v_u_3, (ref) v_u_7, (ref) v_u_20, (ref) v_u_40, (ref) v_u_56, (ref) v_u_57, (ref) v_u_53, (ref) v_u_519, (ref) v_u_1
            if v_u_54.Visible then
                if v_u_518 then
                    v_u_518:Disconnect()
                end
                v_u_518 = v_u_3.InputBegan:Connect(function(p520, p521)
                    -- upvalues: (ref) v_u_54, (ref) v_u_7, (ref) v_u_20, (ref) v_u_40, (ref) v_u_56, (ref) v_u_57, (ref) v_u_53
                    if p520.UserInputType == Enum.UserInputType.Gamepad1 then
                        if v_u_54 and (v_u_54.Visible and not p521) then
                            local v522 = p520.KeyCode
                            local v523 = v_u_7.SelectedObject
                            local v524 = v_u_54 and v_u_54.ItemNotification
                            if v524 then
                                v524 = v_u_54.ItemNotification.Visible
                            end
                            if v522 == Enum.KeyCode.ButtonB then
                                if v524 then
                                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                                    v_u_54.ItemNotification.Visible = false
                                    v_u_40 = 0
                                    table.clear(v_u_56)
                                    v_u_57 = false
                                    return
                                end
                                if v_u_53 and v_u_53.Visible then
                                    v_u_53.Visible = false
                                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                                    return
                                end
                                if v_u_54 and v_u_54.Tabs.Inventory.Sort.Button.Options.Visible then
                                    v_u_54.Tabs.Inventory.Sort.Button.Options.Visible = false
                                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                                    return
                                end
                            end
                            if v524 then
                                local v525 = v_u_54.ItemNotification.Holder
                                if v522 == Enum.KeyCode.Thumbstick1 or (v522 == Enum.KeyCode.DPadLeft or v522 == Enum.KeyCode.DPadRight) then
                                    return
                                else
                                    local v526 = v522 == Enum.KeyCode.DPadUp
                                    if v526 or v522 == Enum.KeyCode.DPadDown then
                                        if v523 and v523:IsA("GuiButton") then
                                            local v527 = v526 and v523.NextSelectionUp or v523.NextSelectionDown
                                            if v527 and (v527 == v525.Continue or v527 == v525.ViewLoadout) then
                                                v_u_7.SelectedObject = v527
                                            end
                                        end
                                    end
                                end
                            else
                                local v528 = v_u_53 and v_u_53.Visible
                                if v528 then
                                    if v523 then
                                        v528 = v523:IsDescendantOf(v_u_53)
                                    else
                                        v528 = v523
                                    end
                                end
                                if not v528 or v522 ~= Enum.KeyCode.Thumbstick1 and (v522 ~= Enum.KeyCode.DPadLeft and v522 ~= Enum.KeyCode.DPadRight) then
                                    local v529 = v522 == Enum.KeyCode.DPadUp
                                    local v530 = (v529 or v522 == Enum.KeyCode.DPadDown) and (v523 and v523:IsA("GuiButton")) and (v529 and v523.NextSelectionUp or v523.NextSelectionDown)
                                    if v530 then
                                        if v528 then
                                            if v530:IsDescendantOf(v_u_53) then
                                                v_u_7.SelectedObject = v530
                                                return
                                            end
                                        else
                                            v_u_7.SelectedObject = v530
                                        end
                                    end
                                end
                            end
                        else
                            return
                        end
                    else
                        return
                    end
                end)
                if v_u_519 then
                    v_u_519:Disconnect()
                end
                v_u_519 = v_u_7.Changed:Connect(function(p531)
                    -- upvalues: (ref) v_u_54, (ref) v_u_7, (ref) v_u_1, (ref) v_u_53
                    if p531 == "SelectedObject" then
                        local v532 = v_u_54
                        if v532 then
                            v532 = v_u_54.ItemNotification
                        end
                        if v532 and v532.Visible then
                            local v533 = v532.Holder
                            local v534 = v_u_7.SelectedObject
                            if v534 and (v534 ~= v533.Continue and (v534 ~= v533.ViewLoadout and not (v534:IsDescendantOf(v533) and v534:IsA("GuiButton")))) then
                                task.defer(function()
                                    -- upvalues: (ref) v_u_1
                                    v_u_1.SelectFirstItemNotificationButton()
                                end)
                            end
                            return
                        elseif v_u_53 and v_u_53.Visible then
                            local v535 = v_u_7.SelectedObject
                            if v535 and not v535:IsDescendantOf(v_u_53) then
                                task.defer(function()
                                    -- upvalues: (ref) v_u_1
                                    v_u_1.SelectFirstInformationFrameButton()
                                end)
                            end
                        end
                    else
                        return
                    end
                end)
                if v_u_3.GamepadEnabled then
                    task.defer(function()
                        -- upvalues: (ref) v_u_7, (ref) v_u_54
                        local v536 = 0
                        while v536 < 5 do
                            task.wait(0.1)
                            v536 = v536 + 1
                            if v_u_7.SelectedObject or not (v_u_54 and v_u_54.Visible) then
                                break
                            end
                            if v_u_54.Tabs.Inventory.Container then
                                for _, v537 in ipairs(v_u_54.Tabs.Inventory.Container:GetChildren()) do
                                    if v537:IsA("Frame") and (v537.Name ~= "UIGridLayout" and (v537.Name ~= "UIListLayout" and v537.Name ~= "UIPadding")) then
                                        local v538 = v537:FindFirstChild("Button")
                                        if v538 and (v538:IsA("GuiButton") and (v538.Selectable and v538.Visible)) then
                                            v_u_7.SelectedObject = v538
                                            return
                                        end
                                    end
                                end
                            end
                        end
                    end)
                    return
                end
            else
                if v_u_518 then
                    v_u_518:Disconnect()
                    v_u_518 = nil
                end
                if v_u_519 then
                    v_u_519:Disconnect()
                    v_u_519 = nil
                end
            end
        end)
    end
    v_u_6.Heartbeat:Connect(function(p539)
        -- upvalues: (ref) v_u_55, (ref) v_u_35, (ref) v_u_1, (ref) v_u_54, (ref) v_u_56, (ref) v_u_40
        local v540 = v_u_55.Menu.Top.Buttons.Inventory.Alert
        if v_u_35 then
            v_u_1.UpdateHoverFrame(p539)
        else
            v_u_54.Hover.Visible = false
        end
        local v541 = #v_u_56
        v540.TextLabel.Text = v541
        v540.Visible = v541 > 0
        v_u_54.ItemNotification.Holder.Light.Rotation = v_u_54.ItemNotification.Holder.Light.Rotation + p539 * 10
        v_u_54.ItemNotification.Holder.Amount.TextLabel.Text = ("%* / %*"):format(v_u_40, v541)
        v_u_54.ItemNotification.Holder.Right.Visible = v_u_40 < v541
        v_u_54.ItemNotification.Holder.Left.Visible = v_u_40 > 1
    end)
    v_u_14.OnItemStockSchemasUpdated:Connect(function(_)
        -- upvalues: (ref) v_u_11, (ref) v_u_9, (ref) v_u_1
        local v542 = v_u_11.Get(v_u_9, "Inventory")
        v_u_1.UpdateTemplates(v542)
    end)
    v_u_19.Store.NewInventoryItem.Listen(function(p543)
        -- upvalues: (ref) v_u_8, (ref) v_u_9, (ref) v_u_56
        local v544 = p543.Player
        local v545 = tonumber(v544)
        if not v545 then
            return
        end
        local v546 = v_u_8:GetPlayerByUserId(v545)
        if not v546 or v_u_9 ~= v546 then
            return
        end
        for _, v547 in ipairs(p543.Items) do
            local v548 = false
            for _, v549 in ipairs(v_u_56) do
                if v549._id == v547._id then
                    v548 = true
                    break
                end
            end
            if not v548 then
                local v550 = v_u_56
                table.insert(v550, v547)
            end
        end
    end)
    v_u_19.Store.CaseOpenDenied.Listen(function(p551)
        -- upvalues: (ref) v_u_51, (ref) v_u_27, (ref) v_u_47, (ref) v_u_20
        local v552
        if p551 then
            local v553 = p551.RequestId
            if typeof(v553) == "string" then
                v552 = p551.RequestId
            else
                v552 = nil
            end
        else
            v552 = nil
        end
        local v554
        if v552 then
            v554 = v_u_51 == v552
        else
            v554 = v552
        end
        if v554 and (not v552 or v_u_51 == v552) then
            if v_u_51 then
                v_u_27.ClearPendingOpenCaseRequest(v_u_51)
            end
            v_u_47 = false
            v_u_51 = nil
        end
        if v554 and (p551 and p551.Reason == "RateLimited") then
            local v555 = p551.RetryAfterMs
            local v556 = (tonumber(v555) or 0) / 1000
            local v557 = v556 <= 0 and "Quick open is rate limited. Please wait a moment and try again." or string.format("Quick open is rate limited. Wait %.1fs and try again.", v556)
            v_u_20.broadcastRouter("CreateMenuNotification", "Error", v557)
        end
    end)
    v_u_11.CreateListener(v_u_9, "Inventory", function(p558)
        -- upvalues: (ref) v_u_1, (ref) v_u_41, (ref) v_u_54, (ref) v_u_43, (ref) v_u_46, (ref) v_u_45, (ref) v_u_34, (ref) v_u_150, (ref) v_u_187, (ref) v_u_243
        v_u_1.UpdateInventory(p558)
        if not v_u_41 then
            v_u_54.Tabs.Inventory.Sort.Button.Frame.TextLabel.Text = "Newest"
            v_u_43 = "Newest"
            v_u_41 = true
        end
        if v_u_54 then
            if v_u_54.Visible then
                v_u_34 = v_u_150()
                v_u_34 = v_u_187(v_u_34)
                v_u_243()
            else
                v_u_46 = true
                v_u_45 = true
            end
        else
            return
        end
    end)
    v_u_11.CreateListener(v_u_9, "Loadout", function()
        -- upvalues: (ref) v_u_54, (ref) v_u_82
        if v_u_54 and v_u_54.Visible then
            local v559 = v_u_54.Tabs.Inventory.Container
            for _, v560 in ipairs(v559:GetChildren()) do
                local v561 = v560:IsA("Frame")
                if v561 then
                    if v560.Name == "UIGridLayout" or (v560.Name == "UIListLayout" or (v560.Name == "UIPadding" or v560.Name == "Title")) then
                        v561 = false
                    else
                        v561 = v560.Name ~= "Label"
                    end
                end
                if v561 then
                    v_u_82(v560, v560.Name)
                end
            end
        end
    end)
    v_u_30.OnInspectStateChanged:Connect(function(p562)
        -- upvalues: (ref) v_u_56, (ref) v_u_54, (ref) v_u_40, (ref) v_u_1
        if not p562 then
            task.defer(function()
                -- upvalues: (ref) v_u_56, (ref) v_u_54, (ref) v_u_40, (ref) v_u_1
                local v563 = #v_u_56
                if v_u_54.Visible and (v563 > 0 and v_u_40 < v563) then
                    v_u_1.NextInventoryItem(v_u_40 + 1)
                end
            end)
        end
    end)
    v_u_20.observerRouter("QuickOpenResolved", function(p564)
        -- upvalues: (ref) v_u_51, (ref) v_u_27, (ref) v_u_47
        if typeof(p564) == "string" then
            if p564 and v_u_51 ~= p564 then
                return
            end
            if v_u_51 then
                v_u_27.ClearPendingOpenCaseRequest(v_u_51)
            end
            v_u_47 = false
            v_u_51 = nil
        end
    end)
    v_u_20.observerRouter("ShowNewItemNotification", function(p565)
        -- upvalues: (ref) v_u_1
        v_u_1.ShowNewItemNotification(p565)
    end)
    v_u_20.observerRouter("ShowNewItemNotificationAtIndex", function(p566)
        -- upvalues: (ref) v_u_56, (ref) v_u_1
        if p566 <= #v_u_56 then
            v_u_1.NextInventoryItem(p566)
        end
    end)
end
return v_u_1
