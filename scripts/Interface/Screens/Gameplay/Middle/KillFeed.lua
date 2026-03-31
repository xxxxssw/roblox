-- MODULESCRIPT: KillFeed
-- Original Path: game.BAC - 52404.Interface.Screens.Gameplay.Middle.KillFeed
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("Debris")
require(script:WaitForChild("Types"))
local v_u_6 = require(v_u_2.Database.Security.Remotes)
local v_u_7 = require(v_u_2.Database.Components.GameState)
local v_u_8 = v_u_4.LocalPlayer
local v_u_9 = nil
local v_u_10 = {}
local v_u_11 = {
    [2] = "got a Multi Kill",
    [3] = "is on a Killing Spree",
    [4] = "is on a Rampage",
    [5] = "is Dominating",
    [6] = "got a M-M-Monster Kill",
    [7] = "is going Ludicrus",
    [8] = "is Unstoppable",
    [9] = "is Godlike"
}
local function v_u_17(p12, p13, p14)
    -- upvalues: (copy) v_u_4, (copy) v_u_8
    if p14 then
        local v15 = v_u_4:GetPlayerByUserId(p14)
        if not (v15 and v15:IsDescendantOf(v_u_4)) then
            p13.Visible = false
            return
        end
        local v16 = v15:GetAttribute("Team")
        p13.Text = v15.DisplayName
        p13.Visible = true
        if v_u_8.UserId == p14 then
            p12.UIStroke.Color = Color3.fromRGB(255, 0, 0)
        end
        if v16 == "Counter-Terrorists" then
            p13.TextColor3 = Color3.fromRGB(165, 183, 212)
            return
        end
        if v16 == "Terrorists" then
            p13.TextColor3 = Color3.fromRGB(219, 199, 126)
            return
        end
    end
end
local function v_u_27(p18, p19)
    -- upvalues: (copy) v_u_2, (ref) v_u_9, (copy) v_u_4, (copy) v_u_8, (copy) v_u_5, (copy) v_u_3
    local v_u_20 = v_u_2.Assets.UI.KillFeed.Kill:Clone()
    v_u_20.Parent = v_u_9
    local v21 = v_u_20.Contents
    v21.Weapon.Visible = false
    v21.Headshot.Visible = false
    v21.NoScope.Visible = false
    v21.Smoke.Visible = false
    v21.Wallbang.Visible = false
    v21.Blind.Visible = false
    v21.Jump.Visible = false
    v21.FlashAssist.Visible = false
    v21.Addition.Visible = false
    v21.Assistor.Visible = false
    v21.Enemy.Visible = false
    local v22 = v21:FindFirstChild("UIPadding")
    if not v22 then
        v22 = Instance.new("UIPadding")
        v22.Parent = v21
    end
    v22.PaddingLeft = UDim.new(0, 5)
    v22.PaddingRight = UDim.new(0, 5)
    local v23 = v21.Player
    local v24 = v_u_4:GetPlayerByUserId(p18)
    if v24 and v24:IsDescendantOf(v_u_4) then
        v23.Text = v24.DisplayName
        v23.Visible = true
        if p18 == v_u_8.UserId then
            v_u_20.UIStroke.Color = Color3.fromRGB(255, 0, 0)
        end
        local v25 = v24:GetAttribute("Team")
        if v25 == "Counter-Terrorists" then
            v23.TextColor3 = Color3.fromRGB(165, 183, 212)
        elseif v25 == "Terrorists" then
            v23.TextColor3 = Color3.fromRGB(219, 199, 126)
        end
        local v26 = v21.Enemy
        v26.Text = p19
        v26.TextColor3 = Color3.fromRGB(255, 255, 255)
        v26.Visible = true
        v23.LayoutOrder = 0
        v26.LayoutOrder = 1
        v_u_20.Visible = true
        task.delay(5, function()
            -- upvalues: (ref) v_u_3, (copy) v_u_20, (ref) v_u_5
            v_u_3:Create(v_u_20, TweenInfo.new(1), {
                ["GroupTransparency"] = 1
            }):Play()
            v_u_3:Create(v_u_20.UIStroke, TweenInfo.new(1), {
                ["Transparency"] = 1
            }):Play()
            v_u_5:AddItem(v_u_20, 1)
        end)
    else
        v_u_5:AddItem(v_u_20, 0)
    end
