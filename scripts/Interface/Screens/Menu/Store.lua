-- MODULESCRIPT: Store
-- Original Path: game.BAC - 29052.Interface.Screens.Menu.Store
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("MarketplaceService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("CollectionService")
local v_u_5 = game:GetService("PolicyService")
local v_u_6 = game:GetService("TweenService")
local v_u_7 = game:GetService("HttpService")
local v_u_8 = game:GetService("RunService")
local v_u_9 = game:GetService("Players")
require(v_u_3.Database.Custom.Types)
local v_u_10 = require(v_u_3.Database.Custom.Constants)
local v_u_11 = require(v_u_3.Controllers.DataController)
local v_u_12 = require(v_u_3.Controllers.CaseSceneController)
local v_u_13 = require(v_u_3.Components.Common.InterfaceAnimations.ActivateButton)
require(v_u_3.Components.Common.GetWeaponProperties)
local v_u_14 = require(v_u_3.Components.Common.GetUserPlatform)
local v_u_15 = require(v_u_3.Database.Components.Libraries.Bundles)
local v_u_16 = require(v_u_3.Database.Components.Libraries.Skins)
local v_u_17 = require(v_u_3.Database.Components.Libraries.Cases)
local v_u_18 = require(v_u_3.Shared.CloseButtonRegistry)
local v_u_19 = require(v_u_3.Database.Security.Remotes)
local v_u_20 = require(v_u_3.Database.Security.Router)
local v_u_21 = require(v_u_3.Interface.MenuState)
local v_u_22 = require(v_u_3.Packages.Observers)
local v23 = require(v_u_3.Shared.Spring)
local v_u_24 = require(v_u_3.Database.Custom.GameStats.Monetization.DevProducts)
local v_u_25 = require(v_u_3.Database.Custom.GameStats.Monetization.Gamepasses)
local v_u_26 = require(v_u_3.Database.Custom.GameStats.Rarities)
local v_u_27 = v23.new(1, 8, 0)
local v_u_28 = v_u_9.LocalPlayer
local v_u_29 = -1
local v_u_30 = true
local v_u_31 = 0
local v_u_32 = 0
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = Color3.fromRGB(243, 243, 243)
local v_u_36 = Color3.fromRGB(125, 206, 243)
local v_u_37 = Color3.fromRGB(100, 168, 195)
local v_u_38 = Color3.fromRGB(53, 83, 99)
local v_u_39 = Color3.fromRGB(127, 143, 144)
local v_u_40 = {
    {
        ["frameNames"] = { "AWP" },
        ["productName"] = "AWP | Tekko",
        ["weaponName"] = "AWP",
        ["skinName"] = "Tekko"
    },
    {
        ["frameNames"] = { "M4A4", "M4-A4", "M4 A4" },
        ["productName"] = "M4A4 | Tekko",
        ["weaponName"] = "M4A4",
        ["skinName"] = "Tekko"
    },
    {
        ["frameNames"] = { "USP-S", "USP S", "USP_S" },
        ["productName"] = "USP-S | Tekko",
        ["weaponName"] = "USP-S",
        ["skinName"] = "Tekko"
    }
}
local v_u_41 = {
    ["chrysalis"] = "rbxassetid://127888213250008"
}
local v_u_42 = {
    ["Blue"] = 1,
    ["Purple"] = 2,
    ["Pink"] = 3,
    ["Red"] = 4,
    ["Special"] = 5
}
local v_u_43 = nil
local v_u_44 = nil
local v_u_45 = nil
local v_u_46 = nil
local v_u_47 = nil
local v_u_48 = false
local v_u_49 = 0
local v_u_50 = false
local v_u_51 = false
local v_u_52 = nil
local v_u_53 = {
    ["isOpening"] = false,
    ["isPendingOpenRequest"] = false,
    ["isQuickUnlock"] = false,
    ["currentTween"] = nil,
    ["currentZoomTween"] = nil,
    ["renderConnection"] = nil,
    ["viewportConnection"] = nil,
    ["currentInventoryItem"] = nil,
    ["currentCaseIdentifier"] = nil,
    ["pendingOpenRequestId"] = nil,
    ["progressRightTween"] = nil,
    ["progressRightProxy"] = nil
}
local v_u_54 = 0
local v_u_55 = {}
local v_u_56 = {}
local v_u_57 = {
    ["Special"] = "Drop Gold",
    ["Red"] = "Drop Red",
    ["Pink"] = "Drop Pink",
    ["Purple"] = "Drop Purple",
    ["Blue"] = "Drop Blue"
}
local v_u_58 = {
    ["inventoryItems"] = nil,
    ["bulkIdentifier"] = nil,
    ["caseId"] = nil,
    ["isBulkOpening"] = false,
    ["currentIndex"] = 0,
    ["skipped"] = false,
    ["total"] = 0
}
local function v_u_62(p59, p60)
    for _, v61 in ipairs(p59:GetChildren()) do
        if not table.find(p60, v61.Name) then
            v61:Destroy()
        end
    end
end
local function v_u_66(p63, p64)
    for _, v65 in ipairs(p64) do
        if not p63 then
            return nil
        end
        p63 = p63:FindFirstChild(v65)
    end
    return p63
end
local function v_u_71(p67)
    -- upvalues: (copy) v_u_66
    local v68 = v_u_66(p67, {
        "Content",
        "FullBundle",
        "Content",
        "Buy"
    })
    local v69
    if v68 then
        v69 = v68:FindFirstChild("Gift")
    else
        v69 = v68
    end
    if not (v69 and v69:IsA("GuiButton")) then
        v69 = nil
    end
    if v68 then
        v68 = v68:FindFirstChild("Purchase")
    end
    if not (v68 and v68:IsA("GuiButton")) then
        v68 = nil
    end
    if not v69 then
        v69 = p67:FindFirstChild("Gift")
        if not (v69 and v69:IsA("GuiButton")) then
            v69 = nil
        end
    end
    if not v68 then
        local v70 = p67:FindFirstChild("Purchase")
        if v70 and v70:IsA("GuiButton") then
            return v69, v70
        end
        v68 = nil
    end
    return v69, v68
end
local function v_u_77(p72, p73)
    -- upvalues: (copy) v_u_7, (ref) v_u_43
    local v_u_74 = v_u_7:GenerateGUID(false)
    v_u_43.CreatorCode:SetAttribute("ResponseId", v_u_74)
    v_u_43.CreatorCode.Container.Body.Response.Text = p73
    local v75 = v_u_43.CreatorCode.Container.Body.Response
    local v76 = p72 == "Success" and Color3.fromRGB(86, 228, 21)
    if not v76 then
        if p72 == "Error" then
            v76 = Color3.fromRGB(232, 59, 82)
        else
            v76 = false
        end
    end
    v75.TextColor3 = v76
    task.delay(5, function()
        -- upvalues: (ref) v_u_43, (copy) v_u_74
        if v_u_43.CreatorCode:GetAttribute("ResponseId") == v_u_74 then
            v_u_43.CreatorCode.Container.Body.Response.Text = ""
        end
    end)
end
local function v_u_82(p78, p79)
    if not p78 then
        return nil
    end
    for _, v80 in ipairs(p79) do
        local v81 = p78:FindFirstChild(v80)
        if v81 then
            return v81
        end
    end
    return nil
end
local function v_u_88(p83)
    -- upvalues: (copy) v_u_66
    local v84 = p83:FindFirstChild("Purchase")
    if not (v84 and v84:IsA("GuiButton")) then
        v84 = nil
    end
    local v85 = p83:FindFirstChild("Gift")
    if not (v85 and v85:IsA("GuiButton")) then
        v85 = nil
    end
    local v86 = p83:FindFirstChild("Inspect")
    if not (v86 and v86:IsA("GuiButton")) then
        v86 = nil
    end
    local v87 = v_u_66(p83, { "Footer", "Action" })
    if v87 then
        if not v84 then
            v84 = v87:FindFirstChild("Purchase")
            if not (v84 and v84:IsA("GuiButton")) then
                v84 = nil
            end
            if not v84 then
                v84 = v87:FindFirstChild("Buy")
                if not (v84 and v84:IsA("GuiButton")) then
                    v84 = nil
                end
            end
        end
        if not v85 then
            v85 = v87:FindFirstChild("Gift")
            if not (v85 and v85:IsA("GuiButton")) then
                v85 = nil
            end
        end
    end
    return v85, v84, v86
end
local function v_u_91()
    -- upvalues: (copy) v_u_53, (copy) v_u_58, (copy) v_u_21, (copy) v_u_56, (copy) v_u_1
    if v_u_53.isOpening or (v_u_58.isBulkOpening or v_u_21.IsInspectActive()) then
        return false
    end
    local v89 = false
    while true do
        local v90 = not (v_u_53.isOpening or (v_u_58.isBulkOpening or v_u_21.IsInspectActive())) and table.remove(v_u_56, 1)
        if not v90 then
            break
        end
        v89 = true
        if #v90.InventoryItems > 1 then
            v_u_1.StartBulkOpening(v90.CaseId, v90.InventoryItems, v90.CaseIdentifier)
        else
            v_u_1.OpenCase(v90.CaseId, v90.InventoryItems[1], v90.CaseIdentifier, v90.IsQuickUnlock, v90.RequestId)
        end
    end
    return v89
end
local function v_u_92()
    -- upvalues: (copy) v_u_53
    if v_u_53.currentTween then
        v_u_53.currentTween:Cancel()
        v_u_53.currentTween = nil
    end
    if v_u_53.currentZoomTween then
        v_u_53.currentZoomTween:Cancel()
        v_u_53.currentZoomTween = nil
    end
    if v_u_53.renderConnection then
        v_u_53.renderConnection:Disconnect()
        v_u_53.renderConnection = nil
    end
    if v_u_53.viewportConnection then
        v_u_53.viewportConnection:Disconnect()
        v_u_53.viewportConnection = nil
    end
end
local function v_u_111(p_u_93)
    local v94 = workspace:GetServerTimeNow()
    local v95 = math.floor(v94)
    local v96 = nil
    local v97 = typeof(p_u_93) == "number" or tonumber(p_u_93)
    if v97 then
        v96 = v97
    else
        local v98, v99 = pcall(function()
            -- upvalues: (copy) p_u_93
            return DateTime.fromIsoDate(p_u_93)
        end)
        if v98 and v99 then
            v96 = v99.UnixTimestamp
        end
    end
    if not v96 then
        return "00:00:00:00"
    end
    local v100
    if v96 > 10000000000 then
        local v101 = v96 / 1000
        v100 = math.floor(v101)
    else
        v100 = math.floor(v96)
    end
    local v102 = v100 - v95
    if v102 <= 0 then
        return "00:00:00:00"
    end
    local v103 = string.format
    local v104 = v102 / 86400
    local v105 = math.floor(v104)
    local v106 = v102 % 86400 / 3600
    local v107 = math.floor(v106)
    local v108 = v102 % 3600 / 60
    local v109 = math.floor(v108)
    local v110 = v102 % 60
    return v103("%02d:%02d:%02d:%02d", v105, v107, v109, (math.floor(v110)))
end
local function v_u_115()
    -- upvalues: (ref) v_u_45, (ref) v_u_46, (ref) v_u_47, (ref) v_u_43, (copy) v_u_66, (ref) v_u_51
    if v_u_45 and (v_u_46 and v_u_47) then
        return true
    end
    local v112 = v_u_43 and v_u_43.Tabs and (v_u_43.Tabs.Container and v_u_43.Tabs.Container.Credits)
    if v112 then
        v112 = v_u_43.Tabs.Container.Credits.Container
    end
    if v112 then
        v112 = v112:FindFirstChild("StarterPack")
    end
    local v113
    if v112 then
        v113 = v_u_66(v112, { "StarterPack", "Timer" })
        if not (v113 and (v113:IsA("TextLabel") or v113:IsA("TextButton"))) then
            v113 = nil
        end
    else
        v113 = v112
    end
    local v114
    if v112 then
        v114 = v112:FindFirstChild("Purchase", true)
        if not (v114 and v114:IsA("GuiButton")) then
            v114 = nil
        end
    else
        v114 = v112
    end
    if not (v112 and (v113 and v114)) then
        if not v_u_51 then
            v_u_51 = true
            warn("[Store] Missing StarterPack UI under Store.Tabs.Container.Credits.Container")
        end
        return false
    end
    v_u_45 = v112
    v_u_46 = v113
    v_u_47 = v114
    return true
end
local function v_u_148(p116)
    -- upvalues: (copy) v_u_11, (copy) v_u_28, (ref) v_u_52, (copy) v_u_15, (copy) v_u_111, (copy) v_u_115, (ref) v_u_45, (ref) v_u_46
    local v117 = v_u_11.Get(v_u_28, "Statistics.OpenShopTime")
    local v118 = nil
    if typeof(v117) == "number" then
        v118 = v117
    elseif typeof(v117) == "string" then
        v118 = tonumber(v117)
    end
    local v119
    if v118 == nil then
        v119 = nil
    elseif v118 > 10000000000 then
        local v120 = v118 / 1000
        v119 = math.floor(v120)
    else
        v119 = math.floor(v118)
    end
    local v121
    if v119 == nil then
        v121 = 0
    else
        local v122 = (p116 or workspace:GetServerTimeNow()) - v119
        local v123 = 86400 - math.max(0, v122)
        local v124 = math.floor(v123)
        v121 = math.max(0, v124)
    end
    local v125
    if v121 > 0 then
        local v126 = v_u_11.Get(v_u_28, "Gamepasses")
        local v127
        if typeof(v126) == "table" then
            v127 = table.find(v126, "Credits StarterPack") ~= nil
        else
            v127 = false
        end
        v125 = not v127
    else
        v125 = false
    end
    if v_u_52 then
        if v125 then
            local v128 = v_u_52
            local v129 = math.floor(v121)
            local v130 = math.max(0, v129)
            local v131 = v130 / 3600
            local v132 = math.floor(v131)
            local v133 = v130 % 3600 / 60
            local v134 = math.floor(v133)
            local v135 = v130 % 60
            local v136 = math.floor(v135)
            v128.Text = string.format("%02d:%02d:%02d", v132, v134, v136)
        else
            local v137 = v_u_15.GetActiveBundle()
            v_u_52.Text = not (v137 and v137.discontinueDate) and "NEW!" or v_u_111(v137.discontinueDate)
        end
    end
    if v_u_115() then
        v_u_45.Visible = v125
        local v138 = v_u_46
        local v139
        if v125 then
            local v140 = math.floor(v121)
            local v141 = math.max(0, v140)
            local v142 = v141 / 3600
            local v143 = math.floor(v142)
            local v144 = v141 % 3600 / 60
            local v145 = math.floor(v144)
            local v146 = v141 % 60
            local v147 = math.floor(v146)
            v139 = string.format("%02d:%02d:%02d", v143, v145, v147) or "00:00:00"
        else
            v139 = "00:00:00"
        end
        v138.Text = v139
    end
end
function v_u_1.IsStarterPackAvailable()
    -- upvalues: (copy) v_u_11, (copy) v_u_28
    local v149, v150 = v_u_11.Get(v_u_28, "Statistics.OpenShopTime")
    local v151 = nil
    if typeof(v149) == "number" then
        v151 = v149
    elseif typeof(v149) == "string" then
        v151 = tonumber(v149)
    end
    local v152
    if v151 == nil then
        v152 = nil
    elseif v151 > 10000000000 then
        local v153 = v151 / 1000
        v152 = math.floor(v153)
    else
        v152 = math.floor(v151)
    end
    local v154
    if v152 == nil then
        v154 = 0
    else
        local v155 = (v150 or workspace:GetServerTimeNow()) - v152
        local v156 = 86400 - math.max(0, v155)
        local v157 = math.floor(v156)
        v154 = math.max(0, v157)
    end
    local v158
    if v154 > 0 then
        local v159 = v_u_11.Get(v_u_28, "Gamepasses")
        local v160
        if typeof(v159) == "table" then
            v160 = table.find(v159, "Credits StarterPack") ~= nil
        else
            v160 = false
        end
        v158 = not v160
    else
        v158 = false
    end
    return v158
end
function v_u_1.GetStarterPackRemainingSeconds()
    -- upvalues: (copy) v_u_11, (copy) v_u_28
    local v161, v162 = v_u_11.Get(v_u_28, "Statistics.OpenShopTime")
    local v163 = nil
    if typeof(v161) == "number" then
        v163 = v161
    elseif typeof(v161) == "string" then
        v163 = tonumber(v161)
    end
    local v164
    if v163 == nil then
        v164 = nil
    elseif v163 > 10000000000 then
        local v165 = v163 / 1000
        v164 = math.floor(v165)
    else
        v164 = math.floor(v163)
    end
    if v164 == nil then
        return 0
    end
    local v166 = (v162 or workspace:GetServerTimeNow()) - v164
    local v167 = 86400 - math.max(0, v166)
    local v168 = math.floor(v167)
    return math.max(0, v168)
end
local function v_u_174()
    -- upvalues: (copy) v_u_11, (copy) v_u_28, (ref) v_u_48, (copy) v_u_148, (ref) v_u_49, (copy) v_u_19
    local v169 = v_u_11.Get(v_u_28, "Statistics.OpenShopTime")
    local v170 = nil
    if typeof(v169) == "number" then
        v170 = v169
    elseif typeof(v169) == "string" then
        v170 = tonumber(v169)
    end
    local v171
    if v170 == nil then
        v171 = nil
    elseif v170 > 10000000000 then
        local v172 = v170 / 1000
        v171 = math.floor(v172)
    else
        v171 = math.floor(v170)
    end
    if v171 == nil then
        local v173 = tick()
        if not v_u_48 or v173 - v_u_49 >= 5 then
            v_u_48 = true
            v_u_49 = v173
            v_u_19.Store.OpenedShop.Send({})
        end
        v_u_148()
    else
        v_u_48 = true
        v_u_148()
    end
end
local function v_u_186(p_u_175)
    -- upvalues: (copy) v_u_6, (copy) v_u_20, (copy) v_u_39, (copy) v_u_37, (copy) v_u_35
    local v_u_176 = p_u_175.Size
    p_u_175.MouseEnter:Connect(function()
        -- upvalues: (ref) v_u_6, (copy) p_u_175, (copy) v_u_176, (ref) v_u_20, (ref) v_u_39, (ref) v_u_37
        local v177 = v_u_6
        local v178 = p_u_175
        local v179 = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)
        local v180 = {}
        local v181 = v_u_176
        v180.Size = UDim2.fromScale(v181.X.Scale * 0.9, v181.Y.Scale * 0.9)
        v177:Create(v178, v179, v180):Play()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Highlight")
        if p_u_175.Name ~= "Credits" and not p_u_175:GetAttribute("Selected") then
            local v182 = {
                ["BackgroundTransparency"] = 0.8,
                ["BackgroundColor3"] = v_u_39
            }
            v_u_6:Create(p_u_175.HoverFrame, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), v182):Play()
            local v183 = {
                ["TextColor3"] = v_u_37
            }
            v_u_6:Create(p_u_175.TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), v183):Play()
        end
    end)
    p_u_175.MouseLeave:Connect(function()
        -- upvalues: (ref) v_u_6, (copy) p_u_175, (copy) v_u_176, (ref) v_u_35
        local v184 = {
            ["Size"] = v_u_176
        }
        v_u_6:Create(p_u_175, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), v184):Play()
        if p_u_175.Name ~= "Credits" and not p_u_175:GetAttribute("Selected") then
            local v185 = {
                ["TextColor3"] = v_u_35
            }
            v_u_6:Create(p_u_175.TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), v185):Play()
            v_u_6:Create(p_u_175.HoverFrame, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
                ["BackgroundTransparency"] = 1
            }):Play()
        end
    end)
    p_u_175.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_20
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
    end)
