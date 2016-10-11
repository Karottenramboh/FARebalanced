#****************************************************************************
#**
#**  File     :  /units/XSA0304/XSA0304_script.lua
#**  Author(s):  Drew Staltman, Greg Kohne, Gordon Duclos
#**
#**  Summary  :  Seraphim Strategic Bomber Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SIFBombZhanaseeWeapon = import('/lua/seraphimweapons.lua').SIFBombZhanaseeWeapon
local SFlares = import('/lua/seraphimweapons.lua').SSamFlaresWeapon 

XSA0304 = Class(SAirUnit) {
    Weapons = {
        Bomb = Class(SIFBombZhanaseeWeapon) {
        OnWeaponFired = function(self)
            self.unit:SetFuelUseTime(100)
            self:SetEnabled(false)
            SIFBombZhanaseeWeapon:OnWeaponFired()
         end,	
       },
        Flare1 = Class(SFlares) {},
        Flare2 = Class(SFlares) {}, 
        Flare3 = Class(SFlares) {},  
    },
    OnStartRefueling = function(self)
        self:SetFuelUseTime(1500)
        SAirUnit:OnStartRefueling()
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
      SAirUnit.OnStopBeingBuilt(self,builder,layer)
	    self:ForkThread(self.WatchFlareDistance)
  end,
}
TypeClass = XSA0304