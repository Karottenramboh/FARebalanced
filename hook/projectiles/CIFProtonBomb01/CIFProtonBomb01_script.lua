#
# UEF Small Yield Nuclear Bomb
#
local CIFProtonBombProjectile = import('/lua/cybranprojectiles.lua').CIFProtonBombProjectile2
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

CIFProtonBomb01 = Class(CIFProtonBombProjectile) {
    OnImpact = function(self, targetType, targetEntity)
        
        local army = self:GetArmy()
        if targetType == 'Terrain' or targetType == 'Prop' then
            local size = RandomFloat(4.0,9.00)  
            CreateDecal( self:GetPosition(), RandomFloat(0.0,6.28), 'Scorch_002_albedo', '', 'Albedo', size, size, 350, 200, army )   
        end
       # self:ShakeCamera( 15, 3, 0, 4 )     
		CIFProtonBombProjectile.OnImpact(self, targetType, targetEntity)		
    end,
}

TypeClass = CIFProtonBomb01