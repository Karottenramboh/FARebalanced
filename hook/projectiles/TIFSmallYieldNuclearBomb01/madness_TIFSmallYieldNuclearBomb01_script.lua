#
# UEF Small Yield Nuclear Bomb
#
local TIFSmallYieldNuclearBombProjectile = import('/lua/terranprojectiles.lua').TCarpetBomb
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

TIFSmallYieldNuclearBomb01 = Class(TIFSmallYieldNuclearBombProjectile) {
	PolyTrail = '/effects/emitters/default_polytrail_04_emit.bp',
	FxLandHitScale = 0.5,
    FxUnitHitScale = 0.5,
	MultiplyThread = function(self, targetType, targetEntity)
		WaitSeconds(0.2)
		
		local vx, vy, vz = self:GetVelocity()
        local velocity = 6
       
        local army = self:GetArmy()
        if targetType == 'Terrain' or targetType == 'Prop' then
            local size = RandomFloat(4.0,12.00)
            CreateDecal( self:GetPosition(), RandomFloat(0.0,6.28), 'Scorch_generic_002_albedo', '', 'Albedo', size, size, 350, 200, army )   
        end
        self:ShakeCamera( 15, 3, 0, 4 )     
        ########
		 local ChildProjectileBP = '/projectiles/TIFSmallYieldNuclearBomb01/TIFSmallYieldNuclearBomb01_proj.bp' 
		 
        local vx, vy, vz = self:GetVelocity()
        local velocity = 6
    

		# Create several other projectiles in a dispersal pattern
        local numProjectiles = 1
        local angle = (2*math.pi) / numProjectiles
        local angleInitial = RandomFloat( 0, angle )
        
        # Randomization of the spread
        local angleVariation = angle * 0.35 # Adjusts angle variance spread
        local spreadMul = 0.5 # Adjusts the width of the dispersal        
        
        local xVec = 0 
        local yVec = vy
        local zVec = 0
		local pos = self:GetPosition();
        # Launch projectiles at semi-random angles away from split location
        for i = 0, (numProjectiles -1) do
            xVec = vx + (math.sin(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation))) * spreadMul
            zVec = vz + (math.cos(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation))) * spreadMul 
            local proj = self:CreateChildProjectile(ChildProjectileBP)
            proj:SetVelocity(xVec,yVec,zVec)
            proj:SetVelocity(velocity)
            proj:PassDamageData(self.DamageData)   
			proj:SetPosition({pos[1]+ xVec*5, pos[2] + 5, pos[3]+ zVec*5},true)
        end
		 TIFSmallYieldNuclearBombProjectile.OnImpact(self, targetType, targetEntity)
	end,
    OnImpact = function(self, targetType, targetEntity)
		self:ForkThread(self.MultiplyThread, targetType, targetEntity)

		
		###############		
    end,
}

TypeClass = TIFSmallYieldNuclearBomb01