end
local function v_u_194(p187)
    local v188 = 0
    for _, v189 in ipairs(p187.contents) do
        v188 = v188 + v189.weight
    end
    local v190 = math.random() * v188
    local v191 = 0
    for _, v192 in ipairs(p187.contents) do
        v191 = v191 + v192.weight
        if v190 <= v191 then
            return v192, v192.isSpecial or false
        end
    end
    local v193 = p187.contents[1]
    return v193, v193.isSpecial or false
end
local function v_u_203(p195, p196, p197, p198)
    -- upvalues: (copy) v_u_194
    local v199 = {}
    for v200 = 1, 75 do
        if v200 == p197 then
            table.insert(v199, {
                ["item"] = p196,
                ["isGold"] = p198
            })
        else
            local v201, v202 = v_u_194(p195)
            table.insert(v199, {
                ["item"] = v201,
                ["isGold"] = v202
            })
        end
    end
    return v199
end
local function v_u_220(p204, p205, p206, p207)
    -- upvalues: (copy) v_u_3, (copy) v_u_26, (copy) v_u_16, (copy) v_u_41
    local v208 = v_u_3.Assets.UI.Store.CaseScroll
    local v209
    if p205.isGold then
        v209 = v208:FindFirstChild("GoldTemplate")
    else
        v209 = v208:FindFirstChild("ItemTemplate")
    end
    if v209 then
        local v210 = v209:Clone()
        v210.Name = tostring(p206)
        v210.LayoutOrder = p206
        v210.Size = p207
        v210.SizeConstraint = Enum.SizeConstraint.RelativeXY
        v210.AutomaticSize = Enum.AutomaticSize.None
        v210.Parent = p204
        if p205.isGold then
            local v211 = string.lower(p205.item.skin.skinName)
            v210.Frame.Icon.Image = "rbxassetid://132217734282843"
            if v_u_41[v211] then
                v210.Frame.Icon.Image = v_u_41[v211]
                return
            end
        else
            local v212 = v_u_26[p205.item.rarity]
            local v213 = v_u_16.GetSkinInformation(p205.item.skin.weaponName, p205.item.skin.skinName)
            local v214 = v210:FindFirstChild("Frame")
            if v212 and (v213 and v214) then
                local v215 = v214:FindFirstChild("RarityFrame")
                local v216 = v215 and v215:FindFirstChild("UIGradient")
                if v216 then
                    v216.Color = v212.ColorSequence
                end
                local v217 = v214:FindFirstChild("Icon")
                if v217 then
                    local v218 = ""
                    if v213.wearImages and #v213.wearImages > 0 then
                        v218 = v213.wearImages[1].assetId
                    elseif v213.charmImages and #v213.charmImages > 0 then
                        v218 = v213.charmImages[1].assetId
                    elseif v213.imageAssetId then
                        v218 = v213.imageAssetId
                    end
                    v217.Image = v218
                end
                local v219 = v214:FindFirstChild("Rarity")
                if v219 then
                    v219.ImageColor3 = v212.Color
                    return
                end
            end
        end
    else
        warn("[Store] Missing case scroll template")
    end
end
local function v_u_229(p221, p222, p223, p224)
    -- upvalues: (copy) v_u_220
    for _, v225 in ipairs(p221:GetChildren()) do
        if v225:IsA("Frame") or (v225:IsA("ImageLabel") or v225:IsA("ImageButton")) then
            v225:Destroy()
        end
    end
    local v226 = p221:FindFirstChildOfClass("UIListLayout")
    if v226 then
        v226.FillDirection = Enum.FillDirection.Horizontal
        v226.HorizontalAlignment = Enum.HorizontalAlignment.Left
        v226.VerticalAlignment = Enum.VerticalAlignment.Center
        v226.Padding = UDim.new(0, p224)
    end
    for v227, v228 in ipairs(p222) do
        v_u_220(p221, v228, v227, p223)
    end
end
local function v_u_237(p230, p231)
    local v232 = p230.AbsoluteSize.X
    local v233 = math.max(v232, 1)
    local v234 = p231 / v233
    local v235 = math.max(v234, 1)
    p230.CanvasSize = UDim2.fromScale(v235, 0)
    local v236 = p231 - v233
    p230:SetAttribute("ScrollMaxOffset", (math.max(0, v236)))
    p230:SetAttribute("ScrollViewportWidth", v233)
