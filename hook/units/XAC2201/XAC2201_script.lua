#****************************************************************************
#** 
#**  File     :  /cdimage/units/XAC2201/XAC2201_script.lua 
#** 
#** 
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local weather = import('/Mods/FARebalanced/hook/lua/weather.lua')
local ACivilianStructureUnit = import('/lua/aeonunits.lua').ACivilianStructureUnit

XAC2201 = Class(ACivilianStructureUnit) {

OnCreate = function(self)
  ACivilianStructureUnit.OnCreate(self)
    weather.CreateWeather()	
end,
}


TypeClass = XAC2201

