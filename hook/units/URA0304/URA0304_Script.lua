#****************************************************************************
#**
#**  File     :  /cdimage/units/URA0304/URA0304_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Strategic Bomber Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CIFBombNeutronWeapon = import('/lua/cybranweapons.lua').CIFBombNeutronWeapon
local CAAAutocannon = import('/lua/cybranweapons.lua').CAAAutocannon
local CFlare = import('/lua/cybranweapons.lua').CSamFlaresWeapon
URA0304 = Class(CAirUnit) {
    Weapons = {
        Bomb = Class(CIFBombNeutronWeapon) {
	--[[		DisposeEntity = function(self, orig) 
				WaitSeconds(8)
				if(orig != nil) then
					orig.createdHelperEntity = false
				end
				Destroy(self)
			end,
			
			CreateProjectileAtMuzzle = function(self, muzzle) 
				CIFBombNeutronWeapon.CreateProjectileAtMuzzle(self, muzzle) 
				local helper
				if not(self.createdHelperEntity) then
					self.createdHelperEntity = true
					helper = self.unit:CreateProjectile('/Mods/FARebalanced/projectiles/CybranT3BomberDebuff/CybranT3BomberDebuff_proj.bp' )
					if(self.unit:GetTargetEntity()) then
						helper:SetPosition(self.unit:GetTargetEntity():GetPosition(),true)
						helper.alignment = self.unit:GetVelocity()
					end
					helper:ForkThread(self.DisposeEntity, self)
				end
			end,]]--
       OnWeaponFired = function(self)
          self.unit:SetFuelUseTime(100)
          self:SetEnabled(false)
          CIFBombNeutronWeapon:OnWeaponFired()
       end,	
		},
        AAGun1 = Class(CAAAutocannon) {},
        AAGun2 = Class(CAAAutocannon) {},
        Flare1 = Class(CFlare) {},
        Flare2 = Class(CFlare) {},
        Flare3 = Class(CFlare) {},
        Flare4 = Class(CFlare) {},
    },
    ContrailBones = {'Left_Exhaust','Center_Exhaust','Right_Exhaust'},
    ExhaustBones = {'Left_Exhaust','Center_Exhaust','Right_Exhaust'},
	  OnStartRefueling = function(self)
        self:SetFuelUseTime(1500)
        CAirUnit:OnStartRefueling()
        self:GetWeapon(1):SetEnabled(true)
    end,  

	--[[FlareBurst = function(self)
	#Applies to a weapon
		local numFlares = 15
		local delayTick = 3
		local n = 0
		while (n < numFlares) do
			#self:CreateProjectile(self:GetBlueprint().RackBones.MuzzleBones[1])
			self:CreateProjectileAtMuzzle(self:GetBlueprint().RackBones.MuzzleBones[1])
			WaitTicks(delayTick)
			n = n + 1
		end	
	end,]]--
	

					
    WatchFlareDistance = function(self)
		local enableDistance = (self:GetBlueprint().General.FlareBurstDistance or 100)
		#LOG(self:GetBlueprint().General.FlareBurstDistance)
		
		while (true) do
		
			WaitSeconds(1)

			if(self:GetTargetEntity()) then

				if (VDist3(self:GetPosition(), self:GetTargetEntity():GetPosition())< enableDistance) then
					for i = 1, self:GetWeaponCount() do
						local wep = self:GetWeapon(i)
						local wepbp = wep:GetBlueprint()
						local weprof = wepbp.RateOfFire
					
				
						
						
						if (wepbp.Label == "Flare1") or (wepbp.Label == "Flare2") or (wepbp.Label == "Flare3") or (wepbp.Label == "Flare4") then
							wep:ChangeRateOfFire( (self:GetBlueprint().General.FlareBurstRoF or 2) )
							#wep:ForkThread(self.FlareBurst)
							LOG('*BUFF: RateOfFire = ' ..  4 )
						end					   
					end
			
					WaitSeconds((self:GetBlueprint().General.FlareBurstDuration or 5))
						for i = 1, self:GetWeaponCount() do
						local wep = self:GetWeapon(i)
						local wepbp = wep:GetBlueprint()
						local weprof = wepbp.RateOfFire

				
						
						
						
						if (wepbp.Label == "Flare1") or (wepbp.Label == "Flare2") or (wepbp.Label == "Flare3") or (wepbp.Label == "Flare4") then
							wep:ChangeRateOfFire( weprof )
							LOG('*BUFF: RateOfFire = ' ..  (weprof) )
							LOG("This was for weapon " .. wepbp.Label)
						end
						
					end
					WaitSeconds((self:GetBlueprint().General.FlareBurstTimeOut or 50)) ### OR UNTIL RELOAD?
				end
			end
		end
		
	end,
    OnStopBeingBuilt = function(self,builder,layer)
        CAirUnit.OnStopBeingBuilt(self,builder,layer)
        self:SetScriptBit('RULEUTC_StealthToggle', true)
		self:ForkThread(self.WatchFlareDistance)
    end,
}
TypeClass = URA0304
