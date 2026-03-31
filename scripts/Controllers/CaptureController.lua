-- MODULESCRIPT: CaptureController
-- Original Path: game.BAC - 52212.Controllers.CaptureController
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("CaptureService")
function v1.CaptureScreenshot(p_u_4)
    -- upvalues: (copy) v_u_2, (copy) v_u_3
    return require(v_u_2.Shared.Promise).new(function(p_u_5, p6)
        -- upvalues: (ref) v_u_3, (copy) p_u_4
        local v8, v9 = pcall(function()
            -- upvalues: (ref) v_u_3, (ref) p_u_4, (copy) p_u_5
            v_u_3:CaptureScreenshot(function(p7)
                -- upvalues: (ref) p_u_4, (ref) p_u_5
                if p_u_4 then
                    p_u_4(p7)
                end
                p_u_5(p7)
            end)
        end)
        if not v8 then
            p6(v9)
        end
    end)
end
return v1
