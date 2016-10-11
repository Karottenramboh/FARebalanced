#****************************************************************************
#**
#**  File     :  /data/projectiles/ADFQuatumAutoGun01/ADFQuatumAutoGun01_script.lua
#**  Author(s):  Gordon Duclos
#**
#**  Summary  :  Aeon Quantum Autogun Projectile script, XAL0203
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SFlares = import('/lua/seraphimprojectiles.lua').SSamFlareProjectile

SFlares01 = Class(SFlares) 
{
  ManipulateVelocity = function(self)
    WaitTicks(2)
    local px, py, pz = self:GetVelocity()
    LOG('*INFO: px: ' .. px .. ', py: ' .. py .. ', pz: ' .. pz)
    local vx, vy, vz = self:GetLauncher():GetVelocity()
    LOG('*INFO: vx: ' .. vx .. ', vy: ' .. vy .. ', vz: ' .. vz)
    self:SetVelocity((px*10) + (vx*5), (py*10) + (vy*5), (pz*10) + (vz*5))
  end,
  OnCreate = function(self)
    SFlares.OnCreate(self)
    self:ForkThread(self.ManipulateVelocity)
  end,
}
TypeClass = SFlares01