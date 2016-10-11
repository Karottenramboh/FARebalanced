#****************************************************************************
#**
#**  File     :  /data/projectiles/SDFAireauBolter02/SDFAireauBolter02_script.lua
#**  Author(s):  Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Aire-au Bolter Projectile script, XSL0303
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local Buff = import('/lua/sim/Buff.lua')
local SAireauBolter = import('/lua/seraphimprojectiles.lua').SAireauBolter

SDFAireauBolter02 = Class(SAireauBolter) {

  OnImpact = function(self, TargetType, TargetEntity)
      SAireauBolter.OnImpact(self, TargetType, TargetEntity)
      #LOG('*INFO OnImpact')
      if TargetType == 'Unit' then
          Buff.ApplyBuff(TargetEntity, 'SeraTankDamageDebuffWeapon')
      end
	end,
  
  OnCreate = function(self)
      SAireauBolter.OnCreate(self)
      #LOG('*INFO OnCreate')
      if not Buffs['SeraTankDamageDebuffWeapon'] then
          BuffBlueprint {
              Name = 'SeraTankDamageDebuffWeapon',
              DisplayName = 'SeraTankDamageDebuffWeapon',
              BuffType = 'SERATANKWEAPON',
              #Stacks = 'REPLACE',
              Duration = 2,
              Affects = {
                  Damage = {
                          Add = 0,
                          Mult = 0.75, ## lololol good value would be 0.005
                          #Ceil = 1.0,
                          Floor = 1.0,
                  },
              },
          }
      end          
  end,
}
TypeClass = SDFAireauBolter02