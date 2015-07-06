AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( 'shared.lua' )

AddCSLuaFile( "cl_hud.lua" )


// Serverside only stuff goes here

/*---------------------------------------------------------
   Name: gamemode:PlayerLoadout( )
   Desc: Give the player the default spawning weapons/ammo
---------------------------------------------------------*/
function GM:PlayerLoadout( pl )

	pl:GiveAmmo( 255,	"Pistol", 		true )
	
	pl:Give( "weapon_pistol" )
	
end

local combinemodels = {
	"models/player/combine_soldier.mdl",
	"models/player/combine_soldier_prisonguard.mdl",
	"models/player/combine_super_soldier.mdl",
	"models/player/police.mdl",
	"models/player/police_fem.mdl"
}

local rebelmodels = {
	"models/player/group03/male_01.mdl",
	"models/player/group03/male_02.mdl",
	"models/player/group03/male_03.mdl",
	"models/player/group03/male_04.mdl",
	"models/player/group03/male_05.mdl",
	"models/player/group03/male_06.mdl",
	"models/player/group03/male_07.mdl",
	"models/player/group03/male_08.mdl",
	"models/player/group03/male_09.mdl",
	"models/player/group03/female_01.mdl",
	"models/player/group03/female_02.mdl",
	"models/player/group03/female_03.mdl",
	"models/player/group03/female_04.mdl",
	"models/player/group03/female_05.mdl",
	"models/player/group03/female_06.mdl"
}

function GM:PlayerInitialSpawn( ply )
	ply:SetTeam( team.BestAutoJoinTeam() )
end

function GM:PlayerSpawn( ply )
	if ply:Team() == TEAM_COMBINE then
		ply:SetModel( table.Random( combinemodels ) )
	end
	if ply:Team() == TEAM_REBEL then
		ply:SetModel( table.Random( rebelmodels ) )
	end
end