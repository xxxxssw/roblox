-- MODULESCRIPT: MenuState
-- Original Path: game.BAC - 17285.Interface.MenuState
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Lighting")
local v_u_4 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local v5 = require(v_u_2.Packages.Signal)
v_u_1.OnScreenChanged = v5.new()
v_u_1.OnInspectStateChanged = v5.new()
v_u_1.OnCaseSceneStateChanged = v5.new()
local v_u_6 = nil
local v_u_7 = nil
local v_u_8 = false
local v_u_9 = false
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = nil
function v_u_1.Initialize(p14)
    -- upvalues: (ref) v_u_12, (ref) v_u_13, (copy) v_u_3
    v_u_12 = p14
    local v15
    if v_u_13 then
        v15 = v_u_13
    else
        v_u_13 = v_u_3:FindFirstChild("Menu")
        v15 = v_u_13
    end
    v_u_13 = v15
end
function v_u_1.GetCurrentScreen()
    -- upvalues: (ref) v_u_6
    return v_u_6
end
function v_u_1.GetPreviousScreen()
    -- upvalues: (ref) v_u_7
    return v_u_7
end
function v_u_1.IsInspectActive()
    -- upvalues: (ref) v_u_8
    return v_u_8
end
function v_u_1.SetScreen(p16)
    -- upvalues: (copy) v_u_2, (ref) v_u_6, (ref) v_u_7, (copy) v_u_1
    local v17 = v_u_2:GetAttribute("Environment")
    if p16 ~= v_u_6 and (p16 ~= "Store" or v17 == "Production") then
        local v18 = v_u_6
        v_u_7 = v18
        v_u_6 = p16
        v_u_1.OnScreenChanged:Fire(v18, p16)
    end
end
function v_u_1.EnterInspect()
    -- upvalues: (ref) v_u_8, (ref) v_u_10, (ref) v_u_6, (copy) v_u_1
    if not v_u_8 then
        v_u_10 = v_u_6
        v_u_8 = true
        v_u_1.OnInspectStateChanged:Fire(true)
    end
end
function v_u_1.ExitInspect()
    -- upvalues: (ref) v_u_8, (copy) v_u_1, (ref) v_u_10
    if v_u_8 then
        v_u_8 = false
        v_u_1.OnInspectStateChanged:Fire(false)
        v_u_10 = nil
    end
end
function v_u_1.GetScreenBeforeInspect()
    -- upvalues: (ref) v_u_10
    return v_u_10
end
function v_u_1.IsCaseSceneActive()
    -- upvalues: (ref) v_u_9
    return v_u_9
end
function v_u_1.EnterCaseScene()
    -- upvalues: (ref) v_u_9, (ref) v_u_11, (ref) v_u_6, (copy) v_u_1
    if not v_u_9 then
        v_u_11 = v_u_6
        v_u_9 = true
        v_u_1.OnCaseSceneStateChanged:Fire(true)
    end
end
function v_u_1.ExitCaseScene()
    -- upvalues: (ref) v_u_9, (copy) v_u_1, (ref) v_u_11
    if v_u_9 then
        v_u_9 = false
        v_u_1.OnCaseSceneStateChanged:Fire(false)
        v_u_11 = nil
    end
end
function v_u_1.GetScreenBeforeCaseScene()
    -- upvalues: (ref) v_u_11
    return v_u_11
end
function v_u_1.SetBlurEnabled(p19)
    -- upvalues: (ref) v_u_13, (copy) v_u_3
    local v20
    if v_u_13 then
        v20 = v_u_13
    else
        v_u_13 = v_u_3:FindFirstChild("Menu")
        v20 = v_u_13
    end
    if v20 then
        v20.Enabled = p19
    end
end
function v_u_1.IsBlurEnabled()
    -- upvalues: (ref) v_u_13, (copy) v_u_3
    local v21
    if v_u_13 then
        v21 = v_u_13
    else
        v_u_13 = v_u_3:FindFirstChild("Menu")
        v21 = v_u_13
    end
    return v21 and v21.Enabled or false
end
function v_u_1.GetMenuFrame()
    -- upvalues: (ref) v_u_12, (copy) v_u_4
    if not v_u_12 then
        v_u_12 = v_u_4:FindFirstChild("MainGui")
    end
    if v_u_12 then
        return v_u_12:FindFirstChild("Menu")
    else
        return nil
    end
end
function v_u_1.GetMainGui()
    -- upvalues: (ref) v_u_12, (copy) v_u_4
    if not v_u_12 then
        v_u_12 = v_u_4:FindFirstChild("MainGui")
    end
    return v_u_12
end
return v_u_1
