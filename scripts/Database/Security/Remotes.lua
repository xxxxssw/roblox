-- MODULESCRIPT: Remotes
-- Original Path: game.BAC - 29092.Database.Security.Remotes
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require(v_u_1.Database.Security.Network)
local v_u_4 = require(script:WaitForChild("DefinePacket"))
local function v11(p5, p6)
    -- upvalues: (copy) v_u_2, (copy) v_u_1
    if v_u_2:IsClient() then
        v_u_1:WaitForChild("NetworkRemotes"):WaitForChild(p5)
    end
    local v7 = p6()
    local v8 = {}
    for v9, v10 in pairs(v7) do
        if type(v10) == "function" then
            v8[v9] = v10(p5, v9)
        else
            v8[v9] = v10
        end
    end
    return table.freeze(v8)
end
return table.freeze({
    ["Collaborations"] = v11("Collaborations", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v12 = {
            ["ClaimExclusiveMedalReward"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Nothing
            }), {
                ["maximum_requests_per_second"] = 1
            }),
            ["RefreshMedalStatus"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.String
            }), {
                ["maximum_requests_per_second"] = 0.2
            })
        }
        return v12
    end),
    ["PlayerData"] = v11("PlayerData", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v13 = {
            ["RetrieveAllPlayerData"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Nothing
            }))
        }
        local v14 = v_u_4
        local v15 = v_u_3.DefinePacket
        local v16 = {
            ["Value"] = v_u_3.Struct({
                ["Player"] = v_u_3.Instance,
                ["Data"] = v_u_3.Unknown
            })
        }
        v13.PlayerDataEvent = v14(v15(v16))
        local v17 = v_u_4
        local v18 = v_u_3.DefinePacket
        local v19 = {
            ["Value"] = v_u_3.Struct({
                ["Data"] = v_u_3.Map(v_u_3.String, v_u_3.Unknown),
                ["Player"] = v_u_3.Instance
            })
        }
        v13.PlayerDataChanged = v17(v18(v19))
        return v13
    end),
    ["Player"] = v11("Player", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v20 = {}
        local v21 = v_u_4
        local v22 = v_u_3.DefinePacket
        local v23 = {
            ["Value"] = v_u_3.Struct({
                ["Path"] = v_u_3.String,
                ["Value"] = v_u_3.Unknown
            })
        }
        v20.UpdatePlayerSettings = v21(v22(v23), {
            ["maximum_requests_per_second"] = 3
        })
        local v24 = v_u_4
        local v25 = v_u_3.DefinePacket
        local v26 = {
            ["Value"] = v_u_3.Struct({
                ["Layout"] = v_u_3.Map(v_u_3.String, v_u_3.Unknown)
            })
        }
        v20.UpdateMobileButtons = v24(v25(v26), {
            ["maximum_requests_per_second"] = 1
        })
        v20.BlankRequest = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Float64
        }), {
            ["maximum_requests_per_second"] = 1
        })
        v20.ReportPlayerConnect = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }), {
            ["maximum_requests_per_second"] = 1
        })
        v20.SubmitUserPlatformAnalytics = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }), {
            ["maximum_requests_per_second"] = 1
        })
        v20.AFKTeleport = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        }), {
            ["maximum_requests_per_second"] = 1
        })
        return v20
    end),
    ["VoteKick"] = v11("VoteKick", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local function v31(p27)
            -- upvalues: (ref) v_u_4, (ref) v_u_3
            local v28 = v_u_4
            local v29 = v_u_3.DefinePacket
            local v30 = {
                ["Value"] = v_u_3.Struct({
                    ["Amount"] = v_u_3.Uint8,
                    ["Voter"] = v_u_3.String
                })
            }
            return v28(v29(v30), {
                ["maximum_requests_per_second"] = p27
            })
        end
        local v32 = {
            ["VoteNo"] = v31(1),
            ["VoteYes"] = v31(1),
            ["VoteNoUpdate"] = v31(0),
            ["VoteYesUpdate"] = v31(0)
        }
        local v33 = v_u_4
        local v34 = v_u_3.DefinePacket
        local v35 = {
            ["Value"] = v_u_3.Struct({
                ["TargetUserId"] = v_u_3.String,
                ["VoterUserId"] = v_u_3.String
            })
        }
        v32.StartVote = v33(v34(v35), {
            ["maximum_requests_per_second"] = 0
        })
        v32.EndVote = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        }), {
            ["maximum_requests_per_second"] = 1
        })
        v32.CallVote = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }), {
            ["maximum_requests_per_second"] = 1
        })
        return v32
    end),
    ["Character"] = v11("Character", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v36 = {
            ["CharacterDamaged"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Nothing
            })),
            ["CharacterDied"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Nothing
            }))
        }
        local v37 = v_u_4
        local v38 = v_u_3.DefinePacket
        local v39 = {
            ["Value"] = v_u_3.Struct({
                ["Headshot"] = v_u_3.Bool,
                ["Damage"] = v_u_3.Float32
            })
        }
        v36.CharacterFlinch = v37(v38(v39))
        v36.UpdateWalkState = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Bool
        }))
        v36.UpdateCrouchState = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Bool
        }))
        v36.FallDamage = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Float32
        }))
        local v40 = v_u_4
        local v41 = v_u_3.DefinePacket
        local v42 = {
            ["Value"] = v_u_3.Struct({
                ["Duration"] = v_u_3.Float32,
                ["Multiplier"] = v_u_3.Float32
            })
        }
        v36.ShotSlow = v40(v41(v42))
        local v43 = v_u_4
        local v44 = v_u_3.DefinePacket
        local v45 = {
            ["ReliabilityType"] = "Unreliable",
            ["Value"] = v_u_3.Struct({
                ["HorizontalAngle"] = v_u_3.Float32,
                ["VerticalLook"] = v_u_3.Float32
            })
        }
        v36.UpdateLookAngle = v43(v44(v45), {
            ["maximum_requests_per_second"] = 30
        })
        local v46 = v_u_4
        local v47 = v_u_3.DefinePacket
        local v48 = {
            ["ReliabilityType"] = "Unreliable",
            ["Value"] = v_u_3.Struct({
                ["Player"] = v_u_3.Instance,
                ["HorizontalAngle"] = v_u_3.Float32,
                ["VerticalLook"] = v_u_3.Float32
            })
        }
        v36.ReplicateLookAngle = v46(v47(v48))
        return v36
    end),
    ["Sound"] = v11("Sound", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v49 = {}
        local v50 = v_u_4
        local v51 = v_u_3.DefinePacket
        local v52 = {
            ["Value"] = v_u_3.Struct({
                ["Position"] = v_u_3.Optional(v_u_3.Vec3),
                ["Parent"] = v_u_3.Optional(v_u_3.Instance),
                ["Duration"] = v_u_3.Optional(v_u_3.String),
                ["Path"] = v_u_3.Optional(v_u_3.String),
                ["Class"] = v_u_3.String,
                ["Name"] = v_u_3.String
            })
        }
        v49.ReplicateSound = v50(v51(v52), {
            ["maximum_requests_per_second"] = 25
        })
        local v53 = v_u_4
        local v54 = v_u_3.DefinePacket
        local v55 = {
            ["Value"] = v_u_3.Struct({
                ["Position"] = v_u_3.Vec3,
                ["Radius"] = v_u_3.Float32
            })
        }
        v49.StopSoundAtPosition = v53(v54(v55))
        return v49
    end),
    ["Store"] = v11("Store", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v56 = {}
        local v57 = v_u_4
        local v58 = v_u_3.DefinePacket
        local v59 = {}
        local v60 = v_u_3.Struct
        local v61 = {
            ["DeletedCaseIds"] = v_u_3.Array(v_u_3.String),
            ["CaseIdentifier"] = v_u_3.String,
            ["CaseId"] = v_u_3.String,
            ["RequestId"] = v_u_3.Optional(v_u_3.String)
        }
        local v62 = v_u_3.Array
        local v63 = v_u_3.Struct
        local v64 = {
            ["_id"] = v_u_3.String,
            ["Type"] = v_u_3.String,
            ["Serial"] = v_u_3.Optional(v_u_3.Uint32),
            ["Name"] = v_u_3.String,
            ["Skin"] = v_u_3.String,
            ["Rarity"] = v_u_3.Optional(v_u_3.String),
            ["Float"] = v_u_3.Optional(v_u_3.Float32),
            ["StatTrack"] = v_u_3.Unknown,
            ["IsTradeable"] = v_u_3.Optional(v_u_3.Bool),
            ["NameTag"] = v_u_3.Unknown,
            ["OriginalOwner"] = v_u_3.Optional(v_u_3.String),
            ["Charm"] = v_u_3.Unknown,
            ["Pattern"] = v_u_3.Optional(v_u_3.Uint16)
        }
        local v65 = v_u_3.Optional
        local v66 = v_u_3.Array
        local v67 = v_u_3.Struct
        local v68 = {
            ["Sticker"] = v_u_3.String,
            ["Position"] = v_u_3.Struct({
                ["Rotation"] = v_u_3.Float32,
                ["X"] = v_u_3.Float32,
                ["Y"] = v_u_3.Float32
            })
        }
        v64.Stickers = v65(v66(v67(v68)))
        v64.MetaData = v_u_3.Optional(v_u_3.Struct({
            ["LastTradeAt"] = v_u_3.Optional(v_u_3.Float64),
            ["CreatedAt"] = v_u_3.Optional(v_u_3.Float64),
            ["TradeHistory"] = v_u_3.Optional(v_u_3.Array(v_u_3.String)),
            ["OriginalOwner"] = v_u_3.Optional(v_u_3.String),
            ["Owner"] = v_u_3.Optional(v_u_3.String),
            ["Origin"] = v_u_3.Optional(v_u_3.String)
        }))
        v64.__v = v_u_3.Optional(v_u_3.Uint32)
        v61.InventoryItems = v62(v63(v64))
        v59.Value = v60(v61)
        v56.CaseOpened = v57(v58(v59), {
            ["maximum_requests_per_second"] = 1
        })
        local v69 = v_u_4
        local v70 = v_u_3.DefinePacket
        local v71 = {
            ["Value"] = v_u_3.Struct({
                ["Reason"] = v_u_3.Optional(v_u_3.String),
                ["RequestId"] = v_u_3.Optional(v_u_3.String),
                ["RetryAfterMs"] = v_u_3.Optional(v_u_3.Float64)
            })
        }
        v56.CaseOpenDenied = v69(v70(v71), {
            ["maximum_requests_per_second"] = 1
        })
        local v72 = v_u_4
        local v73 = v_u_3.DefinePacket
        local v74 = {
            ["Value"] = v_u_3.Struct({
                ["CaseIdentifiers"] = v_u_3.Array(v_u_3.String),
                ["OpenType"] = v_u_3.String,
                ["CaseId"] = v_u_3.String,
                ["RequestId"] = v_u_3.Optional(v_u_3.String)
            })
        }
        v56.OpenCase = v72(v73(v74), {
            ["maximum_requests_per_second"] = 3
        })
        local v75 = v_u_4
        local v76 = v_u_3.DefinePacket
        local v77 = {
            ["Value"] = v_u_3.Struct({
                ["CaseIdentifier"] = v_u_3.String
            })
        }
        v56.CaseOpenSequenceFinished = v75(v76(v77), {
            ["maximum_requests_per_second"] = 3
        })
        local v78 = v_u_4
        local v79 = v_u_3.DefinePacket
        local v80 = {}
        local v81 = v_u_3.Struct
        local v82 = {}
        local v83 = v_u_3.Array
        local v84 = v_u_3.Struct
        local v85 = {
            ["_id"] = v_u_3.String,
            ["Type"] = v_u_3.String,
            ["Serial"] = v_u_3.Optional(v_u_3.Uint32),
            ["Name"] = v_u_3.String,
            ["Skin"] = v_u_3.String,
            ["Rarity"] = v_u_3.Optional(v_u_3.String),
            ["Float"] = v_u_3.Optional(v_u_3.Float32),
            ["StatTrack"] = v_u_3.Unknown,
            ["IsTradeable"] = v_u_3.Optional(v_u_3.Bool),
            ["NameTag"] = v_u_3.Unknown,
            ["OriginalOwner"] = v_u_3.Optional(v_u_3.String),
            ["Charm"] = v_u_3.Unknown,
            ["Pattern"] = v_u_3.Optional(v_u_3.Uint16)
        }
        local v86 = v_u_3.Optional
        local v87 = v_u_3.Array
        local v88 = v_u_3.Struct
        local v89 = {
            ["Sticker"] = v_u_3.String,
            ["Position"] = v_u_3.Struct({
                ["Rotation"] = v_u_3.Float32,
                ["X"] = v_u_3.Float32,
                ["Y"] = v_u_3.Float32
            })
        }
        v85.Stickers = v86(v87(v88(v89)))
        v85.MetaData = v_u_3.Optional(v_u_3.Struct({
            ["LastTradeAt"] = v_u_3.Optional(v_u_3.Float64),
            ["CreatedAt"] = v_u_3.Optional(v_u_3.Float64),
            ["TradeHistory"] = v_u_3.Optional(v_u_3.Array(v_u_3.String)),
            ["OriginalOwner"] = v_u_3.Optional(v_u_3.String),
            ["Owner"] = v_u_3.Optional(v_u_3.String),
            ["Origin"] = v_u_3.Optional(v_u_3.String)
        }))
        v85.__v = v_u_3.Optional(v_u_3.Uint32)
        v82.Items = v83(v84(v85))
        v82.Player = v_u_3.String
        v82.DeletedItemIds = v_u_3.Optional(v_u_3.Array(v_u_3.String))
        v80.Value = v81(v82)
        v56.NewInventoryItem = v78(v79(v80), {
            ["maximum_requests_per_second"] = 8
        })
        local v90 = v_u_4
        local v91 = v_u_3.DefinePacket
        local v92 = {
            ["Value"] = v_u_3.Struct({
                ["RecipientUserId"] = v_u_3.String,
                ["CaseId"] = v_u_3.String,
                ["Amount"] = v_u_3.Uint8
            })
        }
        v56.GiftCase = v90(v91(v92), {
            ["maximum_requests_per_second"] = 1
        })
        local v93 = v_u_4
        local v94 = v_u_3.DefinePacket
        local v95 = {
            ["Value"] = v_u_3.Struct({
                ["CaseId"] = v_u_3.String,
                ["Amount"] = v_u_3.Uint8
            })
        }
        v56.PurchaseCase = v93(v94(v95), {
            ["maximum_requests_per_second"] = 3
        })
        v56.OpenedShop = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Struct({})
        }), {
            ["maximum_requests_per_second"] = 1
        })
        local v96 = v_u_4
        local v97 = v_u_3.DefinePacket
        local v98 = {
            ["Value"] = v_u_3.Struct({
                ["RecipientUserId"] = v_u_3.String,
                ["ProductName"] = v_u_3.String,
                ["ProductType"] = v_u_3.String
            })
        }
        v56.CreateGift = v96(v97(v98), {
            ["maximum_requests_per_second"] = 1
        })
        return v56
    end),
    ["Spectate"] = v11("Spectate", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v99 = {
            ["UpdateCameraCFrame"] = v_u_4(v_u_3.DefinePacket({
                ["ReliabilityType"] = "Unreliable",
                ["Value"] = v_u_3.CFrame
            }), {
                ["maximum_requests_per_second"] = 60
            }),
            ["SetSpectatePerspective"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.String
            })),
            ["SpectatePlayer"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.String
            })),
            ["StartSpectating"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Nothing
            })),
            ["StopSpectating"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Nothing
            })),
            ["ReplicateSpectateEvent"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.String
            }))
        }
        return v99
    end),
    ["Dashboard"] = v11("Dashboard", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v100 = {
            ["MissionCompleted"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.String
            }), {
                ["maximum_requests_per_second"] = 1
            }),
            ["RedeemCode"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.String
            }), {
                ["maximum_requests_per_second"] = 1
            }),
            ["RedeemLikeAndFavoriteReward"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Nothing
            }), {
                ["maximum_requests_per_second"] = 1
            }),
            ["ClaimStarReward"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Float64
            }), {
                ["maximum_requests_per_second"] = 10
            })
        }
        return v100
    end),
    ["Map"] = v11("Map", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v101 = {
            ["SubmitMapVote"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.String
            })),
            ["StartMapVote"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Array(v_u_3.String)
            })),
            ["UpdateMapVote"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Map(v_u_3.String, v_u_3.Uint8)
            })),
            ["EndMapVote"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.String
            })),
            ["RequestMapVote"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Nothing
            }))
        }
        return v101
    end),
    ["Match"] = v11("Match", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v102 = {}
        local v103 = v_u_4
        local v104 = v_u_3.DefinePacket
        local v105 = {}
        local v106 = v_u_3.Struct
        local v107 = {
            ["WinningTeam"] = v_u_3.String,
            ["CTScore"] = v_u_3.Uint16,
            ["TScore"] = v_u_3.Uint16
        }
        local v108 = v_u_3.Map
        local v109 = v_u_3.String
        local v110 = v_u_3.Struct
        local v111 = {
            ["Team"] = v_u_3.String,
            ["ADR"] = v_u_3.Float32,
            ["Kills"] = v_u_3.Uint16,
            ["Deaths"] = v_u_3.Uint16,
            ["Assists"] = v_u_3.Uint16,
            ["Score"] = v_u_3.Uint16,
            ["Headshots"] = v_u_3.Uint16,
            ["Accolade"] = v_u_3.String,
            ["ExperienceEarned"] = v_u_3.Optional(v_u_3.Uint32),
            ["Weapon"] = v_u_3.Optional(v_u_3.Struct({
                ["Name"] = v_u_3.String,
                ["Skin"] = v_u_3.String,
                ["Float"] = v_u_3.Float32,
                ["StatTrack"] = v_u_3.Unknown,
                ["NameTag"] = v_u_3.Unknown
            })),
            ["Gloves"] = v_u_3.Optional(v_u_3.Struct({
                ["Name"] = v_u_3.String,
                ["Skin"] = v_u_3.String,
                ["Float"] = v_u_3.Float32
            }))
        }
        local v112 = v_u_3.Optional
        local v113 = v_u_3.Array
        local v114 = v_u_3.Struct
        local v115 = {
            ["type"] = v_u_3.String,
            ["amount"] = v_u_3.Optional(v_u_3.Uint32),
            ["inventoryItem"] = v_u_3.Optional(v_u_3.Struct({
                ["_id"] = v_u_3.String,
                ["Name"] = v_u_3.String,
                ["Skin"] = v_u_3.Optional(v_u_3.String),
                ["Rarity"] = v_u_3.String,
                ["Type"] = v_u_3.String,
                ["Float"] = v_u_3.Optional(v_u_3.Float32),
                ["Serial"] = v_u_3.Optional(v_u_3.Uint32),
                ["Pattern"] = v_u_3.Optional(v_u_3.Uint16),
                ["StatTrack"] = v_u_3.Unknown,
                ["NameTag"] = v_u_3.Unknown,
                ["Charm"] = v_u_3.Unknown,
                ["IsTradeable"] = v_u_3.Optional(v_u_3.Bool),
                ["Stickers"] = v_u_3.Optional(v_u_3.Unknown),
                ["MetaData"] = v_u_3.Optional(v_u_3.Unknown)
            }))
        }
        v111.LevelRewards = v112(v113(v114(v115)))
        v107.Players = v108(v109, v110(v111))
        v107.ShowAccolades = v_u_3.Optional(v_u_3.Bool)
        v107.ShowProgression = v_u_3.Optional(v_u_3.Bool)
        v107.SequenceDuration = v_u_3.Optional(v_u_3.Float32)
        v107.ReturnToMenu = v_u_3.Optional(v_u_3.Bool)
        v107.Halftime = v_u_3.Optional(v_u_3.Bool)
        v105.Value = v106(v107)
        v102.EndScreen = v103(v104(v105))
        return v102
    end),
    ["Inventory"] = v11("Inventory", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v116 = {
            ["RemoveInventoryItem"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.String
            }))
        }
        local v117 = v_u_4
        local v118 = v_u_3.DefinePacket
        local v119 = {}
        local v120 = v_u_3.Struct
        local v121 = {
            ["customProperties"] = v_u_3.Optional(v_u_3.Map(v_u_3.String, v_u_3.Unknown)),
            ["OriginalOwner"] = v_u_3.Optional(v_u_3.String),
            ["StatTrack"] = v_u_3.Unknown,
            ["NameTag"] = v_u_3.Unknown,
            ["Charm"] = v_u_3.Unknown,
            ["Float"] = v_u_3.Float32,
            ["identifier"] = v_u_3.String,
            ["shouldEquip"] = v_u_3.Optional(v_u_3.Bool),
            ["weapon"] = v_u_3.String,
            ["skin"] = v_u_3.String,
            ["slot"] = v_u_3.Uint8,
            ["_id"] = v_u_3.String
        }
        local v122 = v_u_3.Array
        local v123 = v_u_3.Struct
        local v124 = {
            ["Sticker"] = v_u_3.String,
            ["Position"] = v_u_3.Struct({
                ["X"] = v_u_3.Float32,
                ["Y"] = v_u_3.Float32,
                ["Rotation"] = v_u_3.Float32
            })
        }
        v121.Stickers = v122(v123(v124))
        v119.Value = v120(v121)
        v116.NewInventoryItem = v117(v118(v119))
        local v125 = v_u_4
        local v126 = v_u_3.DefinePacket
        local v127 = {
            ["Value"] = v_u_3.Struct({
                ["Player"] = v_u_3.Instance,
                ["Identifier"] = v_u_3.String,
                ["StatTrack"] = v_u_3.Uint32
            })
        }
        v116.UpdateStatTrack = v125(v126(v127))
        v116.CleanupGameLoadout = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        }))
        local v128 = v_u_4
        local v129 = v_u_3.DefinePacket
        local v130 = {}
        local v131 = v_u_3.Array
        local v132 = v_u_3.Struct
        local v133 = {
            ["_items"] = v_u_3.Array(v_u_3.Struct({
                ["Identifier"] = v_u_3.String
            })),
            ["_settings"] = v_u_3.Struct({
                ["_strict_slot_space"] = v_u_3.Uint8,
                ["_strict_type"] = v_u_3.String
            })
        }
        v130.Value = v131(v132(v133))
        v116.CreateGameLoadout = v128(v129(v130))
        v116.RequestSpectatedPlayerInventory = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Instance
        }))
        local v134 = v_u_4
        local v135 = v_u_3.DefinePacket
        local v136 = {}
        local v137 = v_u_3.Struct
        local v138 = {
            ["Player"] = v_u_3.Instance
        }
        local v139 = v_u_3.Array
        local v140 = v_u_3.Struct
        local v141 = {}
        local v142 = v_u_3.Array
        local v143 = v_u_3.Struct
        local v144 = {
            ["Identifier"] = v_u_3.String,
            ["Name"] = v_u_3.String,
            ["Skin"] = v_u_3.Optional(v_u_3.String),
            ["Slot"] = v_u_3.Uint8,
            ["Properties"] = v_u_3.Struct({
                ["Class"] = v_u_3.String,
                ["Icon"] = v_u_3.String,
                ["Slot"] = v_u_3.String
            })
        }
        v141._items = v142(v143(v144))
        v141._settings = v_u_3.Struct({
            ["_strict_slot_space"] = v_u_3.Uint8,
            ["_strict_type"] = v_u_3.String
        })
        v138.Inventory = v139(v140(v141))
        v138.EquippedSlot = v_u_3.Uint8
        v138.EquippedSlotSpace = v_u_3.Uint8
        v136.Value = v137(v138)
        v116.SpectatedPlayerInventory = v134(v135(v136))
        local v145 = v_u_4
        local v146 = v_u_3.DefinePacket
        local v147 = {
            ["Value"] = v_u_3.Struct({
                ["Identifier"] = v_u_3.String,
                ["PreviousIdentifier"] = v_u_3.Optional(v_u_3.String)
            })
        }
        v116.WeaponEquipped = v145(v146(v147), {
            ["maximum_requests_per_second"] = 0
        })
        local v148 = v_u_4
        local v149 = v_u_3.DefinePacket
        local v150 = {
            ["Value"] = v_u_3.Struct({
                ["Identifier"] = v_u_3.String,
                ["Equipment"] = v_u_3.Bool
            })
        }
        v116.ReturnBuyMenuPurchase = v148(v149(v150))
        local v151 = v_u_4
        local v152 = v_u_3.DefinePacket
        local v153 = {
            ["Value"] = v_u_3.Struct({
                ["Name"] = v_u_3.String,
                ["Equipment"] = v_u_3.Bool,
                ["Path"] = v_u_3.String
            })
        }
        v116.BuyMenuPurchase = v151(v152(v153), {
            ["maximum_requests_per_second"] = 3
        })
        local v154 = v_u_4
        local v155 = v_u_3.DefinePacket
        local v156 = {
            ["Value"] = v_u_3.Struct({
                ["Identity"] = v_u_3.String,
                ["AllowAutoEquip"] = v_u_3.Bool
            })
        }
        v116.PickupWeapon = v154(v155(v156), {
            ["maximum_requests_per_second"] = 7
        })
        local v157 = v_u_4
        local v158 = v_u_3.DefinePacket
        local v159 = {
            ["Value"] = v_u_3.Struct({
                ["Identifier"] = v_u_3.String,
                ["Direction"] = v_u_3.Vec3
            })
        }
        v116.DropWeapon = v157(v158(v159), {
            ["maximum_requests_per_second"] = 5
        })
        v116.UpdateScopeIncrement = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Uint8
        }), {
            ["maximum_requests_per_second"] = 10
        })
        local v160 = v_u_4
        local v161 = v_u_3.DefinePacket
        local v162 = {
            ["Value"] = v_u_3.Struct({
                ["Identifier"] = v_u_3.String,
                ["State"] = v_u_3.Bool
            })
        }
        v116.UpdateWeaponSuppressor = v160(v161(v162))
        local v163 = v_u_4
        local v164 = v_u_3.DefinePacket
        local v165 = {
            ["Value"] = v_u_3.Struct({
                ["WeaponId"] = v_u_3.String,
                ["CharmId"] = v_u_3.String,
                ["Position"] = v_u_3.String
            })
        }
        v116.UpdateWeaponCharm = v163(v164(v165))
        local v166 = v_u_4
        local v167 = v_u_3.DefinePacket
        local v168 = {
            ["Value"] = v_u_3.Struct({
                ["WeaponId"] = v_u_3.String
            })
        }
        v116.RemoveWeaponCharm = v166(v167(v168))
        local v169 = v_u_4
        local v170 = v_u_3.DefinePacket
        local v171 = {
            ["Value"] = v_u_3.Struct({
                ["Identifier"] = v_u_3.String,
                ["Rounds"] = v_u_3.Uint16,
                ["Capacity"] = v_u_3.Uint16
            })
        }
        v116.ReloadWeapon = v169(v170(v171))
        local v172 = v_u_4
        local v173 = v_u_3.DefinePacket
        local v174 = {}
        local v175 = v_u_3.Struct
        local v176 = {
            ["ShootingHand"] = v_u_3.String,
            ["Identifier"] = v_u_3.String,
            ["Rounds"] = v_u_3.Uint16,
            ["Capacity"] = v_u_3.Uint16,
            ["IsSniperScoped"] = v_u_3.Bool
        }
        local v177 = v_u_3.Array
        local v178 = v_u_3.Struct
        local v179 = {
            ["Direction"] = v_u_3.Vec3,
            ["Origin"] = v_u_3.Vec3,
            ["Hits"] = v_u_3.Array(v_u_3.Struct({
                ["Instance"] = v_u_3.Instance,
                ["Position"] = v_u_3.Vec3,
                ["Normal"] = v_u_3.Vec3,
                ["Material"] = v_u_3.String,
                ["Distance"] = v_u_3.Float32,
                ["Exit"] = v_u_3.Bool
            }))
        }
        v176.Bullets = v177(v178(v179))
        v174.Value = v175(v176)
        v116.ShootWeapon = v172(v173(v174), {
            ["maximum_requests_per_second"] = 20
        })
        v116.CreateMagazine = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }), {
            ["maximum_requests_per_second"] = 1
        })
        local v180 = v_u_4
        local v181 = v_u_3.DefinePacket
        local v182 = {
            ["Value"] = v_u_3.Struct({
                ["Identifier"] = v_u_3.String,
                ["Direction"] = v_u_3.Vec3,
                ["Position"] = v_u_3.Vec3,
                ["Animation"] = v_u_3.String,
                ["CharacterVelocity"] = v_u_3.Vec3,
                ["IsCrouching"] = v_u_3.Bool
            })
        }
        v116.ThrowGrenade = v180(v181(v182), {
            ["maximum_requests_per_second"] = 1
        })
        local v183 = v_u_4
        local v184 = v_u_3.DefinePacket
        local v185 = {
            ["Value"] = v_u_3.Struct({
                ["Type"] = v_u_3.String,
                ["Slot"] = v_u_3.Uint8,
                ["Team"] = v_u_3.String,
                ["Identifier"] = v_u_3.String
            })
        }
        v116.EquipLoadoutSkin = v183(v184(v185), {
            ["maximum_requests_per_second"] = 5
        })
        local v186 = v_u_4
        local v187 = v_u_3.DefinePacket
        local v188 = {
            ["Value"] = v_u_3.Struct({
                ["Type"] = v_u_3.String,
                ["SlotOne"] = v_u_3.Uint8,
                ["SlotTwo"] = v_u_3.Uint8,
                ["Team"] = v_u_3.String
            })
        }
        v116.SwapLoadoutSkins = v186(v187(v188), {
            ["maximum_requests_per_second"] = 5
        })
        local v189 = v_u_4
        local v190 = v_u_3.DefinePacket
        local v191 = {
            ["Value"] = v_u_3.Struct({
                ["Path"] = v_u_3.String,
                ["Team"] = v_u_3.String,
                ["Identifier"] = v_u_3.String
            })
        }
        v116.EquipSpecialItem = v189(v190(v191), {
            ["maximum_requests_per_second"] = 5
        })
        v116.LoadoutResponse = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Bool
        }))
        return v116
    end),
    ["Projectile"] = v11("Projectile", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v192 = {}
        local v193 = v_u_4
        local v194 = v_u_3.DefinePacket
        local v195 = {}
        local v196 = v_u_3.Struct
        local v197 = {
            ["Id"] = v_u_3.String,
            ["Weapon"] = v_u_3.String,
            ["Skin"] = v_u_3.String,
            ["Float"] = v_u_3.Float32,
            ["StatTrack"] = v_u_3.Unknown,
            ["NameTag"] = v_u_3.Unknown,
            ["Charm"] = v_u_3.Unknown
        }
        local v198 = v_u_3.Array
        local v199 = v_u_3.Struct
        local v200 = {
            ["Sticker"] = v_u_3.String,
            ["Position"] = v_u_3.Struct({
                ["X"] = v_u_3.Float32,
                ["Y"] = v_u_3.Float32,
                ["Rotation"] = v_u_3.Float32
            })
        }
        v197.Stickers = v198(v199(v200))
        v197.State = v_u_3.Struct({
            ["Position"] = v_u_3.Vec3,
            ["Velocity"] = v_u_3.Vec3,
            ["StartTime"] = v_u_3.Optional(v_u_3.Float64),
            ["IsJumpThrow"] = v_u_3.Bool
        })
        v197.Physics = v_u_3.Struct({
            ["Gravity"] = v_u_3.Vec3,
            ["Drag"] = v_u_3.Float32,
            ["Restitution"] = v_u_3.Float32,
            ["Radius"] = v_u_3.Float32,
            ["MaxBounces"] = v_u_3.Uint8,
            ["FuseTime"] = v_u_3.Float32,
            ["Step"] = v_u_3.Float32,
            ["RestVelocityThreshold"] = v_u_3.Float32,
            ["CollisionGroup"] = v_u_3.String
        })
        v195.Value = v196(v197)
        v192.Spawn = v193(v194(v195))
        local v201 = v_u_4
        local v202 = v_u_3.DefinePacket
        local v203 = {
            ["Value"] = v_u_3.Struct({
                ["Id"] = v_u_3.String,
                ["Grenade"] = v_u_3.String,
                ["Position"] = v_u_3.Vec3,
                ["Normal"] = v_u_3.Vec3,
                ["Reason"] = v_u_3.String
            })
        }
        v192.Resolve = v201(v202(v203))
        local v204 = v_u_4
        local v205 = v_u_3.DefinePacket
        local v206 = {
            ["Value"] = v_u_3.Struct({
                ["Id"] = v_u_3.String,
                ["BounceIndex"] = v_u_3.Uint8,
                ["Position"] = v_u_3.Vec3,
                ["Velocity"] = v_u_3.Vec3,
                ["Normal"] = v_u_3.Vec3,
                ["Timestamp"] = v_u_3.Float64
            })
        }
        v192.Bounce = v204(v205(v206))
        return v192
    end),
    ["VFX"] = v11("VFX", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v207 = {}
        local v208 = v_u_4
        local v209 = v_u_3.DefinePacket
        local v210 = {
            ["Value"] = v_u_3.Struct({
                ["Skin"] = v_u_3.Optional(v_u_3.String),
                ["DirectionMultiplier"] = v_u_3.Float32,
                ["Finisher"] = v_u_3.String,
                ["Direction"] = v_u_3.Vec3,
                ["Weapon"] = v_u_3.String,
                ["Killer"] = v_u_3.Float64,
                ["Victim"] = v_u_3.Float64,
                ["Part"] = v_u_3.String
            })
        }
        v207.ReplicateFinisher = v208(v209(v210), {
            ["maximum_requests_per_second"] = 5
        })
        local v211 = v_u_4
        local v212 = v_u_3.DefinePacket
        local v213 = {
            ["Value"] = v_u_3.Struct({
                ["Suppressor"] = v_u_3.Optional(v_u_3.String),
                ["ShootingHand"] = v_u_3.String,
                ["PlayerName"] = v_u_3.String,
                ["WeaponName"] = v_u_3.String
            })
        }
        v207.CreateCharacterMuzzleFlash = v211(v212(v213), {
            ["maximum_requests_per_second"] = 25
        })
        local v214 = v_u_4
        local v215 = v_u_3.DefinePacket
        local v216 = {
            ["Value"] = v_u_3.Struct({
                ["Position"] = v_u_3.Vec3,
                ["Direction"] = v_u_3.Vec3
            })
        }
        v207.CreateBloodSplatter = v214(v215(v216), {
            ["maximum_requests_per_second"] = 0
        })
        local v217 = v_u_4
        local v218 = v_u_3.DefinePacket
        local v219 = {
            ["Value"] = v_u_3.Struct({
                ["Instance"] = v_u_3.Instance,
                ["Material"] = v_u_3.String,
                ["Position"] = v_u_3.Vec3,
                ["Normal"] = v_u_3.Vec3,
                ["Exit"] = v_u_3.Bool,
                ["Ricochet"] = v_u_3.Bool,
                ["AttackerUserId"] = v_u_3.Optional(v_u_3.String),
                ["IsWallbang"] = v_u_3.Optional(v_u_3.Bool),
                ["WasHelmetHeadshot"] = v_u_3.Optional(v_u_3.Bool),
                ["SuppressVisuals"] = v_u_3.Optional(v_u_3.Bool)
            })
        }
        v207.CreateImpact = v217(v218(v219), {
            ["maximum_requests_per_second"] = 25
        })
        local v220 = v_u_4
        local v221 = v_u_3.DefinePacket
        local v222 = {
            ["Value"] = v_u_3.Struct({
                ["Instance"] = v_u_3.Instance,
                ["Type"] = v_u_3.String,
                ["Position"] = v_u_3.Vec3,
                ["Normal"] = v_u_3.Vec3
            })
        }
        v207.CreateMarker = v220(v221(v222), {
            ["maximum_requests_per_second"] = 25
        })
        local v223 = v_u_4
        local v224 = v_u_3.DefinePacket
        local v225 = {
            ["Value"] = v_u_3.Struct({
                ["Distance"] = v_u_3.Float32,
                ["Origin"] = v_u_3.Vec3,
                ["Target"] = v_u_3.Vec3
            })
        }
        v207.CreateTracer = v223(v224(v225), {
            ["maximum_requests_per_second"] = 25
        })
        v207.CleanupDebris = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        }))
        local v226 = v_u_4
        local v227 = v_u_3.DefinePacket
        local v228 = {
            ["Value"] = v_u_3.Struct({
                ["Instance"] = v_u_3.Instance,
                ["Position"] = v_u_3.Vec3,
                ["Direction"] = v_u_3.Vec3
            })
        }
        v207.BreakGlass = v226(v227(v228), {
            ["maximum_requests_per_second"] = 25
        })
        local v229 = v_u_4
        local v230 = v_u_3.DefinePacket
        local v231 = {}
        local v232 = v_u_3.Struct
        local v233 = {
            ["SmokeId"] = v_u_3.String,
            ["Duration"] = v_u_3.Float32,
            ["DeployTime"] = v_u_3.Float32,
            ["Voxels"] = v_u_3.Array(v_u_3.Struct({
                ["Position"] = v_u_3.Vec3,
                ["Size"] = v_u_3.Float32
            })),
            ["Team"] = v_u_3.Optional(v_u_3.String)
        }
        v231.Value = v232(v233)
        v207.CreateVoxelSmoke = v229(v230(v231))
        v207.DestroyVoxelSmoke = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }))
        local v234 = v_u_4
        local v235 = v_u_3.DefinePacket
        local v236 = {
            ["Value"] = v_u_3.Struct({
                ["Position"] = v_u_3.Vec3,
                ["Radius"] = v_u_3.Float32,
                ["Duration"] = v_u_3.Float32
            })
        }
        v207.DisruptVoxelSmoke = v234(v235(v236))
        local v237 = v_u_4
        local v238 = v_u_3.DefinePacket
        local v239 = {}
        local v240 = v_u_3.Struct
        local v241 = {
            ["FireId"] = v_u_3.String,
            ["Duration"] = v_u_3.Float32,
            ["Voxels"] = v_u_3.Array(v_u_3.Struct({
                ["Position"] = v_u_3.Vec3,
                ["SizeX"] = v_u_3.Float32,
                ["SizeZ"] = v_u_3.Float32,
                ["Normal"] = v_u_3.Vec3
            }))
        }
        v239.Value = v240(v241)
        v207.CreateVoxelFire = v237(v238(v239))
        v207.DestroyVoxelFire = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }))
        local v242 = v_u_4
        local v243 = v_u_3.DefinePacket
        local v244 = {}
        local v245 = v_u_3.Struct
        local v246 = {
            ["FireId"] = v_u_3.String,
            ["Voxels"] = v_u_3.Array(v_u_3.Struct({
                ["Position"] = v_u_3.Vec3,
                ["SizeX"] = v_u_3.Float32,
                ["SizeZ"] = v_u_3.Float32,
                ["Normal"] = v_u_3.Vec3
            }))
        }
        v244.Value = v245(v246)
        v207.UpdateVoxelFire = v242(v243(v244))
        local v247 = v_u_4
        local v248 = v_u_3.DefinePacket
        local v249 = {
            ["Value"] = v_u_3.Struct({
                ["Position"] = v_u_3.Vec3,
                ["AttackerUserId"] = v_u_3.Optional(v_u_3.String),
                ["Duration"] = v_u_3.Optional(v_u_3.Float32)
            })
        }
        v207.FlashPlayer = v247(v248(v249))
        return v207
    end),
    ["C4"] = v11("C4", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v250 = {
            ["Defused"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Nothing
            }))
        }
        local v251 = v_u_4
        local v252 = v_u_3.DefinePacket
        local v253 = {
            ["Value"] = v_u_3.Struct({
                ["SessionId"] = v_u_3.Uint32
            })
        }
        v250.StartDefuse = v251(v252(v253))
        local v254 = v_u_4
        local v255 = v_u_3.DefinePacket
        local v256 = {
            ["Value"] = v_u_3.Struct({
                ["SessionId"] = v_u_3.Uint32
            })
        }
        v250.CancelDefuse = v254(v255(v256))
        v250.Planted = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }))
        v250.Start = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }))
        v250.Cancel = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }))
        v250.ForceCancel = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        }))
        return v250
    end),
    ["Hostage"] = v11("Hostage", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v257 = {
            ["StartRescue"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Nothing
            })),
            ["CancelRescue"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Nothing
            })),
            ["PickedUp"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.Nothing
            }))
        }
        return v257
    end),
    ["Melee"] = v11("Melee", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v258 = {}
        local v259 = v_u_4
        local v260 = v_u_3.DefinePacket
        local v261 = {
            ["Value"] = v_u_3.Struct({
                ["Direction"] = v_u_3.Vec3,
                ["Material"] = v_u_3.String,
                ["Distance"] = v_u_3.Float32,
                ["Instance"] = v_u_3.Instance,
                ["Position"] = v_u_3.Vec3,
                ["Normal"] = v_u_3.Vec3,
                ["MeleeAttack"] = v_u_3.String,
                ["Identifier"] = v_u_3.String
            })
        }
        v258.MeleeAttack = v259(v260(v261), {
            ["maximum_requests_per_second"] = 5
        })
        return v258
    end),
    ["Chat"] = v11("Chat", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v262 = {}
        local v263 = v_u_4
        local v264 = v_u_3.DefinePacket
        local v265 = {
            ["Value"] = v_u_3.Struct({
                ["displayName"] = v_u_3.String,
                ["team"] = v_u_3.String,
                ["message"] = v_u_3.String,
                ["alive"] = v_u_3.Bool,
                ["role"] = v_u_3.Uint8,
                ["verified"] = v_u_3.Bool
            })
        }
        v262.ServerChat = v263(v264(v265))
        local v266 = v_u_4
        local v267 = v_u_3.DefinePacket
        local v268 = {
            ["Value"] = v_u_3.Struct({
                ["displayName"] = v_u_3.String,
                ["team"] = v_u_3.String,
                ["message"] = v_u_3.String,
                ["alive"] = v_u_3.Bool,
                ["role"] = v_u_3.Uint8,
                ["verified"] = v_u_3.Bool
            })
        }
        v262.ServerTeamChat = v266(v267(v268))
        local v269 = v_u_4
        local v270 = v_u_3.DefinePacket
        local v271 = {
            ["Value"] = v_u_3.Struct({
                ["name"] = v_u_3.String,
                ["team"] = v_u_3.String
            })
        }
        v262.ChatTeamJoin = v269(v270(v271))
        local v272 = v_u_4
        local v273 = v_u_3.DefinePacket
        local v274 = {
            ["Value"] = v_u_3.Struct({
                ["Killer"] = v_u_3.String,
                ["Weapon"] = v_u_3.String,
                ["Points"] = v_u_3.Optional(v_u_3.Uint8)
            })
        }
        v262.ChatPlayerKilled = v272(v273(v274))
        local v275 = v_u_4
        local v276 = v_u_3.DefinePacket
        local v277 = {
            ["Value"] = v_u_3.Struct({
                ["weaponName"] = v_u_3.Optional(v_u_3.String),
                ["amount"] = v_u_3.String,
                ["source"] = v_u_3.String
            })
        }
        v262.ChatMoneyReward = v275(v276(v277))
        local v278 = v_u_4
        local v279 = v_u_3.DefinePacket
        local v280 = {
            ["Value"] = v_u_3.Struct({
                ["displayName"] = v_u_3.String,
                ["team"] = v_u_3.String,
                ["weaponName"] = v_u_3.String,
                ["skinName"] = v_u_3.String,
                ["rarity"] = v_u_3.String,
                ["statTrak"] = v_u_3.Bool
            })
        }
        v262.ChatCaseOpened = v278(v279(v280))
        local v281 = v_u_4
        local v282 = v_u_3.DefinePacket
        local v283 = {
            ["Value"] = v_u_3.Struct({
                ["name"] = v_u_3.String
            })
        }
        v262.ChatPlayerLeave = v281(v282(v283))
        local v284 = v_u_4
        local v285 = v_u_3.DefinePacket
        local v286 = {
            ["Value"] = v_u_3.Struct({
                ["name"] = v_u_3.String
            })
        }
        v262.ChatPlayerBanned = v284(v285(v286))
        local v287 = v_u_4
        local v288 = v_u_3.DefinePacket
        local v289 = {
            ["Value"] = v_u_3.Struct({
                ["message"] = v_u_3.String
            })
        }
        v262.ChatSystemMessage = v287(v288(v289))
        local v290 = v_u_4
        local v291 = v_u_3.DefinePacket
        local v292 = {
            ["Value"] = v_u_3.Struct({
                ["messageType"] = v_u_3.String,
                ["displayName"] = v_u_3.String,
                ["team"] = v_u_3.String
            })
        }
        v262.ChatTeamDamage = v290(v291(v292))
        local v293 = v_u_4
        local v294 = v_u_3.DefinePacket
        local v295 = {
            ["Value"] = v_u_3.Struct({
                ["displayName"] = v_u_3.String,
                ["grenadeName"] = v_u_3.String,
                ["team"] = v_u_3.String
            })
        }
        v262.ChatGrenadeThrow = v293(v294(v295))
        local v296 = v_u_4
        local v297 = v_u_3.DefinePacket
        local v298 = {
            ["Value"] = v_u_3.Struct({
                ["displayName"] = v_u_3.String,
                ["team"] = v_u_3.String,
                ["site"] = v_u_3.String
            })
        }
        v262.ChatDefuseStart = v296(v297(v298))
        local v299 = v_u_4
        local v300 = v_u_3.DefinePacket
        local v301 = {
            ["Value"] = v_u_3.Struct({
                ["Text"] = v_u_3.String,
                ["Mode"] = v_u_3.Uint8
            })
        }
        v262.ClientChat = v299(v300(v301), {
            ["maximum_requests_per_second"] = 5
        })
        return v262
    end),
    ["UI"] = v11("UI", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v302 = {}
        local v303 = v_u_4
        local v304 = v_u_3.DefinePacket
        local v305 = {
            ["Value"] = v_u_3.Struct({
                ["Text"] = v_u_3.String,
                ["Type"] = v_u_3.String
            })
        }
        v302.UpdateCreatorCode = v303(v304(v305))
        local v306 = v_u_4
        local v307 = v_u_3.DefinePacket
        local v308 = {
            ["Value"] = v_u_3.Struct({
                ["CreatorCode"] = v_u_3.String
            })
        }
        v302.EquipCreatorCode = v306(v307(v308), {
            ["maximum_requests_per_second"] = 1
        })
        local v309 = v_u_4
        local v310 = v_u_3.DefinePacket
        local v311 = {
            ["Value"] = v_u_3.Struct({
                ["notificationType"] = v_u_3.String,
                ["text"] = v_u_3.String
            })
        }
        v302.CreateMenuNotification = v309(v310(v311))
        v302.RoundWinner = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }))
        local v312 = v_u_4
        local v313 = v_u_3.DefinePacket
        local v314 = {
            ["Value"] = v_u_3.Array(v_u_3.Struct({
                ["userId"] = v_u_3.String,
                ["grenades"] = v_u_3.Array(v_u_3.String)
            }))
        }
        v302.TeammateGrenades = v312(v313(v314))
        local v315 = v_u_4
        local v316 = v_u_3.DefinePacket
        local v317 = {
            ["Value"] = v_u_3.Struct({
                ["outgoing"] = v_u_3.Map(v_u_3.String, v_u_3.Array(v_u_3.Float32)),
                ["incoming"] = v_u_3.Map(v_u_3.String, v_u_3.Array(v_u_3.Float32))
            })
        }
        v302.RoundDamageMatrix = v315(v316(v317))
        local v318 = v_u_4
        local v319 = v_u_3.DefinePacket
        local v320 = {
            ["Value"] = v_u_3.Struct({
                ["PlayerName"] = v_u_3.String,
                ["Team"] = v_u_3.String,
                ["Reason"] = v_u_3.String
            })
        }
        v302.RoundMVP = v318(v319(v320))
        local v321 = v_u_4
        local v322 = v_u_3.DefinePacket
        local v323 = {
            ["Value"] = v_u_3.Struct({
                ["Assistor"] = v_u_3.Optional(v_u_3.String),
                ["Float"] = v_u_3.Optional(v_u_3.Float32),
                ["Skin"] = v_u_3.Optional(v_u_3.String),
                ["Killer"] = v_u_3.String,
                ["Victim"] = v_u_3.String,
                ["Weapon"] = v_u_3.String,
                ["Headshot"] = v_u_3.Bool,
                ["NoScope"] = v_u_3.Optional(v_u_3.Bool),
                ["Smoke"] = v_u_3.Optional(v_u_3.Bool),
                ["Wallbang"] = v_u_3.Optional(v_u_3.Bool),
                ["Blind"] = v_u_3.Optional(v_u_3.Bool),
                ["Jump"] = v_u_3.Optional(v_u_3.Bool),
                ["FlashAssist"] = v_u_3.Optional(v_u_3.Bool),
                ["DeathPosition"] = v_u_3.Optional(v_u_3.Vec3)
            })
        }
        v302.UIPlayerKilled = v321(v322(v323))
        local v324 = v_u_4
        local v325 = v_u_3.DefinePacket
        local v326 = {
            ["Value"] = v_u_3.Struct({
                ["timeLength"] = v_u_3.Float32,
                ["message"] = v_u_3.String,
                ["header"] = v_u_3.String
            })
        }
        v302.ShowNotification = v324(v325(v326))
        v302.CreateDamageIndicator = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Vec3
        }))
        local v327 = v_u_4
        local v328 = v_u_3.DefinePacket
        local v329 = {
            ["Value"] = v_u_3.Struct({
                ["KillerName"] = v_u_3.String,
                ["KillerTeam"] = v_u_3.String,
                ["Weapon"] = v_u_3.String,
                ["Headshot"] = v_u_3.Bool
            })
        }
        v302.ShowDeathCard = v327(v328(v329))
        return v302
    end),
    ["Ping"] = v11("Ping", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v330 = {}
        local v331 = v_u_4
        local v332 = v_u_3.DefinePacket
        local v333 = {
            ["Value"] = v_u_3.Struct({
                ["WeaponIdentity"] = v_u_3.Optional(v_u_3.String),
                ["WeaponName"] = v_u_3.Optional(v_u_3.String),
                ["WeaponSkin"] = v_u_3.Optional(v_u_3.String),
                ["Position"] = v_u_3.Vec3,
                ["IsDanger"] = v_u_3.Bool
            })
        }
        v330.CreatePlayerPositionPing = v331(v332(v333), {
            ["maximum_requests_per_second"] = 2
        })
        return v330
    end),
    ["TeamSelection"] = v11("TeamSelection", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v334 = {
            ["SelectTeam"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.String
            }), {
                ["maximum_requests_per_second"] = 1
            })
        }
        return v334
    end),
    ["Modes"] = v11("Modes", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v335 = {
            ["SelectGamemode"] = v_u_4(v_u_3.DefinePacket({
                ["Value"] = v_u_3.String
            }), {
                ["maximum_requests_per_second"] = 1
            })
        }
        return v335
    end),
    ["Hints"] = v11("Hints", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v336 = {}
        local v337 = v_u_4
        local v338 = v_u_3.DefinePacket
        local v339 = {
            ["Value"] = v_u_3.Struct({
                ["site"] = v_u_3.String,
                ["action"] = v_u_3.String
            })
        }
        v336.BombSiteEntered = v337(v338(v339))
        local v340 = v_u_4
        local v341 = v_u_3.DefinePacket
        local v342 = {
            ["Value"] = v_u_3.Struct({
                ["site"] = v_u_3.String,
                ["action"] = v_u_3.String
            })
        }
        v336.BombSiteExited = v340(v341(v342))
        local v343 = v_u_4
        local v344 = v_u_3.DefinePacket
        local v345 = {
            ["Value"] = v_u_3.Struct({
                ["hintType"] = v_u_3.String
            })
        }
        v336.ClearHint = v343(v344(v345))
        return v336
    end),
    ["VIP"] = v11("VIP", function()
        -- upvalues: (copy) v_u_4, (copy) v_u_3
        local v346 = {}
        local v347 = v_u_4
        local v348 = v_u_3.DefinePacket
        local v349 = {
            ["Value"] = v_u_3.Struct({
                ["Key"] = v_u_3.String,
                ["Value"] = v_u_3.Unknown
            })
        }
        v346.SetSetting = v347(v348(v349), {
            ["maximum_requests_per_second"] = 5
        })
        local v350 = v_u_4
        local v351 = v_u_3.DefinePacket
        local v352 = {
            ["Value"] = v_u_3.Struct({
                ["Action"] = v_u_3.String,
                ["Params"] = v_u_3.Optional(v_u_3.Unknown)
            })
        }
        v346.ExecuteAction = v350(v351(v352), {
            ["maximum_requests_per_second"] = 2
        })
        v346.SyncState = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Map(v_u_3.String, v_u_3.Unknown)
        }))
        v346.RequestData = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }), {
            ["maximum_requests_per_second"] = 2
        })
        local v353 = v_u_4
        local v354 = v_u_3.DefinePacket
        local v355 = {
            ["Value"] = v_u_3.Struct({
                ["Type"] = v_u_3.String,
                ["Data"] = v_u_3.Unknown
            })
        }
        v346.DataResponse = v353(v354(v355))
        return v346
    end)
})