end
local function v_u_252(p_u_238, p_u_239, p_u_240, p_u_241, p_u_242, p_u_243)
    -- upvalues: (copy) v_u_6, (copy) v_u_53, (copy) v_u_8
    local v244 = TweenInfo.new(7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local v_u_245 = v_u_6:Create(p_u_238, v244, {
        ["CanvasPosition"] = Vector2.new(p_u_240, 0)
    })
    local v_u_246 = v_u_6:Create(p_u_239, v244, {
        ["CanvasPosition"] = Vector2.new(p_u_241, 0)
    })
    v_u_53.currentTween = v_u_245
    v_u_53.currentZoomTween = v_u_246
    local v_u_247 = 0
    local v_u_248 = nil
    v_u_248 = v_u_8.RenderStepped:Connect(function()
        -- upvalues: (ref) v_u_53, (ref) v_u_248, (copy) p_u_238, (copy) p_u_242, (ref) v_u_247, (copy) p_u_243, (copy) v_u_245
        if v_u_53.isOpening then
            local v249 = p_u_238.CanvasPosition.X
            local v250 = p_u_242 <= 0 and 0 or v249 / p_u_242
            local v251 = math.floor(v250) + 1
            if v_u_247 < v251 and v251 <= 75 then
                p_u_243(v251)
                v_u_247 = v251
            end
            if v_u_245.PlaybackState == Enum.PlaybackState.Completed and v_u_248 then
                v_u_248:Disconnect()
                v_u_248 = nil
                v_u_53.renderConnection = nil
            end
        elseif v_u_248 then
            v_u_248:Disconnect()
            v_u_248 = nil
            v_u_53.renderConnection = nil
        end
    end)
    v_u_53.renderConnection = v_u_248
    v_u_245.Completed:Connect(function()
        -- upvalues: (copy) v_u_245, (ref) v_u_53, (ref) v_u_248
        if v_u_245 == v_u_53.currentTween then
            if v_u_248 then
                v_u_248:Disconnect()
                v_u_248 = nil
                v_u_53.renderConnection = nil
            end
        end
    end)
    task.delay(6.02, function()
        -- upvalues: (copy) v_u_245, (ref) v_u_53, (copy) p_u_238, (copy) p_u_239, (ref) v_u_248, (copy) v_u_246, (copy) p_u_240, (copy) p_u_241
        if v_u_245 == v_u_53.currentTween then
            if v_u_245.PlaybackState == Enum.PlaybackState.Completed then
                return
            elseif p_u_238.Parent == nil or p_u_239.Parent == nil then
                if v_u_248 then
                    v_u_248:Disconnect()
                    v_u_248 = nil
                    v_u_53.renderConnection = nil
                end
            else
                v_u_245:Cancel()
                v_u_246:Cancel()
                p_u_238.CanvasPosition = Vector2.new(p_u_240, 0)
                p_u_239.CanvasPosition = Vector2.new(p_u_241, 0)
                if v_u_248 then
                    v_u_248:Disconnect()
                    v_u_248 = nil
                    v_u_53.renderConnection = nil
                end
            end
        else
            return
        end
    end)
    v_u_245:Play()
    v_u_246:Play()
    return v_u_245
end
local function v_u_257(p253, p254)
    -- upvalues: (copy) v_u_111
    local v255 = p253:FindFirstChild("Alert")
    if v255 and v255:IsA("GuiObject") then
        if p254.discontinueDate then
            v255.Visible = true
            local v256 = v255:FindFirstChild("TextLabel")
            if v256 and v256:IsA("TextLabel") then
                v256.Text = v_u_111(p254.discontinueDate)
            end
        else
            v255.Visible = p254.status == "featured"
        end
    else
        return
    end
end
local function v_u_262(p258)
    -- upvalues: (copy) v_u_11, (copy) v_u_28
    local v259 = v_u_11.Get(v_u_28, "Inventory")
    if not v259 then
        return 0
    end
    local v260 = 0
    for _, v261 in ipairs(v259) do
        if (v261.Type == "Case" or v261.Type == "Package") and v261.Skin == p258 then
            v260 = v260 + 1
        end
    end
    return v260
end
local function v_u_269(p263, p264)
    -- upvalues: (copy) v_u_11, (copy) v_u_28
    local v265 = v_u_11.Get(v_u_28, "Inventory")
    local v266 = {}
    if v265 then
        for _, v267 in ipairs(v265) do
            if p264 <= #v266 then
                break
            end
            if (v267.Type == "Case" or v267.Type == "Package") and v267.Skin == p263 then
                local v268 = v267._id
                table.insert(v266, v268)
            end
        end
    end
    return v266
end
local function v_u_275(p270, p271)
    local v272 = p270:GetChildren()
    for _, v273 in ipairs(v272) do
        if v273:IsA("TextButton") then
            local v274 = v273.Name
            v273.Visible = (tonumber(v274) or 0) <= p271
        end
    end
end
local function v_u_279(p276)
    local v277 = p276:GetChildren()
    for _, v278 in ipairs(v277) do
        if v278:IsA("TextButton") then
            v278.Visible = true
        end
    end
end
local function v_u_283(p280, p281)
    if p280.Type == "Melee" or p280.Type == "Glove" then
        return "Special"
    end
    for _, v282 in ipairs(p281.contents) do
        if v282.skin.skinName == p280.Skin and v282.skin.weaponName == p280.Name then
            return v282.rarity or "Blue"
        end
    end
    return "Blue"
end
local function v_u_289(p284, p285)
    for _, v286 in ipairs(p284.contents) do
        if v286.skin.skinName == p285.Skin and v286.skin.weaponName == p285.Name then
            return v286, v286.isSpecial or false
        end
    end
    if p285.Type == "Melee" or p285.Type == "Glove" then
        local v287 = {
            ["skin"] = {
                ["weaponName"] = p285.Name,
                ["skinName"] = p285.Skin,
                ["type"] = p285.Type
            },
            ["isSpecial"] = true,
            ["rarity"] = "Special",
            ["skinId"] = "",
            ["weight"] = 0
        }
        return v287, true
    else
        local v288 = p284.contents[1]
        return v288, v288.isSpecial or false
    end
end
local function v_u_295()
    -- upvalues: (copy) v_u_53, (ref) v_u_44
    if v_u_53.progressRightTween then
        v_u_53.progressRightTween:Cancel()
        v_u_53.progressRightTween = nil
    end
    if v_u_53.progressRightProxy then
        v_u_53.progressRightProxy:Destroy()
        v_u_53.progressRightProxy = nil
    end
    if v_u_44 then
        local v290 = v_u_44.Menu.OpenCase.Contents:FindFirstChild("ProgressBar")
        if v290 then
            local v291 = v290:FindFirstChild("RightGradient")
            local v292 = v290:FindFirstChild("LeftGradient")
            local v293 = v291 and v291:FindFirstChild("ProgressBarImage")
            if v293 then
                v293 = v291.ProgressBarImage:FindFirstChild("UIGradient")
            end
            local v294 = v292 and v292:FindFirstChild("ProgressBarImage")
            if v294 then
                v294 = v292.ProgressBarImage:FindFirstChild("UIGradient")
            end
            if v293 then
                v293.Transparency = NumberSequence.new(1)
                v293.Rotation = 90
            end
            if v294 then
                v294.Transparency = NumberSequence.new(1)
                v294.Rotation = 90
            end
        end
    else
        return
    end
end
local function v_u_301(p296)
    if p296 <= 0.001 then
        return NumberSequence.new(1)
    end
    if p296 >= 0.999 then
        return NumberSequence.new(0)
    end
    local v297 = p296 - 0.05
    local v298 = math.clamp(v297, 0, 0.999)
    local v299 = v298 + 0.001
    local v300 = math.clamp(p296, v299, 1)
    return NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(v298, 0),
        NumberSequenceKeypoint.new(v300, 1),
        NumberSequenceKeypoint.new(1, 1)
    })
end
local function v_u_307(p302)
    if p302 <= 0.001 then
        return NumberSequence.new(0)
    end
    if p302 >= 0.999 then
        return NumberSequence.new(1)
    end
    local v303 = p302 - 0.05
    local v304 = math.clamp(v303, 0, 0.999)
    local v305 = v304 + 0.001
    local v306 = math.clamp(p302, v305, 1)
    return NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(v304, 1),
        NumberSequenceKeypoint.new(v306, 0),
        NumberSequenceKeypoint.new(1, 0)
    })
end
local function v_u_327(p308)
    -- upvalues: (copy) v_u_295, (ref) v_u_44, (ref) v_u_31, (copy) v_u_53, (copy) v_u_6, (copy) v_u_301, (copy) v_u_307
    v_u_295()
    if v_u_44 then
        local v309 = v_u_44.Menu.OpenCase.Contents:FindFirstChild("ProgressBar")
        if v309 then
            local v310 = v309:FindFirstChild("LeftGradient")
            local v311 = v309:FindFirstChild("RightGradient")
            if v310 and v311 then
                local v312 = v310:FindFirstChild("ProgressBarImage")
                local v313 = v311:FindFirstChild("ProgressBarImage")
                if v312 and v313 then
                    local v_u_314 = v312:FindFirstChild("UIGradient")
                    local v_u_315 = v313:FindFirstChild("UIGradient")
                    if v_u_314 and v_u_315 then
                        v310.ClipsDescendants = true
                        v311.ClipsDescendants = true
                        v_u_314.Rotation = 90
                        v_u_315.Rotation = -90
                        v_u_314.Transparency = NumberSequence.new(1)
                        v_u_315.Transparency = NumberSequence.new(1)
                        v309.Visible = true
                        v_u_31 = v_u_31 + 1
                        local v_u_316 = v_u_31
                        local v_u_317 = p308 / 4 / 4
                        local function v_u_326(p_u_318, p_u_319, p320)
                            -- upvalues: (ref) v_u_53, (copy) v_u_316, (ref) v_u_31, (ref) v_u_6
                            if not v_u_53.isOpening or v_u_316 ~= v_u_31 then
                                return false
                            end
                            local v321 = Instance.new("NumberValue")
                            v321.Value = 0
                            local v323 = v321.Changed:Connect(function(p322)
                                -- upvalues: (copy) p_u_318, (copy) p_u_319
                                p_u_318.Transparency = p_u_319(p322)
                            end)
                            v_u_53.progressRightProxy = v321
                            local v324 = v_u_6:Create(v321, TweenInfo.new(p320, Enum.EasingStyle.Linear), {
                                ["Value"] = 1
                            })
                            v_u_53.progressRightTween = v324
                            v324:Play()
                            v324.Completed:Wait()
                            v323:Disconnect()
                            v321:Destroy()
                            v_u_53.progressRightProxy = nil
                            v_u_53.progressRightTween = nil
                            local v325 = v_u_53.isOpening
                            if v325 then
                                v325 = v_u_316 == v_u_31
                            end
                            return v325
                        end
                        task.spawn(function()
                            -- upvalues: (copy) v_u_326, (copy) v_u_314, (ref) v_u_301, (copy) v_u_317, (copy) v_u_315, (ref) v_u_307
                            for _ = 1, 4 do
                                if not v_u_326(v_u_314, v_u_301, v_u_317) then
                                    return
                                end
                                if not v_u_326(v_u_315, v_u_301, v_u_317) then
                                    return
                                end
                                if not v_u_326(v_u_314, v_u_307, v_u_317) then
                                    return
                                end
                                if not v_u_326(v_u_315, v_u_307, v_u_317) then
                                    return
                                end
                            end
                        end)
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
local function v_u_392(p328, p329)
    -- upvalues: (copy) v_u_53, (ref) v_u_44, (copy) v_u_289, (copy) v_u_203, (copy) v_u_229, (copy) v_u_237, (copy) v_u_252, (copy) v_u_20, (copy) v_u_327, (copy) v_u_6
    if not v_u_53.isOpening then
        return nil
    end
    local v330 = v_u_44.Menu.OpenCase
    local v331 = v330:FindFirstChild("CanvasGroup")
    local v332 = v330:FindFirstChild("Zoom")
    if not (v331 and v332) then
        warn("[Store] Missing CanvasGroup or Zoom group in OpenCase UI")
        return nil
    end
    local v_u_333 = v331:FindFirstChild("Container")
    local v_u_334 = v332:FindFirstChild("Container")
    if not (v_u_333 and v_u_334) then
        warn("[Store] Missing scroll containers for case opening")
        return nil
    end
    local v335, v336 = v_u_289(p328, p329)
    local v337 = v_u_203(p328, v335, 55, v336)
    local v338 = v_u_44 and v_u_44.AbsoluteSize or Vector2.new(1075, 1000)
    local v339 = v338.X / 5
    local v340 = math.max(v339, 1)
    local v341 = v340 * 0.65
    local v342 = math.max(v341, 1)
    local v343 = UDim2.fromOffset(v340, v342)
    local v344 = UDim2.fromOffset(v340, v342 * 1.125)
    local v345 = v330:FindFirstChild("Line")
    if v345 and v345:IsA("GuiObject") then
        v345.Size = UDim2.new(0.003, 0, 0, v342 * 1.125)
    end
    v_u_229(v_u_333, v337, v343, 8)
    v_u_229(v_u_334, v337, v344, 8)
    v_u_333.CanvasPosition = Vector2.new(0, 0)
    v_u_334.CanvasPosition = Vector2.new(0, 0)
    local v_u_346 = v340 + 8
    local v_u_347 = v_u_346 * 75
    task.wait()
    v_u_237(v_u_333, v_u_347)
    v_u_237(v_u_334, v_u_347)
    local v348 = v338.X
    local v349 = math.random
    local v350 = v348 / 11
    local v351 = -math.floor(v350)
    local v352 = v348 / 22
    local v_u_353 = v349(v351, (math.floor(v352)))
    local v354 = v_u_333.AbsoluteSize.X
    local v355 = math.max(v354, 1)
    local v356 = v_u_347 - v355
    local v357 = math.max(0, v356)
    local v358
    if v357 <= 0 then
        v358 = 0
    else
        local v359 = v_u_346 * 54.5 - v355 * 0.5 + v_u_353
        v358 = math.clamp(v359, 0, v357)
    end
    local v360 = v_u_334.AbsoluteSize.X
    local v361 = math.max(v360, 1)
    local v362 = v_u_347 - v361
    local v363 = math.max(0, v362)
    local v364
    if v363 <= 0 then
        v364 = 0
    else
        local v365 = v_u_346 * 54.5 - v361 * 0.5 + v_u_353
        v364 = math.clamp(v365, 0, v363)
    end
    v_u_333:SetAttribute("_scrollTarget", v358)
    v_u_334:SetAttribute("_scrollTarget", v364)
    local v_u_366 = tick()
    local v367 = v_u_252(v_u_333, v_u_334, v358, v364, v_u_346, function()
        -- upvalues: (ref) v_u_20
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
    end)
    v_u_327(7)
    v_u_53.viewportConnection = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        -- upvalues: (ref) v_u_53, (copy) v_u_333, (copy) v_u_347, (copy) v_u_346, (copy) v_u_353, (copy) v_u_334, (copy) v_u_366, (ref) v_u_6
        if v_u_53.isOpening then
            local v368 = v_u_347
            local v369 = v_u_346
            local v370 = v_u_353
            local v371 = v_u_333.AbsoluteSize.X
            local v372 = math.max(v371, 1)
            local v373 = v368 - v372
            local v374 = math.max(0, v373)
            local v375
            if v374 <= 0 then
                v375 = 0
            else
                local v376 = v369 * 54.5 - v372 * 0.5 + v370
                v375 = math.clamp(v376, 0, v374)
            end
            local v377 = v_u_347
            local v378 = v_u_346
            local v379 = v_u_353
            local v380 = v_u_334.AbsoluteSize.X
            local v381 = math.max(v380, 1)
            local v382 = v377 - v381
            local v383 = math.max(0, v382)
            local v384
            if v383 <= 0 then
                v384 = 0
            else
                local v385 = v378 * 54.5 - v381 * 0.5 + v379
                v384 = math.clamp(v385, 0, v383)
            end
            if v_u_53.currentTween then
                v_u_53.currentTween:Cancel()
            end
            if v_u_53.currentZoomTween then
                v_u_53.currentZoomTween:Cancel()
            end
            local v386 = 7 - (tick() - v_u_366)
            local v387 = math.max(0.1, v386)
            local v388 = TweenInfo.new(v387, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            local v389 = v_u_6:Create(v_u_333, v388, {
                ["CanvasPosition"] = Vector2.new(v375, 0)
            })
            local v390 = v_u_6:Create(v_u_334, v388, {
                ["CanvasPosition"] = Vector2.new(v384, 0)
            })
            v_u_53.currentTween = v389
            v_u_53.currentZoomTween = v390
            v389:Play()
            v390:Play()
        end
    end)
    if v367 then
        while v_u_53.isOpening do
            local v391 = v_u_53.currentTween
            if not v391 then
                break
            end
            v391.Completed:Wait()
            if v_u_53.currentTween == v391 then
                break
            end
        end
    end
    if v_u_53.viewportConnection then
        v_u_53.viewportConnection:Disconnect()
        v_u_53.viewportConnection = nil
    end
    v_u_53.currentTween = nil
    v_u_53.currentZoomTween = nil
    return v335
