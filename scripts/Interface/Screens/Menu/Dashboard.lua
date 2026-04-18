-- MODULESCRIPT: Dashboard
-- Original Path: game.BAC - 29052.Interface.Screens.Menu.Dashboard
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {}
game:GetService("MarketplaceService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("PolicyService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("RunService")
local v6 = game:GetService("Players")
game:GetService("HttpService")
require(v_u_2.Database.Custom.Types)
local v_u_7 = require(v_u_2.Controllers.DataController)
local v_u_8 = require(v_u_2.Components.Common.InterfaceAnimations.ActivateButton)
local v_u_9 = require(v_u_2.Database.Security.Remotes)
local v_u_10 = require(v_u_2.Database.Security.Router)
require(v_u_2.Database.Custom.GameStats.Monetization.DevProducts)
local _ = require(v_u_2.Database.Custom.GameStats.MissionStars)
require(v_u_2.Database.Custom.GameStats.Missions)
local v11 = require(v_u_2.Database.Custom.Constants)
local v_u_12 = require(v_u_2.Interface.Screens.Menu.Store)
local v_u_13 = require(v_u_2.Interface.Screens.Menu.Top)
local v_u_14 = v6.LocalPlayer
local v_u_15 = { "News", "RedeemCode", "Verify" }
local v_u_16 = { "MedalEvent", "EditMobile" }
local v_u_17 = {
    ["isLinked"] = false,
    ["hasClipped"] = false
}
local v_u_18 = {}
local v_u_19 = 0
local v_u_20 = tick()
local v_u_21 = 1
local v_u_22 = {}
local v_u_23 = require(script.Parent:WaitForChild("EditMobile"))
ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 236, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 216, 141)) })
local v_u_24 = v11.EVENT_END_TIMES["MEDAL.TV"]
local v_u_25 = v11.ACTIVE_EVENTS["MEDAL.TV"]
local v_u_26 = Color3.fromRGB(255, 255, 255)
local v_u_27 = Color3.fromRGB(201, 201, 201)
local v_u_28 = Color3.fromRGB(50, 46, 46)
local v_u_29 = Color3.fromRGB(50, 46, 46)
Color3.fromRGB(255, 255, 255)
Color3.fromRGB(207, 207, 207)
ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 255, 157)), ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 225, 95)) })
ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 125, 125)), ColorSequenceKeypoint.new(1, Color3.fromRGB(65, 65, 65)) })
local v_u_30 = nil
local function v_u_35(p31)
    -- upvalues: (ref) v_u_30
    if v_u_30 then
        local v32 = v_u_30:FindFirstChild("Holder")
        if v32 then
            local v33 = v32:FindFirstChild("Missions")
            if v33 and v33:IsA("Frame") then
                v33.Visible = p31
            end
            local v34 = v32:FindFirstChild("MissionStars")
            if v34 and v34:IsA("Frame") then
                v34.Visible = p31
            end
        end
    else
        return
    end
end
local function v_u_41()
    -- upvalues: (ref) v_u_30, (copy) v_u_22, (ref) v_u_21, (copy) v_u_26, (copy) v_u_29, (copy) v_u_27, (copy) v_u_28
    local v36 = v_u_30.Container.News.Frame.Bottom.Frame
    local v37 = #v_u_22
    v36.Right.ImageColor3 = v37 > 1 and (v_u_21 < v37 and v_u_26) or v_u_29
    v36.Left.ImageColor3 = v_u_21 > 1 and v_u_26 or v_u_29
    for v38, v39 in ipairs(v_u_22) do
        v39.Visible = v38 == v_u_21
    end
    for _, v40 in ipairs(v36:GetChildren()) do
        if v40:IsA("Frame") and (v40.Name ~= "Left" and v40.Name ~= "Right") then
            v40.BackgroundColor3 = v40.Name == v_u_22[v_u_21].Name and v_u_27 or v_u_28
        end
    end
end
local function v_u_46(p42, p43)
    local v44 = p42:GetChildren()
    for _, v45 in ipairs(v44) do
        if v45:IsA("Frame") and not (table.find(p43, v45.Name) or table.find(p43, v45.ClassName)) then
            v45:Destroy()
        end
    end
