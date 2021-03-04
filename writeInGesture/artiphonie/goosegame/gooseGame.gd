extends Control

const NB_TILE: int = 10

var pronouncingRessource := load(Global.artiphonie.PATH_PRONOUNCING)
var pronouncingLayout: int
var pronouncingScene: Control

var currentTile = 1
var tileWords: Array

var maxAttempt: int
var attempt: int

func _ready():
	var arguments = Global.get_arguments()
	setup(arguments[0])

func setup(difficulty: String = "Facile"):
	match difficulty:
		"Facile":
			pronouncingLayout = 1
			maxAttempt = 5
	attempt = maxAttempt
	tileWords = Global.get_n_word_from_active_list(NB_TILE)
	move_player_to_next_position()
	

func get_player_position_on_tile(tileNumber: int) -> Vector2:
	var tile: TextureRect = find_node("tile_" + String(tileNumber))
	var tileCenter := Vector2(tile.rect_position.x + tile.rect_size.x/2 , tile.rect_position.y + tile.rect_size.y/2)
	return  Vector2(tileCenter.x - $player.rect_pivot_offset.x, tileCenter.y - $player.rect_pivot_offset.y)

func _on_Validate_pressed():
	find_node("Validate").disabled = true
	pronouncingScene = pronouncingRessource.instance()
	pronouncingScene.setup(tileWords[currentTile], pronouncingLayout)
	pronouncingScene.connect("pronounced", self, "_on_pronounced")
	add_child(pronouncingScene)

func _on_pronounced(word: Word, result: bool):
	if not result:
		attempt -= 1
		if attempt > 0:
			return
	pronouncingScene.queue_free()
	currentTile += 1
	move_player_to_next_position()

func move_player_to_next_position() -> void:
	var target = get_player_position_on_tile(currentTile)
	$tween.interpolate_property($player, "rect_position", $player.rect_position, target, 1, Tween.TRANS_QUINT, 0)
	$tween.start()

func _on_tween_tween_all_completed():
	find_node("Validate").disabled = false
