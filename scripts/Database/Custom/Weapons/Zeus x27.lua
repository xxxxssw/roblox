-- MODULESCRIPT: Zeus x27
-- Original Path: game.BAC - 19854.Database.Custom.Weapons.Zeus x27
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Database.Components.Common.RecoilPatterns)
require(v1.Database.Custom.Types)
local v3 = v1.Assets:WaitForChild("WeaponAnimations")
local v4 = v3:FindFirstChild("Zeus x27") or (v3:FindFirstChild("Zeus X27") or v3:FindFirstChild("Zeus") or (v3:FindFirstChild("Taser") or v3:WaitForChild("P250")))
return table.freeze({
    ["HasSuppressor"] = false,
    ["Automatic"] = false,
    ["Droppable"] = true,
    ["HasScope"] = false,
    ["Slot"] = "Melee",
    ["WallbangMultiplier"] = 0,
    ["Class"] = "Weapon",
    ["ShootingOptions"] = "Default",
    ["Team"] = "Both",
    ["AimingOptions"] = "None",
    ["Type"] = "Pistol",
    ["MuzzleType"] = "Zeus x27",
    ["ReverseIcon"] = "rbxassetid://131579417467777",
    ["Icon"] = "rbxassetid://71464446190434",
    ["Cost"] = 200,
    ["InventoryIconData"] = {
        ["Position"] = UDim2.fromScale(0.5, 0.48),
        ["ScaleType"] = Enum.ScaleType.Fit,
        ["Size"] = UDim2.fromScale(0.95, 0.95)
    },
    ["BulletsPerShot"] = 1,
    ["FireRate"] = 0.15,
    ["Range"] = 13.584,
    ["RangeModifier"] = 0.011416,
    ["RechargeTime"] = 30,
    ["ArmorPenetration"] = 1,
    ["Penetration"] = 0,
    ["Spread"] = {
        ["Range"] = NumberRange.new(0.2, 3.5),
        ["PerShot"] = 0,
        ["RecoverySpeed"] = 10,
        ["MovementMultiplier"] = 0.04
    },
    ["Recoil"] = {
        ["Pattern"] = v2["Zeus x27"] or v2.P250,
        ["RecoverySpeed"] = 8,
        ["CameraScale"] = 0.2,
        ["Damper"] = 1,
        ["Speed"] = 20,
        ["Scale"] = 0.35
    },
    ["WalkSpeed"] = 18.584,
    ["RagdollMultiplier"] = 42,
    ["DamagePerPart"] = {
        ["Torso"] = 500,
        ["Head"] = 500,
        ["Arms"] = 500,
        ["Legs"] = 500
    },
    ["ReloadAnimationCount"] = 1,
    ["Capacity"] = 0,
    ["Rounds"] = 1,
    ["CharacterAnimations"] = v4.CharacterAnimations,
    ["CameraAnimations"] = v4.CameraAnimations,
    ["ShowCrosshair"] = true
})