end
function v_u_1.PurchaseCase(p393, p394)
    -- upvalues: (copy) v_u_11, (copy) v_u_28, (copy) v_u_19, (ref) v_u_30, (copy) v_u_2, (copy) v_u_24, (copy) v_u_1
    local v395 = v_u_11.Get(v_u_28, "Credits")
    local v396 = p393.price * p394
    if v396 <= v395 then
        v_u_19.Store.PurchaseCase.Send({
            ["CaseId"] = p393.caseId,
            ["Amount"] = p394
        })
        return
    elseif v_u_30 then
        local v397 = v396 - v395
        v_u_2:PromptProductPurchase(v_u_28, v_u_24[v397 <= 400 and "+ 400 Credits" or (v397 <= 950 and "+ 950 Credits" or (v397 <= 3100 and "+ 3,100 Credits" or (v397 <= 6500 and "+ 6,500 Credits" or (v397 <= 13250 and "+ 13,250 Credits" or "+ 27,000 Credits"))))].DevProductId)
        v_u_1.CloseCaseContent("Store")
        v_u_1.OpenTab("Credits")
    end
end
function v_u_1.CreateCaseTemplate(p_u_398, p399)
    -- upvalues: (copy) v_u_26, (copy) v_u_3, (copy) v_u_257, (copy) v_u_13, (copy) v_u_20, (copy) v_u_1
    local v400 = v_u_26[p_u_398.caseRarity]
    if v400 then
        local v401 = v_u_3.Assets.UI.Store.CaseTemplate:Clone()
        v401.Contents.Rarity.UIGradient.Color = v400.ColorSequence
        local v402 = v401.Buy.Credits.Amount
        local v403 = p_u_398.price
        v402.Text = ("%*"):format((tostring(v403):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
        v401.Contents.Glow.ImageColor3 = v400.Color
        v_u_257(v401, p_u_398)
        v401.Contents.Icon.Image = p_u_398.imageAssetId
        v401.Footer.CaseName.Text = p_u_398.name
        v401.Parent = p399
        v401.Name = p_u_398.caseId
        v_u_13(v401.Purchase)
        v401.Purchase.MouseButton1Click:Connect(function()
            -- upvalues: (ref) v_u_20, (ref) v_u_1, (copy) p_u_398
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_1.OpenCaseContent(p_u_398.caseId, "Inspect")
        end)
        v_u_13(v401.Gift)
        v401.Gift.MouseButton1Click:Connect(function()
            -- upvalues: (ref) v_u_1, (copy) p_u_398
            v_u_1.OpenGift(p_u_398.caseId, "Case")
        end)
    end
end
function v_u_1.ActivateGiftTemplate(p_u_404, p_u_405)
    -- upvalues: (copy) v_u_20, (copy) v_u_6, (copy) v_u_28, (ref) v_u_43, (copy) v_u_11, (copy) v_u_17, (copy) v_u_19, (copy) v_u_2, (copy) v_u_25, (copy) v_u_24
    p_u_404.Button.MouseEnter:Connect(function()
        -- upvalues: (ref) v_u_20, (ref) v_u_6, (copy) p_u_404
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Highlight")
        v_u_6:Create(p_u_404.Player.Username, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["TextColor3"] = Color3.fromRGB(255, 200, 0)
        }):Play()
    end)
    p_u_404.Button.MouseLeave:Connect(function()
        -- upvalues: (ref) v_u_6, (copy) p_u_404
        v_u_6:Create(p_u_404.Player.Username, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["TextColor3"] = Color3.fromRGB(190, 190, 190)
        }):Play()
    end)
    p_u_404.Button.MouseButton1Click:Connect(function()
        -- upvalues: (copy) p_u_405, (ref) v_u_28, (ref) v_u_43, (ref) v_u_20, (ref) v_u_11, (ref) v_u_17, (ref) v_u_19, (ref) v_u_2, (ref) v_u_25, (ref) v_u_24
        if p_u_405 == v_u_28.UserId then
            return
        else
            local v406 = v_u_43:GetAttribute("GiftProductName")
            local v407 = v_u_43:GetAttribute("GiftProductType")
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v407 == "Case" then
                local v408 = v_u_11.Get(v_u_28, "Credits")
                local v409 = v_u_17.GetCase(v406)
                local v410 = v_u_43.Gift.Amount.Header.TextLabel.Text
                local v411 = tonumber(v410) or 1
                if v408 >= v409.price * v411 then
                    v_u_43.Gift.Visible = false
                    local v412 = v_u_19.Store.GiftCase.Send
                    local v413 = {}
                    local v414 = p_u_405
                    v413.RecipientUserId = tostring(v414)
                    v413.CaseId = v406
                    v413.Amount = v411
                    return v412(v413)
                end
                return
            else
                local v415 = v_u_19.Store.CreateGift.Send
                local v416 = {}
                local v417 = p_u_405
                v416.RecipientUserId = tostring(v417)
                v416.ProductName = v406
                v416.ProductType = v407
                v415(v416)
                if v407 == "Gamepass" then
                    v_u_2:PromptGamePassPurchase(v_u_28, v_u_25[v406].GamepassId)
                else
                    if v407 ~= "DevProduct" then
                        return nil
                    end
                    v_u_2:PromptProductPurchase(v_u_28, v_u_24[v406].DevProductId)
                end
            end
        end
    end)
end
function v_u_1.SetupCreditsFrame(p_u_418)
    -- upvalues: (copy) v_u_20, (copy) v_u_6, (copy) v_u_13, (ref) v_u_30, (copy) v_u_2, (copy) v_u_28, (copy) v_u_24, (copy) v_u_1
    local v419 = p_u_418:FindFirstChild("Rewards")
    local v_u_420 = p_u_418.Size
    p_u_418.MouseEnter:Connect(function()
        -- upvalues: (ref) v_u_20, (copy) p_u_418, (ref) v_u_6, (copy) v_u_420
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Highlight")
        p_u_418.Hoverstroke.Enabled = true
        local v421 = v_u_6
        local v422 = p_u_418
        local v423 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v424 = {}
        local v425 = v_u_420
        v424.Size = UDim2.fromScale(v425.X.Scale * 0.975, v425.Y.Scale * 0.975)
        v421:Create(v422, v423, v424):Play()
    end)
    p_u_418.MouseLeave:Connect(function()
        -- upvalues: (copy) p_u_418, (ref) v_u_6, (copy) v_u_420
        p_u_418.Hoverstroke.Enabled = false
        local v426 = {
            ["Size"] = v_u_420
        }
        v_u_6:Create(p_u_418, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v426):Play()
    end)
    v_u_13(p_u_418.Purchase)
    p_u_418.Purchase.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_30, (ref) v_u_2, (ref) v_u_28, (ref) v_u_24, (copy) p_u_418, (ref) v_u_20
        if v_u_30 then
            v_u_2:PromptProductPurchase(v_u_28, v_u_24[p_u_418.Name].DevProductId)
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        end
    end)
    v_u_13(p_u_418.Gift)
    p_u_418.Gift.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_1, (copy) p_u_418, (ref) v_u_20
        v_u_1.OpenGift("Gift " .. p_u_418.Name, "DevProduct")
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
    end)
    if v419 then
        local v427 = v419:FindFirstChild("Rewards") or v419
        for _, v_u_428 in ipairs(v427:GetChildren()) do
            if v_u_428:IsA("Frame") then
                v_u_428.Icon.Button.MouseButton1Click:Connect(function()
                    -- upvalues: (ref) v_u_20, (copy) v_u_428
                    v_u_20.broadcastRouter("WeaponInspect", v_u_428.Icon.Button:GetAttribute("WeaponName"), v_u_428.Icon.Button:GetAttribute("SkinName"), 0, nil, nil, nil, nil, nil, 1, nil, 1, nil)
                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                end)
            end
        end
    end
end
local v_u_429 = false
local v_u_430 = nil
function v_u_1.SetupStarterPackFrame()
    -- upvalues: (copy) v_u_115, (ref) v_u_50, (copy) v_u_13, (ref) v_u_47, (ref) v_u_429, (copy) v_u_11, (copy) v_u_28, (ref) v_u_30, (copy) v_u_24, (ref) v_u_430, (copy) v_u_2, (copy) v_u_20
    if v_u_115() and not v_u_50 then
        v_u_50 = true
        v_u_13(v_u_47)
        v_u_47.MouseButton1Click:Connect(function()
            -- upvalues: (ref) v_u_429, (ref) v_u_11, (ref) v_u_28, (ref) v_u_30, (ref) v_u_24, (ref) v_u_430, (ref) v_u_2, (ref) v_u_20
            if not v_u_429 then
                local v431 = v_u_11.Get(v_u_28, "Gamepasses")
                local v432
                if typeof(v431) == "table" then
                    v432 = table.find(v431, "Credits StarterPack") ~= nil
                else
                    v432 = false
                end
                if not v432 then
                    if v_u_30 then
                        local v433 = v_u_24["Credits Starter Pack"]
                        if not v433 then
                            warn("[Store] Missing dev product configuration for Credits Starter Pack")
                            return
                        end
                        v_u_429 = true
                        v_u_430 = v433.DevProductId
                        v_u_2:PromptProductPurchase(v_u_28, v433.DevProductId)
                        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                    end
                    return
                end
            end
        end)
        v_u_2.PromptProductPurchaseFinished:Connect(function(p434, p435, p436)
            -- upvalues: (ref) v_u_430, (ref) v_u_28, (ref) v_u_429
            if p435 == v_u_430 and (p434 == v_u_28.UserId and not p436) then
                v_u_429 = false
            end
        end)
    end
