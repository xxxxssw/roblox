-- MODULESCRIPT: Toggle
-- Original Path: game.BAC - 29052.Interface.Screens.Menu.Settings.Templates.Toggle
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.Types)
local v_u_2 = require(v1.Shared.Janitor)
require(v1.Database.Custom.GameStats.UI.Settings.Pages)
local v_u_3 = Color3.fromRGB(255, 255, 255)
return function(p_u_4, p5, p6, p7, p_u_8, p9, p_u_10, p_u_11)
    -- upvalues: (copy) v_u_2, (copy) v_u_3
    p_u_8.Name = p_u_4
    p_u_8.Title.Text = p5.DisplayName or p_u_4
    p_u_8.LayoutOrder = p7
    p_u_8.Button.Selectable = false
    local v_u_12 = p9
    local v_u_13 = v_u_2.new()
    v_u_13:Add(p_u_8, "Destroy")
    local v14 = v_u_12
    p_u_8.Button.ImageLabel.Visible = v14
    local v15 = p_u_8.Button.Border.UIStroke
    local v16
    if v14 then
        v16 = Color3.fromRGB(255, 255, 255)
    else
        v16 = Color3.fromRGB(100, 100, 100)
    end
    v15.Color = v16
    p_u_8.Title.TextColor3 = v_u_3
    v_u_13:Add(p_u_8.Button.MouseButton1Click:Connect(function()
        -- upvalues: (ref) v_u_12, (copy) p_u_8, (ref) v_u_3, (copy) p_u_10, (copy) p_u_11, (copy) p_u_4
        v_u_12 = not v_u_12
        local v17 = v_u_12
        p_u_8.Button.ImageLabel.Visible = v17
        local v18 = p_u_8.Button.Border.UIStroke
        local v19
        if v17 then
            v19 = Color3.fromRGB(255, 255, 255)
        else
            v19 = Color3.fromRGB(100, 100, 100)
        end
        v18.Color = v19
        p_u_8.Title.TextColor3 = v_u_3
        p_u_10(p_u_11, p_u_4, v_u_12)
    end), "Disconnect")
    p_u_8.Parent = p6
    return function()
        -- upvalues: (copy) v_u_13
        v_u_13:Cleanup()
    end
end
