#****************************************************************************
#**
#**  File     :  /lua/terranweapons.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  Terran-specific weapon definitions
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local WeaponFile = import('/lua/sim/DefaultWeapons.lua')
local CollisionBeams = import('defaultcollisionbeams.lua')
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon
local CarpetBombingWeapon = WeaponFile.CarpetBombingWeapon
local GinsuCollisionBeam = CollisionBeams.GinsuCollisionBeam
local OrbitalDeathLaserCollisionBeam = CollisionBeams.OrbitalDeathLaserCollisionBeam
local EffectTemplate = import('/lua/EffectTemplates.lua')
#added 06.07.2012
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

TDFFragmentationGrenadeLauncherWeapon= Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.THeavyFragmentationGrenadeMuzzleFlash,
}

TDFPlasmaCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TPlasmaGatlingCannonMuzzleFlash,
}

TIFFragLauncherWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TPlasmaCannonHeavyMuzzleFlash,
}

TDFHeavyPlasmaGatlingWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TPlasmaCannonHeavyMuzzleFlash,
}

TDFLightPlasmaCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TPlasmaCannonLightMuzzleFlash,
}

TDFHeavyPlasmaCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TPlasmaCannonHeavyMuzzleFlash,
}

TDFHeavyPlasmaGatlingCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.THeavyPlasmaGatlingCannonMuzzleFlash,
}


TDFOverchargeWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TCommanderOverchargeFlash01,
}

TDFMachineGunWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {
        '/effects/emitters/machinegun_muzzle_fire_01_emit.bp',
        '/effects/emitters/machinegun_muzzle_fire_02_emit.bp',
    },
}

TDFGaussCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TGaussCannonFlash,
}

TDFShipGaussCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TShipGaussCannonFlash,
}

TDFLandGaussCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TLandGaussCannonFlash,
}

TDFZephyrCannonWeapon = Class(DefaultProjectileWeapon) {
	FxMuzzleFlash = EffectTemplate.TLaserMuzzleFlash,
}

TDFRiotWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFx,
}

TAAGinsuRapidPulseWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {},
}

TDFIonizedPlasmaCannon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TIonizedPlasmaGatlingCannonMuzzleFlash,
}

TDFHiroPlasmaCannon = Class(DefaultBeamWeapon) {
    BeamType = CollisionBeams.TDFHiroCollisionBeam,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = {},
    FxUpackingChargeEffectScale = 1,

    PlayFxWeaponUnpackSequence = function( self )
        if not self.ContBeamOn then
            local army = self.unit:GetArmy()
            local bp = self:GetBlueprint()
            for k, v in self.FxUpackingChargeEffects do
                for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do
                    CreateAttachedEmitter(self.unit, ev, army, v):ScaleEmitter(self.FxUpackingChargeEffectScale)
                end
            end
            DefaultBeamWeapon.PlayFxWeaponUnpackSequence(self)
        end
    end,
}

TAAFlakArtilleryCannon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
    # Custom over-ride for this weapon, so it passes data and damageTable
    CreateProjectileForWeapon = function(self, bone)
        local proj = self:CreateProjectile(bone)
        local damageTable = self:GetDamageTable()
        local blueprint = self:GetBlueprint()
        local data = {
            Instigator = self.unit,
            Damage = blueprint.DoTDamage,
            Duration = blueprint.DoTDuration,
            Frequency = blueprint.DoTFrequency,
            Radius = blueprint.DamageRadius,
            Type = 'Normal',
            DamageFriendly = blueprint.DamageFriendly,
        }

        if proj and not proj:BeenDestroyed() then
            proj:PassDamageData(damageTable)
            proj:PassData(data)
        end

        return proj
    end
}

TAALinkedRailgun = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TRailGunMuzzleFlash01,
}


TAirToAirLinkedRailgun = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TRailGunMuzzleFlash02,
}

TIFCruiseMissileUnpackingLauncher = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {},
}
TIFCruiseMissileLauncher = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TIFCruiseMissileLaunchSmoke,
}

TIFCruiseMissileLauncherSub = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TIFCruiseMissileLaunchUnderWater,
}

TSAMLauncher = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TAAMissileLaunch,
}

TANTorpedoLandWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {
		'/effects/emitters/default_muzzle_flash_01_emit.bp',
        '/effects/emitters/default_muzzle_flash_02_emit.bp',
        '/effects/emitters/torpedo_underwater_launch_01_emit.bp',
    },
}

TANTorpedoAngler = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {
		'/effects/emitters/default_muzzle_flash_01_emit.bp',
        '/effects/emitters/default_muzzle_flash_02_emit.bp',
        '/effects/emitters/torpedo_underwater_launch_01_emit.bp',
    },
}


TIFSmartCharge = Class(DefaultProjectileWeapon) {

    CreateProjectileAtMuzzle = function(self, muzzle)
        local proj = DefaultProjectileWeapon.CreateProjectileAtMuzzle(self, muzzle)
        local tbl = self:GetBlueprint().DepthCharge
        proj:AddDepthCharge(tbl)
    end,
}


