#****************************************************************************
#**
#**  File     :  /data/projectiles/SAALosaareAutoCannon04\SAALosaareAutoCannon04_script.lua
#**  Author(s):  Greg Kohne, Gordon Duclos
#**
#**  Summary  :  Losaare AA AutoCannon Projectile script, XSB2304
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SLosaareAAAutoCannon = import('/lua/seraphimprojectiles.lua').SLosaareAAAutoCannon
SAAlosaareAutoCannon04 = Class(SLosaareAAAutoCannon) {
  OnCreate = function(self)
    self:SetCollisionShape('Sphere', 0, 0, 0, 0)
    SLosaareAAAutoCannon.OnCreate(self)
  end,
}
TypeClass = SAAlosaareAutoCannon04