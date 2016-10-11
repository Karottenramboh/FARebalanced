##
# UEF Small Yield Nuclear Bomb
#
local TIFSmallYieldNuclearBombProjectile = import('/lua/terranprojectiles.lua').TCarpetBomb
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

TIFSmallYieldNuclearBomb01 = Class(TIFSmallYieldNuclearBombProjectile) {
	PolyTrail = '/effects/emitters/default_polytrail_04_emit.bp',
	FxLandHitScale = 0.5,
    FxUnitHitScale = 0.5,
    OnImpact = function(self, targetType, targetEntity)
        
        local army = self:GetArmy()
        if targetType == 'Terrain' or targetType == 'Prop' then
            local size = RandomFloat(4.0,12.00)
			DamageArea( self, self:GetPosition(), self.DamageData.DamageRadius, 1, 'Force', true )
            DamageArea( self, self:GetPosition(), self.DamageData.DamageRadius, 1, 'Force', true )   
            CreateDecal( self:GetPosition(), RandomFloat(0.0,6.28), 'Scorch_generic_002_albedo', '', 'Albedo', size, size, 350, 200, army )   
        end
        self:ShakeCamera( 15, 3, 0, 4 )      
		TIFSmallYieldNuclearBombProjectile.OnImpact(self, targetType, targetEntity)
    end,
}

TypeClass = TIFSmallYieldNuclearBomb01