end
local function v_u_55(p47, p48, p49)
    -- upvalues: (copy) v_u_4
    local v50 = p47:FindFirstChild("Bar")
    local v51 = v50 and v50:FindFirstChild("Frame")
    if v51 then
        local v52 = UDim2.fromScale(p48 and 1 or 0, 1)
        if p49 and p48 then
            v51.Size = UDim2.fromScale(0, 1)
            v_u_4:Create(v51, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = v52
            }):Play()
        else
            v51.Size = v52
        end
    end
    local v53 = p47:FindFirstChild("Button")
    if v53 then
        local v54 = v53:FindFirstChild("Title")
        if v54 then
            v54.Text = p48 and "COMPLETED" or "REFRESH"
        end
        v53.Active = not p48
    end
end
local function v_u_66(p56, p57, p58, p59, p60)
    -- upvalues: (ref) v_u_30, (copy) v_u_4
    local v61 = v_u_30.Holder.MedalEvent.Container.Frame.Rewards.Item.Frame.Progress.Content
    local v62 = v61:FindFirstChild("1")
    local v63 = v61:FindFirstChild("2")
    if v62 then
        local v64 = p56 and 0 or 0.75
        if p58 and p59 then
            v_u_4:Create(v62, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["BackgroundTransparency"] = v64
            }):Play()
        else
            v62.BackgroundTransparency = v64
        end
    end
    if v63 then
        local v65 = p57 and 0 or 0.75
        if p58 and p60 then
            v_u_4:Create(v63, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["BackgroundTransparency"] = v65
            }):Play()
            return
        end
        v63.BackgroundTransparency = v65
    end
end
local function v_u_86(p67)
    -- upvalues: (ref) v_u_30, (copy) v_u_2, (copy) v_u_7, (copy) v_u_14, (copy) v_u_17, (copy) v_u_66, (ref) v_u_18, (copy) v_u_8, (ref) v_u_19, (copy) v_u_10, (copy) v_u_9, (copy) v_u_55
    local v68 = v_u_30.Holder.MedalEvent.Container.Frame.ScrollingFrame
    local v69 = v_u_2.Assets.UI.MedalAssets
    local v70 = v_u_7.Get(v_u_14, "HasClaimedExclusiveMedalReward") == true
    local v_u_71 = v70 or v_u_14:GetAttribute("RobloxAccountLinkedToMedal") == true
    local v_u_72 = v70 or v_u_14:GetAttribute("HasClippedBloxStrike") == true
    local v73 = v_u_71 ~= v_u_17.isLinked
    local v74 = v_u_72 ~= v_u_17.hasClipped
    v_u_17.isLinked = v_u_71
    v_u_17.hasClipped = v_u_72
    v_u_66(v_u_71, v_u_72, p67, v73, v74)
    for _, v75 in ipairs(v68:GetChildren()) do
        if v75:IsA("Frame") then
            v75:Destroy()
        end
    end
    v_u_18 = {}
    local v76 = v69.Unlocked:Clone()
    v76.TextLabel.Text = "Link your Roblox account to your Medal account"
    v76.Name = "LinkAccount"
    v76.LayoutOrder = 1
    v76.Parent = v68
    v_u_18.LinkAccount = v76
    local v77 = v76.Button
    local function v_u_78()
        -- upvalues: (copy) v_u_71
        return v_u_71
    end
    v_u_8(v77)
    local v_u_79 = "link"
    v77.MouseButton1Click:Connect(function()
        -- upvalues: (copy) v_u_78, (ref) v_u_19, (ref) v_u_10, (ref) v_u_9, (copy) v_u_79
        if v_u_78() then
            return
        else
            local v80 = tick()
            if v80 - v_u_19 < 5 then
                v_u_10.broadcastRouter("CreateMenuNotification", "Error", "Please wait before refreshing again.")
            else
                v_u_19 = v80
                v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
                v_u_9.Collaborations.RefreshMedalStatus.Send(v_u_79)
            end
        end
    end)
    v_u_55(v76, v_u_71, p67 and v73)
    local v81
    if v_u_71 then
        v81 = v69.Unlocked:Clone()
        v81.TextLabel.Text = "Clip and upload your best BloxStrike moment"
        local v82 = v81.Button
        local function v_u_83()
            -- upvalues: (copy) v_u_72
            return v_u_72
        end
        v_u_8(v82)
        local v_u_84 = "clip"
        v82.MouseButton1Click:Connect(function()
            -- upvalues: (copy) v_u_83, (ref) v_u_19, (ref) v_u_10, (ref) v_u_9, (copy) v_u_84
            if v_u_83() then
                return
            else
                local v85 = tick()
                if v85 - v_u_19 < 5 then
                    v_u_10.broadcastRouter("CreateMenuNotification", "Error", "Please wait before refreshing again.")
                else
                    v_u_19 = v85
                    v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
                    v_u_9.Collaborations.RefreshMedalStatus.Send(v_u_84)
                end
            end
        end)
        v_u_55(v81, v_u_72, p67 and v74)
    else
        v81 = v69.Locked:Clone()
    end
    v81.Name = "ClipKill"
    v81.LayoutOrder = 2
    v81.Parent = v68
    v_u_18.ClipKill = v81
