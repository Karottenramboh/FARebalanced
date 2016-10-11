#****************************************************************************
#**
#**  File     :  /cdimage/units/UAA0203/UAA0203_script.lua
#**  Author(s):  Drew Staltman, Gordon Duclos
#**
#**  Summary  :  Seraphim Gunship Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local VizMarker = import('/lua/sim/VizMarker.lua').VizMarker
local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SDFPhasicAutoGunWeapon = import('/lua/seraphimweapons.lua').SDFPhasicAutoGunWeapon

XSA0203 = Class(SAirUnit) {
    Weapons = {
        TurretLeft = Class(SDFPhasicAutoGunWeapon) {
          MakeVision = function(self)
            local pos = self.unit:GetPosition()
            local spec = {
                X = pos[1],
                Z = pos[3],
                Radius = 25,
                LifeTime = 3,
                Army = self.unit:GetArmy(),
                Omni = false,
                WaterVision = false,
            }
            local vizEntity = VizMarker(spec)
          end,
          
          OnWeaponFired = function(self)
            SDFPhasicAutoGunWeapon:OnWeaponFired()
            self:ForkThread( self.MakeVision )
          end, 
        },
        TurretRight = Class(SDFPhasicAutoGunWeapon) {
          MakeVision = function(self)
            local pos = self.unit:GetPosition()
            local spec = {
                X = pos[1],
                Z = pos[3],
                Radius = 25,
                LifeTime = 2,
                Army = self.unit:GetArmy(),
                Omni = false,
                WaterVision = false,
            }
            local vizEntity = VizMarker(spec)
          end,
          
          OnWeaponFired = function(self)
            SDFPhasicAutoGunWeapon:OnWeaponFired()
            self:ForkThread( self.MakeVision )
          end, 
        },
    },
}
TypeClass = XSA0203