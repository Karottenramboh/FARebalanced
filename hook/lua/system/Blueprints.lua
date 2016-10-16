--
-- Blueprint loading
--
--   During preloading of the map, we run loadBlueprints() from this file. It scans
--   the game directories and runs all .bp files it finds.
--
--   The .bp files call UnitBlueprint(), PropBlueprint(), etc. to define a blueprint.
--   All those functions do is fill in a couple of default fields and store off the
--   table in 'original_blueprints'.
--
--   Once that scan is complete, ModBlueprints() is called. It can arbitrarily mess
--   with the data in original_blueprints.
--
--   Finally, the engine registers all blueprints in original_blueprints to define the
--   "real" blueprints used by the game. A separate copy of these blueprints is made
--   available to the sim-side and user-side scripts.
--
-- How mods can affect blueprints
--
--   First, a mod can simply add a new blueprint file that defines a new blueprint.
--
--   Second, a mod can contain a blueprint with the same ID as an existing blueprint.
--   In this case it will completely override the original blueprint. Note that in
--   order to replace an original non-unit blueprint, the mod must set the "BlueprintId"
--   field to name the blueprint to be replaced. Otherwise the BlueprintId is defaulted
--   off the source file name. (Units don't have this problem because the BlueprintId is
--   shortened and doesn't include the original path).
--
--   Third, a mod can contain a blueprint with the same ID as an existing blueprint,
--   and with the special field "Merge = true". This causes the mod to be merged with,
--   rather than replace, the original blueprint.
--
--   Finally, a mod can hook the ModBlueprints() function which manipulates the
--   blueprints table in arbitrary ways.
--      1. create a file /mod/s.../hook/system/Blueprints.lua
--      2. override ModBlueprints(all_bps) in that file to manipulate the blueprints
--
-- Reloading of changed blueprints
--
--   When the disk watcher notices that a .bp file has changed, it calls
--   ReloadBlueprint() on it. ReloadBlueprint() repeats the above steps, but with
--   original_blueprints containing just the one blueprint.
--
--   Changing an existing blueprint is not 100% reliable; some changes will be picked
--   up by existing units, some not until a new unit of that type is created, and some
--   not at all. Also, if you remove a field from a blueprint and then reload, it will
--   default to its old value, not to 0 or its normal default.
--

-- Save the original function before we overwrite it with our own.
local OldModBlueprints = ModBlueprints
-- Overwrite the original ModBlueprints

function ModBlueprints(all_blueprints)
    OldModBlueprints(all_blueprints)
	
    for id,bp in all_blueprints.Unit do
        if bp.Categories then
            local Categories = {}
			
            for _, cat in bp.Categories do
                Categories[cat] = true
            end
            if ((Categories.BUILTBYTIER1FACTORY or Categories.BUILTBYTIER2FACTORY or Categories.BUILTBYTIER3FACTORY) and Categories.LAND) then
				if bp.Physics.MaxAcceleration and bp.Physics.MaxAcceleration > 0 then
					bp.Physics.MaxAcceleration = bp.Physics.MaxAcceleration * 2
				end
				if bp.Physics.MaxBrake and bp.Physics.MaxBrake > 0 then
					bp.Physics.MaxBrake = bp.Physics.MaxBrake * 2
				end
				if bp.Physics.MaxSpeed and bp.Physics.MaxSpeed > 0 then
					bp.Physics.MaxSpeed = bp.Physics.MaxSpeed * 1.2
				end
				if bp.Physics.MaxSpeedReverse and bp.Physics.MaxSpeedReverse > 0 then
					bp.Physics.MaxSpeedReverse = bp.Physics.MaxSpeedReverse * 1.2
				end
				if bp.Physics.MaxSteerForce and bp.Physics.MaxSteerForce > 0 then
					bp.Physics.MaxSteerForce = bp.Physics.MaxSteerForce * 2
				end
				if bp.Physics.TurnFacingRate and bp.Physics.TurnFacingRate > 0 then
					bp.Physics.TurnFacingRate = bp.Physics.TurnFacingRate * 2
				end
				if bp.Physics.TurnRadius and bp.Physics.TurnRadius > 0 then
					bp.Physics.TurnRadius = bp.Physics.TurnRadius * 2
				end
				if bp.Physics.TurnRate and bp.Physics.TurnRate > 0 then
					bp.Physics.TurnRate = bp.Physics.TurnRate * 2
				end
           end
        end
    end
end