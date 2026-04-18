-- MODULESCRIPT: Votekick
-- Original Path: game.BAC - 20621.Interface.Screens.Gameplay.Middle.Votekick
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("Players")
local v_u_6 = v_u_5.LocalPlayer
local v_u_7 = require(v2.Database.Security.Remotes)
local v_u_8 = require(v2.Database.Components.GameState)
local v_u_9 = require(v2.Components.Common.InterfaceAnimations.ActivateButton)
local v_u_10 = require(v2.Components.Common.GetUserPlatform)
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = false
function v_u_1.UpdateAmount(p14, p15, p16)
    -- upvalues: (ref) v_u_11, (copy) v_u_6
    v_u_11.Option[p14].Amount.Text = ("%*"):format(p15)
    if v_u_6.UserId == tonumber(p16) then
        local v17 = p14 == "Yes" and "rgb(90, 186, 55)" or "rgb(255,49,49)"
        v_u_11.Result.TextLabel.Text = ("You voted: <font color=\"%*\">%*</font>"):format(v17, (string.upper(p14)))
        v_u_11.Result.Visible = true
    end
end
function v_u_1.UpdateFrame(p18, p19)
    -- upvalues: (copy) v_u_5, (ref) v_u_11
    local v20 = v_u_5:GetPlayerByUserId(p18)
    local v21 = v_u_5:GetPlayerByUserId(p19)
    if v20 then
        v_u_11.Player.Text = ("Kick player: %*? "):format(v20.Name)
        v_u_11.Frame.Title.Text = ("Vote By: %*"):format(v21 and v21.Name or "Unknown")
        v_u_11.Option.Yes.Amount.Text = "0"
        v_u_11.Option.No.Amount.Text = "0"
    end
end
function v_u_1.OpenFrame(p22)
    -- upvalues: (ref) v_u_11, (ref) v_u_12, (ref) v_u_13, (copy) v_u_6, (copy) v_u_4
    v_u_11.Position = UDim2.fromScale(-0.08, 0.525)
    v_u_11:SetAttribute("IsVoteKickActive", true)
    v_u_11.Result.Visible = false
    v_u_12 = p22
    v_u_11.Visible = true
    v_u_13 = false
    if v_u_6.UserId == p22 then
        v_u_11.Result.TextLabel.Text = "You are being vote kicked."
        v_u_11.Result.Visible = true
    end
    v_u_4:Create(v_u_11, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromScale(0.08, 0.525)
    }):Play()
end
function v_u_1.CloseFrame()
    -- upvalues: (ref) v_u_11, (ref) v_u_12, (ref) v_u_13, (copy) v_u_4
    v_u_11:SetAttribute("IsVoteKickActive", false)
    v_u_11.Result.Visible = false
    v_u_12 = nil
    v_u_13 = false
    local v23 = v_u_4:Create(v_u_11, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromScale(-0.08, 0.525)
    })
    v23.Completed:Once(function()
        -- upvalues: (ref) v_u_11
        v_u_11.Visible = false
    end)
    v23:Play()
end
function v_u_1.CastVote(p24)
    -- upvalues: (ref) v_u_12, (copy) v_u_6, (ref) v_u_13, (copy) v_u_7
    if not v_u_12 or v_u_6.UserId ~= v_u_12 then
        if not v_u_13 then
            local v25 = p24 == "Yes" and v_u_7.VoteKick.VoteYes or v_u_7.VoteKick.VoteNo
            v_u_13 = true
            local v26 = v25.Send
            local v27 = {}
            local v28 = v_u_6.UserId
            v27.Voter = tostring(v28)
            v27.Amount = 0
            return v26(v27)
        end
    end
end
function v_u_1.Initialize(_, p29)
    -- upvalues: (ref) v_u_11, (copy) v_u_10, (copy) v_u_7, (copy) v_u_1, (copy) v_u_8, (ref) v_u_12, (ref) v_u_13, (copy) v_u_9, (copy) v_u_3
    v_u_11 = p29
    v_u_11:SetAttribute("IsVoteKickActive", false)
    local v30 = table.find(v_u_10(), "Mobile") ~= nil
    local v31 = v_u_11:FindFirstChild("Keybinds")
    local v32 = v_u_11:FindFirstChild("MobileNoButton")
    local v33 = v_u_11:FindFirstChild("MobileYesButton")
    if v31 then
        v31.Visible = not v30
    end
    if v32 then
        v32.Visible = v30
    end
    if v33 then
        v33.Visible = v30
    end
    v_u_7.VoteKick.VoteNoUpdate.Listen(function(p34)
        -- upvalues: (ref) v_u_1
        v_u_1.UpdateAmount("No", p34.Amount, p34.Voter)
    end)
    v_u_7.VoteKick.VoteYesUpdate.Listen(function(p35)
        -- upvalues: (ref) v_u_1
        v_u_1.UpdateAmount("Yes", p35.Amount, p35.Voter)
    end)
    v_u_7.VoteKick.StartVote.Listen(function(p36)
        -- upvalues: (ref) v_u_8, (ref) v_u_1
        local v37 = v_u_8.GetState()
        if v37 ~= "Game Ending" and v37 ~= "Map Voting" then
            local v38 = p36.TargetUserId
            local v39 = tonumber(v38)
            local v40 = p36.VoterUserId
            local v41 = tonumber(v40)
            v_u_1.UpdateFrame(v39, v41)
            v_u_1.OpenFrame(v39)
        end
    end)
    v_u_7.VoteKick.EndVote.Listen(function()
        -- upvalues: (ref) v_u_11, (ref) v_u_1
        if v_u_11.Visible then
            v_u_1.CloseFrame()
        end
    end)
    v_u_8.ListenToState(function(_, p42)
        -- upvalues: (ref) v_u_11, (ref) v_u_1, (ref) v_u_12, (ref) v_u_13
        if p42 == "Game Ending" and true or p42 == "Map Voting" then
            if v_u_11.Visible then
                v_u_1.CloseFrame()
            else
                v_u_11:SetAttribute("IsVoteKickActive", false)
                v_u_12 = nil
                v_u_13 = false
            end
        else
            return
        end
    end)
    if v30 and (v32 and v33) then
        v_u_9(v32)
        v_u_9(v33)
        v32.Activated:Connect(function()
            -- upvalues: (ref) v_u_1
            v_u_1.CastVote("No")
        end)
        v33.Activated:Connect(function()
            -- upvalues: (ref) v_u_1
            v_u_1.CastVote("Yes")
        end)
    end
    if not (v30 and (v32 and v33)) then
        v_u_3.InputBegan:Connect(function(p43, p44)
            -- upvalues: (ref) v_u_11, (ref) v_u_3, (ref) v_u_1
            if p44 then
                return
            elseif v_u_11.Visible then
                if v_u_3:GetFocusedTextBox() then
                    return
                elseif p43.UserInputType == Enum.UserInputType.Keyboard then
                    if p43.KeyCode == Enum.KeyCode.K then
                        v_u_1.CastVote("Yes")
                        return
                    elseif p43.KeyCode == Enum.KeyCode.L then
                        v_u_1.CastVote("No")
                    end
                else
                    return
                end
            else
                return
            end
        end)
    end
end
return v_u_1
