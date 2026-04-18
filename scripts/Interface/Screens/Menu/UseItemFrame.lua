-- MODULESCRIPT: UseItemFrame
-- Original Path: game.BAC - 29052.Interface.Screens.Menu.UseItemFrame
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = require(v_u_2.Controllers.DataController)
local v_u_8 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_9 = require(v_u_2.Database.Components.Libraries.Cases)
local v_u_10 = require(v_u_2.Database.Components.Libraries.Collections)
local v_u_11 = require(v_u_2.Components.Common.GetResolvedSkinInformation)
local v_u_12 = require(v_u_2.Database.Security.Router)
local v_u_13 = require(v_u_2.Shared.CloseButtonRegistry)
local v14 = require(v_u_2.Packages.Signal)
local v_u_15 = require(v_u_2.Interface.MenuState)
local v_u_16 = require(v_u_2.Database.Custom.GameStats.UI.Inventory.Sort)
local v_u_17 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_18 = require(v_u_2.Database.Custom.GameStats.Grenades)
local v_u_19 = require(script.Actions)
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = nil
local v_u_23 = false
local v_u_24 = nil
local v_u_25 = nil
local v_u_26 = nil
local v_u_27 = false
local v_u_28 = {}
local v_u_29 = 0
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = nil
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = nil
v_u_1.OnItemSelected = v14.new()
v_u_1.OnClosed = v14.new()
local function v_u_41(p36, p37)
    -- upvalues: (copy) v_u_10, (ref) v_u_25
    local v38 = p36:GetChildren()
    for _, v39 in ipairs(v38) do
        if v39.ClassName == p37 then
            v39:Destroy()
        end
    end
    v_u_10.ObserveAvailableCollections(function(p40)
        -- upvalues: (ref) v_u_25
        v_u_25 = p40
    end)
end
local function v_u_47(p_u_42, p_u_43, _, p_u_44, p_u_45, _)
    -- upvalues: (copy) v_u_3, (copy) v_u_12, (ref) v_u_26, (copy) v_u_1
    p_u_43.MouseEnter:Connect(function()
        -- upvalues: (ref) v_u_3, (copy) p_u_43
        v_u_3:Create(p_u_43, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["BackgroundTransparency"] = 0.85
        }):Play()
    end)
    p_u_43.MouseLeave:Connect(function()
        -- upvalues: (ref) v_u_3, (copy) p_u_43
        v_u_3:Create(p_u_43, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["BackgroundTransparency"] = 1
        }):Play()
    end)
    p_u_43.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_12, (ref) v_u_26, (copy) p_u_44, (ref) v_u_1, (copy) p_u_45, (copy) p_u_42, (copy) p_u_43
        v_u_12.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_26 = p_u_44
        v_u_1.PopulateItems()
        p_u_45.Text = p_u_44
        for _, v46 in ipairs(p_u_42:GetChildren()) do
            if v46:IsA("TextButton") then
                v46.Frame.BackgroundTransparency = v46 == p_u_43 and 0 or 1
            end
        end
        p_u_42.Visible = false
    end)
end
local function v_u_71(p_u_48)
    -- upvalues: (copy) v_u_3
    local v_u_49 = p_u_48.Size
    local v50 = p_u_48.Button
    p_u_48.MouseEnter:Connect(function()
        -- upvalues: (ref) v_u_3, (copy) p_u_48, (copy) v_u_49
        local v51 = v_u_3
        local v52 = p_u_48
        local v53 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v54 = {}
        local v55 = v_u_49
        v54.Size = UDim2.new(v55.X.Scale * 0.95, v55.X.Offset, v55.Y.Scale * 0.95, v55.Y.Offset)
        v51:Create(v52, v53, v54):Play()
    end)
    p_u_48.MouseLeave:Connect(function()
        -- upvalues: (ref) v_u_3, (copy) p_u_48, (copy) v_u_49
        local v56 = v_u_3
        local v57 = p_u_48
        local v58 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v59 = {}
        local v60 = v_u_49
        v59.Size = UDim2.new(v60.X.Scale * 1, v60.X.Offset, v60.Y.Scale * 1, v60.Y.Offset)
        v56:Create(v57, v58, v59):Play()
    end)
    v50.MouseButton1Down:Connect(function()
        -- upvalues: (ref) v_u_3, (copy) p_u_48, (copy) v_u_49
        local v61 = v_u_3
        local v62 = p_u_48
        local v63 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v64 = {}
        local v65 = v_u_49
        v64.Size = UDim2.new(v65.X.Scale * 0.9, v65.X.Offset, v65.Y.Scale * 0.9, v65.Y.Offset)
        v61:Create(v62, v63, v64):Play()
    end)
    v50.MouseButton1Up:Connect(function()
        -- upvalues: (ref) v_u_3, (copy) p_u_48, (copy) v_u_49
        local v66 = v_u_3
        local v67 = p_u_48
        local v68 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v69 = {}
        local v70 = v_u_49
        v69.Size = UDim2.new(v70.X.Scale * 0.95, v70.X.Offset, v70.Y.Scale * 0.95, v70.Y.Offset)
        v66:Create(v67, v68, v69):Play()
    end)
