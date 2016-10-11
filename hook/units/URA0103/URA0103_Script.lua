#****************************************************************************
#**
#**  File     :  /cdimage/units/URA0103/URA0103_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Bomber Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#**************************************************************************** 

local VizMarker = import('/lua/sim/VizMarker.lua').VizMarker
local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CIFBombNeutronWeapon01 = import('/lua/cybranweapons.lua').CIFBombNeutronWeapon01

URA0103 = Class(CAirUnit) {
    Weapons = {
        Bomb = Class(CIFBombNeutronWeapon01) { 
        
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
          CIFBombNeutronWeapon01:OnWeaponFired()
          self:ForkThread( self.MakeVision )
        end,
        },
    },
    ExhaustBones = {'Exhaust_L','Exhaust_R',},
    ContrailBones = {'Contrail_L','Contrail_R',},
}

TypeClass = URA0103