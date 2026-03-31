-- MODULESCRIPT: Symbol
-- Original Path: game.BAC - 54247.Shared.Janitor.Symbol
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
return function(p_u_1)
    local v2 = newproxy(true)
    getmetatable(v2).__tostring = function()
        -- upvalues: (copy) p_u_1
        return p_u_1
    end
    return v2
end