end
local function v_u_97()
    -- upvalues: (ref) v_u_31
    if not (v_u_31 and v_u_31.Visible) then
        return 50
    end
    local v72 = v_u_31:FindFirstChildOfClass("UIGridLayout")
    if not v72 then
        return 50
    end
    local v73 = v_u_31.AbsoluteSize
    local v74 = v73.Y
    local v75 = v73.X
    local v76 = v72.CellSize
    local v77 = v72.CellPadding
    local v78 = v76.Y.Scale * v74 + v76.Y.Offset
    local v79 = v77.Y.Scale * v74 + v77.Y.Offset
    local v80 = v76.X.Scale * v75 + v76.X.Offset
    local v81 = v77.X.Scale * v75 + v77.X.Offset
    local v82 = v_u_31:FindFirstChildOfClass("UIPadding")
    local v83, v84, v85, v86
    if v82 then
        v83 = v82.PaddingTop.Scale * v74 + v82.PaddingTop.Offset
        v84 = v82.PaddingBottom.Scale * v74 + v82.PaddingBottom.Offset
        v85 = v82.PaddingLeft.Scale * v75 + v82.PaddingLeft.Offset
        v86 = v82.PaddingRight.Scale * v75 + v82.PaddingRight.Offset
    else
        v83 = 0
        v84 = 0
        v85 = 0
        v86 = 0
    end
    local v87 = v74 - v83 - v84
    local v88 = v75 - v85 - v86
    local v89 = v80 + v81
    local v90
    if v89 > 0 then
        local v91 = (v88 + v81) / v89
        local v92 = math.floor(v91)
        v90 = math.max(1, v92)
    else
        v90 = 1
    end
    local v93 = v78 + v79
    local v94
    if v93 > 0 then
        local v95 = (v87 + v79) / v93
        local v96 = math.floor(v95)
        v94 = math.max(1, v96)
    else
        v94 = 1
    end
    return v94 * v90 + v90
end
local function v_u_108()
    -- upvalues: (ref) v_u_31, (ref) v_u_20, (copy) v_u_1, (copy) v_u_10, (ref) v_u_25, (ref) v_u_29, (ref) v_u_28
    if v_u_31 then
        local function v99(p98)
            -- upvalues: (ref) v_u_20, (ref) v_u_1
            if v_u_20 then
                v_u_1.OnItemSelected:Fire(p98, v_u_20)
                v_u_1.Hide()
            end
        end
        v_u_10.ObserveAvailableCollections(function(p100)
            -- upvalues: (ref) v_u_25
            v_u_25 = p100
        end)
        local v101 = v_u_29 + 1
        local v102 = v_u_29 + 25
        local v103 = #v_u_28
        local v104 = math.min(v102, v103)
        for v105 = v101, v104 do
            local v106 = v_u_28[v105]
            if v106 and not v_u_31:FindFirstChild(v106._id) then
                v_u_1.CreateItemTemplate(v106, v99)
            end
        end
        v_u_10.ObserveAvailableCollections(function(p107)
            -- upvalues: (ref) v_u_25
            v_u_25 = p107
        end)
        v_u_29 = v104
    end