end
function v_u_1.UpdateCases()
    -- upvalues: (copy) v_u_17, (copy) v_u_62, (ref) v_u_43, (copy) v_u_1
    local v437 = v_u_17.GetFeaturedCases(6)
    v_u_62(v_u_43.Tabs.Container.Featured.Container.Items, { "UIListLayout" })
    local v438 = v_u_17.GetCases()
    v_u_62(v_u_43.Tabs.Container.Cases.Cases, { "UIListLayout", "UIGridLayout" })
    for _, v439 in ipairs(v437) do
        if v439.caseType ~= "Package" then
            v_u_1.CreateCaseTemplate(v439, v_u_43.Tabs.Container.Featured.Container.Items)
        end
    end
    for _, v440 in ipairs(v438) do
        if v440.caseType ~= "Package" then
            v_u_1.CreateCaseTemplate(v440, v_u_43.Tabs.Container.Cases.Cases)
        end
    end
end
function v_u_1.OpenCaseContent(p441, p442, p443)
    -- upvalues: (copy) v_u_17, (ref) v_u_33, (ref) v_u_34, (ref) v_u_43, (copy) v_u_21, (ref) v_u_44, (copy) v_u_262, (copy) v_u_275, (copy) v_u_279, (copy) v_u_12, (copy) v_u_62, (copy) v_u_42, (copy) v_u_16, (copy) v_u_26, (copy) v_u_3, (copy) v_u_13, (copy) v_u_20, (copy) v_u_14, (copy) v_u_41
    local v444 = v_u_17.GetCase(p441)
    v_u_33 = p443
    v_u_34 = v444
    if v444 then
        if v_u_43.Visible or v_u_21.GetCurrentScreen() == "Store" then
            v_u_21.SetScreen("Store")
            v_u_43.CaseContent:SetAttribute("WasVisibleBeforeInspect", true)
        else
            v_u_43.CaseContent:SetAttribute("WasVisibleBeforeInspect", false)
        end
        v_u_43.CaseContent.List.Amount.Position = p442 == "Open" and UDim2.new(0.687, 0, 0.465, 0) or UDim2.new(0.575, 0, 0.465, 0)
        v_u_43.CaseContent.Title.Text = p442 == "Inspect" and "Inspect Container" or "Unlock Container"
        local v445 = v_u_43.CaseContent.List.Buy.Header.TextLabel
        local v446 = v444.price
        v445.Text = ("BUY (%*)"):format((tostring(v446):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
        v_u_43.CaseContent.List.Amount.Visible = true
        v_u_43.CaseContent.List.Amount.Header.TextLabel.Text = "1"
        v_u_43.CaseContent.List.Buy.Visible = p442 == "Inspect"
        v_u_43.CaseContent.CaseName.Text = v444.name
        v_u_43.CaseContent.List.Open.Visible = p442 == "Open"
        v_u_43.CaseContent:SetAttribute("State", p442)
        v_u_43.OpenCreatorCode.Visible = false
        v_u_43.Tabs.Container.Visible = false
        v_u_43.CaseContent.Visible = true
        v_u_44.Menu.Top.Visible = false
        v_u_43.Top.Visible = false
        v_u_43.Visible = true
        if p442 == "Open" then
            local v447 = v_u_262(v444.name)
            v_u_275(v_u_43.CaseContent.List.Amount.Container, v447)
        else
            v_u_279(v_u_43.CaseContent.List.Amount.Container)
        end
        for _, v448 in ipairs(v_u_43.CaseContent.List.Amount.Container:GetChildren()) do
            if v448:IsA("TextButton") then
                v448.Frame.BackgroundTransparency = v448.Name == "1" and 0 or 1
                v448:SetAttribute("Selected", v448.Name == "1")
            end
        end
        for _, v449 in ipairs(v_u_43.CaseContent.CaseChances:GetChildren()) do
            if v449:IsA("TextLabel") then
                v449.Visible = false
            end
        end
        for _, v450 in ipairs(v444.rarityChances) do
            local v451 = v_u_43.CaseContent.CaseChances:FindFirstChild(v450.rarity)
            v451.Text = ("%*: %*%%"):format(v450.rarity, v450.chance)
            v451.Visible = true
        end
        if v444.caseType == "Case" then
            local v452 = v444.rarityChances
            local v453 = 0
            for _, v454 in ipairs(v452) do
                v453 = v453 + v454.chance
            end
            local v455 = (100 - v453) * 100
            local v456 = math.round(v455) / 100
            v_u_43.CaseContent.CaseChances.Special.Text = ("Special: %*%%"):format(v456)
            v_u_43.CaseContent.CaseChances.Special.Visible = true
        end
        if v_u_44 and v_u_44.Menu then
            v_u_44.Menu.Visible = true
        end
        v_u_12.ShowCaseScene(v444.caseType, v444.name)
        task.defer(function()
            -- upvalues: (ref) v_u_43
            v_u_43.Visible = true
            v_u_43.CaseContent.Visible = true
        end)
        v_u_62(v_u_43.CaseContent.Container, { "UIGridLayout", "UIPadding" })
        local v457 = table.clone(v444.contents)
        table.sort(v457, function(p458, p459)
            -- upvalues: (ref) v_u_42
            return (v_u_42[p458.rarity] or 0) < (v_u_42[p459.rarity] or 0)
        end)
        for _, v_u_460 in ipairs(v457) do
            local v461 = v_u_16.GetSkinInformation(v_u_460.skin.weaponName, v_u_460.skin.skinName)
            local v462 = v_u_26[v_u_460.rarity]
            local v463
            if v461.wearImages and v461.wearImages[1] then
                v463 = v461.wearImages[1].assetId
            elseif v461.charmImages and v461.charmImages[1] then
                v463 = v461.charmImages[1].assetId
            else
                v463 = v461.imageAssetId or ""
            end
            local v464 = v_u_3.Assets.UI.Store.ItemTemplate:Clone()
            v464.Content.RarityFrame.UIGradient.Color = v462.ColorSequence
            v464.Footer.WeaponName.Text = v_u_460.skin.weaponName
            v464.Content.Rarity.ImageColor3 = v462.Color
            v464.Footer.SkinName.Text = v_u_460.skin.skinName
            v464.Parent = v_u_43.CaseContent.Container
            v464.Content.Icon.Image = v463
            local v_u_465 = v464.Content:FindFirstChild("Inspect")
            if v_u_465 then
                v_u_465.Visible = false
                v_u_13(v_u_465)
                v464.Content.MouseEnter:Connect(function()
                    -- upvalues: (copy) v_u_465
                    v_u_465.Visible = true
                end)
                v464.Content.MouseLeave:Connect(function()
                    -- upvalues: (copy) v_u_465
                    v_u_465.Visible = false
                end)
                v_u_465.MouseButton1Click:Connect(function()
                    -- upvalues: (ref) v_u_20, (copy) v_u_460
                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                    local v466 = v_u_460.skin.type == "Charm" and "Charm" or nil
                    v_u_20.broadcastRouter("WeaponInspect", v_u_460.skin.weaponName, v_u_460.skin.skinName, 0, nil, nil, nil, nil, v466, 1, nil, 1, nil)
                end)
                local v467 = v_u_14()
                local v468
                if table.find(v467, "Mobile") == nil then
                    v468 = false
                else
                    v468 = #v467 <= 1
                end
                local v469 = v464.Content:FindFirstChild("MobileInspect")
                if v469 and not v468 then
                    v469.Visible = false
                end
                if v468 and v469 then
                    v_u_13(v469)
                    v469.Activated:Connect(function()
                        -- upvalues: (copy) v_u_465
                        v_u_465.Visible = true
                    end)
                    v_u_465:GetPropertyChangedSignal("Visible"):Connect(function()
                        -- upvalues: (copy) v_u_465, (ref) v_u_20, (copy) v_u_460
                        if v_u_465.Visible then
                            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                            local v470 = v_u_460.skin.type == "Charm" and "Charm" or nil
                            v_u_20.broadcastRouter("WeaponInspect", v_u_460.skin.weaponName, v_u_460.skin.skinName, 0, nil, nil, nil, nil, v470, 1, nil, 1, nil)
                        end
                    end)
                end
            end
        end
        if v444.caseType == "Case" then
            local v471 = v_u_3.Assets.UI.Store.GoldTemplate:Clone()
            v471.Content.Icon.Image = v_u_41[v444.caseId] or "rbxassetid://132217734282843"
            v471.Parent = v_u_43.CaseContent.Container
            return
        end
    end
end
function v_u_1.OpenGift(p472, p473)
    -- upvalues: (ref) v_u_43
    v_u_43:SetAttribute("GiftProductName", p472)
    v_u_43:SetAttribute("GiftProductType", p473)
    local v474 = v_u_43.Gift.Amount
    v474.Header.TextLabel.Text = "1"
    v474.Visible = p473 == "Case"
    v474.Container.Visible = false
    for _, v475 in ipairs(v474.Container:GetChildren()) do
        if v475:IsA("TextButton") then
            v475.Frame.BackgroundTransparency = v475.Name == "1" and 0 or 1
            v475:SetAttribute("Selected", v475.Name == "1")
        end
    end
    v_u_43.Gift.Visible = true
end
function v_u_1.SearchPlayerGift(p476)
    -- upvalues: (ref) v_u_43, (copy) v_u_9, (copy) v_u_3, (copy) v_u_1
    local v477 = v_u_43.Gift.Container:FindFirstChild("SearchResult")
    if v477 then
        v477:Destroy()
    end
    local v_u_478 = tonumber(p476)
    if p476 == "" or not v_u_478 then
        return
    else
        for _, v479 in ipairs(v_u_43.Gift.Container:GetChildren()) do
            if v479:IsA("Frame") then
                v479.Visible = false
            end
        end
        local v480, v481 = pcall(function()
            -- upvalues: (ref) v_u_9, (copy) v_u_478
            return v_u_9:GetNameFromUserIdAsync(v_u_478)
        end)
        if v480 then
            local v482 = v_u_3.Assets.UI.Store.PlayerTemplate:Clone()
            v482.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(v_u_478)
            v482.Player.Username.Text = ("@%*"):format(v481)
            v482.Parent = v_u_43.Gift.Container
            v482.Name = "SearchResult"
            v_u_1.ActivateGiftTemplate(v482, v_u_478)
        end
    end
end
function v_u_1.OpenTab(p483)
    -- upvalues: (ref) v_u_30, (copy) v_u_20, (ref) v_u_43, (copy) v_u_38, (copy) v_u_36, (copy) v_u_35
    if p483 == "Credits" and not v_u_30 then
        v_u_20.broadcastRouter("CreateMenuNotification", "Error", "Paid random items are not allowed in your region.")
    else
        for _, v484 in ipairs(v_u_43.Top.Categories:GetChildren()) do
            if v484:IsA("TextButton") then
                v484:SetAttribute("Selected", v484.Name == p483)
                if v484.Name == p483 and v484.Name ~= "Credits" then
                    v484.HoverFrame.BackgroundTransparency = 0
                    v484.HoverFrame.BackgroundColor3 = v_u_38
                    v484.TextLabel.TextColor3 = v_u_36
                elseif v484.Name ~= "Credits" then
                    v484.HoverFrame.BackgroundColor3 = Color3.fromRGB(243, 243, 243)
                    v484.TextLabel.TextColor3 = v_u_35
                    v484.HoverFrame.BackgroundTransparency = 1
                end
                v484:SetAttribute("Selected", v484.Name == p483)
            end
        end
        for _, v485 in ipairs(v_u_43.Tabs.Container:GetChildren()) do
            if v485:IsA("Frame") then
                v485.Visible = v485.Name == p483
            end
        end
    end
end
function v_u_1.OpenCase(p486, p_u_487, p488, p489, p490)
    -- upvalues: (copy) v_u_53, (copy) v_u_92, (copy) v_u_17, (copy) v_u_19, (copy) v_u_12, (ref) v_u_43, (ref) v_u_44, (copy) v_u_21, (copy) v_u_57, (copy) v_u_283, (copy) v_u_20, (copy) v_u_91, (copy) v_u_392
    if p489 == nil then
        p489 = v_u_53.isQuickUnlock
    end
    v_u_53.currentCaseIdentifier = p488
    v_u_92()
    local v_u_491 = v_u_17.GetCase(p486)
    if v_u_491 then
        if p489 then
            if p488 then
                v_u_19.Store.CaseOpenSequenceFinished.Send({
                    ["CaseIdentifier"] = p488
                })
            end
            v_u_12.HideCaseScene()
            v_u_43.Tabs.Container.Visible = true
            v_u_43.CaseContent.Visible = false
            v_u_44.Menu.Top.Visible = true
            v_u_43.Top.Visible = true
            v_u_43.Visible = false
            v_u_21.SetScreen("Inventory")
            local v492 = v_u_57[v_u_283(p_u_487, v_u_491)] or "Drop Blue"
            v_u_20.broadcastRouter("RunStoreSound", v492)
            v_u_20.broadcastRouter("RunStoreSound", "Case Close")
            v_u_20.broadcastRouter("QuickOpenResolved", p490)
            v_u_20.broadcastRouter("ShowNewItemNotification", p_u_487)
            task.defer(v_u_91)
            return
        else
            v_u_53.isOpening = true
            v_u_53.currentInventoryItem = p_u_487
            v_u_43.CaseContent.Visible = false
            local v493 = v_u_491.caseType == "Charm Capsule"
            local v494 = v_u_491.caseType == "Package"
            local function v498()
                -- upvalues: (ref) v_u_53, (ref) v_u_44, (copy) v_u_491, (ref) v_u_43, (ref) v_u_392, (copy) p_u_487, (ref) v_u_20, (ref) v_u_19, (ref) v_u_12, (ref) v_u_21, (ref) v_u_57
                if v_u_53.isOpening then
                    v_u_44.Menu.OpenCase.CaseName.Text = ("Unlock %*"):format(v_u_491.name)
                    v_u_44.Menu.OpenCase.Visible = true
                    v_u_43.Visible = false
                    v_u_44.Menu.OpenCase.Contents.Close.TextLabel.Text = "CLOSE"
                    local v495 = v_u_392(v_u_491, p_u_487)
                    if v_u_53.isOpening then
                        v_u_20.broadcastRouter("RunInterfaceSound", "UI Notification")
                        task.wait(0.5)
                        if v_u_53.isOpening then
                            v_u_53.isOpening = false
                            v_u_53.currentInventoryItem = nil
                            local v496 = v_u_53.currentCaseIdentifier
                            if v496 then
                                v_u_19.Store.CaseOpenSequenceFinished.Send({
                                    ["CaseIdentifier"] = v496
                                })
                                v_u_53.currentCaseIdentifier = nil
                            end
                            v_u_44.Menu.OpenCase.Visible = false
                            v_u_12.HideCaseScene()
                            v_u_43.Tabs.Container.Visible = true
                            v_u_43.CaseContent.Visible = false
                            v_u_44.Menu.Top.Visible = true
                            v_u_43.Top.Visible = true
                            v_u_43.Visible = false
                            v_u_21.SetScreen("Inventory")
                            local v497 = v_u_57[v495 and v495.rarity or "Blue"] or "Drop Blue"
                            v_u_20.broadcastRouter("RunStoreSound", v497)
                            v_u_20.broadcastRouter("RunStoreSound", "Case Close")
                            v_u_20.broadcastRouter("WeaponInspect", p_u_487.Name, p_u_487.Skin, p_u_487.Float, p_u_487.StatTrack, p_u_487.NameTag, p_u_487.Charm, p_u_487.Stickers, p_u_487.Type, p_u_487.Pattern, p_u_487._id, p_u_487.Serial, p_u_487.IsTradeable)
                        end
                    else
                        return
                    end
                else
                    return
                end
            end
            if v493 then
                v_u_12.TransitionToUnboxing(v498)
            elseif v494 then
                v_u_12.TransitionToUnboxing()
                v_u_12.WaitForOpeningAnimation()
                if v_u_53.isOpening then
                    v_u_53.isOpening = false
                    v_u_53.currentInventoryItem = nil
                    local v499 = v_u_53.currentCaseIdentifier
                    if v499 then
                        v_u_19.Store.CaseOpenSequenceFinished.Send({
                            ["CaseIdentifier"] = v499
                        })
                        v_u_53.currentCaseIdentifier = nil
                    end
                    v_u_12.HideCaseScene()
                    v_u_43.Tabs.Container.Visible = true
                    v_u_43.CaseContent.Visible = false
                    v_u_44.Menu.Top.Visible = true
                    v_u_43.Top.Visible = true
                    v_u_43.Visible = false
                    v_u_21.SetScreen("Inventory")
                    local v500 = v_u_57[v_u_283(p_u_487, v_u_491)] or "Drop Blue"
                    v_u_20.broadcastRouter("RunStoreSound", v500)
                    v_u_20.broadcastRouter("RunStoreSound", "Case Close")
                    v_u_20.broadcastRouter("WeaponInspect", p_u_487.Name, p_u_487.Skin, p_u_487.Float, p_u_487.StatTrack, p_u_487.NameTag, p_u_487.Charm, p_u_487.Stickers, p_u_487.Type, p_u_487.Pattern, p_u_487._id, p_u_487.Serial, p_u_487.IsTradeable)
                    return
                end
            else
                v_u_12.TransitionToUnboxing()
                task.wait(0.8)
                v498()
            end
        end
    else
        return
    end
end
function v_u_1.StopCaseOpening()
    -- upvalues: (copy) v_u_53, (copy) v_u_20, (copy) v_u_92, (copy) v_u_58, (copy) v_u_295, (copy) v_u_12
    if v_u_53.isOpening then
        v_u_20.broadcastRouter("RunStoreSound", "Case Close")
    end
    v_u_92()
    v_u_58.isBulkOpening = false
    v_u_58.inventoryItems = nil
    v_u_58.bulkIdentifier = nil
    v_u_58.currentIndex = 0
    v_u_58.skipped = false
    v_u_58.caseId = nil
    v_u_58.total = 0
    v_u_295()
    local v501 = v_u_53.currentInventoryItem
    v_u_53.isOpening = false
    v_u_53.currentInventoryItem = nil
    v_u_12.HideCaseScene()
    return v501
end
function v_u_1.FinishBulkOpening()
    -- upvalues: (copy) v_u_58, (copy) v_u_92, (copy) v_u_295, (copy) v_u_53, (copy) v_u_12, (ref) v_u_44, (ref) v_u_43, (copy) v_u_20, (copy) v_u_19, (copy) v_u_21, (copy) v_u_91
    local v502 = v_u_58.inventoryItems or {}
    local v503 = v_u_58.bulkIdentifier
    v_u_92()
    v_u_295()
    v_u_53.isOpening = false
    v_u_53.currentInventoryItem = nil
    v_u_12.HideCaseScene()
    v_u_44.Menu.OpenCase.Visible = false
    v_u_43.Tabs.Container.Visible = true
    v_u_43.CaseContent.Visible = false
    v_u_44.Menu.Top.Visible = true
    v_u_43.Top.Visible = true
    v_u_43.Visible = false
    v_u_44.Menu.OpenCase.Contents.Close.TextLabel.Text = "CLOSE"
    v_u_20.broadcastRouter("RunStoreSound", "Case Close")
    if v503 then
        v_u_19.Store.CaseOpenSequenceFinished.Send({
            ["CaseIdentifier"] = v503
        })
    end
    v_u_21.SetScreen("Inventory")
    for _, v504 in ipairs(v502) do
        v_u_20.broadcastRouter("ShowNewItemNotification", v504)
    end
    if #v502 > 0 then
        v_u_20.broadcastRouter("ShowNewItemNotificationAtIndex", 1)
    end
    v_u_58.isBulkOpening = false
    v_u_58.inventoryItems = nil
    v_u_58.bulkIdentifier = nil
    v_u_58.currentIndex = 0
    v_u_58.skipped = false
    v_u_58.caseId = nil
    v_u_58.total = 0
    task.defer(v_u_91)
end
function v_u_1.SkipBulkOpening()
    -- upvalues: (copy) v_u_58, (copy) v_u_92, (copy) v_u_1
    v_u_58.skipped = true
    v_u_92()
    v_u_1.FinishBulkOpening()
end
function v_u_1.StartBulkOpening(p505, p506, p507)
    -- upvalues: (copy) v_u_17, (copy) v_u_58, (copy) v_u_92, (copy) v_u_53, (ref) v_u_43, (copy) v_u_12, (ref) v_u_44, (copy) v_u_392, (copy) v_u_20, (copy) v_u_57, (copy) v_u_1
    local v508 = v_u_17.GetCase(p505)
    if not v508 then
        return
    end
    v_u_58.isBulkOpening = true
    v_u_58.inventoryItems = p506
    v_u_58.bulkIdentifier = p507
    v_u_58.caseId = p505
    v_u_58.total = #p506
    v_u_58.currentIndex = 0
    v_u_58.skipped = false
    v_u_92()
    v_u_53.isOpening = true
    v_u_53.currentInventoryItem = nil
    v_u_43.CaseContent.Visible = false
    v_u_12.TransitionToUnboxing()
    task.wait(0.8)
    if not v_u_53.isOpening or v_u_58.skipped then
        return
    end
    v_u_44.Menu.OpenCase.CaseName.Text = ("Unlock %*"):format(v508.name)
    v_u_44.Menu.OpenCase.Visible = true
    v_u_43.Visible = false
    for v509 = 1, #p506 do
        if not v_u_53.isOpening or v_u_58.skipped then
            break
        end
        v_u_58.currentIndex = v509
        local v510 = p506[v509]
        local v511 = v509 == #p506
        v_u_44.Menu.OpenCase.Contents.Close.TextLabel.Text = "CLOSE"
        local v512 = v_u_392(v508, v510)
        if not v_u_53.isOpening or v_u_58.skipped then
            break
        end
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Notification")
        local v513 = v512 and v512.rarity or "Blue"
        v_u_20.broadcastRouter("RunStoreSound", v_u_57[v513] or "Drop Blue")
        if v511 then
            task.wait(0.5)
        else
            local v514 = tick()
            while tick() - v514 < 1.5 and (not v_u_58.skipped and v_u_53.isOpening) do
                task.wait(0.1)
            end
        end
    end
    if v_u_53.isOpening and not v_u_58.skipped then
        v_u_1.FinishBulkOpening()
    end
end
function v_u_1.SetQuickUnlock(p515)
    -- upvalues: (copy) v_u_53
    v_u_53.isQuickUnlock = p515
end
function v_u_1.BeginOpenCaseRequest(p516)
    -- upvalues: (ref) v_u_54, (copy) v_u_55, (copy) v_u_53
    v_u_54 = v_u_54 + 1
    local v517 = v_u_54
    local v518 = tostring(v517)
    v_u_55[v518] = {
        ["IsQuickUnlock"] = p516
    }
    v_u_53.isPendingOpenRequest = true
    v_u_53.pendingOpenRequestId = v518
    v_u_53.isQuickUnlock = p516
    return v518
end
function v_u_1.ClearPendingOpenCaseRequest(p519)
    -- upvalues: (copy) v_u_53
    if v_u_53.pendingOpenRequestId ~= p519 then
        return false
    end
    v_u_53.isPendingOpenRequest = false
    v_u_53.pendingOpenRequestId = nil
    v_u_53.isQuickUnlock = false
    return true
end
function v_u_1.OpenCreatorCode()
    -- upvalues: (ref) v_u_43, (copy) v_u_6
    v_u_43.CreatorCode.Position = UDim2.fromScale(0.5, -1)
    v_u_43.CreatorCode.Visible = true
    v_u_43.Tabs.Visible = false
    v_u_6:Create(v_u_43.CreatorCode, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromScale(0.5, 0.5)
    }):Play()
end
function v_u_1.CloseCreatorCode()
    -- upvalues: (copy) v_u_6, (ref) v_u_43
    v_u_6:Create(v_u_43.CreatorCode, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromScale(0.5, -1)
    }):Play()
    task.wait(0.25)
    if v_u_43.CreatorCode.Visible then
        v_u_43.CreatorCode.Visible = false
        v_u_43.Tabs.Visible = true
    end
