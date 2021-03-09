extends Node

# ===== Globals specific to an application =====
const Artiphonie := preload("res://shared/artiphonie.gd")
var artiphonie := Artiphonie.new()
# ===== ===== =====

const loadingScene = preload("res://shared/loading/loading.tscn")

# ===== Useful for the back button =====
var currentScene: int = 0
var scenesChronology := {0: "res://main.tscn"}
var scenesArgumentsChronology := {0: []}
# ===== ===== ====

var database: DataBase = DataBase.new()
const LEXIQUE_LIGHT_PATH := "res://tools/Lexique383_light.csv"
const LEXIQUE_HEADER_WORD := "1_ortho"
const LEXIQUE_HEADER_PHONETIC := "2_phon"
const LEXIQUE_HEADER_SYLLABLE_STRUCT := "18_p_cvcv"
const LEXIQUE_HEADER_NB_SYLLABLE := "24_nbsyll"
var lexiqueLight: CSVFile = null

var textToSpeech 
var speechToText

# ===== Globals variable available to all application =====
var player: Player = Player.new()
var activeList: Words
# ===== ===== =====

func _ready():
	load_json(player, "res://data/alice.json")
	activeList = player.listOfWords[0]

# ===== JSON =====

func load_json(entity: Entity, jsonPath: String) -> Entity:
	var file = File.new()
	file.open(jsonPath, file.READ)
	entity.from_dictionary(JSON.parse(file.get_as_text()).result)
	file.close()
	return entity

func save_json(entity: Entity, jsonPath: String) -> bool:
	var file = File.new()
	file.open(jsonPath, file.WRITE)
	file.store_string(JSON.print(entity.to_dictionary(), "\t"))
	file.close()
	return true

# ===== ===== =====

# ===== Scene changement =====

func change_scene(newScenePath: String, arguments: Array = []) -> void:
	get_tree().change_scene_to(loadingScene)
	currentScene += 1
	scenesChronology[currentScene] = newScenePath
	scenesArgumentsChronology[currentScene] = arguments
	var newSceneRessource = load(newScenePath)
	get_tree().change_scene_to(newSceneRessource)

func get_arguments() -> Array:
	return scenesArgumentsChronology[currentScene].duplicate(true)

func change_to_previous_scene() -> void:
	if currentScene == 0:
		return
	get_tree().change_scene_to(loadingScene)
	currentScene -= 1
	var newScene = load(scenesChronology[currentScene])
	get_tree().change_scene_to(newScene)

# ===== ===== =====

func get_n_word_from_active_list(n: int, repeat: bool = false) -> Array:
	var randomPositions: Array = []
	randomPositions.append(randi() % activeList.words.size())
	for i in range(n-1):
		var tmp = randi() % activeList.words.size()
		if not repeat:
			while tmp in randomPositions:
				tmp = (tmp + 1) % activeList.words.size()
		randomPositions.append(tmp)
	var result: Array = []
	for randomPosition in randomPositions:
		result.append(activeList.words[randomPosition])
	return result

# ===== ===== =====

const PHONETIC_TABLE_PATH := "res://data/phonetic_table.json"
var phoneticTable:Dictionary = {}
func convert_phonetic(src: String) -> String:
	if phoneticTable.size() == 0:
		var file = File.new()
		file.open(PHONETIC_TABLE_PATH, file.READ)
		phoneticTable = JSON.parse(file.get_as_text()).result
	var result := ""
	for c in src:
		result += phoneticTable[c]
	return result

# ===== ===== =====

func find_texture(path : String):
	var tex = load("res://art/images/" + path)
	if(tex == null):
		var image = Image.new()
		var err = image.load("user://art/" + path)
		if(err) :
			image.load("user://custom/"+path)
		tex = ImageTexture.new()
		tex.create_from_image(image)
	return tex

	

