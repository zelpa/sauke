SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.PrintName			= "Bolt Rifle"
SWEP.Slot				= 3

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel 		= "models/weapons/v_irifle.mdl"
SWEP.WorldModel 	= "models/weapons/w_irifle.mdl"
SWEP.AnimPrefix		= "python"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 1				// Size of a clip
SWEP.Primary.DefaultClip	= 1024				// Default number of bullets in a clip
SWEP.Primary.Recoil			= 0
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "Smg1"
SWEP.Primary.Delay 			= 1

/*---------------------------------------------------------
	Initialize
---------------------------------------------------------*/
function SWEP:Initialize()

end


/*---------------------------------------------------------
	Reload
---------------------------------------------------------*/
function SWEP:Reload()
	self:DefaultReload( ACT_VM_RELOAD );
end


/*---------------------------------------------------------
   Think does nothing
---------------------------------------------------------*/
function SWEP:Think()	
end


/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	// Make sure we can shoot first
	if ( !self:CanPrimaryAttack() ) then return end

	// Play shoot sound
	self:EmitSound("Weapon_AR2.Single")
	

	self:ShootBullet( 150, 1, 0.001 )
	
	// Remove 1 bullet from our clip
	self:TakePrimaryAmmo( 1 )
	
	// Punch the player's view
	self.Owner:ViewPunch( Angle( 0, 0, 0 ) )

	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
end

function SWEP:SecondaryAttack()
	return end
end
