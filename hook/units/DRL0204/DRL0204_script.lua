#****************************************************************************
#**
#**  File     :  /cdimage/units/DRL0204/DRL0204_script.lua
#**  Author(s):  Dru Staltman, Eric Williamson, Gordon Duclos
#**
#**  Summary  :  Cybran Rocket Bot Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CDFRocketIridiumWeapon02 = import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon02

DRL0204 = Class(CWalkingLandUnit) {
    Weapons = {
        RocketBackpack = Class(CDFRocketIridiumWeapon02) {
          CreateProjectileAtMuzzle = function(self, muzzle)
                local proj = CDFRocketIridiumWeapon02.CreateProjectileAtMuzzle(self, muzzle)
                local data = self:GetBlueprint().DamageToShields
                if proj and not proj:BeenDestroyed() then
                    proj:PassData(data)
                end
            end,
        },
    },
}
TypeClass = DRL0204