end
local function v_u_112()
    -- upvalues: (ref) v_u_31, (ref) v_u_29, (ref) v_u_28, (copy) v_u_108, (copy) v_u_10, (ref) v_u_25
    if v_u_31 then
        local v109 = v_u_31.CanvasPosition.Y
        local v110 = v_u_31.AbsoluteCanvasSize.Y - v_u_31.AbsoluteSize.Y
        if v110 > 0 and (v_u_29 < #v_u_28 and v110 - v109 < 200) then
            v_u_108()
        end
        v_u_10.ObserveAvailableCollections(function(p111)
            -- upvalues: (ref) v_u_25
            v_u_25 = p111
        end)
    end
end
local function v_u_133()
    -- upvalues: (ref) v_u_23, (ref) v_u_34, (copy) v_u_6, (ref) v_u_30, (ref) v_u_31, (ref) v_u_35, (copy) v_u_10, (ref) v_u_25, (ref) v_u_26, (copy) v_u_12, (copy) v_u_47, (ref) v_u_27, (copy) v_u_1, (ref) v_u_32, (ref) v_u_33, (copy) v_u_13, (ref) v_u_20, (copy) v_u_7, (copy) v_u_5, (copy) v_u_15, (copy) v_u_112
    if v_u_23 then
        return true
    end
    print("Initializing")
    v_u_34 = v_u_6:FindFirstChild("MainGui")
    if not v_u_34 then
        warn("[UseItemFrame] MainGui not found")
        return false
    end
    local v113 = v_u_34:FindFirstChild("Menu")
    if not v113 then
        warn("[UseItemFrame] Menu frame not found")
        return false
    end
    v_u_30 = v113:FindFirstChild("UseItemFrame")
    if not v_u_30 then
        warn("[UseItemFrame] UseItemFrame not found in Menu")
        return false
    end
    local v114 = v_u_30:FindFirstChild("Tabs")
    local v115 = v114 and v114:FindFirstChild("Inventory")
    if v115 then
        v_u_31 = v115:FindFirstChild("Container")
        v_u_35 = v115:FindFirstChild("Sort")
    end
    v_u_10.ObserveAvailableCollections(function(p116)
        -- upvalues: (ref) v_u_25
        v_u_25 = p116
    end)
    if v_u_35 then
        local v_u_117 = v_u_35:FindFirstChild("Button")
        if v_u_117 then
            local v118 = v_u_117:FindFirstChild("Frame"):FindFirstChild("TextLabel")
            if v118 then
                v118.Text = "Newest"
                v_u_26 = "Newest"
            end
            v_u_117.MouseButton1Click:Connect(function()
                -- upvalues: (copy) v_u_117, (ref) v_u_12
                local v119 = v_u_117:FindFirstChild("Options")
                if v119 then
                    v119.Visible = not v119.Visible
                    v_u_12.broadcastRouter("RunInterfaceSound", "UI Click")
                end
            end)
            local v120 = v_u_117:FindFirstChild("Options")
            local v121 = v_u_117:FindFirstChild("Frame"):FindFirstChild("TextLabel")
            if v120 and v121 then
                for _, v122 in {
                    "Alphabetical",
                    "Collection",
                    "Equipped",
                    "Newest",
                    "Quality",
                    "Type",
                    "Float"
                } do
                    local v123 = v120:FindFirstChild(v122)
                    if v123 then
                        v_u_47(v120, v123, nil, v122, v121, v_u_31)
                    end
                end
            end
        end
        local v124 = v_u_35:FindFirstChild("ReverseSort")
        if v124 then
            local v_u_125 = v124:FindFirstChildOfClass("ImageLabel")
            local function v126()
                -- upvalues: (ref) v_u_27, (copy) v_u_125, (ref) v_u_1, (ref) v_u_12
                v_u_27 = not v_u_27
                if v_u_125 then
                    v_u_125.Rotation = v_u_27 and 180 or 0
                end
                v_u_1.PopulateItems()
                v_u_12.broadcastRouter("RunInterfaceSound", "UI Click")
            end
            v124.Selectable = true
            v124.MouseButton1Click:Connect(v126)
            v124.Activated:Connect(function(p127)
                -- upvalues: (ref) v_u_27, (copy) v_u_125, (ref) v_u_1, (ref) v_u_12
                if p127 and p127.UserInputType == Enum.UserInputType.Gamepad1 then
                    v_u_27 = not v_u_27
                    if v_u_125 then
                        v_u_125.Rotation = v_u_27 and 180 or 0
                    end
                    v_u_1.PopulateItems()
                    v_u_12.broadcastRouter("RunInterfaceSound", "UI Click")
                end
            end)
        end
    end
    v_u_10.ObserveAvailableCollections(function(p128)
        -- upvalues: (ref) v_u_25
        v_u_25 = p128
    end)
    local v129 = v_u_30:FindFirstChild("Top")
    if v129 then
        v_u_32 = v129:FindFirstChild("TextLabel")
        v_u_33 = v129:FindFirstChild("Close")
        if not v_u_33 then
            return
        end
        v_u_13.Add(v_u_30, v_u_33, function()
            -- upvalues: (ref) v_u_12, (ref) v_u_1, (ref) v_u_20
            v_u_12.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_1.OnClosed:Fire(v_u_20)
            v_u_1.Hide()
        end)
    end
    v_u_10.ObserveAvailableCollections(function(p130)
        -- upvalues: (ref) v_u_25
        v_u_25 = p130
    end)
    v_u_7.CreateListener(v_u_5, "Inventory", function(_)
        -- upvalues: (ref) v_u_1
        if v_u_1.IsVisible() then
            v_u_1.PopulateItems()
        end
    end)
    v_u_15.OnScreenChanged:Connect(function(_, _)
        -- upvalues: (ref) v_u_1, (ref) v_u_20
        if v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_20)
            v_u_1.Hide()
        end
    end)
    v_u_15.OnInspectStateChanged:Connect(function(p131)
        -- upvalues: (ref) v_u_1, (ref) v_u_20
        if p131 and v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_20)
            v_u_1.Hide()
        end
    end)
    v_u_15.OnCaseSceneStateChanged:Connect(function(p132)
        -- upvalues: (ref) v_u_1, (ref) v_u_20
        if p132 and v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_20)
            v_u_1.Hide()
        end
    end)
    if v_u_31 then
        v_u_31:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            -- upvalues: (ref) v_u_112
            v_u_112()
        end)
    end
    v_u_23 = true
    return true
