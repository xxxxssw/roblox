-- MODULESCRIPT: Votekick
-- Original Path: game.BAC - 48473.Database.Custom.GameStats.Settings.Votekick
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
return table.freeze({
    ["GetActiveTeam"] = function(p1)
        if p1 == "Counter-Terrorists" or p1 == "Terrorists" then
            return p1
        else
            return nil
        end
    end,
    ["IsFreeForAllGamemode"] = function(_)
        return true
    end,
    ["GetVoteMode"] = function(_)
        return "FFA"
    end,
    ["GetParticipantLabel"] = function(p2)
        return p2 == "FFA" and "players" or "teammates"
    end
})
