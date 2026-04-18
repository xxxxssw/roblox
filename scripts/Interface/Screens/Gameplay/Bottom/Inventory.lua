-- MODULESCRIPT: Inventory
-- Original Path: game.BAC - 17285.Interface.Screens.Gameplay.Bottom.Inventory
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
require(v2.Database.Custom.Types)
local v_u_5 = v_u_4.LocalPlayer
local v_u_6 = require(v2.Controllers.InventoryController)
local v_u_7 = require(v2.Controllers.SpectateController)
local v_u_8 = require(v2.Controllers.DataController)
local v9 = require(v2.Components.Common.GetUserPlatform)
local v_u_10 = require(v2.Components.Common.UserInput.EquipInventorySlot)
local v_u_11 = require(v2.Components.Common.GetPreferenceColor)
local v_u_12 = require(v2.Components.Common.GetSkinDisplayName)
local v_u_13 = require(v2.Components.Common.GetResolvedSkinInformation)
local v_u_14 = require(v2.Database.Security.Remotes)
local v_u_15 = require(v2.Database.Custom.GameStats.Rarities)
local v_u_16 = nil
local v_u_17 = 0
local v_u_18 = nil
local v_u_19 = {}
local v_u_20 = nil
local v_u_21 = table.find(v9(), "Console")
if v_u_21 then
    v_u_21 = #v9() <= 1
end
local v_u_22 = {
    {
        ["type"] = "Primary",
        ["space"] = 1
    },
    {
        ["type"] = "Secondary",
        ["space"] = 1
    },
    {
        ["type"] = "Melee",
        ["space"] = 2
    },
    {
        ["type"] = "Grenade",
        ["space"] = 4
    },
    {
        ["type"] = "C4",
        ["space"] = 1
    }
}
local v_u_23 = utf8.char(9733) .. " "
local v_u_24 = Color3.new(1, 1, 1)
local v_u_25 = {}
local v_u_26 = nil
local v_u_27 = {}
local v_u_28 = nil
local function v_u_38(p29, p30)
    -- upvalues: (copy) v_u_23, (copy) v_u_12, (copy) v_u_5
    local v31
    if p30 == "Melee" then
        local v32
        if p29 == nil then
            v32 = false
        else
            v32 = p29.Name == "Zeus x27"
        end
        v31 = v32 and "" or (v_u_23 or "")
    else
        v31 = ""
    end
    local v33 = v31 .. p29.Name
    if p29.Skin then
        local v34 = v_u_12(p29.Skin)
        local v35
        if v34 == "Vanilla" then
            v35 = false
        else
            v35 = v34 ~= "Stock"
        end
        v33 = v33 .. (v35 and " | " .. v34 or "")
    end
    local v36 = (p29.Name == "T Knife" or p29.Name == "CT Knife") and "Knife" or v33
    if p29.NameTag then
        v36 = ("\"%*\""):format(p29.NameTag)
    end
    local v37 = p29.OriginalOwner
    if v37 and (v37 ~= "" and v37 ~= v_u_5.Name) then
        v36 = ("\"%*\'s %*\""):format(v37, v36)
    end
    return v36
end
local function v_u_43(p39)
    local v40 = p39:FindFirstChild("Weapon")
    local v41
    if v40 then
        v41 = v40:FindFirstChild("Melee") or nil
    else
        v41 = nil
    end
    if v41 then
        if not v41:IsA("ImageLabel") then
            v41 = v41:FindFirstChildWhichIsA("ImageLabel", true)
        end
    else
        v41 = nil
    end
    local v42 = p39:FindFirstChild("Zeus")
    if not v42 then
        if v40 then
            v42 = v40:FindFirstChild("Zeus") or nil
        else
            v42 = nil
        end
    end
    if v42 then
        if not v42:IsA("ImageLabel") then
            v42 = v42:FindFirstChildWhichIsA("ImageLabel", true)
        end
    else
        v42 = nil
    end
    if not v41 and (v40 and v40:IsA("Frame")) then
        v41 = v40:FindFirstChildOfClass("ImageLabel")
    end
    return v41, v42
