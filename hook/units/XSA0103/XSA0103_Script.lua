#****************************************************************************
#**
#**  File     :  /data/units/XSA0103/XSA0103_script.lua
#**  Author(s):  Jessica St. Croix
#**
#**  Summary  :  Seraphim Bomber Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local VizMarker = import('/lua/sim/VizMarker.lua').VizMarker
local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SDFBombOtheWeapon = import('/lua/seraphimweapons.lua').SDFBombOtheWeapon

XSA0103 = Class(SAirUnit) {
    Weapons = {
        Bomb = Class(SDFBombOtheWeapon) {
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
              SDFBombOtheWeapon:OnWeaponFired()
              self:ForkThread( self.MakeVision )
            end,
        },
    },
}

TypeClass = XSA0103