end
function v_u_1.CreateItemTemplate(p_u_134, p_u_135)
    -- upvalues: (ref) v_u_31, (copy) v_u_9, (copy) v_u_11, (copy) v_u_17, (copy) v_u_8, (copy) v_u_2, (copy) v_u_12, (ref) v_u_22, (ref) v_u_24, (copy) v_u_71
    if not (p_u_134 and p_u_134._id) then
        return
    end
    if not v_u_31 then
        return
    end
    local v136 = p_u_134.Type == "Case"
    local v137 = v136 and v_u_9.GetCaseByName(p_u_134.Skin) or v_u_11(p_u_134.Name, p_u_134.Skin)
    if not v137 then
        return
    end
    local v138 = v_u_17[v136 and v137.caseRarity or v137.rarity]
    local v139 = nil
    if v136 then
        v139 = v137.imageAssetId or ""
    elseif p_u_134.Type == "Charm" then
        local v140 = p_u_134.Pattern
        if v140 and v137.charmImages then
            for _, v141 in ipairs(v137.charmImages) do
                if v141.pattern == v140 then
                    v139 = v141.assetId
                    break
                end
            end
        end
        if not v139 then
            v139 = v137.imageAssetId or ""
        end
    else
        v139 = v_u_8.GetWearImageForFloat(v137, p_u_134.Float or 0.9999) or (v137.imageAssetId or "")
    end
    local v_u_142 = v_u_2.Assets.UI.Inventory.ItemTemplate:Clone()
    v_u_142.Main.RarityFrame.UIGradient.Color = v138.ColorSequence
    v_u_142.Main.Glow.UIGradient.Color = v138.ColorSequence
    v_u_142.Parent = v_u_31
    v_u_142.Main.Icon.Image = v139
    v_u_142.Name = p_u_134._id
    local v143 = p_u_134.StatTrack and "KillTrak\226\132\162 " .. p_u_134.Name or p_u_134.Name
    v_u_142.Information.Weapon.Text = v143
    v_u_142.Information.Skin.Text = v136 and v137.skin or p_u_134.Skin
    if p_u_134.Type == "Charm" then
        v_u_142.Button.MouseButton2Click:Connect(function()
            -- upvalues: (ref) v_u_12, (copy) p_u_134
            v_u_12.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_12.broadcastRouter("WeaponInspect", p_u_134.Name, p_u_134.Skin, p_u_134.Float, p_u_134.StatTrack, p_u_134.NameTag, p_u_134.Charm, p_u_134.Stickers, p_u_134.Type, p_u_134.Pattern, p_u_134._id, p_u_134.Serial, p_u_134.IsTradeable)
        end)
    end
    v_u_142.Button.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_12, (copy) p_u_135, (copy) p_u_134
        v_u_12.broadcastRouter("RunInterfaceSound", "UI Click")
        p_u_135(p_u_134)
    end)
    v_u_142.MouseEnter:Connect(function()
        -- upvalues: (ref) v_u_22, (copy) v_u_142, (ref) v_u_24
        v_u_22 = v_u_142
        v_u_24 = tick()
    end)
    v_u_142.MouseLeave:Connect(function()
        -- upvalues: (ref) v_u_22, (ref) v_u_24
        v_u_22 = nil
        v_u_24 = nil
    end)
    v_u_71(v_u_142)