end
function v1.CreateMissionTemplate(_, _) end
function v1.AttemptMissionStarClaim(_) end
function v1.UpdateCurrentMissions(_) end
function v1.OpenMissionFrame(_) end
function v1.Initialize(p_u_87, p88)
    -- upvalues: (ref) v_u_30, (copy) v_u_23, (copy) v_u_35, (copy) v_u_25, (copy) v_u_24, (copy) v_u_46, (copy) v_u_12, (copy) v_u_22, (copy) v_u_10, (copy) v_u_13, (copy) v_u_2, (copy) v_u_28, (copy) v_u_41, (copy) v_u_3, (copy) v_u_14, (copy) v_u_8, (ref) v_u_20, (ref) v_u_21, (copy) v_u_9, (copy) v_u_7, (copy) v_u_15, (copy) v_u_4
    v_u_30 = p88
    v_u_23.Initialize(p_u_87, v_u_30)
    v_u_35(false)
    local v89 = v_u_30.Holder.MedalEvent
    local v90 = v_u_25
    if v90 then
        v90 = os.time() < v_u_24
    end
    v89.Visible = v90
    v_u_30.Holder.Advertisement.Visible = false
    v_u_46(v_u_30.Container.News.Frame.Bottom.Frame, { "UIListLayout", "Left", "Right" })
    for _, v_u_91 in ipairs(v_u_30.Container.News.Frame:GetChildren()) do
        if v_u_91:IsA("Frame") and string.find(v_u_91.Name, "NewsTab") then
            if v_u_91:GetAttribute("News") == "StarterPack" and not v_u_12.IsStarterPackAvailable() then
                v_u_91:Destroy()
            else
                local v92 = v_u_22
                table.insert(v92, v_u_91)
                v_u_91.Button.MouseButton1Click:Connect(function()
                    -- upvalues: (copy) v_u_91, (ref) v_u_10, (ref) v_u_13, (ref) v_u_12
                    local v93 = v_u_91.Button:GetAttribute("Page")
                    v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
                    if v93 == "Store" then
                        local v94 = v_u_91.Button:GetAttribute("Tab")
                        v_u_13.openFrame("Store")
                        if v94 == "Cases" or (v94 == "Credits" or v94 == "Featured") then
                            v_u_12.OpenTab(v94)
                            return
                        end
                    end
                end)
            end
        end
    end
    table.sort(v_u_22, function(p95, p96)
        local v97 = string.gsub(p95.Name, "NewsTab", "")
        local v98 = tonumber(v97)
        local v99 = string.gsub(p96.Name, "NewsTab", "")
        return (v98 or 0) < (tonumber(v99) or 0)
    end)
    local v100 = v_u_30.Container.News.Frame.Bottom.Frame
    v100.Right.LayoutOrder = 999
    v100.Left.LayoutOrder = 0
    for v101, v102 in ipairs(v_u_22) do
        local v103 = v_u_2.Assets.UI.News.TabFrame:Clone()
        v103.BackgroundColor3 = v_u_28
        v103.Name = v102.Name
        v103.Parent = v100
        v103.LayoutOrder = v101
    end
    v_u_41()
    local v104, v105 = pcall(function(...)
        -- upvalues: (ref) v_u_3, (ref) v_u_14
        return v_u_3:GetPolicyInfoForPlayerAsync(v_u_14)
    end)
    if v104 and (v105 and v105.AllowedExternalLinkReferences) then
        local v_u_106 = table.find(v105.AllowedExternalLinkReferences, "Discord") ~= nil
        v_u_30.Holder.Advertisement.Visible = v_u_106 or false
        local v107 = (table.find(v105.AllowedExternalLinkReferences, "Facebook") ~= nil or table.find(v105.AllowedExternalLinkReferences, "Twitter") ~= nil) and true or table.find(v105.AllowedExternalLinkReferences, "X") ~= nil
        v_u_30.Holder.Advertisement:GetPropertyChangedSignal("Visible"):Connect(function()
            -- upvalues: (ref) v_u_30, (copy) v_u_106, (copy) p_u_87
            if not v_u_30.Holder.Advertisement.Visible then
                local v108 = v_u_30.Holder.Advertisement
                local v109 = v_u_106
                if v109 then
                    v109 = p_u_87.Menu.Dashboard.Visible
                end
                v108.Visible = v109
            end
        end)
        p_u_87.Menu.Dashboard:GetPropertyChangedSignal("Visible"):Connect(function()
            -- upvalues: (copy) v_u_106, (copy) p_u_87, (ref) v_u_30
            local v110 = v_u_106
            if v110 then
                v110 = p_u_87.Menu.Dashboard.Visible
            end
            if v_u_30.Holder.Advertisement.Visible ~= v110 then
                v_u_30.Holder.Advertisement.Visible = v110
            end
        end)
        v_u_30.Container.RedeemCode.Frame.Container.Bottom.Info.Visible = v107 or false
        if v_u_30.Container.RedeemCode.Frame.Container.Bottom.Info.Visible then
            v_u_8(v_u_30.Container.RedeemCode.Frame.Container.Bottom.Info)
            v_u_30.Container.RedeemCode.Frame.Container.Bottom.Info.MouseButton1Click:Connect(function()
                -- upvalues: (ref) v_u_30, (ref) v_u_10
                v_u_30.RedeemCodeInfo.Visible = not v_u_30.RedeemCodeInfo.Visible
                v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
            end)
            v_u_8(v_u_30.RedeemCodeInfo.Container.Action.Close)
            v_u_30.RedeemCodeInfo.Container.Action.Close.MouseButton1Click:Connect(function()
                -- upvalues: (ref) v_u_10, (ref) v_u_30
                v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
                v_u_30.RedeemCodeInfo.Visible = false
            end)
        end
    else
        v_u_30.Container.RedeemCode.Frame.Container.Bottom.Info.Visible = false
        v_u_30.Holder.Advertisement.Visible = false
        v_u_30.RedeemCodeInfo.Visible = false
    end
    v_u_30.Container.News.Frame.Bottom.Frame.Left.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_10, (ref) v_u_20, (ref) v_u_22, (ref) v_u_21, (ref) v_u_41
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_20 = tick()
        if #v_u_22 > 0 then
            v_u_21 = (v_u_21 - 2) % #v_u_22 + 1
            v_u_41()
        end
    end)
    v_u_30.Container.News.Frame.Bottom.Frame.Right.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_10, (ref) v_u_20, (ref) v_u_22, (ref) v_u_21, (ref) v_u_41
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_20 = tick()
        if #v_u_22 > 0 then
            v_u_21 = v_u_21 % #v_u_22 + 1
            v_u_41()
        end
    end)
    v_u_8(v_u_30.Container.Reward.Frame.Button)
    v_u_30.Container.Reward.Frame.Button.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_10, (ref) v_u_9
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_9.Dashboard.RedeemLikeAndFavoriteReward.Send()
    end)
    v_u_8(v_u_30.Container.RedeemCode.Frame.Button)
    v_u_30.Container.RedeemCode.Frame.Button.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_7, (ref) v_u_14, (ref) v_u_10, (ref) v_u_30, (ref) v_u_9
        local v111 = v_u_7.Get(v_u_14, "Level")
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        if v111.Level >= 5 then
            local v112 = v_u_30.Container.RedeemCode.Frame.Container.Holder.TextBox.Text
            if tostring(v112) == "" then
                v_u_10.broadcastRouter("CreateMenuNotification", "Error", "Invalid code. Please try again.")
            else
                v_u_30.Container.RedeemCode.Frame.Container.Holder.TextBox.Text = ""
                v_u_9.Dashboard.RedeemCode.Send(v112)
            end
        else
            v_u_10.broadcastRouter("CreateMenuNotification", "Error", "You need to be atleast level 5 to redeem codes.")
            return
        end
    end)
    for _, v113 in ipairs(v_u_30.Container:GetChildren()) do
        if v113:IsA("Frame") then
            v113.Visible = table.find(v_u_15, v113.Name)
        end
    end
    local v_u_114 = v_u_30.Holder.MedalEvent
    local v_u_115 = v_u_114.Position
    local v_u_116 = false
    v_u_114.Position = v_u_115
    v_u_114.Container.Hide.Rotation = 180
    v_u_114.Container.Hide.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_116, (copy) v_u_114, (ref) v_u_4, (copy) v_u_115
        v_u_116 = not v_u_116
        if v_u_116 then
            v_u_114.Container.Hide.Rotation = 0
            v_u_4:Create(v_u_114, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["Position"] = UDim2.new(1.46, v_u_115.X.Offset, v_u_115.Y.Scale, v_u_115.Y.Offset)
            }):Play()
        else
            v_u_114.Container.Hide.Rotation = 180
            local v117 = {
                ["Position"] = v_u_115
            }
            v_u_4:Create(v_u_114, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v117):Play()
        end
    end)
