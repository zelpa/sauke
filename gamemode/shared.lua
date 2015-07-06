GM.Name 	= "Sauke"
GM.Author 	= "Zelpa"
GM.Email 	= "N/A"
GM.Website 	= "N/A"

TEAM_COMBINE = 1
TEAM_REBEL = 2

function GM:Initialize()

	self.BaseClass.Initialize( self )
	
end

function GM:CreateTeams()
	team.SetUp(TEAM_COMBINE, "Combine", Color( 142, 68, 173 ), true)
	team.SetUp(TEAM_REBEL, "Rebels", Color( 211, 84, 0 ), true)

	team.SetSpawnPoint( TEAM_COMBINE, "info_player_start" )
	team.SetSpawnPoint( TEAM_REBEL, "info_player_start" )
end