#****************************************************************************
#**
#**  File     :  /cdimage/units/UAA0103/UAA0103_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Bomber Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local VizMarker = import('/lua/sim/VizMarker.lua').VizMarker
local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local AIFBombGravitonWeapon = import('/lua/aeonweapons.lua').AIFBombGravitonWeapon

UAA0103 = Class(AAirUnit) {
    Weapons = {
        Bomb = Class(AIFBombGravitonWeapon) {
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
          AIFBombGravitonWeapon:OnWeaponFired()
          self:ForkThread( self.MakeVision )
        end,
        },
    },
}

TypeClass = UAA0103