end
local function v_u_48(p44)
    local v45 = p44:FindFirstChild("Weapon")
    local v46
    if v45 then
        v46 = v45:FindFirstChild("WeaponName") or nil
    else
        v46 = nil
    end
    if v46 then
        if not v46:IsA("TextLabel") then
            v46 = v46:FindFirstChildWhichIsA("TextLabel", true)
        end
    else
        v46 = nil
    end
    local v47 = p44:FindFirstChild("Zeus") or (v45 and v45:FindFirstChild("Zeus") or nil)
    if v47 then
        if v47:IsA("TextLabel") then
            return v46, v47
        else
            return v46, v47:FindFirstChildWhichIsA("TextLabel", true)
        end
    else
        return v46, nil
    end
end
local function v_u_70(p49, p50, p51)
    -- upvalues: (copy) v_u_43, (copy) v_u_48, (ref) v_u_26, (copy) v_u_38
    local v52, v53 = v_u_43(p49)
    local v54, v55 = v_u_48(p49)
    p49:SetAttribute("Slot", 3)
    p49.Keybind.Text = "3"
    local v56 = {}
    local v57 = nil
    local v58 = nil
    for _, v59 in ipairs(p50._items) do
        local v60 = ("$%*<%*>"):format(v59.Name, v59.Identifier)
        table.insert(v56, v60)
        local v61
        if v59 == nil then
            v61 = false
        else
            v61 = v59.Name == "Zeus x27"
        end
        if v61 then
            v58 = v59
        else
            v57 = v59
        end
    end
    if v52 then
        v52.Visible = v57 ~= nil
    end
    if v57 and v52 then
        v52.Image = v57.Properties.Icon
        v52.ImageColor3 = v_u_26(v57)
    end
    if v53 then
        v53.Visible = v58 ~= nil
    end
    if v58 and v53 then
        v53.Image = v58.Properties.Icon
        v53.ImageColor3 = v_u_26(v58)
    end
    local v62
    if p51 and p51.Properties.Slot == "Melee" then
        v62 = p51
    else
        v62 = v57 or v58
    end
    if v62 then
        local v63
        if p49 then
            if p49.Name == "Melee" then
                local v64
                v63, v64 = v_u_48(p49)
                local v65
                if v62 == nil then
                    v65 = false
                else
                    v65 = v62.Name == "Zeus x27"
                end
                if v65 then
                    v63 = v64 or v63
                end
            else
                v63 = p49.Weapon:FindFirstChild("WeaponName")
            end
        else
            v63 = nil
        end
        local v66
        if p51 == nil then
            v66 = false
        else
            v66 = p51.Properties.Slot == "Melee"
        end
        if v54 and v54 ~= v63 then
            v54.Visible = false
        end
        if v55 and v55 ~= v63 then
            v55.Visible = false
        end
        if v63 then
            v63.TextColor3 = v_u_26(v62)
            v63.Text = v_u_38(v62, "Melee")
            v63.Visible = v66
            return
        end
    else
        p49.Equip.Visible = false
        if p49 then
            if p49.Name == "Melee" then
                local v67, v68 = v_u_48(p49)
                if v67 then
                    v67.Visible = false
                    v67.Text = ""
                end
                if v68 then
                    v68.Visible = false
                    v68.Text = ""
                end
            else
                local v69 = p49.Weapon:FindFirstChild("WeaponName")
                if v69 then
                    v69.Visible = false
                    v69.Text = ""
                end
            end
        end
        if v52 then
            v52.Visible = false
        end
        if v53 then
            v53.Visible = false
        end
    end
end
local function v_u_76()
    -- upvalues: (ref) v_u_20, (copy) v_u_19, (ref) v_u_28
    if v_u_20 then
        task.cancel(v_u_20)
        v_u_20 = nil
    end
    for _, v71 in v_u_19 do
        v71:Cancel()
    end
    table.clear(v_u_19)
    local v72 = v_u_28 and { v_u_28.Primary, v_u_28.Secondary, v_u_28.Melee } or nil
    if v72 then
        for _, v73 in ipairs(v72) do
            if v73:IsA("Frame") then
                local v74 = v73:FindFirstChild("Equip")
                if v74 and v74:IsA("Frame") then
                    v74.BackgroundTransparency = 0.225
                end
                for _, v75 in v73:QueryDescendants("ImageLabel, TextLabel") do
                    if v75:IsA("ImageLabel") then
                        v75.ImageTransparency = 0.225
                    else
                        v75.TextTransparency = 0.225
                    end
                end
            end
        end
    end
