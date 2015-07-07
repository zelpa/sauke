SWEP.PrintName = "Rocket Launcher"

SWEP.Author			= "Arizard"
SWEP.Contact		= "Don't"
SWEP.Purpose		= "Launches Rockets"
SWEP.Instructions	= "Point away from face."

SWEP.DrawAmmo			= true
SWEP.UseHands = true

SWEP.ViewModelFOV	= 40
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_rpg.mdl"
SWEP.WorldModel		= "models/weapons/w_rocket_launcher.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8					-- Size of a clip
SWEP.Primary.DefaultClip	= 1024				-- Default number of bullets in a clip
SWEP.Primary.Automatic		= false				-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "smg1"
SWEP.Primary.Delay = 0.4

SWEP.Secondary.ClipSize		= 0					-- Size of a clip
SWEP.Secondary.DefaultClip	= 0				-- Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				-- Automatic/Semi Auto
SWEP.Secondary.Ammo			= "none"


function SWEP:Initialize()

end


function SWEP:Reload()
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

function SWEP:Think()	
end


function SWEP:PrimaryAttack()

	if not self:CanPrimaryAttack() then return end

	if SERVER then
		local rocket = {}
		rocket.ent = ents.Create("ent_sauke_rocket")
		rocket.dir = self.Owner:GetAimVector()
		rocket.pos = self.Owner:EyePos() + self.Owner:GetAimVector()*2.5
		rocket.ang = self.Owner:EyeAngles()
		rocket.speed = 1800 -- units per second
		rocket.owner = self.Owner

		rocket.damage = 100

		rocket.ent:Spawn()

		rocket.ent:SetOwner( self.Owner )
		rocket.ent:SetPos( rocket.pos )
		rocket.ent:SetAngles( rocket.ang )

		rocket.ent.data = rocket -- inception

		self.Owner:EmitSound("weapons/rpg/rocketfire1.wav")
	end

	self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	self:TakePrimaryAmmo( 1 )
	
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

end

function SWEP:SecondaryAttack()
	
end
