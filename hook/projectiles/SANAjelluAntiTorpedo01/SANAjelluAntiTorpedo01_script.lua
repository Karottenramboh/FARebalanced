#****************************************************************************
#**
#**  File     :  /data/projectiles/SANAjelluAntiTorpedo01/SANAjelluAntiTorpedo01_script.lua
#**  Author(s):  Gordon Duclos
#**
#**  Summary  :  Seraphim Ajellu Torpedo Defense Projectile script, XSS0201, XSS0203, XSB2205
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#SANAjelluAntiTorpedo01 = Class(import('/lua/seraphimprojectiles.lua').SAnjelluTorpedoDefenseProjectile) 
local SANAjelluAntiTorpedoProjectile = import('/lua/seraphimprojectiles.lua').SDepthChargeProjectile
SANAjelluAntiTorpedo01 = Class(SANAjelluAntiTorpedoProjectile) {
}
TypeClass = SANAjelluAntiTorpedo01