end
function v_u_1.PopulateItems()
    -- upvalues: (ref) v_u_31, (copy) v_u_41, (ref) v_u_29, (ref) v_u_28, (copy) v_u_7, (copy) v_u_5, (copy) v_u_18, (ref) v_u_21, (ref) v_u_20, (copy) v_u_10, (ref) v_u_25, (ref) v_u_26, (ref) v_u_35, (copy) v_u_16, (ref) v_u_27, (copy) v_u_1, (copy) v_u_97
    if v_u_31 then
        v_u_41(v_u_31, "Frame")
        v_u_29 = 0
        v_u_28 = {}
        local v144 = v_u_7.Get(v_u_5, "Inventory")
        if v144 and type(v144) == "table" then
            for _, v145 in ipairs(v144) do
                local v146
                if v145 then
                    v146 = v_u_18[v145.Name]
                else
                    v146 = v145
                end
                local v147
                if v145 then
                    v147 = v145.Type == "Case"
                else
                    v147 = v145
                end
                local v148 = v145 and (v145._id and v145.Name)
                if v148 then
                    v148 = v147 or v145.Skin
                end
                if v148 and not (v146 or v147) and (not (v_u_21 and v_u_20) or v_u_21(v145, v_u_20)) then
                    local v149 = v_u_28
                    table.insert(v149, v145)
                end
            end
            v_u_10.ObserveAvailableCollections(function(p150)
                -- upvalues: (ref) v_u_25
                v_u_25 = p150
            end)
            local v151 = v_u_26 or v_u_35 and v_u_35.Button.Frame.TextLabel.Text or "Newest"
            local v_u_152 = v_u_16.GetSortComparisonFunction(v151, v_u_5, function()
                -- upvalues: (ref) v_u_25
                return v_u_25
            end)
            if v_u_152 then
                if v_u_27 then
                    table.sort(v_u_28, function(p153, p154)
                        -- upvalues: (copy) v_u_152
                        local v155, v156 = v_u_152(p153, p154)
                        if v156 then
                            return v155
                        else
                            return v_u_152(p154, p153)
                        end
                    end)
                else
                    table.sort(v_u_28, v_u_152)
                end
            end
            local function v158(p157)
                -- upvalues: (ref) v_u_20, (ref) v_u_1
                if v_u_20 then
                    v_u_1.OnItemSelected:Fire(p157, v_u_20)
                    v_u_1.Hide()
                end
            end
            v_u_10.ObserveAvailableCollections(function(p159)
                -- upvalues: (ref) v_u_25
                v_u_25 = p159
            end)
            local v160 = v_u_97()
            local v161 = math.max(v160, 50)
            local v162 = #v_u_28
            local v163 = math.min(v161, v162)
            for v164 = 1, v163 do
                local v165 = v_u_28[v164]
                if v165 then
                    v_u_1.CreateItemTemplate(v165, v158)
                end
            end
            v_u_10.ObserveAvailableCollections(function(p166)
                -- upvalues: (ref) v_u_25
                v_u_25 = p166
            end)
            v_u_29 = v163
        end
    else
        return
    end
