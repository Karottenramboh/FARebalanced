#****************************************************************************
#**
#**  File     :  /data/projectiles/SBOOtheTacticalBomb02/SBOOtheTacticalBomb02_script.lua
#**  Author(s):  Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Othe Tactical Bomb script, XSA0202
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
SOtheTacticalBomb = import('/lua/seraphimprojectiles.lua').SOtheTacticalBomb
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

SBOOtheTacticalBomb03 = Class(SOtheTacticalBomb) {
  
  remaining_bombs = 1,
  
  #GetVel = function(self)
  #  WaitTicks(2)
  #  self.vx, self.vy, self.vz = self:GetVelocity()
  #end,
  #OnCreate = function(self)
  #  SOtheTacticalBomb.OnCreate(self)
  #  self:ForkThread(self.GetVel)
  #end,
  
  MultiplyThread = function(self, targetType, targetEntity)
		LOG('*INFO: Velocity, x: ' .. self.vx .. ', y: ' .. self.vy .. ', z: ' .. self.vz)
    
    local ChildProjectileBP = '/Mods/FARebalanced/projectiles/SBOOtheTacticalBomb03/SBOOtheTacticalBomb03_proj.bp' 
    local velocity = 6    
    local xVec = 0 
    local yVec = 1
    local zVec = 0
		local pos = self:GetPosition();
    
    #Launch new projectile
    local proj = self:CreateChildProjectile(ChildProjectileBP)
    proj:SetVelocity(self.vx,yVec,self.vz)
    proj:SetVelocity(velocity)
    proj:PassDamageData(self.DamageData)   
    proj:SetPosition({pos[1]+ xVec*5, pos[2] + 1, pos[3]+ zVec*5},true)
    proj.vx, proj.vy, proj.vz = self.vx, self.vy, self.vz
    proj.remaining_bombs = self.remaining_bombs - 1
		SOtheTacticalBomb.OnImpact(self, targetType, targetEntity)
	end,
  OnImpact = function(self, targetType, targetEntity)
    if self.remaining_bombs > 0 then
	    self:ForkThread(self.MultiplyThread, targetType, targetEntity)
    else
      SOtheTacticalBomb.OnImpact(self, targetType, targetEntity)
    end
  end,
}
TypeClass = SBOOtheTacticalBomb03