-- MODULESCRIPT: Sawed-Off
-- Original Path: game.BAC - 22016.Database.Custom.Weapons.Sawed-Off
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
    ["Team"] = "Terrorists",
    ["AimingOptions"] = "None",
    ["Type"] = "Heavy",
    ["MuzzleType"] = "ShotGun",
    ["ReverseIcon"] = "rbxassetid://102157038423883",
    ["Icon"] = "rbxassetid://117478678996500",
    ["Cost"] = 1100,
    ["InventoryIconData"] = {
        ["ScaleType"] = Enum.ScaleType.Crop,
        ["Size"] = UDim2.fromScale(1, 1)
    },
    ["BulletsPerShot"] = 8,
    ["FireRate"] = 0.8,
    ["Range"] = 120,
    ["RangeModifier"] = 0.5,
    ["ArmorPenetration"] = 0.7,
    ["Penetration"] = 0.1,
    ["Spread"] = {
        ["Range"] = NumberRange.new(12.5, 12.5),
        ["JumpShotMinimum"] = 15,
        ["PerShot"] = 5,
        ["RecoverySpeed"] = 4.25,
        ["MovementMultiplier"] = 0.3
    },
    ["Recoil"] = {
        ["Pattern"] = v2["Sawed-Off"],
        ["RecoverySpeed"] = 6,
        ["CameraScale"] = 1,
        ["Damper"] = 1,
        ["Speed"] = 26,
        ["Scale"] = 3.3
    },
    ["WalkSpeed"] = 17.776,
    ["RagdollMultiplier"] = 75,
    ["DamagePerPart"] = {
        ["Torso"] = 40,
        ["Head"] = 128,
        ["Arms"] = 30,
        ["Legs"] = 24
    },
    ["ReloadAnimationCount"] = 7,
    ["Capacity"] = 32,
    ["Rounds"] = 7,
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations["Sawed-Off"].CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations["Sawed-Off"].CameraAnimations,
    ["ShowCrosshair"] = true
}
return v3(v4)
