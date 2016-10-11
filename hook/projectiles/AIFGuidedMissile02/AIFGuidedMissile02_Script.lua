#****************************************************************************
#**
#**  File     :  /data/projectiles/AIFGuidedMissile02/AIFGuidedMissile02_script.lua
#**  Author(s):  Gordon Duclos
#**
#**  Summary  :  Aeon Guided Split Missile, DAA0206
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AGuidedMissileProjectile = import('/lua/aeonprojectiles.lua').AGuidedMissileProjectile
local VizMarker = import('/lua/sim/VizMarker.lua').VizMarker
AIFGuidedMissile02 = Class(AGuidedMissileProjectile) {
	#FxTrailScale = 0.5,

    OnCreate = function(self)
  		AGuidedMissileProjectile.OnCreate(self)
      local pos = self:GetPosition()
        local spec = {
            X = pos[1],
            Z = pos[3],
            Radius = 20,
            LifeTime = 5,
            Army = self:GetArmy(),
            Omni = false,
            WaterVision = false,
        }
        local vizEntity = VizMarker(spec)
  		self:ForkThread( self.MovementThread )
    end,
    
	MovementThread = function(self)
		WaitSeconds(0.6) 
		self:TrackTarget(true)
	end,    
	OnDestroy = function(self)
	    local pos = self:GetPosition()
        local spec = {
            X = pos[1],
            Z = pos[3],
            Radius = 20,
            LifeTime = 3,
            Army = self:GetArmy(),
            Omni = false,
            WaterVision = false,
        }
        local vizEntity = VizMarker(spec)
		
		AGuidedMissileProjectile.OnDestroy(self)
	end,
}
TypeClass = AIFGuidedMissile02

