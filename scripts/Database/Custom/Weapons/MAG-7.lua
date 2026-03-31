-- MODULESCRIPT: MAG-7
-- Original Path: game.BAC - 22016.Database.Custom.Weapons.MAG-7
-- Decompiled script extracted from game dump

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Database.Components.Common.RecoilPatterns)
require(v1.Database.Custom.Types)
local v3 = table.freeze
local v4 = {
    ["HasSuppressor"] = false,
    ["Automatic"] = false,
    ["Droppable"] = true,
    ["HasScope"] = false,
    ["Slot"] = "Primary",
    ["WallbangMultiplier"] = 0.5,
    ["Class"] = "Weapon",
    ["ShootingOptions"] = "Default",
    ["Team"] = "Counter-Terrorists",
    ["AimingOptions"] = "None",
    ["Type"] = "Heavy",
    ["MuzzleType"] = "ShotGun",
    ["ReverseIcon"] = "rbxassetid://79977904375648",
    ["Icon"] = "rbxassetid://86291171438206",
    ["Cost"] = 1300,
    ["InventoryIconData"] = {
        ["ScaleType"] = Enum.ScaleType.Crop,
        ["Size"] = UDim2.fromScale(1, 1)
    },
    ["BulletsPerShot"] = 8,
    ["FireRate"] = 0.88,
    ["Range"] = 120,
    ["RangeModifier"] = 0.45,
    ["ArmorPenetration"] = 0.75,
    ["Penetration"] = 0.1,
    ["Spread"] = {
        ["Range"] = NumberRange.new(9, 9),
        ["JumpShotMinimum"] = 12,
        ["PerShot"] = 3,
        ["RecoverySpeed"] = 4.25,
        ["MovementMultiplier"] = 0.3
    },
    ["Recoil"] = {
        ["Pattern"] = v2["MAG-7"],
        ["RecoverySpeed"] = 6,
        ["CameraScale"] = 1,
        ["Damper"] = 1,
        ["Speed"] = 26,
        ["Scale"] = 3.3
    },
    ["WalkSpeed"] = 17.776,
    ["RagdollMultiplier"] = 75,
    ["DamagePerPart"] = {
        ["Torso"] = 37,
        ["Head"] = 120,
        ["Arms"] = 24,
        ["Legs"] = 22
    },
    ["ReloadAnimationCount"] = 1,
    ["Capacity"] = 15,
    ["Rounds"] = 5,
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations["MAG-7"].CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations["MAG-7"].CameraAnimations,
    ["ShowCrosshair"] = true
}
return v3(v4)
