#****************************************************************************
#**
#**  File     :  /cdimage/units/DAA0206/DAA0206_script.lua
#**  Author(s):  Dru Staltman, Eric Williamson, Gordon Duclos, Greg Kohne
#**
#**  Summary  :  Aeon Guided Missile Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local DefaultProjectileWeapon = import('/lua/sim/defaultweapons.lua').DefaultProjectileWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local RandI = import('/lua/utilities.lua').GetRandomInt

DAA0206 = Class(AAirUnit) {
    Weapons = {
        Suicide = Class(DefaultProjectileWeapon) {
		
			AcquireNewTarget = function(self,pos)
						local r 
						local t_units = self.unit:GetAIBrain():GetUnitsAroundPoint( categories.LAND + categories.STRUCTURE, pos , 40, 'Enemy' )
						local n = table.getn(t_units)
						if (n > 0) then
							r = RandI(1,n)
							IssueClearCommands({self.unit})
							IssueAttack({self.unit}, t_units[r])
							#LOG("Retargeting unit " .. (t_units[r]:GetBlueprint().General.UnitName or "nothing"))
						#else LOG("We didnt find anything")
						end	
			end,
			TargetPositionHandle = function(self)
				#LOG("Started handle")
				
				while true do
					if self.unit:IsIdleState() then 
						#LOG("We are idle, attempting to kill stuff")
						self.AcquireNewTarget(self,self.unit:GetPosition())
					end
				WaitSeconds(2)
				end
			end,
			
			OnCreate = function(self)
				DefaultProjectileWeapon.OnCreate(self)
				self.TargetHandle = self:ForkThread(self.TargetPositionHandle)
			end,
			OnLostTarget = function(self)
				DefaultProjectileWeapon.OnLostTarget(self)
				#self.AcquireNewTarget(self,self.unit:GetPosition())
			end,
					
		}
    },
    
    OnRunOutOfFuel = function(self)
        self:Kill()
    end,
	
	
    ProjectileFired = function(self)
        self:GetWeapon(1).IdleState.Main = function(self) end
        self:PlayUnitSound('Killed')
		self:PlayUnitSound('Destroyed')
        self:Destroy()  			
    end,
}
TypeClass = DAA0206
