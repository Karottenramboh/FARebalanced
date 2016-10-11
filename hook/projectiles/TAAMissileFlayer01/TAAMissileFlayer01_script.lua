#
# Terran Anti Air Missile
#
local TMissileAAProjectile = import('/lua/terranprojectiles.lua').TMissileAAProjectile
TAAMissileFlayer01 = Class(TMissileAAProjectile) {
  OnCreate = function(self)
    self:SetCollisionShape('Sphere', 0, 0, 0, 0)
    TMissileAAProjectile.OnCreate(self)
  end,
}

TypeClass = TAAMissileFlayer01

