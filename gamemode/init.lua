AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( 'shared.lua' )

AddCSLuaFile( "cl_hud.lua" )

// Serverside only stuff goes here

/*---------------------------------------------------------
   Name: gamemode:PlayerLoadout( )
   Desc: Give the player the default spawning weapons/ammo
---------------------------------------------------------*/
function GM:PlayerLoadout( ply )

	local teamcol = team.GetColor( ply:Team() )
	--print(teamcol)
	local playercol = Vector( teamcol.r/255, teamcol.g/255, teamcol.b/255 )

	ply:Give( "weapon_sauke_rpg" )

	ply:SetRunSpeed( 500 )
	ply:SetWalkSpeed( 500 )
	ply:SetJumpPower( 200 )

	ply:SetPlayerColor( playercol )
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

	GAMEMODE:PlayerLoadout( ply )

	if ply:Team() == TEAM_COMBINE then
		ply:SetModel( table.Random( combinemodels ) )
	end
	if ply:Team() == TEAM_REBEL then
		ply:SetModel( table.Random( rebelmodels ) )
	end
end

function GM:GetFallDamage( ply, speed )
	return ( 0 )
end