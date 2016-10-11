#****************************************************************************
#**
#**  File     :  /projectiles/SBOSmartBomb01/SBOSmartBomb01_script.lua' 
#**  Author(s):  ZJ
#**
#**  Summary  :  Seraphim Guided Split Missile, DAA0206
#**
#**  Copyright © 2012 Penis
#****************************************************************************
local SSmartBombProjectile = import('/lua/seraphimprojectiles.lua').SSmartBombProjectile
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

SBOSmartBomb01 = Class(SSmartBombProjectile) {
	#FxTrailScale = 0.5,

    OnCreate = function(self)
		SSmartBombProjectile.OnCreate(self)
		self:ForkThread( self.MovementThread )
    end,
    OnImpact = function(self, targetType, targetEntity)
        
        local army = self:GetArmy()
        if targetType == 'Terrain' or targetType == 'Prop' then
            local size = RandomFloat(4.0,8.00) 
            CreateDecal( self:GetPosition(), RandomFloat(0.0,6.28), 'Scorch_012_albedo', '', 'Albedo', size, size, 350, 200, army )   
        end
        #self:ShakeCamera( 15, 3, 0, 4 )     
		SSmartBombProjectile.OnImpact(self, targetType, targetEntity)		
    end,
	
	MovementThread = function(self)
		WaitSeconds(0.6)
		self:TrackTarget(true)
	end,    
}
TypeClass = SBOSmartBomb01

