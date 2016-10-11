#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0203/XSL0203_script.lua
#**  Author(s):  Greg Kohne, Gordon Duclos
#**
#**  Summary  :  Seraphim Amphibious Tank Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SHoverLandUnit = import('/lua/seraphimunits.lua').SHoverLandUnit
local SDFThauCannon = import('/lua/seraphimweapons.lua').SDFThauCannon  
local Buff = import('/lua/sim/Buff.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local AIUtils = import('/lua/ai/aiutilities.lua')
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

XSL0203 = Class(SHoverLandUnit) {

    DeathThreadDestructionWaitTime = 2,
   
    Weapons = {
        TauCannon01 = Class(SDFThauCannon){
			FxMuzzleFlashScale = 0.5,
        },
    },
   RegenBuffThread = function(self)
        while not self:IsDead() do
            #Get friendly units in the area (including self)
            local units = AIUtils.GetOwnUnitsAroundPoint(self:GetAIBrain(), categories.BUILTBYTIER3FACTORY + categories.BUILTBYQUANTUMGATE + categories.NEEDMOBILEBUILD, self:GetPosition(), 20)
            
            #Give them a self.myBuffDuration second regen buff
            for _,unit in units do
                Buff.ApplyBuff(unit, 'SeraphimTankRegenAura')
		#		LOG("Applied buff to " .. (unit:GetBlueprint().General.UnitName or "nothing"))
            end
            
            #Wait self.myBuffDuration seconds
            WaitSeconds(self.myBuffDuration)
        end
    end,
	
	OnCreate = function(self)
		SHoverLandUnit.OnCreate(self)
		self.myBuffDuration = RandomFloat(20,40)
            if not Buffs['SeraphimTankRegenAura'] then
                BuffBlueprint {
                    Name = 'SeraphimTankRegenAura',
                    DisplayName = 'SeraphimTankRegenAura',
                    BuffType = 'COMMANDERAURA',
                    Stacks = 'REPLACE',
                    Duration = self.myBuffDuration,
                    Affects = {
                        RegenPercent = {
                                Add = 0,
                                Mult = 0.002, ## lololol good value would be 0.005
                                Ceil = 75,
                                Floor = 5,
                        },
                    },
                }
                
            end
                
            table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 'XSL0001', self:GetArmy(), '/effects/emitters/seraphim_regenerative_aura_01_emit.bp' ) )
            self.RegenThreadHandle = self:ForkThread(self.RegenBuffThread)
	end,
	
}
TypeClass = XSL0203