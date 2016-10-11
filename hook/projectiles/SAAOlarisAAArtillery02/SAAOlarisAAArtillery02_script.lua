#****************************************************************************
#**
#**  File     :  /data/projectiles/SAAOlarisAAArtillery02/SAAOlarisAAArtillery02_script.lua
#**  Author(s):  Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Olaris AA Artillery Projectile script, XSL0205
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SOlarisAAArtillery = import('/lua/seraphimprojectiles.lua').SOlarisAAArtillery

SAAOlarisAAArtillery02 = Class(SOlarisAAArtillery) {
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
    SOlarisAAArtillery.OnImpact(self, TargetType, TargetEntity)
  end,
  
}
TypeClass = SAAOlarisAAArtillery02