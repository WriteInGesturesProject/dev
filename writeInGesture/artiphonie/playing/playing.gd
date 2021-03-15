extends Control

func _ready():
	var instruction = $Instruction
	instruction.setUp("gameChoose")
	
	var gooseGameDifficulties := []
	for difficulty in Global.artiphonie.GOOSE_GAME_DIFFICULTY:
		gooseGameDifficulties.append([difficulty, false, ""])
	$playing.add_playing_element(Global.artiphonie.GOOSE_GAME_NAME, Global.artiphonie.PATH_GOOSE_GAME, 
	Global.artiphonie.PATH_GOOSE_GAME_ICON, gooseGameDifficulties)
	
	var listenAndChooseDifficulties := []
	for difficulty in Global.artiphonie.LISTEN_AND_CHOOSE_GAME_DIFFICULTY:
		listenAndChooseDifficulties.append([difficulty, false, ""])
	$playing.add_playing_element(Global.artiphonie.LISTEN_AND_CHOOSE_GAME_NAME, Global.artiphonie.PATH_LISTEN_AND_CHOOSE_GAME, 
	Global.artiphonie.PATH_LISTEN_AND_CHOOSE_GAME_ICON, listenAndChooseDifficulties)
	
	var memoryDifficulties := []
	for difficulty in Global.artiphonie.MEMORY_DIFFICULTY:
		memoryDifficulties.append([difficulty, false, ""])
	$playing.add_playing_element(Global.artiphonie.MEMORY_NAME, Global.artiphonie.PATH_MEMORY, 
	Global.artiphonie.PATH_MEMORY_ICON, memoryDifficulties)