end
local function v_u_84()
    -- upvalues: (copy) v_u_8, (copy) v_u_5, (copy) v_u_76, (ref) v_u_28, (copy) v_u_3, (copy) v_u_19, (ref) v_u_20
    if v_u_8.Get(v_u_5, "Settings.Game.Item.Always Show Inventory") ~= false then
        v_u_76()
        return
    else
        v_u_76()
        local v77 = v_u_28 and { v_u_28.Primary, v_u_28.Secondary, v_u_28.Melee } or nil
        if v77 then
            for _, v78 in ipairs(v77) do
                if v78:IsA("Frame") then
                    local v79 = v78:FindFirstChild("Equip")
                    if v79 and v79:IsA("Frame") then
                        local v80 = v_u_3:Create(v79, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            ["BackgroundTransparency"] = 1
                        })
                        v_u_19[v78.Name .. "_Equip"] = v80
                        v80:Play()
                    end
                    for _, v81 in v78:QueryDescendants("ImageLabel", "TextLabel") do
                        local v82 = v81:IsA("ImageLabel") and {
                            ["ImageTransparency"] = 1
                        } or {
                            ["TextTransparency"] = 1
                        }
                        local v83 = v_u_3:Create(v81, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), v82)
                        v_u_19[v78.Name .. "_" .. v81:GetFullName()] = v83
                        v83:Play()
                    end
                end
            end
            v_u_20 = task.delay(5, function()
                -- upvalues: (ref) v_u_20
                v_u_20 = nil
            end)
        end
    end
end
v_u_26 = function(p85)
    -- upvalues: (copy) v_u_11, (copy) v_u_8, (copy) v_u_5, (copy) v_u_13, (copy) v_u_15
    if p85 then
        if v_u_8.Get(v_u_5, "Settings.Game.HUD.Glow Weapon with Rarity Color") == true then
            local v86 = v_u_13(p85.Name, p85.Skin)
            if v86 and v86.rarity then
                local v87 = v_u_15[v86.rarity]
                if v87 then
                    return v87.Color
                else
                    return v_u_11()
                end
            else
                return v_u_11()
            end
        else
            return v_u_11()
        end
    else
        return v_u_11()
    end
end
local function v_u_95(p88, p89)
    -- upvalues: (copy) v_u_3, (copy) v_u_24
    local v90 = p88:GetAttribute("DefaultSize")
    if v90 then
        local v91 = UDim2.new(v90.X.Scale * 1.1, v90.X.Offset * 1.1, v90.Y.Scale * 1.1, v90.Y.Offset * 1.1)
        for _ = 1, 6 do
            local v92 = {
                ["ImageColor3"] = v_u_24,
                ["Size"] = v91
            }
            local v93 = v_u_3:Create(p88, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), v92)
            v93:Play()
            v93.Completed:Wait()
            local v94 = v_u_3:Create(p88, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["ImageColor3"] = p89,
                ["Size"] = v90
            })
            v94:Play()
            v94.Completed:Wait()
        end
    end
end
local function v_u_100(p_u_96, p_u_97, p_u_98)
    -- upvalues: (copy) v_u_25, (copy) v_u_95
    if v_u_25[p_u_96] then
        task.cancel(v_u_25[p_u_96])
        v_u_25[p_u_96] = nil
    end
    local v99 = p_u_97:GetAttribute("DefaultSize")
    if v99 then
        p_u_97.ImageColor3 = p_u_98
        p_u_97.Size = v99
    end
    v_u_25[p_u_96] = task.spawn(function()
        -- upvalues: (ref) v_u_95, (copy) p_u_97, (copy) p_u_98, (ref) v_u_25, (copy) p_u_96
        v_u_95(p_u_97, p_u_98)
        v_u_25[p_u_96] = nil
    end)
end
local function v_u_107(p101)
    local v102 = {}
    for _, v103 in p101 do
        local v104 = v103._settings._strict_type
        v102[v104] = {}
        for _, v105 in v103._items do
            local v106 = v105.Identifier
            if v106 then
                v102[v104][v106] = true
            end
        end
    end
    return v102
end
local function v_u_108()
    -- upvalues: (copy) v_u_107, (ref) v_u_27, (ref) v_u_28, (copy) v_u_100, (copy) v_u_11, (copy) v_u_43, (ref) v_u_26
    -- failed to decompile
