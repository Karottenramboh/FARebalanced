#****************************************************************************
#**
#**  File     :  /cdimage/lua/formations.lua
#**  Author(s):
#**
#**  Summary  :
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#
# Basic create formation scripts
#

SurfaceFormations = {
    'AttackFormation',
    'GrowthFormation',
}

AirFormations = {
    'AttackFormation',
    'GrowthFormation',
}

ComboFormations = {
    'AttackFormation',
    'GrowthFormation',
}
function BlockFormation( formationUnits )
    local rotate = true
    local smallUnitsList = {}
    local largeUnitsList = {}
    local smallUnits = 0
    local largeUnits = 0

    for i,u in formationUnits do
        local footPrintSize = u:GetFootPrintSize()
        if footPrintSize > 3  then
            largeUnitsList[largeUnits] = { u }
            largeUnits = largeUnits + 1
        else
            smallUnitsList[smallUnits] = { u }
            smallUnits = smallUnits + 1
        end
    end

    local FormationPos = {}
    local n = smallUnits + largeUnits
    local width = math.ceil(math.sqrt(n))
    local length = n / width

    # Put small units (Size 1 through 3) in front of the formation
    for i in smallUnitsList do
        local offsetX = (( math.mod(i,width)  - math.floor(width/2) ) * 2) + 1
        local offsetY = ( math.floor(i/width) - math.floor(length/2) ) * 2
        local delay = 0.1 + (math.floor(i/width) * 3)
        table.insert(FormationPos, { offsetX, -offsetY, categories.ALLUNITS, delay, rotate })
    end

    # Put large units (Size >= 4) in the back of the formation
    for i in largeUnitsList do
        local adjIndex = smallUnits + i
        local offsetX = (( math.mod(adjIndex,width)  - math.floor(width/2) ) * 2) + 1
        local offsetY = ( math.floor(adjIndex/width) - math.floor(length/2) ) * 2
        local delay = 0.1 + (math.floor(adjIndex/width) * 3)
        table.insert(FormationPos, { offsetX, -offsetY, categories.ALLUNITS, delay, rotate })
    end

    return FormationPos
end