#****************************************************************************
#**
#**  File     :  /cdimage/units/UAA0304/UAA0304_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Strategic Bomber Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local AIFBombQuarkWeapon = import('/lua/aeonweapons.lua').AIFBombQuarkWeapon
local AFlareWeapon = import('/lua/aeonweapons.lua').AAASamFlaresWeapon
UAA0304 = Class(AAirUnit) {
    Weapons = {
        Bomb = Class(AIFBombQuarkWeapon) {
            OnWeaponFired = function(self)
                self.unit:SetFuelUseTime(100)
                self:SetEnabled(false)
              AIFBombQuarkWeapon:OnWeaponFired()
            end,
        },
        Flare1 = Class(AFlareWeapon) {},
        Flare2 = Class(AFlareWeapon) {},
    }, 
      
    OnStartRefueling = function(self)
        self:SetFuelUseTime(1500)
        AAirUnit:OnStartRefueling()
        self:GetWeapon(1):SetEnabled(true)
    end,  
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
      AAirUnit.OnStopBeingBuilt(self,builder,layer)
	    self:ForkThread(self.WatchFlareDistance)
  end,
}

TypeClass = UAA0304