end
function v_u_1.CloseCaseContent(p520)
    -- upvalues: (copy) v_u_12, (ref) v_u_34, (ref) v_u_33, (ref) v_u_43, (copy) v_u_21, (ref) v_u_44
    v_u_12.HideCaseScene()
    v_u_34 = nil
    v_u_33 = nil
    v_u_43.CaseContent:SetAttribute("WasVisibleBeforeInspect", false)
    if p520 == "Inventory" then
        v_u_21.SetScreen("Inventory")
    end
    v_u_43.OpenCreatorCode.Visible = true
    v_u_43.Tabs.Container.Visible = true
    v_u_43.CaseContent.Visible = false
    v_u_44.Menu.Top.Visible = true
    v_u_43.Top.Visible = true
    if p520 == "Inventory" then
        v_u_44.Menu.Inventory.Visible = true
        v_u_43.Visible = false
    else
        v_u_43.Visible = true
    end
end
function v_u_1.Initialize(p521, p522)
    -- upvalues: (ref) v_u_44, (ref) v_u_43, (ref) v_u_52, (copy) v_u_18, (copy) v_u_58, (copy) v_u_1, (copy) v_u_53, (copy) v_u_19, (copy) v_u_21, (copy) v_u_20, (copy) v_u_91, (copy) v_u_13, (ref) v_u_34, (ref) v_u_33, (copy) v_u_269, (ref) v_u_54, (copy) v_u_55, (copy) v_u_77, (copy) v_u_62, (copy) v_u_71, (copy) v_u_15, (copy) v_u_2, (copy) v_u_28, (copy) v_u_24, (copy) v_u_8, (copy) v_u_4, (copy) v_u_66, (copy) v_u_40, (copy) v_u_82, (copy) v_u_88, (copy) v_u_27, (ref) v_u_29, (ref) v_u_32, (copy) v_u_17, (copy) v_u_257, (copy) v_u_148, (copy) v_u_111
    v_u_44 = p521
    v_u_43 = p522
    local v523 = v_u_44.Menu.Top.Buttons.Store:FindFirstChild("Alert")
    if v523 then
        v523 = v523:FindFirstChild("TextLabel")
    end
    v_u_52 = v523
    v_u_18.Add(v_u_44.Menu.OpenCase, v_u_44.Menu.OpenCase.Contents.Close, function()
        -- upvalues: (ref) v_u_58, (ref) v_u_1, (ref) v_u_44, (ref) v_u_53, (ref) v_u_19, (ref) v_u_43, (ref) v_u_21, (ref) v_u_20, (ref) v_u_91
        if v_u_58.isBulkOpening then
            v_u_1.SkipBulkOpening()
            return
        else
            local v524 = v_u_1.StopCaseOpening()
            v_u_44.Menu.OpenCase.Visible = false
            local v525 = v_u_53.currentCaseIdentifier
            if v525 then
                v_u_19.Store.CaseOpenSequenceFinished.Send({
                    ["CaseIdentifier"] = v525
                })
                v_u_53.currentCaseIdentifier = nil
            end
            v_u_43.Tabs.Container.Visible = true
            v_u_43.CaseContent.Visible = false
            v_u_44.Menu.Top.Visible = true
            v_u_43.Top.Visible = true
            v_u_43.Visible = false
            v_u_21.SetScreen("Inventory")
            if v524 then
                v_u_20.broadcastRouter("WeaponInspect", v524.Name, v524.Skin, v524.Float, v524.StatTrack, v524.NameTag, v524.Charm, v524.Stickers, v524.Type, v524.Pattern, v524._id, v524.Serial, v524.IsTradeable)
            else
                v_u_44.Menu.Inventory.Visible = true
                task.defer(v_u_91)
            end
        end
    end)
    v_u_13(v_u_43.CaseContent.List.Open)
    v_u_43.CaseContent.List.Open.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_34, (ref) v_u_53, (ref) v_u_33, (ref) v_u_20, (ref) v_u_43, (ref) v_u_269, (ref) v_u_54, (ref) v_u_55, (ref) v_u_19
        if v_u_34 and not (v_u_53.isOpening or v_u_53.isPendingOpenRequest) then
            if v_u_33 then
                local v526 = v_u_43.CaseContent.List.Amount.Header.TextLabel.Text
                local v527 = tonumber(v526) or 1
                local v528
                if v527 > 1 then
                    v528 = v_u_269(v_u_34.name, v527)
                    if #v528 < 2 then
                        v_u_20.broadcastRouter("CreateMenuNotification", "Error", "Not enough cases in your inventory.")
                        return
                    end
                else
                    v528 = { v_u_33 }
                end
                local v529
                if v527 == 1 then
                    v529 = v_u_53.isQuickUnlock
                else
                    v529 = false
                end
                local v530 = v527 > 1 and "Bulk" or (v529 and "Quick Open" or "Standard")
                v_u_54 = v_u_54 + 1
                local v531 = v_u_54
                local v_u_532 = tostring(v531)
                v_u_55[v_u_532] = {
                    ["IsQuickUnlock"] = v529
                }
                v_u_53.isPendingOpenRequest = true
                v_u_53.pendingOpenRequestId = v_u_532
                v_u_53.isQuickUnlock = v529
                v_u_19.Store.OpenCase.Send({
                    ["CaseIdentifiers"] = v528,
                    ["OpenType"] = v530,
                    ["CaseId"] = v_u_34.caseId,
                    ["RequestId"] = v_u_532
                })
                task.delay(12 * (v527 > 1 and 2 or 1), function()
                    -- upvalues: (ref) v_u_53, (copy) v_u_532, (ref) v_u_20
                    if v_u_53.isPendingOpenRequest and v_u_53.pendingOpenRequestId == v_u_532 then
                        v_u_53.isPendingOpenRequest = false
                        v_u_53.pendingOpenRequestId = nil
                        v_u_53.isQuickUnlock = false
                        v_u_20.broadcastRouter("CreateMenuNotification", "Error", "Opening case timed out. Please try again.")
                    end
                end)
            else
                v_u_20.broadcastRouter("CreateMenuNotification", "Error", "Case identifier missing. Please reopen the case.")
            end
        else
            return
        end
    end)
    v_u_13(v_u_43.CaseContent.List.Buy)
    v_u_43.CaseContent.List.Buy.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_34, (ref) v_u_1, (ref) v_u_43
        if v_u_34 then
            local v533 = v_u_1.PurchaseCase
            local v534 = v_u_34
            local v535 = v_u_43.CaseContent.List.Amount.Header.TextLabel.Text
            v533(v534, (tonumber(v535)))
        end
    end)
    v_u_13(v_u_43.CaseContent.List.Close)
    v_u_18.Add(v_u_43.CaseContent, v_u_43.CaseContent.List.Close, function()
        -- upvalues: (ref) v_u_53, (ref) v_u_1, (ref) v_u_43
        if not v_u_53.isPendingOpenRequest then
            v_u_1.CloseCaseContent(v_u_43.CaseContent:GetAttribute("State") == "Inspect" and "Store" or "Inventory")
        end
    end)
    v_u_13(v_u_43.OpenCreatorCode)
    v_u_43.OpenCreatorCode.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_20, (ref) v_u_43, (ref) v_u_1
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_43.CreatorCode.Visible then
            v_u_1.CloseCreatorCode()
        else
            v_u_1.OpenCreatorCode()
        end
    end)
    v_u_13(v_u_43.CreatorCode.Container.Action.Close)
    v_u_18.Add(v_u_43.CreatorCode, v_u_43.CreatorCode.Container.Action.Close, function()
        -- upvalues: (ref) v_u_1
        v_u_1.CloseCreatorCode()
    end)
    v_u_13(v_u_43.CreatorCode.Container.Action.Confirm)
    v_u_43.CreatorCode.Container.Action.Confirm.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_43, (ref) v_u_20, (ref) v_u_77, (ref) v_u_19
        local v536 = v_u_43.CreatorCode.Container.Body.CreatorName.TextBox.Text
        v_u_43.CreatorCode.Container.Action.Confirm.Title.Text = "SEARCHING.."
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        if v536 and v536 ~= "" then
            v_u_19.UI.EquipCreatorCode.Send({
                ["CreatorCode"] = v536
            })
        else
            v_u_77("Error", "Creator code cannot be empty.")
        end
    end)
    v_u_62(v_u_43.Gift.Container, { "UICorner", "UIListLayout" })
    v_u_18.Add(v_u_43.Gift, v_u_43.Gift.Close, function()
        -- upvalues: (ref) v_u_20, (ref) v_u_43
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_43.Gift.Visible = false
    end)
    v_u_13(v_u_43.Top.Credits.Buy)
    v_u_43.Top.Credits.Buy.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_1
        v_u_1.OpenTab("Credits")
    end)
    local v537 = v_u_43.Tabs.Container.Featured.Bundle
    local v538, v539 = v_u_71(v537)
    if v538 then
        v_u_13(v538)
        v538.MouseButton1Click:Connect(function()
            -- upvalues: (ref) v_u_1
            v_u_1.OpenGift("Gift Featured Bundle", "DevProduct")
        end)
    end
    if v539 then
        v_u_13(v539)
        v539.MouseButton1Click:Connect(function()
            -- upvalues: (ref) v_u_15, (ref) v_u_2, (ref) v_u_28, (ref) v_u_24
            if v_u_15.GetActiveBundle() then
                v_u_2:PromptProductPurchase(v_u_28, v_u_24["Purchase Featured Bundle"].DevProductId)
            end
        end)
    end
    for _, v540 in ipairs(v_u_43.Tabs.Container.Credits.Container.Special:GetChildren()) do
        if v540:IsA("Frame") then
            v_u_1.SetupCreditsFrame(v540)
        end
    end
    for _, v541 in ipairs(v_u_43.Tabs.Container.Credits.Container.Standard:GetChildren()) do
        if v541:IsA("Frame") then
            v_u_1.SetupCreditsFrame(v541)
        end
    end
    v_u_1.SetupStarterPackFrame()
    v_u_8.Heartbeat:Connect(function(p542)
        -- upvalues: (ref) v_u_43, (ref) v_u_4
        if v_u_43.Visible then
            for _, v543 in ipairs(v_u_4:GetTagged("StoreRotaterFrame")) do
                v543.Rotation = v543.Rotation + p542 * 25
            end
        end
    end)
    local v544 = v_u_66(v537, { "Content", "Parts", "Content" }) or v537:FindFirstChild("Frame")
    for _, v_u_545 in ipairs(v_u_40) do
        local v546 = v_u_82(v544, v_u_545.frameNames)
        if v546 then
            local v547, v548, v549 = v_u_88(v546)
            if v547 then
                v_u_13(v547)
                v547.MouseButton1Click:Connect(function()
                    -- upvalues: (ref) v_u_1, (copy) v_u_545
                    v_u_1.OpenGift("Gift " .. v_u_545.productName, "DevProduct")
                end)
            end
            if v548 then
                v_u_13(v548)
                v548.MouseButton1Click:Connect(function()
                    -- upvalues: (ref) v_u_2, (ref) v_u_28, (ref) v_u_24, (copy) v_u_545
                    v_u_2:PromptProductPurchase(v_u_28, v_u_24[v_u_545.productName].DevProductId)
                end)
            end
            if v549 then
                v_u_13(v549)
                v549.MouseButton1Click:Connect(function()
                    -- upvalues: (ref) v_u_20, (copy) v_u_545
                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                    v_u_20.broadcastRouter("WeaponInspect", v_u_545.weaponName, v_u_545.skinName, 0, nil, nil, nil, nil, nil, 1, nil, 1, nil)
                end)
            end
        end
    end
    v_u_43.Gift.Search.TextBox.Focused:Connect(function()
        -- upvalues: (ref) v_u_43
        local v550 = v_u_43.Gift.Container:FindFirstChild("SearchResult")
        if v550 then
            v550:Destroy()
        end
        for _, v551 in ipairs(v_u_43.Gift.Container:GetChildren()) do
            if v551:IsA("Frame") then
                v551.Visible = true
            end
        end
    end)
    v_u_43.Gift.Search.TextBox.FocusLost:Connect(function()
        -- upvalues: (ref) v_u_1, (ref) v_u_43
        v_u_1.SearchPlayerGift(v_u_43.Gift.Search.TextBox.Text)
    end)
    v_u_8.Heartbeat:Connect(function(p552)
        -- upvalues: (ref) v_u_27, (ref) v_u_43, (ref) v_u_29, (ref) v_u_32, (ref) v_u_17, (ref) v_u_257, (ref) v_u_148, (ref) v_u_15, (ref) v_u_111
        local v553 = v_u_27:getPosition()
        local v554 = v_u_43.Top.Credits.TextLabel
        local v555 = math.round(v553)
        v554.Text = ("%*"):format((tostring(v555):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
        v_u_27:update(p552)
        local v556 = v_u_29 + 0.85 * p552
        v_u_43.Top.Categories.Credits.TextLabel.UIGradient.Offset = Vector2.new(v556, 0)
        v_u_29 = v556
        if v_u_29 > 1 then
            v_u_29 = -1
        end
        local v557 = workspace:GetServerTimeNow()
        if v_u_32 <= v557 then
            v_u_32 = v557 + 1
            local function v561(p558)
                -- upvalues: (ref) v_u_17, (ref) v_u_257
                for _, v559 in ipairs(p558:GetChildren()) do
                    if v559:IsA("Frame") then
                        local v560 = v_u_17.GetCase(v559.Name)
                        if v560 then
                            v_u_257(v559, v560)
                        end
                    end
                end
            end
            v561(v_u_43.Tabs.Container.Featured.Container.Items)
            v561(v_u_43.Tabs.Container.Cases.Cases)
            v_u_148(v557)
        end
        local v562 = v_u_15.GetActiveBundle()
        if v562 then
            v_u_43.Tabs.Container.Featured.Bundle.Header.Timer.Text = v_u_111(v562.discontinueDate)
        end
    end)
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_1, (copy) v_u_5, (copy) v_u_28, (ref) v_u_30, (ref) v_u_43, (copy) v_u_186, (ref) v_u_34, (copy) v_u_11, (ref) v_u_48, (copy) v_u_148, (copy) v_u_21, (copy) v_u_174, (copy) v_u_27, (copy) v_u_10, (copy) v_u_17, (copy) v_u_19, (copy) v_u_77, (copy) v_u_55, (copy) v_u_53, (copy) v_u_56, (copy) v_u_91, (copy) v_u_12, (ref) v_u_44, (copy) v_u_22, (copy) v_u_3
    v_u_1.OpenTab("Featured")
    local v563, v564 = pcall(function()
        -- upvalues: (ref) v_u_5, (ref) v_u_28
        return v_u_5:GetPolicyInfoForPlayerAsync(v_u_28)
    end)
    v_u_30 = not (v563 and (v564 and v564.ArePaidRandomItemsRestricted))
    if not v_u_30 then
        v_u_43.Top.Categories.Credits.Visible = false
    end
    for _, v_u_565 in ipairs(v_u_43.Top.Categories:GetChildren()) do
        if v_u_565:IsA("TextButton") then
            v_u_186(v_u_565)
            v_u_565.MouseButton1Click:Connect(function()
                -- upvalues: (ref) v_u_1, (copy) v_u_565
                v_u_1.OpenTab(v_u_565.Name)
            end)
        end
    end
    v_u_43.CaseContent.List.Amount.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_43
        local v_u_566 = v_u_43.CaseContent.List.Amount.Container
        v_u_566.Visible = not v_u_566.Visible
        if v_u_566.Visible then
            v_u_43.CaseContent.List.Amount.Header.ImageLabel.Rotation = 0
            task.defer(function()
                -- upvalues: (copy) v_u_566
                local v567 = v_u_566.AbsoluteCanvasSize.Y - v_u_566.AbsoluteWindowSize.Y
                local v568 = math.max(0, v567)
                v_u_566.CanvasPosition = Vector2.new(v_u_566.CanvasPosition.X, v568)
            end)
        else
            v_u_43.CaseContent.List.Amount.Header.ImageLabel.Rotation = 180
        end
    end)
    for _, v_u_569 in ipairs(v_u_43.CaseContent.List.Amount.Container:GetChildren()) do
        if v_u_569:IsA("TextButton") then
            v_u_569.MouseEnter:Connect(function()
                -- upvalues: (copy) v_u_569
                if not v_u_569:GetAttribute("Selected") then
                    v_u_569.Frame.BackgroundTransparency = 0.5
                end
            end)
            v_u_569.MouseLeave:Connect(function()
                -- upvalues: (copy) v_u_569
                if not v_u_569:GetAttribute("Selected") then
                    v_u_569.Frame.BackgroundTransparency = 1
                end
            end)
            v_u_569.MouseButton1Click:Connect(function()
                -- upvalues: (ref) v_u_34, (copy) v_u_569, (ref) v_u_43
                local v570 = v_u_34.price
                local v571 = v_u_569.Name
                local v572 = v570 * tonumber(v571)
                v_u_43.CaseContent.List.Buy.Header.TextLabel.Text = ("BUY (%*)"):format((tostring(v572):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
                local v573 = v_u_43.CaseContent.List.Amount.Header.TextLabel
                local v574 = v_u_569.Name
                v573.Text = tostring(v574)
                v_u_43.CaseContent.List.Amount.Container.Visible = false
                for _, v575 in ipairs(v_u_43.CaseContent.List.Amount.Container:GetChildren()) do
                    if v575:IsA("TextButton") then
                        v575.Frame.BackgroundTransparency = v575 == v_u_569 and 0 or 1
                        v575:SetAttribute("Selected", v575 == v_u_569)
                    end
                end
            end)
        end
    end
    v_u_43.Gift.Amount.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_43
        local v_u_576 = v_u_43.Gift.Amount.Container
        v_u_576.Visible = not v_u_576.Visible
        if v_u_576.Visible then
            v_u_43.Gift.Amount.Header.ImageLabel.Rotation = 0
            task.defer(function()
                -- upvalues: (copy) v_u_576
                local v577 = v_u_576.AbsoluteCanvasSize.Y - v_u_576.AbsoluteWindowSize.Y
                local v578 = math.max(0, v577)
                v_u_576.CanvasPosition = Vector2.new(v_u_576.CanvasPosition.X, v578)
            end)
        else
            v_u_43.Gift.Amount.Header.ImageLabel.Rotation = 180
        end
    end)
    for _, v_u_579 in ipairs(v_u_43.Gift.Amount.Container:GetChildren()) do
        if v_u_579:IsA("TextButton") then
            v_u_579.MouseEnter:Connect(function()
                -- upvalues: (copy) v_u_579
                if not v_u_579:GetAttribute("Selected") then
                    v_u_579.Frame.BackgroundTransparency = 0.5
                end
            end)
            v_u_579.MouseLeave:Connect(function()
                -- upvalues: (copy) v_u_579
                if not v_u_579:GetAttribute("Selected") then
                    v_u_579.Frame.BackgroundTransparency = 1
                end
            end)
            v_u_579.MouseButton1Click:Connect(function()
                -- upvalues: (ref) v_u_43, (copy) v_u_579
                local v580 = v_u_43.Gift.Amount.Header.TextLabel
                local v581 = v_u_579.Name
                v580.Text = tostring(v581)
                v_u_43.Gift.Amount.Container.Visible = false
                for _, v582 in ipairs(v_u_43.Gift.Amount.Container:GetChildren()) do
                    if v582:IsA("TextButton") then
                        v582.Frame.BackgroundTransparency = v582 == v_u_579 and 0 or 1
                        v582:SetAttribute("Selected", v582 == v_u_579)
                    end
                end
            end)
        end
    end
    v_u_11.CreateListener(v_u_28, "Statistics.OpenShopTime", function(p583)
        -- upvalues: (ref) v_u_48, (ref) v_u_148
        local v584 = nil
        if typeof(p583) == "number" then
            v584 = p583
        elseif typeof(p583) == "string" then
            v584 = tonumber(p583)
        end
        local v585
        if v584 == nil then
            v585 = nil
        elseif v584 > 10000000000 then
            local v586 = v584 / 1000
            v585 = math.floor(v586)
        else
            v585 = math.floor(v584)
        end
        if v585 ~= nil then
            v_u_48 = true
        end
        v_u_148()
    end)
    v_u_11.CreateListener(v_u_28, "Gamepasses", function()
        -- upvalues: (ref) v_u_148
        v_u_148()
    end)
    v_u_21.OnScreenChanged:Connect(function(_, p587)
        -- upvalues: (ref) v_u_174
        if p587 == "Store" then
            v_u_174()
        end
    end)
    if v_u_21.GetCurrentScreen() == "Store" then
        v_u_174()
    else
        v_u_148()
    end
    v_u_11.CreateListener(v_u_28, "Credits", function(p588)
        -- upvalues: (ref) v_u_27
        v_u_27:setGoal(p588)
    end)
    v_u_11.CreateListener(v_u_28, "Statistics.RobuxSpent", function(p589)
        -- upvalues: (ref) v_u_10, (ref) v_u_43
        if v_u_10.MINIMUM_CREDITS_FOR_SPECIAL_CREDITS_OPTION <= p589 then
            v_u_43.Tabs.Container.Credits.Container.Seperator.Visible = true
            v_u_43.Tabs.Container.Credits.Container.Special.Visible = true
        else
            v_u_43.Tabs.Container.Credits.Container.Seperator.Visible = false
            v_u_43.Tabs.Container.Credits.Container.Special.Visible = false
        end
    end)
    v_u_11.CreateListener(v_u_28, "CreatorCode", function(p590)
        -- upvalues: (ref) v_u_43
        if p590 and p590 ~= "" then
            v_u_43.OpenCreatorCode.TextLabel.Text = ("SUPPORT-A-CREATOR: \"%*\""):format(p590)
            v_u_43.CreatorCode.Container.Body.CreatorName.TextBox.Text = p590
        else
            v_u_43.OpenCreatorCode.TextLabel.Text = "SUPPORT-A-CREATOR"
        end
    end)
    v_u_17.ObserveAvailableCases(function(_)
        -- upvalues: (ref) v_u_1
        v_u_1.UpdateCases()
    end)
    v_u_19.UI.UpdateCreatorCode.Listen(function(p591)
        -- upvalues: (ref) v_u_43, (ref) v_u_77
        v_u_43.CreatorCode.Container.Action.Confirm.Title.Text = "CONFIRM"
        v_u_77(p591.Type, p591.Text)
    end)
    v_u_19.Store.CaseOpened.Listen(function(p592)
        -- upvalues: (ref) v_u_11, (ref) v_u_28, (ref) v_u_55, (ref) v_u_53, (ref) v_u_56, (ref) v_u_91
        if p592.InventoryItems and #p592.InventoryItems > 0 then
            v_u_11.ApplyInventoryDelta(v_u_28, p592.InventoryItems, p592.DeletedCaseIds)
        end
        local v593 = p592.RequestId
        local v594
        if typeof(v593) == "string" then
            v594 = p592.RequestId
        else
            v594 = nil
        end
        local v595
        if v594 then
            v595 = v_u_55[v594]
            if v595 then
                if v594 and v_u_53.pendingOpenRequestId == v594 then
                    v_u_53.isPendingOpenRequest = false
                    v_u_53.pendingOpenRequestId = nil
                    v_u_53.isQuickUnlock = false
                end
                v_u_55[v594] = nil
            else
                v595 = nil
            end
        else
            v595 = nil
        end
        if not v594 or v595 then
            local v596 = v_u_56
            local v597 = {
                ["CaseId"] = p592.CaseId,
                ["InventoryItems"] = p592.InventoryItems,
                ["CaseIdentifier"] = p592.CaseIdentifier,
                ["IsQuickUnlock"] = v595 and v595.IsQuickUnlock or false,
                ["RequestId"] = v594
            }
            table.insert(v596, v597)
            task.defer(v_u_91)
        end
    end)
    v_u_19.Store.CaseOpenDenied.Listen(function(p598)
        -- upvalues: (ref) v_u_53, (ref) v_u_55
        local v599
        if p598 then
            local v600 = p598.RequestId
            if typeof(v600) == "string" then
                v599 = p598.RequestId
            else
                v599 = nil
            end
        else
            v599 = nil
        end
        if v599 then
            if v_u_53.pendingOpenRequestId == v599 then
                v_u_53.isPendingOpenRequest = false
                v_u_53.pendingOpenRequestId = nil
                v_u_53.isQuickUnlock = false
            end
            v_u_55[v599] = nil
        end
    end)
    v_u_21.OnInspectStateChanged:Connect(function(p601)
        -- upvalues: (ref) v_u_91, (ref) v_u_21, (ref) v_u_43, (ref) v_u_12, (ref) v_u_34, (ref) v_u_44
        if not p601 then
            task.defer(function()
                -- upvalues: (ref) v_u_91, (ref) v_u_21, (ref) v_u_43, (ref) v_u_12, (ref) v_u_34, (ref) v_u_44
                if not v_u_91() then
                    local v602 = v_u_21.GetCurrentScreen()
                    local v603 = v_u_43.CaseContent:GetAttribute("WasVisibleBeforeInspect") == true
                    local v604 = v_u_12.IsActive()
                    if v_u_34 and (v602 == "Store" and (v603 and v604)) then
                        v_u_43.Visible = true
                        v_u_43.Tabs.Container.Visible = false
                        v_u_43.CaseContent.Visible = true
                        v_u_44.Menu.Top.Visible = false
                        v_u_43.Top.Visible = false
                        v_u_21.SetBlurEnabled(false)
                        local v605 = v_u_21.GetMenuFrame()
                        if v605 then
                            v605.BackgroundTransparency = 1
                            return
                        end
                    elseif v_u_43.CaseContent.Visible and v602 == "Inventory" then
                        v_u_43.Visible = true
                        v_u_43.Tabs.Container.Visible = false
                        v_u_43.CaseContent.Visible = true
                        v_u_44.Menu.Top.Visible = false
                        v_u_43.Top.Visible = false
                        local v606 = v_u_44.Menu:FindFirstChild("Inventory")
                        if v606 then
                            v606.Visible = false
                        end
                        v_u_21.SetBlurEnabled(false)
                        local v607 = v_u_21.GetMenuFrame()
                        if v607 then
                            v607.BackgroundTransparency = 1
                        end
                        if not v_u_12.IsActive() and v_u_34 then
                            v_u_12.ShowCaseScene(v_u_34.caseId)
                        end
                    end
                end
            end)
        end
    end)
    v_u_22.observePlayer(function(p608)
        -- upvalues: (ref) v_u_28, (ref) v_u_3, (ref) v_u_43, (ref) v_u_1
        if v_u_28 == p608 then
            return function() end
        end
        local v_u_609 = v_u_3.Assets.UI.Store.PlayerTemplate:Clone()
        v_u_609.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(p608.UserId)
        v_u_609.Player.Username.Text = ("@%*"):format(p608.Name)
        v_u_609.Parent = v_u_43.Gift.Container
        local v610 = p608.UserId
        v_u_609.Name = tostring(v610)
        v_u_1.ActivateGiftTemplate(v_u_609, p608.UserId)
        return function()
            -- upvalues: (copy) v_u_609
            if v_u_609 then
                v_u_609:Destroy()
            end
        end
    end)
end
return v_u_1
