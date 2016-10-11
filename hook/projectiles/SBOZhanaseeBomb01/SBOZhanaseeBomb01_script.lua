#****************************************************************************
#**
#**  File     :  /data/projectiles/SBOZhanaseeBomb/SBOZhanaseeBomb01_script.lua
#**  Author(s):  Greg Kohne, Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Zhanasee Bomb script, used on XSA0304
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SZhanaseeBombProjectile = import('/lua/seraphimprojectiles.lua').SNewZhanaseeBombProjectile
local DefaultExplosion = import('/lua/defaultexplosions.lua')

local EffectTemplate = import('/lua/EffectTemplates.lua')

local FxFragEffect = EffectTemplate.SNewZhanaseeBombSplit
local RandF = import('/lua/utilities.lua').GetRandomFloat
local RandI = import('/lua/utilities.lua').GetRandomInt
local EffectTemplate = import('/lua/EffectTemplates.lua')
local radius = 25
SBOZhanaseeBombProjectile01 = Class(SZhanaseeBombProjectile){

    --[[OnImpact = function(self, TargetType, TargetEntity)   
        CreateLightParticle(self, -1, self:GetArmy(), 26, 5, 'sparkle_white_add_08', 'ramp_white_24' )
        
        # One initial projectile following same directional path as the original
        self:CreateProjectile('/effects/entities/SBOZhanaseeBombEffect01/SBOZhanaseeBombEffect01_proj.bp', 0, 0, 0, 0, 10.0, 0):SetCollision(false):SetVelocity(0,10.0, 0)
        self:CreateProjectile('/effects/entities/SBOZhanaseeBombEffect02/SBOZhanaseeBombEffect02_proj.bp', 0, 0, 0, 0, 0.05, 0):SetCollision(false):SetVelocity(0,0.05, 0)
        
        if TargetType == 'Terrain' then
            ### WaitSeconds(5.0)
            ### Create our decals for like nine seconds that way there will be no problem when it comes to bombs dropping all the time.
            local pos = self:GetPosition()
            DamageArea( self, pos, self.DamageData.DamageRadius, 1, 'Force', true )
            DamageArea( self, pos, self.DamageData.DamageRadius, 1, 'Force', true )              
            CreateDecal( pos, RandomFloat(0.0,6.28), 'Scorch_012_albedo', '', 'Albedo', 40, 40, 300, 200, self:GetArmy())          
        end
		
        
		SZhanaseeBombProjectile.OnImpact(self, TargetType, TargetEntity) 
        
    end, ]]--
	SplitThread = function(self)
		WaitSeconds(1.3)
		self.OnImpact(self,nil,nil)
	end,
	OnCreate = function(self) 
		SZhanaseeBombProjectile.OnCreate(self)
		self:ForkThread(self.SplitThread)
	end,
    OnImpact = function(self, TargetType, TargetEntity) 
        
        local launcher = self:GetLauncher()
		self.myAIBrain = launcher:GetAIBrain()

        local ChildProjectileBP = '/Mods/FARebalanced/projectiles/SBOSmartBomb01/SBOSmartBomb01_proj.bp'  
              
        
        # Split effects
        for k, v in FxFragEffect do
            CreateEmitterAtEntity( self, self:GetArmy(), v )
        end
        
        local vx, vy, vz = self:GetVelocity()
        local velocity = 16		
        local numProjectiles = 25
        local angle = (2*math.pi) / numProjectiles
        local angleInitial = RandF( 0, angle )
     
        local spreadMul = 0.8 # Adjusts the width of the dispersal        
       
        local xVec = 0 
        local yVec = vy*0.8
        local zVec = 0

      
       

        local t_units
		if (launcher:GetTargetEntity()) then
			t_units = self.myAIBrain:GetUnitsAroundPoint( categories.LAND + categories.STRUCTURE, launcher:GetTargetEntity():GetPosition(),radius, 'Enemy' )
			LOG("we got a target entity")
		else 
			t_units = self.myAIBrain:GetUnitsAroundPoint( categories.LAND + categories.STRUCTURE, self:GetPosition(),radius, 'Enemy' )
			LOG("using workaround")
		end
		local t, r, iterate
		iterate = math.min((numProjectiles -1),table.getn(t_units))
        for i = 0, iterate, 1 do
			
            xVec = vx + math.sin(angleInitial + (i*angle) ) * spreadMul * RandF( 0.6, 1.3 )
            zVec = vz + math.cos(angleInitial + (i*angle) ) * spreadMul * RandF( 0.6, 1.3 )
            local proj = self:CreateChildProjectile(ChildProjectileBP)
			
            proj:SetVelocity( xVec, yVec, zVec )
            proj:SetVelocity( velocity * RandF( 0.8, 1.2 ) )
			
            proj:PassDamageData(self.DamageData)   
			
			r = RandI(1,table.getn(t_units))
			t = t_units[r]
			if (t) then proj:SetNewTarget(t) end
			

			
			table.remove(t_units,r)
			
        end        
        self:Destroy()
    end,
}
TypeClass = SBOZhanaseeBombProjectile01
