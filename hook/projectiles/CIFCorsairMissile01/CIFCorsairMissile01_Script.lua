#
# Cybran Anti Air Missile
#
local CCorsairRocketProjectile = import('/lua/cybranprojectiles.lua').CCorsairRocketProjectile
CDFCorsairRocket01 = Class(CCorsairRocketProjectile) {
    OnImpact = function(self, TargetType, TargetEntity)
			CCorsairRocketProjectile.OnImpact(self, TargetType, TargetEntity)
			if TargetType == 'Shield' then
			    if self.Data > TargetEntity:GetHealth() then
			        Damage(self, {0,0,0}, TargetEntity, TargetEntity:GetHealth(), 'Normal')
			    else
					    Damage(self, {0,0,0}, TargetEntity, self.Data, 'Normal')
		      end
			end				
		end,
}

TypeClass = CDFCorsairRocket01
