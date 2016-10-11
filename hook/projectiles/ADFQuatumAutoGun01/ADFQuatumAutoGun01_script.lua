#****************************************************************************
#**
#**  File     :  /data/projectiles/ADFQuatumAutoGun01/ADFQuatumAutoGun01_script.lua
#**  Author(s):  Gordon Duclos
#**
#**  Summary  :  Aeon Quantum Autogun Projectile script, XAL0203
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local Buff = import('/lua/sim/Buff.lua')
local AQuantumAutogun = import('/lua/aeonprojectiles.lua').AQuantumAutogun

ADFQuatumAutoGun01 = Class(AQuantumAutogun) 
{
  OnImpact = function(self, TargetType, TargetEntity)
      AQuantumAutogun.OnImpact(self, TargetType, TargetEntity)
      if TargetType == 'Unit' then
          
          #LOG('*INFO OnImpact')
          Buff.ApplyBuff(TargetEntity, 'AeonTankSpeedWeapon')
      end
	end,
  
  OnCreate = function(self)
      AQuantumAutogun.OnCreate(self)
      #LOG('*INFO OnCreate')
      if not Buffs['AeonTankSpeedWeapon'] then
          BuffBlueprint {
              Name = 'AeonTankSpeedWeapon',
              DisplayName = 'AeonTankSpeedWeapon',
              BuffType = 'BLAZEWEAPON',
              Stacks = 'REPLACE',
              Duration = 2,
              Affects = {
                  MoveMult = {
                          Add = 0,
                          Mult = 0.9, ## lololol good value would be 0.005
                          Ceil = 0.6,
                          Floor = 1.0,
                  },
              },
          }
      end          
  end,
}
TypeClass = ADFQuatumAutoGun01