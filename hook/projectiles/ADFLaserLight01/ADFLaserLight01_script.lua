#
# Aeon laser 'bolt'
#
local ALightLaserProjectile = import('/lua/aeonprojectiles.lua').ALightLaserProjectile
ADFLaserLight01 = Class(ALightLaserProjectile) {

  OnImpact = function(self, TargetType, TargetEntity)
      ALightLaserProjectile.OnImpact(self, TargetType, TargetEntity)
      if TargetType == 'Shield' then
        DamageArea(self, TargetEntity.Owner:GetPosition(), TargetEntity.Size/2, 1, 'Normal', false)
      end
	end,
}

TypeClass = ADFLaserLight01

