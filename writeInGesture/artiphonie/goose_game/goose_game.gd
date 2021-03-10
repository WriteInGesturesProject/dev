extends Control

const NB_TILE: int = 10

var pronouncingRessource := load(Global.artiphonie.PATH_PRONOUNCING)
var pronouncingLayout: int
var pronouncingScene: Control

var currentTile :int = 1
var tileWords: Array

var maxAttempt: int
var attempt: int
var attemptPerWord: Array = []

var difficulty: String

func _ready():
	var arguments = Global.get_arguments()
	difficulty = arguments[0]
	setup()

func setup():
	match difficulty:
		"Facile":
			pronouncingLayout = 1
			maxAttempt = 5
		"Normal":
			pronouncingLayout = 3
			maxAttempt = 2
		"Difficile":
			pronouncingLayout = 4
			maxAttempt = 1
	maxAttempt += 1
	attempt = maxAttempt
	tileWords = Global.get_n_word_from_active_list(NB_TILE)
	move_player_to_next_position()
	attemptPerWord.resize(NB_TILE)
	

func get_player_position_on_tile(tileNumber: int) -> Vector2:
	var tile: TextureRect = find_node("tile_" + String(tileNumber))
	var tileCenter := Vector2(tile.rect_position.x + tile.rect_size.x/2 , tile.rect_position.y + tile.rect_size.y/2)
	return  Vector2(tileCenter.x - $player.rect_pivot_offset.x, tileCenter.y - $player.rect_pivot_offset.y)

func _on_Validate_pressed():
	find_node("Validate").disabled = true
	pronouncingScene = pronouncingRessource.instance()
	pronouncingScene.setup(tileWords[currentTile-1], pronouncingLayout)
	pronouncingScene.connect("pronounced", self, "_on_pronounced")
	add_child(pronouncingScene)

func _on_pronounced(word: Word, result: bool):
	if not result:
		attempt -= 1
		if attempt > 0:
			return
	pronouncingScene.queue_free()
	attemptPerWord[currentTile-1]=maxAttempt-attempt
	attempt = maxAttempt
	Global.speechToText.stopListen()
	if(currentTile == NB_TILE):
		end_game()
	currentTile += 1
	move_player_to_next_position()

func move_player_to_next_position() -> void:
	var target = get_player_position_on_tile(currentTile)
	$tween.interpolate_property($player, "rect_position", $player.rect_position, target, 1, Tween.TRANS_QUINT, 0)
	$tween.start()

func _on_tween_tween_all_completed():
	find_node("Validate").disabled = false

func calculate_score():
	var sum = 0.0
	for element in attemptPerWord:
		sum += element
	var score = int(5.0 - float(sum/4.0))
	if score<=0:
		score = 1
	match difficulty:
		"Normal":
			score+=2
		"Difficile":
			score+=4
	return score


func end_game():
	var score = calculate_score()
	var argsToStartGame : Array = []
	argsToStartGame.append(difficulty)
	#args to send to game_end
	var args : Array = []
	args.append("res://artiphonie/goose_game/goose_game.tscn")
	args.append(argsToStartGame)
	args.append("Jeu de l'oie")
	args.append(difficulty)
	args.append(score)
	args.append(14)
	Global.change_scene("res://shared/game_end/game_end.tscn", args)
