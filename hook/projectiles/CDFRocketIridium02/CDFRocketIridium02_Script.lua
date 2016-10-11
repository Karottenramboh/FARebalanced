#****************************************************************************
#**
#**  File     :  /data/projectiles/CDFRocketIridium02/CDFRocketIridium02_script.lua
#**  Author(s):  Matt Vainio
#**
#**  Summary  :  Cybran Iridium Rocket Tubes, DRL0204
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CIridiumRocketProjectile = import('/lua/cybranprojectiles.lua').CIridiumRocketProjectile

CDFRocketIridium02 = Class(CIridiumRocketProjectile) {
    OnImpact = function(self, TargetType, TargetEntity)
			CIridiumRocketProjectile.OnImpact(self, TargetType, TargetEntity)
			if TargetType == 'Shield' then
			    if self.Data > TargetEntity:GetHealth() then
			        Damage(self, {0,0,0}, TargetEntity, TargetEntity:GetHealth(), 'Normal')
			    else
					Damage(self, {0,0,0}, TargetEntity, self.Data, 'Normal')
		        end
			end				
		end,
}

TypeClass = CDFRocketIridium02
