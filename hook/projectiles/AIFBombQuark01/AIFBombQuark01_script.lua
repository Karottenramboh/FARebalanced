#
# Aeon Bomb
#
local AQuarkBombProjectile = import('/lua/aeonprojectiles.lua').AQuarkBombProjectile2
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat
AIFBombQuark01 = Class(AQuarkBombProjectile) {

    OnImpact = function(self, targetType, targetEntity)
        
        local army = self:GetArmy()
        if targetType == 'Terrain' or targetType == 'Prop' then
            local size = RandomFloat(16.0,20.00)
            CreateDecal( self:GetPosition(), RandomFloat(0.0,6.28), 'crater_radial01_albedo', '', 'Albedo', size, size, 350, 200, army )  
            CreateDecal( self:GetPosition(), RandomFloat(0.0,6.28), '/Mods/FARebalanced/env/common/decals/crater_radial02_normals.dds', '', 'Alpha Normals', size, size, 350, 200, army )   
        end
       # self:ShakeCamera( 15, 3, 0, 4 )     
		AQuarkBombProjectile.OnImpact(self, targetType, targetEntity)		
    end,
}

TypeClass = AIFBombQuark01

