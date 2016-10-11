#
# Aeon Anti Air Missile
#
local AMissileAAProjectile = import('/lua/aeonprojectiles.lua').AMissileAAProjectile
AAAZealotMissile01 = Class(AMissileAAProjectile) {

  OnCreate = function(self)
    self:SetCollisionShape('Sphere', 0, 0, 0, 0)
    AMissileAAProjectile.OnCreate(self)
  end,
}

TypeClass = AAAZealotMissile01