end
function v_u_1.Show(p167, p168)
    -- upvalues: (copy) v_u_133, (ref) v_u_30, (ref) v_u_20, (ref) v_u_21, (ref) v_u_32, (copy) v_u_10, (ref) v_u_25, (copy) v_u_1
    if v_u_133() then
        if v_u_30 then
            v_u_20 = p167
            v_u_21 = p168
            if v_u_32 then
                if p167.SourceItem then
                    local v169 = p167.SourceItem
                    local v170 = v169.Name
                    if v169.StatTrack then
                        v170 = "KillTrak\226\132\162 " .. v170
                    end
                    if v169.Skin then
                        v170 = v170 .. " | " .. v169.Skin
                    end
                    v_u_32.Text = ("Select an item to use with %*"):format(v170)
                elseif p167.Title then
                    v_u_32.Text = p167.Title
                else
                    v_u_32.Text = "Select an item"
                end
            end
            v_u_10.ObserveAvailableCollections(function(p171)
                -- upvalues: (ref) v_u_25
                v_u_25 = p171
            end)
            v_u_1.PopulateItems()
            v_u_30.Visible = true
        end
    else
        warn("[UseItemFrame] Failed to initialize")
        return
    end
end
function v_u_1.Hide()
    -- upvalues: (ref) v_u_30, (ref) v_u_20, (ref) v_u_21
    if v_u_30 then
        v_u_30.Visible = false
    end
    v_u_20 = nil
    v_u_21 = nil
end
function v_u_1.IsVisible()
    -- upvalues: (ref) v_u_30
    return v_u_30 and v_u_30.Visible or false
end
function v_u_1.GetCurrentContext()
    -- upvalues: (ref) v_u_20
    return v_u_20
end
v_u_1.Filters = {}
function v_u_1.Filters.WeaponsWithoutCharm(p172, _)
    if p172.Type ~= "Weapon" then
        return false
    end
    local v173
    if p172.Charm == nil or p172.Charm == false then
        v173 = false
    else
        local v174 = p172.Charm
        if type(v174) == "string" or p172.Charm == true then
            v173 = true
        else
            local v175 = p172.Charm
            v173 = type(v175) == "table"
        end
    end
    return not v173
end
local function v183(p176, _)
    -- upvalues: (copy) v_u_7, (copy) v_u_5, (copy) v_u_10, (ref) v_u_25
    if p176.Type ~= "Charm" then
        return false
    end
    local v177 = v_u_7.Get(v_u_5, "Inventory")
    if v177 then
        for _, v178 in ipairs(v177) do
            if v178.Charm then
                local v179 = v178.Charm
                local v180 = type(v179) == "table" and v178.Charm._id
                if not v180 then
                    local v181 = v178.Charm
                    if type(v181) == "string" then
                        v180 = v178.Charm
                    else
                        v180 = false
                    end
                end
                if v180 == p176._id then
                    return false
                end
            end
        end
    end
    v_u_10.ObserveAvailableCollections(function(p182)
        -- upvalues: (ref) v_u_25
        v_u_25 = p182
    end)
    return true
end
v_u_1.Filters.AllCharms = v183
function v_u_1.Filters.AllWeapons(p184, _)
    return p184.Type == "Weapon"
end
function v_u_1.Filters.AllMelees(p185, _)
    return p185.Type == "Melee"
end
function v_u_1.Filters.AllGloves(p186, _)
    return p186.Type == "Glove"
