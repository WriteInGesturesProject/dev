extends Node

# Global.gd is the only singleton of our application, it handles most
# of the communication between scenes. And the common function are
# writen here as well.
# The player is accesible here, for saving and getting the active list of word.

# ===== Globals variable specific for main menu =====
#contain the name of the different sub app
var apps : Array = ["artiphonie"]
var currentApp : String 
# ===== ===== =====

# ===== Globals specific to an application =====
const Artiphonie := preload("res://shared/artiphonie.gd")
var artiphonie := Artiphonie.new()
# ===== ===== =====

# ===== Scene shown when loading another scene
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

# ===== Everything related to the phonetic functions =====
const PHONETIC_TABLE_PATH := "res://data/phonetic_table.json"
var phoneticTable: Dictionary
const PHONETIC_TABLE_RESOURCE_PATH := "res://data/phonetic_table_resource.json"
var phoneticTableResource: Dictionary
const PHONETIC_PICTURE_PATH := "res://art/borel_maisony/icon/"
const PHONETIC_PICTURE_EXTENSION := ".png"
const PHONETIC_VIDEO_PATH := "res://art/borel_maisony/video/"
const PHONETIC_VIDEO_EXTENSION := ".ogv"
# ===== ===== =====

# Lexique383 dictionary with ortho as the key and phon as the value
# Used to compare words when one is said
# (for exemple coup, coût sound the same in french so we have to compare their phonetic)
const LEXIQUE_LIGHT_PATH := "res://data/Lexique/Lexique383_ortho_phon_light.json"
var lexiqueLight: Dictionary = {}

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
# This function allows to change scene and to give arguments if necessary.
func change_scene(newScenePath: String, arguments: Array = []) -> void:
	# We switch to the loading scene, this is in case the scene takes a lot of time
	# to load. This is kind of useless, because our scenes are pretty light and
	# most of the loading happens when the scene is launched and allready switched to.
	# So to fix this we could just place the loading scene behind all scene, but I am
	# not sure if it is worth it.
	get_tree().change_scene_to(loadingScene)
	currentScene += 1
	# We had this new scene to our chronology
	scenesChronology[currentScene] = newScenePath
	# We had the arguments to the chronology even there is none
	scenesArgumentsChronology[currentScene] = arguments
	var newSceneRessource = load(newScenePath)
	get_tree().change_scene_to(newSceneRessource)

# The scene which was changed to can choose to call get_arguments(),
# if it needed arguments to functions.
func get_arguments() -> Array:
	return scenesArgumentsChronology[currentScene].duplicate(true)

# This function is used primarly by the back button
func change_to_previous_scene() -> void:
	if currentScene == 0:
		return
	get_tree().change_scene_to(loadingScene)
	currentScene -= 1
	var newScene = load(scenesChronology[currentScene])
	get_tree().change_scene_to(newScene)
# ===== ===== =====

# Get N word from the active list
# repeat: bool -> allows to get n >= activeList.size()
#				  But it make the returned list have repeated word
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
# Load an icon from the given path
# This function is useless for moment as it returns null,
# if the path leads to nothing. However it could be really usefull
# in the future if we have a word that is missing its picture and
# we want to display a picture saying "missing picture" or just a "?"
func load_icon(path: String) -> Resource:
	var icon = load(path)
	if icon != null:
		return load(path)
	else:
		return null

# ===== ===== =====
# cmp_string_word compare a String to a Word
# This is primarly used when we use the speech to text function, which
# return one word or a full sentence (so we have to split the sentence).
# To check if the said word is the same a our word, we can check its
# "orthographe" but if that fail we have to check if the phonetic of the two
# words are the same. Because when you say for example "coup", the speech to text
# can recognize "coût" which is not wrong because it is pronounced the same.
func cmp_string_word(sentence: String, word: Word) -> bool:
	sentence = sentence.to_lower()
	var sentenceWords = sentence.split(" ")
	if sentenceWords == null or sentenceWords.size() == 0:
		return false
	for w in sentenceWords:
		if w == word.word:
			return true
		if lexiqueLight.empty():
			var file = File.new()
			file.open(LEXIQUE_LIGHT_PATH, file.READ)
			lexiqueLight = JSON.parse(file.get_as_text()).result
			file.close()
		if not lexiqueLight.has(w):
			continue
		if lexiqueLight[w] == word.phonetic:
			return true
	return false
