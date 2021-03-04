extends Control

func _ready():
	var gooseGameDifficulties := []
	for difficulty in Global.artiphonie.GOOSE_GAME_DIFFICULTY:
		gooseGameDifficulties.append([difficulty, false, ""])
	$playing.add_playing_element(Global.artiphonie.GOOSE_GAME_NAME, Global.artiphonie.PATH_GOOSE_GAME, 
	Global.artiphonie.PATH_GOOSE_GAME_ICON, gooseGameDifficulties)
	
	var memoryDifficulties := []
	for difficulty in Global.artiphonie.MEMORY_DIFFICULTY:
		memoryDifficulties.append([difficulty, false, ""])
	$playing.add_playing_element(Global.artiphonie.MEMORY_NAME, Global.artiphonie.PATH_MEMORY, 
	Global.artiphonie.PATH_MEMORY_ICON, memoryDifficulties)