end
function v1.Start()
    -- upvalues: (copy) v_u_35, (ref) v_u_30, (copy) v_u_16, (copy) v_u_25, (copy) v_u_24, (copy) v_u_5, (ref) v_u_20, (copy) v_u_22, (ref) v_u_21, (copy) v_u_41, (copy) v_u_12, (copy) v_u_7, (copy) v_u_14, (copy) v_u_86
    v_u_35(false)
    for _, v118 in ipairs(v_u_30.Holder:GetChildren()) do
        if v118:IsA("Frame") then
            local v119 = table.find(v_u_16, v118.Name) ~= nil and (v118.Name == "MedalEvent" and v_u_25)
            if v119 then
                v119 = os.time() < v_u_24
            end
            v118.Visible = v119
        end
    end
    v_u_5.Heartbeat:Connect(function(_)
        -- upvalues: (ref) v_u_20, (ref) v_u_30, (ref) v_u_22, (ref) v_u_21, (ref) v_u_41, (ref) v_u_12
        local v120 = tick() - v_u_20 >= 30
        if v_u_30.Visible and (#v_u_22 > 1 and v120) then
            v_u_21 = v_u_21 % #v_u_22 + 1
            v_u_20 = tick()
            v_u_41()
        end
        local v121 = v_u_30.Container.News.Frame:FindFirstChild("NewsTab2")
        local v122
        if v121 then
            v122 = v121:FindFirstChild("Timer")
        else
            v122 = v121
        end
        if v121 and (v122 and v121.Visible) then
            local v123 = v_u_12.GetStarterPackRemainingSeconds
            local v124 = math.max(0, v123())
            local v125 = string.format
            local v126 = v124 / 3600
            local v127 = math.floor(v126)
            local v128 = v124 % 3600 / 60
            v122.Text = v125("%02i:%02i:%02i", v127, math.floor(v128), v124 % 60)
        end
    end)
    v_u_7.CreateListener(v_u_14, "LikeAndFavoriteReward", function(p129)
        -- upvalues: (ref) v_u_30
        v_u_30.Container.Reward.Visible = not p129
    end)
    local v130 = v_u_25
    if v130 then
        v130 = os.time() < v_u_24
    end
    if v130 then
        v_u_86(false)
        v_u_14:GetAttributeChangedSignal("RobloxAccountLinkedToMedal"):Connect(function()
            -- upvalues: (ref) v_u_86
            v_u_86(true)
        end)
        v_u_14:GetAttributeChangedSignal("HasClippedBloxStrike"):Connect(function()
            -- upvalues: (ref) v_u_86
            v_u_86(true)
        end)
        v_u_7.CreateListener(v_u_14, "HasClaimedExclusiveMedalReward", function()
            -- upvalues: (ref) v_u_86
            v_u_86(false)
        end)
        local v_u_131 = v_u_30.Holder.MedalEvent.Container.Frame.Header.Timer
        v_u_5.Heartbeat:Connect(function(p132)
            -- upvalues: (ref) v_u_24, (ref) v_u_30, (copy) v_u_131
            local v133 = v_u_24 - os.time()
            local v134 = math.max(0, v133)
            if v134 <= 0 then
                v_u_30.Holder.MedalEvent.Visible = false
                return
            else
                local v135 = v134 / 86400
                local v136 = math.floor(v135)
                local v137 = v134 % 86400 / 3600
                local v138 = math.floor(v137)
                local v139 = v134 % 3600 / 60
                local v140 = math.floor(v139)
                local v141 = v134 % 60
                local v142 = v_u_30.Holder.MedalEvent.Container.Frame.Rewards.Item.Frame.Content.Outer.Icon.Glow
                v142.Rotation = v142.Rotation + p132 * 6.7
                if v136 >= 1 then
                    v_u_131.Text = string.format("%02i:%02i:%02i:%02i", v136, v138, v140, v141)
                else
                    v_u_131.Text = string.format("%02i:%02i:%02i", v138, v140, v141)
                end
            end
        end)
    else
        v_u_30.Holder.MedalEvent.Visible = false
    end
end
return v1
