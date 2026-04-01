-- MODULESCRIPT: Skins
-- Original Path: game.BAC - 33020.Database.Components.Libraries.Skins
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("Players")
require(v_u_2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_5 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_6 = nil
local v7 = require(v_u_2.Packages.Signal)
local v_u_8 = v_u_2:WaitForChild("Assets")
local v_u_9 = v_u_8:WaitForChild("Weapons")
local v_u_10 = v_u_8:WaitForChild("Skins")
local v_u_11 = v7.new()
v_u_1.OnItemStockSchemasUpdated = v_u_11
local v_u_12 = {}
local v_u_13 = {}
local v_u_14 = {
    {
        ["max"] = 0.07,
        ["wear"] = "Factory New"
    },
    {
        ["max"] = 0.15,
        ["wear"] = "Minimal Wear"
    },
    {
        ["max"] = 0.38,
        ["wear"] = "Field-Tested"
    },
    {
        ["max"] = 0.45,
        ["wear"] = "Well-Worn"
    },
    {
        ["max"] = 1,
        ["wear"] = "Battle-Scarred"
    }
}
local function v_u_22(p15)
    -- upvalues: (ref) v_u_6, (copy) v_u_2, (copy) v_u_4
    if not v_u_6 then
        local v16, v17 = pcall(function()
            -- upvalues: (ref) v_u_2
            return require(v_u_2.Controllers.DataController)
        end)
        if v16 then
            v_u_6 = v17
        end
    end
    local v18 = v_u_6
    if not v18 then
        return nil
    end
    local v19 = v_u_4.LocalPlayer
    if not v19 then
        return nil
    end
    local v20 = v18.Get(v19, "Inventory")
    if not v20 or typeof(v20) ~= "table" then
        return nil
    end
    for _, v21 in ipairs(v20) do
        if v21._id == p15 and v21.Type == "Charm" then
            return {
                ["Skin"] = v21.Skin,
                ["Pattern"] = v21.Pattern
            }
        end
    end
    return nil
end
local function v_u_25(p23)
    -- upvalues: (copy) v_u_5
    local v24 = v_u_5(p23)
    return v24 and {
        ["paintId"] = "stock",
        ["type"] = v24.Class,
        ["name"] = p23,
        ["skin"] = "Stock",
        ["rarity"] = "Stock",
        ["floatRange"] = {
            ["min"] = 0,
            ["max"] = 0.07
        },
        ["floatChances"] = {
            {
                ["wear"] = "Factory New",
                ["chance"] = 100
            }
        },
        ["charmImages"] = {},
        ["wearImages"] = {},
        ["supportsStatTrak"] = false,
        ["statTrakChance"] = 0,
        ["isEnabled"] = true,
        ["isMarketplaceVisible"] = false,
        ["collection"] = nil,
        ["description"] = "Standard issue finish.",
        ["caseRarity"] = "Stock",
        ["imageAssetId"] = v24.Icon or v24.ReverseIcon
    } or nil
end
local function v_u_36(p26, p_u_27)
    -- upvalues: (copy) v_u_5
    local v28 = p26 or 0
    local v29 = typeof(v28) == "number"
    assert(v29, "KillCount must be a number")
    local v30, v31 = pcall(function(...)
        -- upvalues: (ref) v_u_5, (copy) p_u_27
        return v_u_5(p_u_27)
    end)
    if v30 and v31 then
        if v31.Class == "Melee" then
            local v32 = math.floor(v28)
            local v33 = math.clamp(v32, 0, 9999)
            return tostring(v33)
        else
            local v34 = math.floor(v28)
            local v35 = math.clamp(v34, 0, 999999)
            return string.format("%06d", v35)
        end
    else
        return nil
    end
end
local function v_u_43(p37, p38, p39)
    -- upvalues: (copy) v_u_10
    local v40 = v_u_10:FindFirstChild(p37)
    if v40 then
        if p39 and p37 == "Smoke Grenade" then
            local v41 = v40:FindFirstChild(p39)
            if v41 and v41:IsA("Folder") then
                return v41
            end
        end
        local v42 = v40:FindFirstChild(p38)
        if v42 and v42:IsA("Folder") then
            return v42
        else
            return nil
        end
    else
        return nil
    end
end
local function v_u_53(p44, p45)
    -- upvalues: (copy) v_u_14
    local v46 = p44.floatRange.min
    local v47 = p44.floatRange.max - 1e-12
    local v48 = math.max(v46, v47)
    local v49 = p44.floatRange.min
    local v50 = math.clamp(p45, v49, v48)
    local v51 = math.clamp(v50, 0, 1)
    for _, v52 in ipairs(v_u_14) do
        if v51 < v52.max then
            return v52.wear
        end
    end
    return "Battle-Scarred"
end
local function v_u_60(p54, p55, p56)
    -- upvalues: (copy) v_u_53, (copy) v_u_14
    if not (p54 and p54:IsA("Folder")) then
        warn("[SkinHandler] GetWearTextureFolder: Parent folder not found or invalid")
        return nil
    end
    local v57 = v_u_53(p55, p56)
    if v57 then
        v57 = p54:FindFirstChild(v57)
    end
    if v57 and v57:IsA("Folder") then
        return v57
    end
    for _, v58 in ipairs(v_u_14) do
        local v59 = p54:FindFirstChild(v58.wear)
        if v59 and v59:IsA("Folder") then
            return v59
        end
    end
    return nil
end
local function v_u_65(p61, p62)
    local v63 = {}
    for _, v64 in ipairs(p61:GetDescendants()) do
        if v64:IsA("MeshPart") and v64.Name == p62 then
            table.insert(v63, v64)
        end
    end
    return v63
end
local function v_u_76(p66, p67)
    -- upvalues: (copy) v_u_65
    local v68 = 0
    local v69 = 0
    local v70 = {}
    for _, v71 in ipairs(p67:GetChildren()) do
        if v71:IsA("SurfaceAppearance") then
            v68 = v68 + 1
            local v72 = v_u_65(p66, v71.Name)
            if #v72 > 0 then
                for _, v73 in ipairs(v72) do
                    local v74 = v73:FindFirstChildOfClass("SurfaceAppearance")
                    if v74 then
                        v74:Destroy()
                    end
                    v71:Clone().Parent = v73
                end
                v69 = v69 + 1
            else
                local v75 = v71.Name
                table.insert(v70, v75)
            end
        end
    end
    return v68, v69, v70
end
local function v_u_89(p77, p78, p79, p_u_80)
    -- upvalues: (copy) v_u_5, (copy) v_u_8, (copy) v_u_36
    local v81, v82 = pcall(function(...)
        -- upvalues: (ref) v_u_5, (copy) p_u_80
        return v_u_5(p_u_80)
    end)
    local v83 = v81 and (v82 and v82.Class == "Melee") and "KillTrackKnife" or "KillTrak"
    local v84 = v_u_8.Other[v83]:Clone()
    local v85 = p78.PrimaryPart
    if v85 then
        local v86 = p78:FindFirstChild("KillTrack", true)
        if v86 then
            local v87 = v84.PrimaryPart
            local v88 = Instance.new("WeldConstraint")
            v88.Part0 = v87
            v88.Part1 = v85
            v88.Parent = v87
            v84:PivotTo(v86.WorldCFrame)
            v84.Screen.SurfaceGui.TextLabel.Text = v_u_36(p79, p_u_80)
            v84.Parent = p77
        else
            v84:Destroy()
        end
    else
        v84:Destroy()
        return
    end
end
local function v_u_96(p90, p91, p92)
    -- upvalues: (copy) v_u_89
    local v93 = p90:FindFirstChild("Weapon")
    if v93 then
        v_u_89(p90, v93, p91, p92)
    else
        local v94 = p90:FindFirstChild("WeaponL")
        local v95 = p90:FindFirstChild("WeaponR")
        if v94 then
            v_u_89(p90, v94, p91, p92)
        end
        if v95 then
            v_u_89(p90, v95, p91, p92)
        end
    end
end
local function v_u_105(p97, p98, p99)
    -- upvalues: (copy) v_u_8
    local v100 = v_u_8.Other.NamePlate:Clone()
    local v101 = p98.PrimaryPart
    if v101 then
        local v102 = v101:FindFirstChild("Nametag")
        if v102 then
            local v103 = v100.PrimaryPart
            local v104 = Instance.new("WeldConstraint")
            v104.Part0 = v103
            v104.Part1 = v101
            v104.Parent = v103
            v100:PivotTo(v102.WorldCFrame)
            v100.Screen.SurfaceGui.TextLabel.Text = tostring(p99)
            v100.Parent = p97
        else
            v100:Destroy()
        end
    else
        v100:Destroy()
        return
    end
end
local function v_u_111(p106, p107)
    -- upvalues: (copy) v_u_105
    local v108 = p106:FindFirstChild("Weapon")
    if v108 then
        v_u_105(p106, v108, p107)
    else
        local v109 = p106:FindFirstChild("WeaponL")
        local v110 = p106:FindFirstChild("WeaponR")
        if v109 then
            v_u_105(p106, v109, p107)
        end
        if v110 then
            v_u_105(p106, v110, p107)
        end
    end
end
local function v_u_125(p112, p113, p114, p_u_115)
    -- upvalues: (copy) v_u_5, (copy) v_u_8, (copy) v_u_36
    local v116, v117 = pcall(function(...)
        -- upvalues: (ref) v_u_5, (copy) p_u_115
        return v_u_5(p_u_115)
    end)
    local v118 = v116 and (v117 and v117.Class == "Melee") and "KillTrackKnife" or "KillTrak"
    local v119 = v_u_8.Other[v118]:Clone()
    local v120 = p113.PrimaryPart
    if v120 then
        local v121 = p113:FindFirstChild("KillTrack", true)
        if v121 then
            local v122 = v119.PrimaryPart
            local v123 = Instance.new("WeldConstraint")
            v123.Part0 = v122
            v123.Part1 = v120
            v123.Parent = v122
            v119:PivotTo(v121.WorldCFrame)
            local v124 = v119.Screen.SurfaceGui
            v124.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
            v124.CanvasSize = Vector2.new(100, 25)
            v124.TextLabel.Text = v_u_36(p114, p_u_115)
            v124.TextLabel.TextSize = 29
            v124.TextLabel.Size = UDim2.fromScale(1, 1)
            v119.Parent = p112
        else
            v119:Destroy()
        end
    else
        v119:Destroy()
        return
    end
end
local function v_u_132(p126, p127, p128)
    -- upvalues: (copy) v_u_125
    local v129 = p126:FindFirstChild("Weapon")
    if v129 then
        v_u_125(p126, v129, p127, p128)
    else
        local v130 = p126:FindFirstChild("WeaponL")
        local v131 = p126:FindFirstChild("WeaponR")
        if v130 then
            v_u_125(p126, v130, p127, p128)
        end
        if v131 then
            v_u_125(p126, v131, p127, p128)
        end
    end
end
local function v_u_142(p133, p134, p135)
    -- upvalues: (copy) v_u_8
    local v136 = v_u_8.Other.NamePlate:Clone()
    local v137 = p134.PrimaryPart
    if v137 then
        local v138 = v137:FindFirstChild("Nametag")
        if v138 then
            local v139 = v136.PrimaryPart
            local v140 = Instance.new("WeldConstraint")
            v140.Part0 = v139
            v140.Part1 = v137
            v140.Parent = v139
            v136:PivotTo(v138.WorldCFrame)
            local v141 = v136.Screen.SurfaceGui
            v141.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
            v141.CanvasSize = Vector2.new(100, 8)
            v141.TextLabel.Text = tostring(p135)
            v141.TextLabel.TextSize = 8.98
            v141.TextLabel.Size = UDim2.fromScale(0.95, 1)
            v141.TextLabel.Position = UDim2.fromOffset(5, 0)
            v136.Parent = p133
        else
            v136:Destroy()
        end
    else
        v136:Destroy()
        return
    end
end
local function v_u_148(p143, p144)
    -- upvalues: (copy) v_u_142
    local v145 = p143:FindFirstChild("Weapon")
    if v145 then
        v_u_142(p143, v145, p144)
    else
        local v146 = p143:FindFirstChild("WeaponL")
        local v147 = p143:FindFirstChild("WeaponR")
        if v146 then
            v_u_142(p143, v146, p144)
        end
        if v147 then
            v_u_142(p143, v147, p144)
        end
    end
end
local function v_u_165(p149, p150, p151, p152)
    -- upvalues: (copy) v_u_8
    local v153 = v_u_8:FindFirstChild("Charms")
    local v154
    if v153 then
        v154 = v153:FindFirstChild("CharmBase")
    else
        v154 = v153
    end
    if v154 and v154:IsA("Model") then
        local v155 = v153:FindFirstChild(p150)
        if v155 then
            v155 = v155:FindFirstChild((tostring(p151)))
        end
        if v155 and v155:IsA("Model") then
            local v156 = p149:FindFirstChild("Charm" .. p152, true)
            if v156 then
                local v157 = v156.Parent
                if v157 and v157:IsA("BasePart") then
                    local v158 = v154:Clone()
                    v158.Parent = p149
                    v158:PivotTo(v156.WorldCFrame * CFrame.Angles(0, 0, 0))
                    if v158.PrimaryPart then
                        local v159 = v158.PrimaryPart
                        local v160 = Instance.new("WeldConstraint")
                        v160.Part0 = v159
                        v160.Part1 = v157
                        v160.Parent = v159
                    end
                    local v161 = v155:Clone()
                    v161.Parent = v158
                    local v162 = v158:FindFirstChild("Part")
                    if v162 and v162:IsA("BasePart") then
                        v161:PivotTo(v162.CFrame)
                        v162:Destroy()
                    end
                    local v163 = v158:FindFirstChild("HingeConstraint", true)
                    local v164 = v163 and (v161.PrimaryPart and v161.PrimaryPart:FindFirstChild("Attachment"))
                    if v164 then
                        v163.Attachment1 = v164
                    end
                end
            else
                print("Charm attachment not found for weapon:", p149.Name, p152)
                return
            end
        else
            warn("Specific charm not found for weapon:", p149.Name, p150, p151)
            return
        end
    else
        warn("Charm base not found for weapon:", p149.Name)
        return
    end
end
local function v_u_174(p166, p167)
    -- upvalues: (copy) v_u_22, (copy) v_u_165
    if typeof(p167) == "table" then
        if p167._id and p167.Position then
            local v168 = p167.Position
            local v169, v170
            if p167.Skin and p167.Pattern then
                v169 = p167.Skin
                v170 = p167.Pattern
            else
                local v171 = v_u_22(p167._id)
                if not v171 then
                    return
                end
                v169 = v171.Skin
                v170 = v171.Pattern
            end
            if v169 and v170 then
                if p166:FindFirstChild("Weapon") then
                    v_u_165(p166, v169, v170, v168)
                else
                    local v172 = p166:FindFirstChild("WeaponL")
                    local v173 = p166:FindFirstChild("WeaponR")
                    if v172 then
                        v_u_165(p166, v169, v170, v168)
                    end
                    if v173 then
                        v_u_165(p166, v169, v170, v168)
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
local function v_u_191(p175, p176, p177, p178)
    -- upvalues: (copy) v_u_8
    local v179 = v_u_8:FindFirstChild("Charms")
    local v180
    if v179 then
        v180 = v179:FindFirstChild("CharmBase")
    else
        v180 = v179
    end
    if v180 and v180:IsA("Model") then
        local v181 = v179:FindFirstChild(p176)
        if v181 then
            v181 = v181:FindFirstChild((tostring(p177)))
        end
        if v181 and v181:IsA("Model") then
            local v182 = p175:FindFirstChild("Charm" .. p178, true)
            if v182 then
                local v183 = v182.Parent
                if v183 and v183:IsA("BasePart") then
                    local v184 = v180:Clone()
                    v184.Parent = p175
                    v184:PivotTo(v182.WorldCFrame * CFrame.Angles(0, 0, 0))
                    if v184.PrimaryPart then
                        local v185 = v184.PrimaryPart
                        local v186 = Instance.new("WeldConstraint")
                        v186.Part0 = v185
                        v186.Part1 = v183
                        v186.Parent = v185
                    end
                    local v187 = v181:Clone()
                    v187.Parent = v184
                    local v188 = v184:FindFirstChild("Part")
                    if v188 and v188:IsA("BasePart") then
                        v187:PivotTo(v188.CFrame)
                        v188:Destroy()
                    end
                    local v189 = v184:FindFirstChild("HingeConstraint", true)
                    local v190 = v189 and (v187.PrimaryPart and v187.PrimaryPart:FindFirstChild("Attachment"))
                    if v190 then
                        v189.Attachment1 = v190
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
local function v_u_200(p192, p193)
    -- upvalues: (copy) v_u_22, (copy) v_u_191
    if typeof(p193) == "table" then
        if p193._id and p193.Position then
            local v194 = p193.Position
            local v195, v196
            if p193.Skin and p193.Pattern then
                v195 = p193.Skin
                v196 = p193.Pattern
            else
                local v197 = v_u_22(p193._id)
                if not v197 then
                    return
                end
                v195 = v197.Skin
                v196 = v197.Pattern
            end
            if v195 and v196 then
                if p192:FindFirstChild("Weapon") then
                    v_u_191(p192, v195, v196, v194)
                else
                    local v198 = p192:FindFirstChild("WeaponL")
                    local v199 = p192:FindFirstChild("WeaponR")
                    if v198 then
                        v_u_191(p192, v195, v196, v194)
                    end
                    if v199 then
                        v_u_191(p192, v195, v196, v194)
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
function v_u_1.GetCharmModel(p201, p202)
    -- upvalues: (copy) v_u_8
    local v203 = v_u_8:FindFirstChild("Charms")
    local v204
    if v203 then
        v204 = v203:FindFirstChild("CharmBase")
    else
        v204 = v203
    end
    if not (v204 and v204:IsA("Model")) then
        warn((("Skins.GetCharmModel: Charm base not found for charm \"%*\" with pattern \"%*\""):format(p201, p202)))
        return nil
    end
    local v205 = v203:FindFirstChild(p201)
    if v205 then
        v205 = v205:FindFirstChild((tostring(p202)))
    end
    if not (v205 and v205:IsA("Model")) then
        warn((("Skins.GetCharmModel: Specific charm not found for charm \"%*\" with pattern \"%*\""):format(p201, p202)))
        return nil
    end
    local v206 = v204:Clone()
    v206.Name = p201
    local v207 = v205:Clone()
    v207.Parent = v206
    local v208 = v206:FindFirstChild("Part")
    if v208 and v208:IsA("BasePart") then
        v207:PivotTo(v208.CFrame)
        v208:Destroy()
    end
    local v209 = v206:FindFirstChild("HingeConstraint", true)
    local v210 = v209 and (v207.PrimaryPart and v207.PrimaryPart:FindFirstChild("Attachment"))
    if v210 then
        v209.Attachment1 = v210
    end
    return v206
end
function v_u_1.GetBadgeModel(p211)
    -- upvalues: (copy) v_u_8
    local v212 = v_u_8:FindFirstChild("Badges")
    if not v212 then
        warn((("Skins.GetBadgeModel: Badges folder not found for badge \"%*\""):format(p211)))
        return nil
    end
    local v213 = v212:FindFirstChild(p211)
    if v213 and v213:IsA("Model") then
        return v213:Clone()
    end
    warn((("Skins.GetBadgeModel: Badge model not found for \"%*\""):format(p211)))
    return nil
end
function v_u_1.GetWearNameForFloat(p214, p215)
    -- upvalues: (copy) v_u_53
    return v_u_53(p214, p215)
end
function v_u_1.GetKillTrackValue(p216, p217)
    -- upvalues: (copy) v_u_36
    return v_u_36(p216, p217)
end
function v_u_1.GetMagazine(p218, p219, p220)
    -- upvalues: (copy) v_u_1, (ref) v_u_12, (copy) v_u_11, (copy) v_u_9, (copy) v_u_10, (copy) v_u_60, (copy) v_u_76
    local v221
    if typeof(p218) == "string" and (typeof(p219) == "string" and p218 ~= "") then
        v221 = p219 ~= ""
    else
        v221 = false
    end
    if not v221 then
        return nil
    end
    local v222 = v_u_1.GetSkinInformation(p218, p219)
    if not v222 and next(v_u_12) == nil then
        v_u_11:Wait()
        v222 = v_u_1.GetSkinInformation(p218, p219)
    end
    if not v222 then
        return nil
    end
    local v223 = v_u_9:FindFirstChild(p218)
    if not (v223 and v223:IsA("Folder")) then
        v223 = nil
    end
    if v223 then
        v223 = v223:FindFirstChild("Character")
    end
    if not (v223 and v223:IsA("Model")) then
        return nil
    end
    local v224 = {}
    for _, v225 in ipairs(v223:GetDescendants()) do
        if v225:IsA("BasePart") and v225:HasTag("CharacterMagazine") then
            table.insert(v224, v225)
        end
    end
    if #v224 == 0 then
        return nil
    end
    local v226 = Instance.new("Model")
    v226.Name = "Magazine"
    for _, v227 in ipairs(v224) do
        local v228 = v227:Clone()
        v228.Parent = v226
        if not v226.PrimaryPart then
            v226.PrimaryPart = v228
        end
    end
    local v229 = v_u_10:FindFirstChild(p218)
    local v230
    if v229 then
        v230 = v229:FindFirstChild(p219)
        if not (v230 and v230:IsA("Folder")) then
            v230 = nil
        end
    else
        v230 = nil
    end
    if v230 then
        v230 = v230:FindFirstChild("Character")
    end
    local v231 = v_u_60(v230, v222, p220 or v222.floatRange.min)
    if v231 then
        v_u_76(v226, v231)
    end
    return v226
end
function v_u_1.GetGloves(p232, p233, p234)
    -- upvalues: (copy) v_u_1, (ref) v_u_12, (copy) v_u_11, (copy) v_u_9, (copy) v_u_10, (copy) v_u_60, (copy) v_u_76
    local v235
    if typeof(p232) == "string" and (typeof(p233) == "string" and p232 ~= "") then
        v235 = p233 ~= ""
    else
        v235 = false
    end
    if not v235 then
        return nil
    end
    local v236 = v_u_1.GetSkinInformation(p232, p233)
    if not v236 and next(v_u_12) == nil then
        v_u_11:Wait()
        v236 = v_u_1.GetSkinInformation(p232, p233)
    end
    if not v236 then
        return nil
    end
    local v237 = v_u_9:FindFirstChild(p232)
    if not (v237 and v237:IsA("Folder")) then
        v237 = nil
    end
    if not v237 then
        return nil
    end
    local v238 = Instance.new("Model")
    v238.Name = p232
    for _, v239 in ipairs(v237:GetChildren()) do
        if v239:IsA("BasePart") then
            v239:Clone().Parent = v238
        end
    end
    local v240 = v_u_10:FindFirstChild(p232)
    local v241
    if v240 then
        v241 = v240:FindFirstChild(p233)
        if not (v241 and v241:IsA("Folder")) then
            v241 = nil
        end
    else
        v241 = nil
    end
    if v241 then
        v241 = v241:FindFirstChild("Camera")
    end
    local v242 = v_u_60(v241, v236, p234 or v236.floatRange.min)
    if v242 then
        v_u_76(v238, v242)
    end
    return v238
end
function v_u_1.GetCharacterModel(p243, p244, p245, p246, p247, p248, _, p249)
    -- upvalues: (copy) v_u_1, (ref) v_u_12, (copy) v_u_11, (copy) v_u_9, (copy) v_u_43, (copy) v_u_60, (copy) v_u_76, (copy) v_u_96, (copy) v_u_111, (copy) v_u_174
    local v250
    if typeof(p243) == "string" and (typeof(p244) == "string" and p243 ~= "") then
        v250 = p244 ~= ""
    else
        v250 = false
    end
    if not v250 then
        return nil
    end
    local v251 = v_u_1.GetSkinInformation(p243, p244)
    if not v251 and next(v_u_12) == nil then
        v_u_11:Wait()
        v251 = v_u_1.GetSkinInformation(p243, p244)
    end
    if not v251 then
        warn((("SkinHandler.GetCharacterModel: Skin \"%*\" not found for weapon \"%*\""):format(p244, p243)))
        return nil
    end
    local v252 = v_u_9:FindFirstChild(p243)
    if not (v252 and v252:IsA("Folder")) then
        v252 = nil
    end
    if v252 then
        v252 = v252:FindFirstChild("Character")
    end
    if not (v252 and v252:IsA("Model")) then
        warn((("SkinHandler.GetCharacterModel: Base character model not found for weapon \"%*\""):format(p243)))
        return nil
    end
    local v253 = v252:Clone()
    local v254 = v_u_43(p243, p244, p249)
    if v254 then
        v254 = v254:FindFirstChild("Character")
    end
    local v255 = v_u_60(v254, v251, p245 or v251.floatRange.max)
    if v255 then
        v_u_76(v253, v255)
    end
    if p246 then
        v_u_96(v253, p246, p243)
    end
    if p247 then
        v_u_111(v253, p247)
    end
    if p248 then
        v_u_174(v253, p248)
    end
    return v253
end
function v_u_1.GetWorldModel(p256, p257, p258, p259, p260, p261, _)
    -- upvalues: (copy) v_u_1, (ref) v_u_12, (copy) v_u_11, (copy) v_u_9, (copy) v_u_10, (copy) v_u_60, (copy) v_u_76, (copy) v_u_96, (copy) v_u_111, (copy) v_u_174
    local v262
    if typeof(p256) == "string" and (typeof(p257) == "string" and p256 ~= "") then
        v262 = p257 ~= ""
    else
        v262 = false
    end
    if not v262 then
        return nil
    end
    local v263 = v_u_1.GetSkinInformation(p256, p257)
    if not v263 and next(v_u_12) == nil then
        v_u_11:Wait()
        v263 = v_u_1.GetSkinInformation(p256, p257)
    end
    if not v263 then
        return nil
    end
    local v264 = v_u_9:FindFirstChild(p256)
    if not (v264 and v264:IsA("Folder")) then
        v264 = nil
    end
    if v264 then
        v264 = v264:FindFirstChild("Other")
    end
    if v264 then
        v264 = v264:FindFirstChild("World")
    end
    if not (v264 and v264:IsA("Model")) then
        return nil
    end
    local v265 = v264:Clone()
    local v266 = v_u_10:FindFirstChild(p256)
    local v267
    if v266 then
        v267 = v266:FindFirstChild(p257)
        if not (v267 and v267:IsA("Folder")) then
            v267 = nil
        end
    else
        v267 = nil
    end
    if v267 then
        v267 = v267:FindFirstChild("Character")
    end
    local v268 = v_u_60(v267, v263, p258 or v263.floatRange.max)
    if v268 then
        v_u_76(v265, v268)
    end
    if p259 then
        v_u_96(v265, p259, p256)
    end
    if p260 then
        v_u_111(v265, p260)
    end
    if p261 then
        v_u_174(v265, p261)
    end
    return v265
end
function v_u_1.GetCameraModel(p269, p270, p271, p272, p273, p274, _, p275)
    -- upvalues: (copy) v_u_1, (ref) v_u_12, (copy) v_u_11, (copy) v_u_9, (copy) v_u_43, (copy) v_u_60, (copy) v_u_76, (copy) v_u_132, (copy) v_u_148, (copy) v_u_200
    local v276
    if typeof(p269) == "string" and (typeof(p270) == "string" and p269 ~= "") then
        v276 = p270 ~= ""
    else
        v276 = false
    end
    if not v276 then
        return nil
    end
    local v277 = v_u_1.GetSkinInformation(p269, p270)
    if not v277 and next(v_u_12) == nil then
        v_u_11:Wait()
        v277 = v_u_1.GetSkinInformation(p269, p270)
    end
    if not v277 then
        return nil
    end
    local v278 = v_u_9:FindFirstChild(p269)
    if not (v278 and v278:IsA("Folder")) then
        v278 = nil
    end
    if v278 then
        v278 = v278:FindFirstChild("Camera")
    end
    if not (v278 and v278:IsA("Model")) then
        return nil
    end
    local v279 = v_u_43(p269, p270, p275)
    if v279 then
        v279 = v279:FindFirstChild("Camera")
    end
    local v280 = v_u_60(v279, v277, p271 or v277.floatRange.max)
    local v281 = v278:Clone()
    if v280 then
        v_u_76(v281, v280)
    end
    if p272 then
        v_u_132(v281, p272, p269)
    end
    if p273 then
        v_u_148(v281, p273)
    end
    if p274 then
        v_u_200(v281, p274)
    end
    return v281
end
function v_u_1.GetSkinInformation(p282, p283)
    -- upvalues: (ref) v_u_12, (copy) v_u_13, (copy) v_u_25
    local v284
    if typeof(p282) == "string" and (typeof(p283) == "string" and p282 ~= "") then
        v284 = p283 ~= ""
    else
        v284 = false
    end
    if not v284 then
        return nil
    end
    local v285 = v_u_12[p282]
    if v285 and v285[p283] then
        return v285[p283]
    end
    if p283 ~= "Stock" then
        return nil
    end
    local v286 = v_u_13[p282]
    if v286 and v286.Stock then
        return v286.Stock
    end
    local v287 = v_u_25(p282)
    if not v287 then
        return nil
    end
    local v288 = v286 or {}
    v288.Stock = v287
    v_u_13[p282] = v288
    return v287
end
function v_u_1.GetAllSkinsForWeapon(p289)
    -- upvalues: (ref) v_u_12
    if typeof(p289) ~= "string" or p289 == "" then
        return nil
    end
    local v290 = v_u_12[p289]
    if not v290 then
        return nil
    end
    local v291 = {}
    for _, v292 in pairs(v290) do
        table.insert(v291, v292)
    end
    return v291
end
function v_u_1.GetWearImageForFloat(p293, p294)
    -- upvalues: (copy) v_u_53
    local v295 = v_u_53(p293, p294)
    if not v295 then
        return nil
    end
    for _, v296 in ipairs(p293.wearImages) do
        if v296.wear == v295 then
            return v296.assetId
        end
    end
    return nil
end
function v_u_1.GetBaseWeaponModel(p297, p298)
    -- upvalues: (copy) v_u_9
    if typeof(p297) == "string" and p297 ~= "" then
        local v299 = v_u_9:FindFirstChild(p297)
        if not (v299 and v299:IsA("Folder")) then
            v299 = nil
        end
        if v299 then
            local v300 = v299:FindFirstChild(p298)
            if v300 and v300:IsA("Model") then
                return v300:Clone()
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
if v_u_2:GetAttribute("AvaiableSkins") then
    v_u_12 = v_u_3:JSONDecode((v_u_2:GetAttribute("AvaiableSkins")))
    if #v_u_11:GetConnections() > 0 then
        v_u_11:Fire(v_u_12)
    end
end
v_u_2:GetAttributeChangedSignal("AvaiableSkins"):Connect(function()
    -- upvalues: (copy) v_u_2, (ref) v_u_12, (copy) v_u_3, (copy) v_u_11
    local v301 = v_u_2:GetAttribute("AvaiableSkins")
    if v301 then
        v_u_12 = v_u_3:JSONDecode(v301)
        if #v_u_11:GetConnections() > 0 then
            v_u_11:Fire(v_u_12)
        end
    else
        return
    end
end)
return v_u_1
