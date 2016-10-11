#****************************************************************************
#**
#**  File     :  /data/projectiles/ADFShieldDisruptor01/ADFShieldDisruptor01_script.lua
#**  Author(s):  Matt Vainio
#**
#**  Summary  :  Aeon Shield Disruptor Projectile, DAL0310
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local ADisruptorProjectile = import('/lua/aeonprojectiles.lua').AShieldDisruptorProjectile

ADFShieldDisruptor01 = Class(ADisruptorProjectile) {

  StunThread = function(self, TargetEntity)
      #LOG('*INFO: StunThread')
      TargetEntity.stuntime = 1
      TargetEntity:SetStunned(TargetEntity.stuntime)     
      while TargetEntity.stuntime > 0 do
          WaitSeconds(1)
          TargetEntity.stuntime = TargetEntity.stuntime - 1
          #LOG('*INFO: Tick: ' .. TargetEntity.stuntime)
          if(TargetEntity.stuntime > 0) then
              TargetEntity:SetStunned(TargetEntity.stuntime)
          else
              TargetEntity.stuntime = 0
          end
      end  
  end,
	OnImpact = function(self, TargetType, TargetEntity)
			if TargetType == 'Shield' then
			    if self.Data > TargetEntity:GetHealth() then
			        Damage(self, {0,0,0}, TargetEntity, TargetEntity:GetHealth(), 'Normal')
			    else
					    Damage(self, {0,0,0}, TargetEntity, self.Data, 'Normal')
		        end
			end
      if TargetType == 'Unit' then
          local targetbp = TargetEntity:GetBlueprint()
          for k, v in targetbp.Categories do
              if (v == 'EXPERIMENTAL') then
                  if TargetEntity.stuntime > 0 then
                      TargetEntity.stuntime = TargetEntity.stuntime + 1
                      TargetEntity:SetStunned(TargetEntity.stuntime)
                      #LOG('*INFO: Stuntime = ' .. TargetEntity.stuntime)
                  else
                      TargetEntity.StunThread = TargetEntity:ForkThread( self.StunThread, TargetEntity )
                      #LOG('*INFO: NewStun')
                  end
              end
          end
      else
      end	
      ADisruptorProjectile.OnImpact(self, TargetType, TargetEntity)   			
	end,
}

TypeClass = ADFShieldDisruptor01