end
local function v_u_109()
    -- upvalues: (ref) v_u_16, (ref) v_u_17, (copy) v_u_3, (ref) v_u_18, (copy) v_u_43, (copy) v_u_48, (ref) v_u_28, (copy) v_u_11, (ref) v_u_26, (copy) v_u_38, (copy) v_u_21
    -- failed to decompile
end
local function v_u_118(p110)
    -- upvalues: (copy) v_u_22
    local v111 = {}
    if not p110 or #p110 == 0 then
        return nil
    end
    for v112 = 1, 5 do
        local v113 = p110[v112]
        if v113 then
            local v114 = {
                ["_items"] = {},
                ["_settings"] = {
                    ["_strict_slot_space"] = v113._settings._strict_slot_space,
                    ["_strict_type"] = v113._settings._strict_type
                }
            }
            v111[v112] = v114
            for _, v115 in ipairs(v113._items) do
                local v116 = v111[v112]._items
                table.insert(v116, v115)
            end
        else
            local v117 = {
                ["_items"] = {},
                ["_settings"] = {
                    ["_strict_slot_space"] = v_u_22[v112].space,
                    ["_strict_type"] = v_u_22[v112].type
                }
            }
            v111[v112] = v117
        end
    end
    return v111
end
local function v_u_147(p119, p120)
    -- upvalues: (copy) v_u_11, (ref) v_u_28, (copy) v_u_5, (copy) v_u_6, (copy) v_u_70, (copy) v_u_12, (ref) v_u_26, (copy) v_u_38
    local v121 = v_u_11()
    v_u_28.Grenade.DefuseKit.ImageColor3 = v121
    v_u_28.Grenade.Bomb.ImageColor3 = v121
    local v122 = p120 or v_u_5
    local v123 = v_u_28.Grenade.DefuseKit
    local v124
    if v122 and v122:GetAttribute("Team") == "Counter-Terrorists" then
        local v125 = workspace:GetAttribute("Gamemode")
        local v126 = v125 == "Bomb Defusal" and "HasDefuseKit" or (v125 == "Hostage Rescue" and "HasRescueKit" or nil)
        if v126 then
            v124 = v122:GetAttribute(v126) == true
        else
            v124 = false
        end
    else
        v124 = false
    end
    v123.Visible = v124
    if workspace:GetAttribute("Gamemode") == "Hostage Rescue" then
        v_u_28.Grenade.Bomb.Visible = false
    end
    local v127 = v_u_6.getCurrentEquipped()
    for _, v128 in ipairs(p119) do
        if v128._settings._strict_type == "Melee" then
            v_u_70(v_u_28.Melee, v128, v127)
        elseif v128._settings._strict_slot_space == 1 then
            local v129 = v_u_28:FindFirstChild(v128._settings._strict_type)
            if v129 then
                local v130 = v128._items[1]
                if v130 then
                    local v131 = v129:FindFirstChild("Weapon")
                    v129:SetAttribute("Slot", v130.Slot)
                    v129.Keybind.Text = v130.Slot
                    if v131 then
                        local v132 = v129.Weapon:FindFirstChild(v130.Properties.Class)
                        local v133 = (v128._settings._strict_type == "Melee" and "\195\162\203\156\226\128\166 " or "") .. v130.Name
                        if v130.Skin then
                            local v134 = v_u_12(v130.Skin)
                            local v135
                            if v134 == "Vanilla" then
                                v135 = false
                            else
                                v135 = v134 ~= "Stock"
                            end
                            v133 = v133 .. (v135 and " | " .. v134 or "")
                        end
                        local v136 = (v130.Name == "T Knife" or v130.Name == "CT Knife") and "Knife" or v133
                        if v130.NameTag then
                            v136 = ("\"%*\""):format(v130.NameTag)
                        end
                        local v137 = v130.OriginalOwner
                        if v137 and (v137 ~= "" and v137 ~= v_u_5.Name) then
                            ("\"%*\'s %*\""):format(v137, v136)
                        end
                        v129.Weapon.WeaponName.TextColor3 = v_u_26(v130)
                        v129.Weapon.WeaponName.Text = v_u_38(v130, v128._settings._strict_type)
                        local v138
                        if v127 then
                            v138 = v127.Properties.Slot == v128._settings._strict_type
                        else
                            v138 = v127
                        end
                        v129.Weapon.WeaponName.Visible = v138
                        if v132 then
                            for _, v139 in v129.Weapon:GetChildren() do
                                if v139:IsA("ImageLabel") then
                                    v139.Visible = v139 == v132
                                end
                            end
                            v132.Image = v130.Properties.Icon
                            v132.ImageColor3 = v_u_26(v130)
                        end
                    end
                else
                    v129.Equip.Visible = false
                    v129.Weapon.WeaponName.Text = ""
                    v129.Weapon.WeaponName.Visible = false
                    for _, v140 in v129.Weapon:GetChildren() do
                        if v140:IsA("ImageLabel") then
                            v140.Visible = false
                        end
                    end
                end
            elseif v128._settings._strict_type == "C4" then
                v_u_28.Grenade.Bomb.Visible = v128._items[1]
            end
        elseif v128._settings._strict_type == "Grenade" then
            for v141 = 1, 4 do
                local v142 = v_u_28.Grenade.Grenades:FindFirstChild((tostring(v141)))
                if v142 then
                    local v143 = v128._items[v141]
                    if v143 then
                        v142.Grenade.ImageColor3 = v121
                        v142.Grenade.Visible = true
                        v142.Dot.Visible = false
                        if v143.Properties and v143.Properties.Icon then
                            v142.Grenade.Image = v143.Properties.Icon
                        end
                    else
                        v142.Grenade.Visible = false
                        v142.Dot.Visible = true
                    end
                end
            end
        end
    end
    for _, v144 in v_u_28:GetChildren() do
        if v144:IsA("Frame") then
            local v145 = v144.Name == "Grenade"
            for _, v146 in p119 do
                if #v146._items > 0 and v146._settings._strict_type == v144.Name then
                    v145 = true
                    break
                end
            end
            v144.Visible = v145
        end
    end
