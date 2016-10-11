#****************************************************************************
#**
#**  File     :  /data/projectiles/SDFHeavyPhasicAutogun02/SDFHeavyPhasicAutogun02_script.lua
#**  Author(s):  Gordon Duclos
#**
#**  Summary  :  Heavy Phasic Autogun Projectile script, XSA0203
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SHeavyPhasicAutogun02 = import('/lua/seraphimprojectiles.lua').SHeavyPhasicAutogun02

SDFHeavyPhasicAutogun02 = Class(SHeavyPhasicAutogun02) {
    OnImpact = function(self, TargetType, TargetEntity)
			SHeavyPhasicAutogun02.OnImpact(self, TargetType, TargetEntity)
      if TargetType == 'Unit' or TargetType == 'Shield' then
  			self.newdamage = 	TargetEntity:GetMaxHealth() * 0.0025
        if self.newdamage > 150 then
           self.newdamage = 150
        end
        if self.newdamage > TargetEntity:GetHealth() then 
            Damage(self, {0,0,0}, TargetEntity, TargetEntity:GetHealth(), 'Normal')
        else
            Damage(self, {0,0,0}, TargetEntity, self.newdamage, 'Normal')
        end
        #LOG(self.newdamage)	
      end	
		end,
}
TypeClass = SDFHeavyPhasicAutogun02