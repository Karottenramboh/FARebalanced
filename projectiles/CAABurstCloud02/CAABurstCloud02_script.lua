#
# Cybran Anti Air Projectile
#
local CAAElectronBurstCloudProjectile = import('/lua/cybranprojectiles.lua').CAAElectronBurstCloudProjectile

CAABurstCloud02 = Class(CAAElectronBurstCloudProjectile) { 
  OnImpact = function(self, TargetType, TargetEntity)
    local launcher = self:GetLauncher()
    if launcher then
  		self.myAIBrain = launcher:GetAIBrain()
      local t_units = self.myAIBrain:GetUnitsAroundPoint( categories.AIR, self:GetPosition(), self.DamageData.DamageRadius, 'Enemy' )
      local number = table.getn(t_units)
      if number > 1 then
        self.DamageData.DamageAmount = self.DamageData.DamageAmount / (1.5 * (number - 1))
      end
      LOG(number)
      #LOG(repr(self))
    else
      self.DamageData.DamageAmount = self.DamageData.DamageAmount / 2
    end
    CAAElectronBurstCloudProjectile.OnImpact(self, TargetType, TargetEntity)
  end,
}

TypeClass = CAABurstCloud02