end
function v1.Initialize(_, p148)
    -- upvalues: (ref) v_u_28, (copy) v_u_10, (copy) v_u_6
    v_u_28 = p148
    if v_u_28.Active then
        v_u_28.Active = false
    end
    for _, v149 in v_u_28:QueryDescendants("GuiObject") do
        v149.Active = false
    end
    for _, v150 in v_u_28:QueryDescendants("ImageLabel, ImageButton") do
        if v150.Parent.Name == "Weapon" or (v150.Name == "Grenade" or v150.Name == "Bomb") then
            v150:SetAttribute("DefaultSize", v150.Size)
        end
    end
    for _, v_u_151 in v_u_28:GetChildren() do
        if v_u_151:IsA("Frame") and v_u_151:FindFirstChild("Button") then
            v_u_151.Button.MouseButton1Click:Connect(function()
                -- upvalues: (copy) v_u_151, (ref) v_u_10
                local v152 = v_u_151:GetAttribute("Slot")
                if v152 then
                    v_u_10(v152)
                end
            end)
        end
    end
    for _, v_u_153 in v_u_28.Grenade.Grenades:GetChildren() do
        if v_u_153:IsA("Frame") then
            v_u_153:FindFirstChild("Button").MouseButton1Click:Connect(function()
                -- upvalues: (ref) v_u_6, (copy) v_u_153
                local v154 = v_u_6.equip
                local v155 = v_u_153.Name
                v154(4, (tonumber(v155)))
            end)
        end
    end
    local v_u_156 = v_u_28.Grenade.Bomb
    if v_u_156:IsA("ImageButton") then
        v_u_156.MouseButton1Click:Connect(function()
            -- upvalues: (copy) v_u_156, (ref) v_u_6
            if v_u_156.Visible then
                v_u_6.equip(5, 1)
            end
        end)
    end
