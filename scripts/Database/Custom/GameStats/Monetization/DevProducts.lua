-- MODULESCRIPT: DevProducts
-- Original Path: game.BAC - 48473.Database.Custom.GameStats.Monetization.DevProducts
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
require(v1.Database.Custom.Types)
local v_u_3 = require(v1.Database.Custom.Constants)
local v_u_4 = require(v1.Database.Security.Router)
local v_u_5 = v2:IsServer()
local v68 = {
    ["Refresh Missions"] = {
        ["DevProductId"] = 3509753152,
        ["OnPurchased"] = function(p6, p7)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v8 = v_u_5
            assert(v8, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Refresh Missions", p6, p7)
        end
    },
    ["+ 400 Credits"] = {
        ["DevProductId"] = 3543515479,
        ["OnPurchased"] = function(p9, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v10 = v_u_5
            assert(v10, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p9, 400)
        end
    },
    ["+ 950 Credits"] = {
        ["DevProductId"] = 3543515926,
        ["OnPurchased"] = function(p11, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v12 = v_u_5
            assert(v12, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p11, 950)
        end
    },
    ["+ 3,100 Credits"] = {
        ["DevProductId"] = 3543516192,
        ["OnPurchased"] = function(p13, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v14 = v_u_5
            assert(v14, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p13, 3100)
        end
    },
    ["+ 6,500 Credits"] = {
        ["DevProductId"] = 3543516540,
        ["OnPurchased"] = function(p15, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v16 = v_u_5
            assert(v16, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p15, 6500)
        end
    },
    ["+ 13,250 Credits"] = {
        ["DevProductId"] = 3543516770,
        ["OnPurchased"] = function(p17, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v18 = v_u_5
            assert(v18, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p17, 13250)
        end
    },
    ["+ 27,000 Credits"] = {
        ["DevProductId"] = 3543517001,
        ["OnPurchased"] = function(p19, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v20 = v_u_5
            assert(v20, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p19, 27000)
        end
    },
    ["+ 67,500 Credits"] = {
        ["DevProductId"] = 3543517199,
        ["OnPurchased"] = function(p21, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v22 = v_u_5
            assert(v22, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p21, 67500)
        end
    },
    ["Credits Starter Pack"] = {
        ["DevProductId"] = 3550800164,
        ["OnPurchased"] = function(p23, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v24 = v_u_5
            assert(v24, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Purchase Credits Starter Pack", p23)
        end
    },
    ["Gift + 400 Credits"] = {
        ["DevProductId"] = 3543518894,
        ["OnPurchased"] = function(p25, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v26 = v_u_5
            assert(v26, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Credits", p25, 400)
        end
    },
    ["Gift + 950 Credits"] = {
        ["DevProductId"] = 3543519307,
        ["OnPurchased"] = function(p27, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v28 = v_u_5
            assert(v28, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Credits", p27, 950)
        end
    },
    ["Gift + 3,100 Credits"] = {
        ["DevProductId"] = 3543519553,
        ["OnPurchased"] = function(p29, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v30 = v_u_5
            assert(v30, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Credits", p29, 3100)
        end
    },
    ["Gift + 6,500 Credits"] = {
        ["DevProductId"] = 3543519769,
        ["OnPurchased"] = function(p31, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v32 = v_u_5
            assert(v32, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Credits", p31, 6500)
        end
    },
    ["Gift + 13,250 Credits"] = {
        ["DevProductId"] = 3543520414,
        ["OnPurchased"] = function(p33, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v34 = v_u_5
            assert(v34, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Credits", p33, 13250)
        end
    },
    ["Gift + 27,000 Credits"] = {
        ["DevProductId"] = 3543520614,
        ["OnPurchased"] = function(p35, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v36 = v_u_5
            assert(v36, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Credits", p35, 27000)
        end
    },
    ["Gift + 67,500 Credits"] = {
        ["DevProductId"] = 3543520837,
        ["OnPurchased"] = function(p37, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_3, (copy) v_u_4
            local v38 = v_u_5
            assert(v38, "This function should only be called in studio.")
            local v39 = (require(game:GetService("ServerScriptService").Services.DataService).Get(p37, "Statistics.RobuxSpent") or 0) >= v_u_3.MINIMUM_CREDITS_FOR_SPECIAL_CREDITS_OPTION
            assert(v39, "Player has not met the minimum spending requirement.")
            return v_u_4.broadcastRouter("Gift Credits", p37, 67500)
        end
    },
    ["Purchase Featured Bundle"] = {
        ["DevProductId"] = 3559942103,
        ["OnPurchased"] = function(p40, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v41 = v_u_5
            assert(v41, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Purchase Featured Bundle", p40)
        end
    },
    ["USP-S | Tekko"] = {
        ["DevProductId"] = 3560105762,
        ["OnPurchased"] = function(p42, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v43 = v_u_5
            assert(v43, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Purchase Featured Package", p42, "USP-S | Tekko")
        end
    },
    ["M4A4 | Tekko"] = {
        ["DevProductId"] = 3560105992,
        ["OnPurchased"] = function(p44, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v45 = v_u_5
            assert(v45, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Purchase Featured Package", p44, "M4A4 | Tekko")
        end
    },
    ["AWP | Tekko"] = {
        ["DevProductId"] = 3560106175,
        ["OnPurchased"] = function(p46, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v47 = v_u_5
            assert(v47, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Purchase Featured Package", p46, "AWP | Tekko")
        end
    },
    ["AWP | High Octane"] = {
        ["DevProductId"] = 3535995013,
        ["OnPurchased"] = function(p48, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v49 = v_u_5
            assert(v49, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Purchase Featured Package", p48, "AWP | High Octane")
        end
    },
    ["Desert Eagle | High Octane"] = {
        ["DevProductId"] = 3535993503,
        ["OnPurchased"] = function(p50, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v51 = v_u_5
            assert(v51, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Purchase Featured Package", p50, "Desert Eagle | High Octane")
        end
    },
    ["MP9 | High Octane"] = {
        ["DevProductId"] = 3535993672,
        ["OnPurchased"] = function(p52, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v53 = v_u_5
            assert(v53, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Purchase Featured Package", p52, "MP9 | High Octane")
        end
    },
    ["Gift Featured Bundle"] = {
        ["DevProductId"] = 3559942352,
        ["OnPurchased"] = function(p54, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v55 = v_u_5
            assert(v55, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Featured Bundle", p54)
        end
    },
    ["Gift USP-S | Tekko"] = {
        ["DevProductId"] = 3560105878,
        ["OnPurchased"] = function(p56, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v57 = v_u_5
            assert(v57, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Featured Package", p56, "USP-S | Tekko")
        end
    },
    ["Gift M4A4 | Tekko"] = {
        ["DevProductId"] = 3560106106,
        ["OnPurchased"] = function(p58, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v59 = v_u_5
            assert(v59, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Featured Package", p58, "M4A4 | Tekko")
        end
    },
    ["Gift AWP | Tekko"] = {
        ["DevProductId"] = 3560106396,
        ["OnPurchased"] = function(p60, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v61 = v_u_5
            assert(v61, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Featured Package", p60, "AWP | Tekko")
        end
    },
    ["Gift AWP | High Octane"] = {
        ["DevProductId"] = 3535995438,
        ["OnPurchased"] = function(p62, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v63 = v_u_5
            assert(v63, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Featured Package", p62, "AWP | High Octane")
        end
    },
    ["Gift Desert Eagle | High Octane"] = {
        ["DevProductId"] = 3535995262,
        ["OnPurchased"] = function(p64, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v65 = v_u_5
            assert(v65, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Featured Package", p64, "Desert Eagle | High Octane")
        end
    },
    ["Gift MP9 | High Octane"] = {
        ["DevProductId"] = 3535995640,
        ["OnPurchased"] = function(p66, _)
            -- upvalues: (copy) v_u_5, (copy) v_u_4
            local v67 = v_u_5
            assert(v67, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Featured Package", p66, "MP9 | High Octane")
        end
    }
}
return table.freeze(v68)
