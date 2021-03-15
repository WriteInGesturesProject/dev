extends Node

# ===== Globals variable specific for main menu =====
#contain the name of the different sub app
var apps : Array = ["artiphonie"]
# ===== ===== =====

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

# ===== Globals variable related to instruction =====
var player: Player = Player.new()
var activeList: Words
# ===== ===== =====

var textToSpeech 
var speechToText

const PHONETIC_TABLE_PATH := "res://data/phonetic_table.json"
var phoneticTable: Dictionary
const PHONETIC_TABLE_RESOURCE_PATH := "res://data/phonetic_table_resource.json"
var phoneticTableResource: Dictionary
const PHONETIC_PICTURE_PATH := "res://art/borel_maisony/icon/"
const PHONETIC_PICTURE_EXTENSION := ".png"
const PHONETIC_VIDEO_PATH := "res://art/borel_maisony/video/"
const PHONETIC_VIDEO_EXTENSION := ".ogv"

# ===== Globals variable available to all application =====
var instructionAlreadyPlayed: Array = []
# ===== ===== =====

func _ready():
	var file = File.new()
	file.open(PHONETIC_TABLE_PATH, file.READ)
	phoneticTable = JSON.parse(file.get_as_text()).result
	file.close()
	
	file = File.new()
	file.open(PHONETIC_TABLE_RESOURCE_PATH, file.READ)
	phoneticTableResource = JSON.parse(file.get_as_text()).result
	file.close()
	
	load_json(player, "res://data/general.json")
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

# ===== Phonetic =====
#convert the code phonetic of a word into the visual API phonetic code
func convert_phonetic(phonetic: String) -> String:
	var result := ""
	for p in phonetic:
		result += phoneticTable[p]
	return result

#get an array of borelImage which represent the code phonetic
func phonetic_to_array_picture_path(phonetic: String) -> Array:
	var result: Array = []
	for i in range(len(phonetic)):
		if phonetic[i] == "w":
			if i + 1 >= len(phonetic):
				break
			elif phonetic[i + 1] == "a":
				result.append(PHONETIC_PICTURE_PATH + "wa" + PHONETIC_PICTURE_EXTENSION)
				i += 1
			elif phonetic[i + 1] == "5":
				result.append(PHONETIC_PICTURE_PATH + "w5" + PHONETIC_PICTURE_EXTENSION)
				i += 1
		else:
			if phoneticTableResource[phonetic[i]] != "":
				result.append(PHONETIC_PICTURE_PATH + phoneticTableResource[phonetic[i]] + PHONETIC_PICTURE_EXTENSION)
	return result

#get an array of video  which represent the code phonetic
func phonetic_to_array_video_path(phonetic: String) -> Array:
	var result: Array = []
	for i in range(len(phonetic)):
		if phonetic[i] == "w":
			if i + 1 >= len(phonetic):
				break
			elif phonetic[i + 1] == "a":
				result.append(PHONETIC_VIDEO_PATH + "wa" + PHONETIC_VIDEO_EXTENSION)
				i += 1
			elif phonetic[i + 1] == "5":
				result.append(PHONETIC_VIDEO_PATH + "w5" + PHONETIC_VIDEO_EXTENSION)
				i += 1
		else:
			if phoneticTableResource[phonetic[i]] != "":
				result.append(PHONETIC_VIDEO_PATH + phoneticTableResource[phonetic[i]] + PHONETIC_VIDEO_EXTENSION)
	return result

# ===== ===== =====

func load_icon(path: String) -> Resource:
	var icon = load(path)
	if icon != null:
		return load(path)
	else:
		return null

# ===== ===== =====