end
function v1.Start()
    -- upvalues: (copy) v_u_6, (copy) v_u_5, (copy) v_u_147, (copy) v_u_108, (copy) v_u_109, (copy) v_u_8, (copy) v_u_76, (copy) v_u_84, (ref) v_u_28, (ref) v_u_26, (copy) v_u_43, (copy) v_u_48, (copy) v_u_7, (copy) v_u_14, (copy) v_u_118, (copy) v_u_4
    v_u_6.OnInventoryChanged:Connect(function(p157)
        -- upvalues: (ref) v_u_5, (ref) v_u_147, (ref) v_u_108
        if not v_u_5:GetAttribute("IsSpectating") then
            v_u_147(p157)
            v_u_108(p157)
        end
    end)
    v_u_6.OnInventoryItemEquipped:Connect(function(p158, p159)
        -- upvalues: (ref) v_u_109, (ref) v_u_8, (ref) v_u_5, (ref) v_u_76, (ref) v_u_84
        v_u_109(p158, p159)
        if v_u_8.Get(v_u_5, "Settings.Game.Item.Always Show Inventory") == false then
            local v160 = p159.Properties.Slot
            if v160 == "Primary" or (v160 == "Secondary" or (v160 == "Melee" or v160 == "Grenade")) then
                v_u_76()
                v_u_84()
            end
        end
    end)
    v_u_8.CreateListener(v_u_5, "Settings.Game.HUD.Glow Weapon with Rarity Color", function()
        -- upvalues: (ref) v_u_6, (ref) v_u_147, (ref) v_u_28, (ref) v_u_26, (ref) v_u_43, (ref) v_u_48
        local v161 = v_u_6.getCurrentInventory()
        if v161 then
            v_u_147(v161)
        end
        local v162 = v_u_6.getCurrentEquipped()
        if v162 then
            local v163 = v_u_28
            local v164 = v162.Properties.Slot
            local v165 = v163:FindFirstChild((tostring(v164)))
            if v165 and v165.Name ~= "Grenade" then
                local v166 = v_u_26(v162)
                local v167
                if v165 then
                    if v165.Name == "Melee" then
                        local v168
                        v167, v168 = v_u_43(v165)
                        local v169
                        if v162 == nil then
                            v169 = false
                        else
                            v169 = v162.Name == "Zeus x27"
                        end
                        if v169 then
                            v167 = v168 or v167
                        end
                    else
                        v167 = v165.Weapon:FindFirstChildOfClass("ImageLabel")
                    end
                else
                    v167 = nil
                end
                if v167 then
                    v167.ImageColor3 = v166
                end
                local v170
                if v165 then
                    if v165.Name == "Melee" then
                        local v171
                        v170, v171 = v_u_48(v165)
                        local v172
                        if v162 == nil then
                            v172 = false
                        else
                            v172 = v162.Name == "Zeus x27"
                        end
                        if v172 then
                            v170 = v171 or v170
                        end
                    else
                        v170 = v165.Weapon:FindFirstChild("WeaponName")
                    end
                else
                    v170 = nil
                end
                if v170 then
                    v170.TextColor3 = v166
                end
            end
        end
    end)
    v_u_8.CreateListener(v_u_5, "Settings.Game.HUD.Color", function()
        -- upvalues: (ref) v_u_5, (ref) v_u_7, (ref) v_u_14, (ref) v_u_6, (ref) v_u_147
        if v_u_5:GetAttribute("IsSpectating") == true then
            local v173 = v_u_7.GetPlayer()
            if v173 then
                v_u_14.Inventory.RequestSpectatedPlayerInventory.Send(v173)
                return
            end
        else
            local v174 = v_u_6.getCurrentInventory()
            if v174 then
                v_u_147(v174)
            end
        end
    end)
    local function v180()
        -- upvalues: (ref) v_u_5, (ref) v_u_28
        if not v_u_5:GetAttribute("IsSpectating") then
            local v175 = v_u_5
            local v176 = v_u_28.Grenade.DefuseKit
            local v177
            if v175 and v175:GetAttribute("Team") == "Counter-Terrorists" then
                local v178 = workspace:GetAttribute("Gamemode")
                local v179 = v178 == "Bomb Defusal" and "HasDefuseKit" or (v178 == "Hostage Rescue" and "HasRescueKit" or nil)
                if v179 then
                    v177 = v175:GetAttribute(v179) == true
                else
                    v177 = false
                end
            else
                v177 = false
            end
            v176.Visible = v177
        end
    end
    v_u_5:GetAttributeChangedSignal("HasDefuseKit"):Connect(v180)
    v_u_5:GetAttributeChangedSignal("HasRescueKit"):Connect(v180)
    v_u_5:GetAttributeChangedSignal("Team"):Connect(v180)
    v_u_14.Inventory.SpectatedPlayerInventory.Listen(function(p181)
        -- upvalues: (ref) v_u_5, (ref) v_u_7, (ref) v_u_118, (ref) v_u_147, (ref) v_u_109
        if v_u_5:GetAttribute("IsSpectating") == true then
            local v182 = v_u_7.GetPlayer()
            local v183 = v182 and (p181.Player == v182 and v_u_118(p181.Inventory))
            if v183 then
                v_u_147(v183, v182)
                local v184 = p181.EquippedSlot or 0
                local v185 = p181.EquippedSlotSpace or 0
                if v184 > 0 and v185 > 0 then
                    local v186 = v183[v184]
                    if v186 and (v186._items and v186._items[v185]) then
                        v_u_109(v185, v186._items[v185])
                    end
                end
            end
        end
    end)
    v_u_7.ListenToSpectate:Connect(function(p187)
        -- upvalues: (ref) v_u_14, (ref) v_u_28, (ref) v_u_6, (ref) v_u_147, (ref) v_u_109, (ref) v_u_5
        if p187 then
            v_u_14.Inventory.RequestSpectatedPlayerInventory.Send(p187)
            local v188 = v_u_28.Grenade.DefuseKit
            local v189
            if p187 and p187:GetAttribute("Team") == "Counter-Terrorists" then
                local v190 = workspace:GetAttribute("Gamemode")
                local v191 = v190 == "Bomb Defusal" and "HasDefuseKit" or (v190 == "Hostage Rescue" and "HasRescueKit" or nil)
                if v191 then
                    v189 = p187:GetAttribute(v191) == true
                else
                    v189 = false
                end
            else
                v189 = false
            end
            v188.Visible = v189
            return
        end
        local v192 = v_u_6.getCurrentInventory()
        if v192 then
            v_u_147(v192)
        end
        local v193 = v_u_6.getCurrentEquipped()
        if v192 and (v193 and v193.Identifier) then
            local v194 = false
            for v195 = 1, 5 do
                if v194 then
                    break
                end
                local v196 = v192[v195]
                if v196 and v196._items then
                    for v197, v198 in ipairs(v196._items) do
                        if v198.Identifier == v193.Identifier then
                            v_u_109(v197, v198)
                            v194 = true
                            break
                        end
                    end
                end
            end
        end
        local v199 = v_u_5
        local v200 = v_u_28.Grenade.DefuseKit
        local v201
        if v199 and v199:GetAttribute("Team") == "Counter-Terrorists" then
            local v202 = workspace:GetAttribute("Gamemode")
            local v203 = v202 == "Bomb Defusal" and "HasDefuseKit" or (v202 == "Hostage Rescue" and "HasRescueKit" or nil)
            if v203 then
                v201 = v199:GetAttribute(v203) == true
            else
                v201 = false
            end
        else
            v201 = false
        end
        v200.Visible = v201
    end)
    local function v_u_209()
        -- upvalues: (ref) v_u_5, (ref) v_u_7, (ref) v_u_28
        local v204 = v_u_5:GetAttribute("IsSpectating") == true and v_u_7.GetPlayer()
        if v204 then
            local v205 = v_u_28.Grenade.DefuseKit
            local v206
            if v204 and v204:GetAttribute("Team") == "Counter-Terrorists" then
                local v207 = workspace:GetAttribute("Gamemode")
                local v208 = v207 == "Bomb Defusal" and "HasDefuseKit" or (v207 == "Hostage Rescue" and "HasRescueKit" or nil)
                if v208 then
                    v206 = v204:GetAttribute(v208) == true
                else
                    v206 = false
                end
            else
                v206 = false
            end
            v205.Visible = v206
        end
    end
    for _, v210 in ipairs(v_u_4:GetPlayers()) do
        if v210 ~= v_u_5 then
            v210:GetAttributeChangedSignal("HasDefuseKit"):Connect(v_u_209)
            v210:GetAttributeChangedSignal("HasRescueKit"):Connect(v_u_209)
            v210:GetAttributeChangedSignal("Team"):Connect(v_u_209)
        end
    end
    v_u_4.PlayerAdded:Connect(function(p211)
        -- upvalues: (ref) v_u_5, (copy) v_u_209
        if p211 ~= v_u_5 then
            p211:GetAttributeChangedSignal("HasDefuseKit"):Connect(v_u_209)
            p211:GetAttributeChangedSignal("HasRescueKit"):Connect(v_u_209)
            p211:GetAttributeChangedSignal("Team"):Connect(v_u_209)
        end
    end)
    workspace:GetAttributeChangedSignal("Gamemode"):Connect(function()
        -- upvalues: (ref) v_u_5, (ref) v_u_7, (ref) v_u_28
        if v_u_5:GetAttribute("IsSpectating") then
            local v212 = v_u_5:GetAttribute("IsSpectating") == true and v_u_7.GetPlayer()
            if v212 then
                local v213 = v_u_28.Grenade.DefuseKit
                local v214
                if v212 and v212:GetAttribute("Team") == "Counter-Terrorists" then
                    local v215 = workspace:GetAttribute("Gamemode")
                    local v216 = v215 == "Bomb Defusal" and "HasDefuseKit" or (v215 == "Hostage Rescue" and "HasRescueKit" or nil)
                    if v216 then
                        v214 = v212:GetAttribute(v216) == true
                    else
                        v214 = false
                    end
                else
                    v214 = false
                end
                v213.Visible = v214
                return
            end
        else
            local v217 = v_u_5
            local v218 = v_u_28.Grenade.DefuseKit
            local v219
            if v217 and v217:GetAttribute("Team") == "Counter-Terrorists" then
                local v220 = workspace:GetAttribute("Gamemode")
                local v221 = v220 == "Bomb Defusal" and "HasDefuseKit" or (v220 == "Hostage Rescue" and "HasRescueKit" or nil)
                if v221 then
                    v219 = v217:GetAttribute(v221) == true
                else
                    v219 = false
                end
            else
                v219 = false
            end
            v218.Visible = v219
        end
    end)
    if v_u_5:GetAttribute("IsSpectating") then
        local v222 = v_u_5:GetAttribute("IsSpectating") == true and v_u_7.GetPlayer()
        if v222 then
            local v223 = v_u_28.Grenade.DefuseKit
            local v224
            if v222 and v222:GetAttribute("Team") == "Counter-Terrorists" then
                local v225 = workspace:GetAttribute("Gamemode")
                local v226 = v225 == "Bomb Defusal" and "HasDefuseKit" or (v225 == "Hostage Rescue" and "HasRescueKit" or nil)
                if v226 then
                    v224 = v222:GetAttribute(v226) == true
                else
                    v224 = false
                end
            else
                v224 = false
            end
            v223.Visible = v224
        end
    else
        local v227 = v_u_5
        local v228 = v_u_28.Grenade.DefuseKit
        local v229
        if v227 and v227:GetAttribute("Team") == "Counter-Terrorists" then
            local v230 = workspace:GetAttribute("Gamemode")
            local v231 = v230 == "Bomb Defusal" and "HasDefuseKit" or (v230 == "Hostage Rescue" and "HasRescueKit" or nil)
            if v231 then
                v229 = v227:GetAttribute(v231) == true
            else
                v229 = false
            end
        else
            v229 = false
        end
        v228.Visible = v229
    end
    v_u_14.Inventory.NewInventoryItem.Listen(function(_)
        -- upvalues: (ref) v_u_5, (ref) v_u_7, (ref) v_u_14
        local v232 = v_u_5:GetAttribute("IsSpectating") == true and v_u_7.GetPlayer()
        if v232 then
            v_u_14.Inventory.RequestSpectatedPlayerInventory.Send(v232)
        end
    end)
    v_u_14.Inventory.RemoveInventoryItem.Listen(function(_)
        -- upvalues: (ref) v_u_5, (ref) v_u_7, (ref) v_u_14
        local v233 = v_u_5:GetAttribute("IsSpectating") == true and v_u_7.GetPlayer()
        if v233 then
            v_u_14.Inventory.RequestSpectatedPlayerInventory.Send(v233)
        end
    end)
    v_u_8.CreateListener(v_u_5, "Settings.Game.Item.Always Show Inventory", function()
        -- upvalues: (ref) v_u_8, (ref) v_u_5, (ref) v_u_76, (ref) v_u_84
        local v234 = v_u_8.Get(v_u_5, "Settings.Game.Item.Always Show Inventory") ~= false
        v_u_76()
        if not v234 then
            v_u_84()
        end
    end)
    task.wait(0.1)
    if v_u_8.Get(v_u_5, "Settings.Game.Item.Always Show Inventory") == false then
        v_u_84()
    end
end
return v1