end
function v_u_1.Initialize(p187, p188)
    -- upvalues: (ref) v_u_34, (ref) v_u_30, (ref) v_u_31, (ref) v_u_35, (copy) v_u_10, (ref) v_u_25, (ref) v_u_26, (copy) v_u_12, (copy) v_u_47, (ref) v_u_32, (ref) v_u_33, (copy) v_u_13, (copy) v_u_1, (ref) v_u_20, (copy) v_u_112, (ref) v_u_23
    v_u_34 = p187
    v_u_30 = p188
    local v189 = p188:FindFirstChild("Tabs")
    local v190 = v189 and v189:FindFirstChild("Inventory")
    if v190 then
        v_u_31 = v190:FindFirstChild("Container")
        v_u_35 = v190:FindFirstChild("Sort")
    end
    v_u_10.ObserveAvailableCollections(function(p191)
        -- upvalues: (ref) v_u_25
        v_u_25 = p191
    end)
    if v_u_35 then
        local v_u_192 = v_u_35:FindFirstChild("Button")
        if v_u_192 then
            local v193 = v_u_192:FindFirstChild("Frame"):FindFirstChild("TextLabel")
            if v193 then
                v193.Text = "Newest"
                v_u_26 = "Newest"
            end
            v_u_192.MouseButton1Click:Connect(function()
                -- upvalues: (copy) v_u_192, (ref) v_u_12
                local v194 = v_u_192:FindFirstChild("Options")
                if v194 then
                    v194.Visible = not v194.Visible
                    v_u_12.broadcastRouter("RunInterfaceSound", "UI Click")
                end
            end)
            local v195 = v_u_192:FindFirstChild("Options")
            local v196 = v_u_192:FindFirstChild("Frame"):FindFirstChild("TextLabel")
            if v195 and v196 then
                for _, v197 in {
                    "Alphabetical",
                    "Collection",
                    "Equipped",
                    "Newest",
                    "Quality",
                    "Type",
                    "Float"
                } do
                    local v198 = v195:FindFirstChild(v197)
                    if v198 then
                        v_u_47(v195, v198, nil, v197, v196, v_u_31)
                    end
                end
            end
        end
    end
    v_u_10.ObserveAvailableCollections(function(p199)
        -- upvalues: (ref) v_u_25
        v_u_25 = p199
    end)
    local v200 = p188:FindFirstChild("Top")
    if v200 then
        v_u_32 = v200:FindFirstChild("TextLabel")
        v_u_33 = v200:FindFirstChild("Close")
        if not v_u_33 then
            return
        end
        v_u_13.Add(v_u_30, v_u_33, function()
            -- upvalues: (ref) v_u_12, (ref) v_u_1, (ref) v_u_20
            v_u_12.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_1.OnClosed:Fire(v_u_20)
            v_u_1.Hide()
        end)
    end
    v_u_10.ObserveAvailableCollections(function(p201)
        -- upvalues: (ref) v_u_25
        v_u_25 = p201
    end)
    if v_u_31 then
        v_u_31:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            -- upvalues: (ref) v_u_112
            v_u_112()
        end)
    end
    p188.Visible = false
    v_u_23 = true
end
function v_u_1.Start()
    -- upvalues: (copy) v_u_19, (copy) v_u_7, (copy) v_u_5, (copy) v_u_1, (copy) v_u_15, (ref) v_u_20
    v_u_19.InitializeAll()
    v_u_7.CreateListener(v_u_5, "Inventory", function(_)
        -- upvalues: (ref) v_u_1
        if v_u_1.IsVisible() then
            v_u_1.PopulateItems()
        end
    end)
    v_u_15.OnScreenChanged:Connect(function(_, _)
        -- upvalues: (ref) v_u_1, (ref) v_u_20
        if v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_20)
            v_u_1.Hide()
        end
    end)
    v_u_15.OnInspectStateChanged:Connect(function(p202)
        -- upvalues: (ref) v_u_1, (ref) v_u_20
        if p202 and v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_20)
            v_u_1.Hide()
        end
    end)
    v_u_15.OnCaseSceneStateChanged:Connect(function(p203)
        -- upvalues: (ref) v_u_1, (ref) v_u_20
        if p203 and v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_20)
            v_u_1.Hide()
        end
    end)
end
function v_u_1.TriggerAction(p204, p205)
    -- upvalues: (copy) v_u_19, (copy) v_u_1
    local v206 = v_u_19.Get(p204)
    if v206 then
        local v207 = v206.GetContext(p205)
        local v208 = v206.GetFilter(p205)
        v_u_1.Show(v207, v208)
    else
        warn((("[UseItemFrame] Unknown action type: %*"):format(p204)))
    end
end
function v_u_1.GetActions()
    -- upvalues: (copy) v_u_19
    return v_u_19
end
return v_u_1
