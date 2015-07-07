AddCSLuaFile( )
print("Loaded rocket entity")
ENT.Type 		= "anim"
ENT.Base 		= "base_entity"

ENT.PrintName	= "Rocket"
ENT.Author		= "Arizard"
ENT.Contact		= "Don't"

ENT.Category = "Sauke"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.WorldModel = "models/weapons/w_missile_closed.mdl"

function ENT:Initialize()

	self:SetModel( self.WorldModel )
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
 	
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.phys = phys

	if SERVER then
		phys:EnableGravity( false )
		self.LoopSound = CreateSound( self, "weapons/rpg/rocket1.wav" )
		self.LoopSound:Play()
		
		self.trail = util.SpriteTrail( self, 0, Color(200,200,180), true, 4, 0, 1, 1 / (4*0.5), "trails/smoke.vmt")
	end

end

if SERVER then
	function ENT:Think()

		local ent = self

		local mins = Vector(-5,-5,-5)
		local maxs = Vector(5,5,5)
		local startpos = ent:GetPos()
		local dir = ent:GetForward()
		local len = 15

		local tr = util.TraceHull( {
			start = startpos,
			endpos = startpos + dir * len,
			maxs = maxs,
			mins = mins,
			filter = { ent, ent.data.owner }
		} )

		self.phys:SetVelocity( self.data.dir * self.data.speed )

		if tr.Hit or math.abs(self:GetVelocity():Length() - self.data.speed) > 100 then
			self:DoExplosion( tr.HitPos, tr.HitNormal )
		end

		self:NextThink(CurTime())
		return true

	end
	function ENT:Touch( e )

	end
	function ENT:DoExplosion( pos, normal )
		self.LoopSound:Stop()

		local ed = EffectData()
		ed:SetOrigin( pos )

		util.Effect( "Explosion", ed )

		--setup damageinfo
		local dmginfo = DamageInfo()
		dmginfo:SetAttacker( IsValid(self.data.owner) and self.data.owner or nil )
		dmginfo:SetDamageType( DMG_BLAST_SURFACE )
		
		-- find players in radius
		local rad = 256
		local affected = ents.FindInSphere( pos, rad )

		for k,v in ipairs( affected ) do
			local force = 1000
			local dist = pos:Distance( v:GetPos() + v:OBBCenter() )

			local frac = 1-(dist/rad)

			local dir = (v:GetPos() - pos)
			dir:Normalize()
			
			dir = dir + normal*2 -- make it force away from the rocket, but also force perpendicular to the surface.

			dir:Normalize()

			local phys = v:GetPhysicsObject()
			if v:IsPlayer() then
				v:SetVelocity( dir * force * frac )
			end
			if IsValid( phys ) then
				phys:SetVelocity( dir * (force * frac) )
			end

			dmginfo:SetDamage( self.data.damage*frac * (v == self.data.owner and 0.1 or 1) )

			-- damage the enemiesz
			v:TakeDamageInfo( dmginfo )
		end

		self:Remove()
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
