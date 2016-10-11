#****************************************************************************
#**
#**  File     :  /cdimage/units/UAS0302/UAS0302_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Battleship Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local ASeaUnit = import('/lua/aeonunits.lua').ASeaUnit
local WeaponsFile = import('/lua/aeonweapons.lua')
local ADFCannonOblivionWeapon = WeaponsFile.ADFCannonOblivionWeapon
local AAMWillOWisp = WeaponsFile.AAMWillOWisp
local ABSZapplaserWeapon = WeaponsFile.ABSZapplaserWeapon

UAS0302 = Class(ASeaUnit) {
    FxDamageScale = 2,
    DestructionTicks = 400,

    Weapons = {
        BackTurret = Class(ADFCannonOblivionWeapon) {},
        FrontTurret = Class(ADFCannonOblivionWeapon) {},
        MidTurret = Class(ADFCannonOblivionWeapon) {},
        AntiMissile1 = Class(AAMWillOWisp) {},
        AntiMissile2 = Class(AAMWillOWisp) {},
        LeftTurret1 = Class(ABSZapplaserWeapon) {},
        LeftTurret2 = Class(ABSZapplaserWeapon) {},
        LeftTurret3 = Class(ABSZapplaserWeapon) {},
        LeftTurret4 = Class(ABSZapplaserWeapon) {},
        RightTurret1 = Class(ABSZapplaserWeapon) {},
        RightTurret2 = Class(ABSZapplaserWeapon) {},
        RightTurret3 = Class(ABSZapplaserWeapon) {},
        RightTurret4 = Class(ABSZapplaserWeapon) {},
        BackTurretS = Class(ABSZapplaserWeapon) {},
    },
    
    OnCreate = function(self)
        ASeaUnit.OnCreate(self)
        for i = 1, 3 do
            self.Trash:Add(CreateAnimator(self):PlayAnim(self:GetBlueprint().Weapon[i].AnimationOpen))
        end
    end,
}

TypeClass = UAS0302