end
function v_u_1.createTemplate(p28)
    -- upvalues: (copy) v_u_2, (ref) v_u_9, (copy) v_u_17, (copy) v_u_3, (copy) v_u_5
    local v29 = require(v_u_2.Database.Custom.Weapons[p28.Weapon])
    v_u_9.Visible = true
    local v_u_30 = v_u_2.Assets.UI.KillFeed.Kill:Clone()
    v_u_30.Parent = v_u_9
    local v31 = v_u_30.Contents:FindFirstChild("UIPadding")
    if not v31 then
        v31 = Instance.new("UIPadding")
        v31.Parent = v_u_30.Contents
    end
    v31.PaddingLeft = UDim.new(0, 5)
    v31.PaddingRight = UDim.new(0, 5)
    local v32 = v_u_17
    local v33 = v_u_30.Contents.Player
    local v34 = p28.Killer
    v32(v_u_30, v33, (tonumber(v34)))
    local v35 = v_u_17
    local v36 = v_u_30.Contents.Enemy
    local v37 = p28.Victim
    v35(v_u_30, v36, (tonumber(v37)))
    if p28.Assistor then
        local v38 = v_u_17
        local v39 = v_u_30.Contents.Assistor
        local v40 = p28.Assistor
        v38(v_u_30, v39, (tonumber(v40)))
        v_u_30.Contents.Addition.Visible = true
        v_u_30.Contents.FlashAssist.Visible = p28.FlashAssist == true
    else
        v_u_30.Contents.Assistor.Visible = false
        v_u_30.Contents.Addition.Visible = false
        v_u_30.Contents.FlashAssist.Visible = false
    end
    v_u_30.Contents.Weapon.Image = v29.ReverseIcon
    v_u_30.Contents.Headshot.Visible = p28.Headshot
    v_u_30.Contents.NoScope.Visible = p28.NoScope == true
    v_u_30.Contents.Smoke.Visible = p28.Smoke == true
    v_u_30.Contents.Blind.Visible = p28.Blind == true
    v_u_30.Contents.Wallbang.Visible = p28.Wallbang == true
    v_u_30.Contents.Jump.Visible = p28.Jump == true
    local function v43()
        -- upvalues: (copy) v_u_30
        local v41 = v_u_30.Contents.Player
        if v41 and v41.AbsoluteSize.Y > 0 then
            local v42 = v41.AbsoluteSize.Y * 0.84 * 1.67
            v_u_30.Contents.Headshot.Size = UDim2.new(0, v42, 0, v42)
            v_u_30.Contents.NoScope.Size = UDim2.new(0, v42 * 0.8333333333333334, 0, v42 * 0.8333333333333334)
            v_u_30.Contents.Smoke.Size = UDim2.new(0, v42 * 1.1111111111111112, 0, v42 * 0.7777777777777778)
            v_u_30.Contents.Wallbang.Size = UDim2.new(0, v42 * 1.1111111111111112, 0, v42 * 1.1111111111111112)
            v_u_30.Contents.Blind.Size = UDim2.new(0, v42 * 0.8333333333333334, 0, v42 * 0.8333333333333334)
            v_u_30.Contents.Jump.Size = UDim2.new(0, v42, 0, v42)
            v_u_30.Contents.FlashAssist.Size = UDim2.new(0, v42, 0, v42)
        end
    end
    v43()
    v_u_30.Contents:GetPropertyChangedSignal("AbsoluteSize"):Connect(v43)
    local v44 = 0
    if p28.Blind == true then
        v_u_30.Contents.Blind.LayoutOrder = v44
        v44 = v44 + 1
    end
    v_u_30.Contents.Player.LayoutOrder = v44
    local v45 = v44 + 1
    if p28.Assistor then
        v_u_30.Contents.Addition.LayoutOrder = v45
        local v46 = v45 + 1
        if p28.FlashAssist == true then
            v_u_30.Contents.FlashAssist.LayoutOrder = v46
            v46 = v46 + 1
        end
        v_u_30.Contents.Assistor.LayoutOrder = v46
        v45 = v46 + 1
    end
    if p28.Jump == true then
        v_u_30.Contents.Jump.LayoutOrder = v45
        v45 = v45 + 1
    end
    v_u_30.Contents.Weapon.LayoutOrder = v45
    local v47 = v45 + 1
    if p28.NoScope == true then
        v_u_30.Contents.NoScope.LayoutOrder = v47
        v47 = v47 + 1
    end
    if p28.Smoke == true then
        v_u_30.Contents.Smoke.LayoutOrder = v47
        v47 = v47 + 1
    end
    if p28.Wallbang == true then
        v_u_30.Contents.Wallbang.LayoutOrder = v47
        v47 = v47 + 1
    end
    if p28.Headshot == true then
        v_u_30.Contents.Headshot.LayoutOrder = v47
        v47 = v47 + 1
    end
    v_u_30.Contents.Enemy.LayoutOrder = v47
    v_u_30.Visible = true
    task.delay(5, function()
        -- upvalues: (ref) v_u_3, (copy) v_u_30, (ref) v_u_5
        v_u_3:Create(v_u_30, TweenInfo.new(1), {
            ["GroupTransparency"] = 1
        }):Play()
        v_u_3:Create(v_u_30.UIStroke, TweenInfo.new(1), {
            ["Transparency"] = 1
        }):Play()
        v_u_5:AddItem(v_u_30, 1)
    end)
end
function v_u_1.Initialize(_, p48)
    -- upvalues: (ref) v_u_9, (copy) v_u_6, (copy) v_u_1, (copy) v_u_10, (copy) v_u_11, (copy) v_u_27, (copy) v_u_7
    v_u_9 = p48
    v_u_6.UI.UIPlayerKilled.Listen(function(p49)
        -- upvalues: (ref) v_u_1, (ref) v_u_10, (ref) v_u_11, (ref) v_u_27
        v_u_1.createTemplate(p49)
        if workspace:GetAttribute("Gamemode") == "Deathmatch" then
            local v50 = p49.Killer
            v_u_10[p49.Victim] = 0
            local v51 = (v_u_10[v50] or 0) + 1
            v_u_10[v50] = v51
            local v52 = v_u_11[math.min(v51, 9)]
            if v52 then
                v_u_27(tonumber(v50), v52)
            end
        end
    end)
    v_u_7.ListenToState(function()
        -- upvalues: (ref) v_u_10
        table.clear(v_u_10)
    end)
end
return v_u_1