TIFCommanderDeathWeapon = Class(BareBonesWeapon) {
    FiringMuzzleBones = {0}, # just fire from the base bone of the unit

    OnCreate = function(self)
        BareBonesWeapon.OnCreate(self)
        local myBlueprint = self:GetBlueprint()
        # The "or x" is supplying default values in case the blueprint doesn't have an overriding value
        self.Data = {
            NukeOuterRingDamage = myBlueprint.NukeOuterRingDamage or 10,
            NukeOuterRingRadius = myBlueprint.NukeOuterRingRadius or 40,
            NukeOuterRingTicks = myBlueprint.NukeOuterRingTicks or 20,
            NukeOuterRingTotalTime = myBlueprint.NukeOuterRingTotalTime or 10,

            NukeInnerRingDamage = myBlueprint.NukeInnerRingDamage or 2000,
            NukeInnerRingRadius = myBlueprint.NukeInnerRingRadius or 30,
            NukeInnerRingTicks = myBlueprint.NukeInnerRingTicks or 24,
            NukeInnerRingTotalTime = myBlueprint.NukeInnerRingTotalTime or 24,
        }
        self:SetWeaponEnabled(false)
    end,

    OnFire = function(self)

    end,

    Fire = function(self)
        local myBlueprint = self:GetBlueprint()
        local myProjectile = self.unit:CreateProjectile( myBlueprint.ProjectileId, 0, 0, 0, nil, nil, nil):SetCollision(false)
        myProjectile:PassDamageData(self:GetDamageTable())
        if self.Data then
            myProjectile:PassData(self.Data)
        end
    end,

}


TIFStrategicMissileWeapon = Class(DefaultProjectileWeapon) {}

TIFArtilleryWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TIFArtilleryMuzzleFlash
}

TIFCarpetBombWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {'/effects/emitters/antiair_muzzle_fire_02_emit.bp',},

    CreateProjectileForWeapon = function(self, bone)
        local projectile = self:CreateProjectile(bone)
        local damageTable = self:GetDamageTable()
        local blueprint = self:GetBlueprint()
        local data = {
            Instigator = self.unit,
            Damage = blueprint.DoTDamage,
            Duration = blueprint.DoTDuration,
            Frequency = blueprint.DoTFrequency,
            Radius = blueprint.DamageRadius,
            Type = 'Normal',
            DamageFriendly = blueprint.DamageFriendly,
        }
        if projectile and not projectile:BeenDestroyed() then
            projectile:PassData(data)
            projectile:PassDamageData(damageTable)
        end
        return projectile
    end,
}
#changed 06.07.2012
TIFSmallYieldNuclearBombWeapon = Class(CarpetBombingWeapon) {
    FxMuzzleFlash = {'/effects/emitters/antiair_muzzle_fire_02_emit.bp',},
    #CreateRotator(unit, bone, axis, [goal], [speed], [accel], [goalspeed])  
 
}

TIFHighBallisticMortarWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TMobileMortarMuzzleEffect01,
}

TAMInterceptorWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {'/effects/emitters/terran_antinuke_launch_01_emit.bp',},
}

TAMPhalanxWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TPhalanxGunMuzzleFlash,
    FxShellEject  = EffectTemplate.TPhalanxGunShells,

    PlayFxMuzzleSequence = function(self, muzzle)
		DefaultProjectileWeapon.PlayFxMuzzleSequence(self, muzzle)
		for k, v in self.FxShellEject do
            CreateAttachedEmitter(self.unit, self:GetBlueprint().TurretBonePitch, self.unit:GetArmy(), v)
        end
    end,
}

TOrbitalDeathLaserBeamWeapon = Class(DefaultBeamWeapon) {
    BeamType = OrbitalDeathLaserCollisionBeam,
    FxUpackingChargeEffects = {},
    FxUpackingChargeEffectScale = 1,

    PlayFxWeaponUnpackSequence = function( self )
        local army = self.unit:GetArmy()
        local bp = self:GetBlueprint()
        for k, v in self.FxUpackingChargeEffects do
            for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do
                CreateAttachedEmitter(self.unit, ev, army, v):ScaleEmitter(self.FxUpackingChargeEffectScale)
            end
        end
        DefaultBeamWeapon.PlayFxWeaponUnpackSequence(self)
    end,
}

#added 14.07.2012
TSamFlaresWeapon = Class(DefaultProjectileWeapon) {
    CreateProjectileAtMuzzle = function(self, muzzle)
        local proj = DefaultProjectileWeapon.CreateProjectileAtMuzzle(self, muzzle)
    #    if not proj or proj:BeenDestroyed() then
    #        return proj
    #        #LOG('*INFO: proj:BeenDestroyed')
    #    end
        local tbl = self:GetBlueprint().SamFlares
        proj:AddSamFlares(tbl)
    end,
}

TAMLaserPhalanxWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TLaserPhalanxGunMuzzleFlash,
    #FxShellEject  = EffectTemplate.TPhalanxGunShells,

    #PlayFxMuzzleSequence = function(self, muzzle)
		#DefaultProjectileWeapon.PlayFxMuzzleSequence(self, muzzle)
		#for k, v in self.FxShellEject do
    #        CreateAttachedEmitter(self.unit, self:GetBlueprint().TurretBonePitch, self.unit:GetArmy(), v)
    #    end
    #end,
}
