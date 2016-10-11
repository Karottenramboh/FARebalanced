#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0103/UEA0103_script.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  Terran Carpet Bomber Unit Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#
# Terran Bomber Script : UEA0103
#
local VizMarker = import('/lua/sim/VizMarker.lua').VizMarker
local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TIFCarpetBombWeapon = import('/lua/terranweapons.lua').TIFCarpetBombWeapon


UEA0103 = Class(TAirUnit) {
    Weapons = {
        Bomb = Class(TIFCarpetBombWeapon) {
           MakeVision = function(self)
            WaitSeconds(2)
            local pos = self.unit:GetPosition()
            local spec = {
                X = pos[1],
                Z = pos[3],
                Radius = 15,
                LifeTime = 4,
                Army = self.unit:GetArmy(),
                Omni = false,
                WaterVision = false,
            }
            local vizEntity = VizMarker(spec)
          end,
        
          OnWeaponFired = function(self)
            TIFCarpetBombWeapon:OnWeaponFired()
            self:ForkThread( self.MakeVision )
          end,
        },
      },
#    DestructionPartsLowToss = {'P01', 'P02', 'P03', 'P04', 'P05', 'P06', },
#    DestructionTicks = 50,
    DamageEffectPullback = 0.5,
}

TypeClass = UEA0103

