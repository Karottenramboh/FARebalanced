#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0307/UAL0307_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Mobile Shield Generator Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local RandomFloat = import('/lua/utilities.lua').GetRandomFloat
local Buff = import('/lua/sim/Buff.lua')
local AIUtils = import('/lua/ai/aiutilities.lua')
local AShieldHoverLandUnit = import('/lua/aeonunits.lua').AShieldHoverLandUnit

UAL0307 = Class(AShieldHoverLandUnit) {
    
    ShieldEffects = {
        '/effects/emitters/aeon_shield_generator_mobile_01_emit.bp',
    },
    
    OnStopBeingBuilt = function(self,builder,layer)
        AShieldHoverLandUnit.OnStopBeingBuilt(self,builder,layer)
		self.ShieldEffectsBag = {}
    end,
    
    OnShieldEnabled = function(self)
        AShieldHoverLandUnit.OnShieldEnabled(self) 
        if not self.Animator then
            self.Animator = CreateAnimator(self)
            self.Trash:Add(self.Animator)
            self.Animator:PlayAnim(self:GetBlueprint().Display.AnimationOpen)
        end
        self.Animator:SetRate(1)
                
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
        for k, v in self.ShieldEffects do
            table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v ) )
        end
    end,

    OnShieldDisabled = function(self)
        AShieldHoverLandUnit.OnShieldDisabled(self)  
        if self.Animator then
            self.Animator:SetRate(-1)
        end
         
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
    end,

    RangeBuffThread = function(self)
        while not self:IsDead() do 
            if self.MyShield:IsOn() then
              #Get friendly units in the area (including self)
              local units = AIUtils.GetOwnUnitsAroundPoint(self:GetAIBrain(), categories.BUILTBYTIER3FACTORY + categories.BUILTBYQUANTUMGATE + categories.NEEDMOBILEBUILD, self:GetPosition(), self:GetBlueprint().Defense.Shield.ShieldSize/2)
              for _,unit in units do
                Buff.ApplyBuff(unit, 'AeonShieldRangeBuff')
                #LOG("Applied buff to " .. (unit:GetBlueprint().General.UnitName or "nothing"))
              end
            end  
            #Wait self.myBuffDuration seconds
            WaitSeconds(self.myBuffDuration)
        end
    end,
    
    OnCreate = function(self)
      AShieldHoverLandUnit.OnCreate(self) 
      self.myBuffDuration = RandomFloat(2,4)
      if not Buffs['AeonShieldRangeBuff'] then
        BuffBlueprint {
          Name = 'AeonShieldRangeBuff',
          DisplayName = 'AeonShieldRangeBuff',
          BuffType = 'SHIELDAURA',
          Stacks = 'REPLACE',
          Duration = self.myBuffDuration,
          Affects = {
            MaxRadius = {
                    Mult = 1.2,
            },
          },
        }
          
      end
      self.RangeBuffThread = self:ForkThread(self.RangeBuffThread)
    end
}

TypeClass = UAL0307
