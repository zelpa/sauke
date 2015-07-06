
GM.Name 	= "Sauke"
GM.Author 	= "Zelpa"
GM.Email 	= "N/A"
GM.Website 	= "N/A"

function GM:Initialize()

	self.BaseClass.Initialize( self )
	
end

function GM:CreateTeams()
	team.SetUp(1, "Combine", Color( 142, 68, 173 ), true)
	team.SetUp(2, "Rebels", Color( 211, 84, 0 ), true)

	team.SetSpawnPoint( 1, "info_player_start" )
	team.SetSpawnPoint( 2, "info_player_start" )
end