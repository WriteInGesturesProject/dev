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


var textToSpeech 
var speechToText


# ===== Globals variable available to all application =====
var player: Player = Player.new()
var activeList: Words
# ===== ===== =====

func _ready():
	load_json(player, "res://data/alice.json")
	activeList = player.listOfWords[0]
#	var alice = Player.new()
#	alice.playerName = "Alice"
#	alice.playerPath = "res://data/alice.json"
#	var tmpList: Words
#	tmpList = Words.new()
#	tmpList.words = get_n_word_from_active_list(16)
#	tmpList.listName = "Nouveaux mots"
#	tmpList.listIconPath = "res://art/images/ananas.png"
#	alice.add_words(tmpList)
#
#	tmpList = Words.new()
#	tmpList.words = get_n_word_from_active_list(16)
#	tmpList.listName = "Mots pour l'école"
#	tmpList.listIconPath = "res://art/images/crayon.png"
#	alice.add_words(tmpList)
#
#	tmpList = Words.new()
#	tmpList.words = get_n_word_from_active_list(16)
#	tmpList.listName = "Mots pour la prochaine séance"
#	alice.add_words(tmpList)
#
#	save_json(alice, alice.playerPath)

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

# ============================================================================

#TODO: Merge check_words and check_homonyms
#func check_words(sentence, myword) -> bool:
#	var sentenceWords = sentence.split(" ")
#	if(sentenceWords == null || len(sentenceWords) == 0):
#		return false
#	for w in sentenceWords:
#		if(check_homonyms(w.to_lower(), myword)):
#			return true
#	return false
#func check_homonyms(w, myword):
#	var word = wordDictionnary.get_word(myword.get_phonetic())
#	if(word == null):
#		return false
#	var h = word.getHomonym()
#	for i in range(0, len(h)):
#		if(w == h[i].to_lower()):
#			return true
#	return false
#==========================================

#func loadConfig():
#	ManageJson.getElement("config.json", "Config", config)
#	config.setAttribut("nameFile", "config.json")

#func loadEntity():
#	#We need to remplace file by lastest version
#
#	ManageJson.getElement(config.getPathExercisesFiles()[0], "Exercise", customExercise)
#	customExercise.setAttribut("nameFile", config.getPathExercisesFiles()[0])
#
#	ManageJson.getElement(config.getPathExercisesFiles()[1], "Exercise", gooseExercise)
#	gooseExercise.setAttribut("nameFile", config.getPathExercisesFiles()[1])
#
#	ManageJson.getElement(config.getPathExercisesFiles()[2], "Exercise", listenExercise)
#	listenExercise.setAttribut("nameFile", config.getPathExercisesFiles()[2])
#
#	ManageJson.getElement(config.getPathExercisesFiles()[3], "Exercise", memoryExercise)
#	memoryExercise.setAttribut("nameFile", config.getPathExercisesFiles()[3])
#
#	ManageJson.getElement("wordsAvailable.json", "WordsAvailable", wordsAvailable)
#	wordsAvailable.setAttribut("nameFile", "wordsAvailable.json")
#
#	ManageJson.getElement("dictionnary.json", "Dictionnary", wordDictionnary)
#	wordDictionnary.setAttribut("nameFile", "dictionnary.json")
#
#	ManageJson.getElement("colors.json", "Exercise", colorExercise)
#	colorExercise.setAttribut("nameFile", "colors.json")
#
#	ManageJson.getElement("week.json", "Exercise", weekExercise)
#	weekExercise.setAttribut("nameFile", "week.json")
#
#	ManageJson.getElement("number.json", "Exercise", countExercise)
#	countExercise.setAttribut("nameFile", "number.json")
#
#	var text = ManageJson.checkFileExistUserPath("phonetic.json")
#	if text == "": 
#		return 0
#	var tmp = JSON.parse(text)
#	phoneticDictionnary = tmp.result
#
#	ManageJson.getElement("player.json", "User", player)
#	player.setAttribut("nameFile", "player.json")
	

#This function create an HboxContainer with the image path in array. the size of the hbox is legthX et lenghtY
#func putBorelInHboxContainer(array : Array, lenghtX, lenghtY) :
#	var size = array.size()
#	var hbox = HBoxContainer.new()
#	hbox.rect_min_size = Vector2(lenghtX, lenghtY)
#	hbox.rect_size = Vector2(lenghtX, lenghtY)
#	hbox.alignment = HBoxContainer.ALIGN_CENTER
#	hbox.add_constant_override("separation", -1)
#	for picturePath in array :
#		var imgBorel = TextureRect.new()
#		var control = Control.new()
#		control.add_child(imgBorel)
#		hbox.add_child(control)
#
#		var image = load("res://art/imgBorel/"+picturePath)
#		imgBorel.texture = image
#		imgBorel.expand = true
#		imgBorel.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
#
#		if(size == 1) :
#			imgBorel.rect_size = Vector2(min(lenghtY, lenghtX/size), min(lenghtY, lenghtX/size)) 
#		else :
#			imgBorel.rect_size = Vector2(min(lenghtY, lenghtX/size), min(lenghtY, lenghtX/size)) 
#		if(image.get_size().x == 3000):
#			imgBorel.rect_size.y = imgBorel.rect_size.y/1.5
#			imgBorel.rect_position.y = control.rect_size.y/2+imgBorel.rect_size.y/4
#		imgBorel.get_parent().size_flags_horizontal = Control.SIZE_EXPAND
#		#Put the size of the controller parent
#		imgBorel.get_parent().rect_size = Vector2(lenghtX/size, lenghtX/size)
#		#put in center of the controller parent 
#		imgBorel.rect_position.x = control.rect_size.x/2-imgBorel.rect_size.x/2
#
#	return hbox
	
#Create an array of picturePath from a phonetic 
#func phoneticToArrayPicturePath(phonetic : String) :
#	var arrayPicture = []
#	var compt = 0
#	var img = ""
#	while (compt < len(phonetic)):
#			if(compt+1 < len(phonetic) && phonetic[compt].to_ascii()[0] == 91 && phonetic[compt+1].to_ascii()[0] == 3):
#				img = "in.png"
#				compt += 1
#			elif(compt + 1 < len(phonetic) && phonetic[compt].to_ascii()[0] == 84 && phonetic[compt + 1].to_ascii()[0] == 3):
#				img = "on.png"
#				compt += 1
#			elif(phonetic[compt].to_ascii()[0] == 226):
#				img = "an.png"
#			else :
#				var find = false
#				for b in Global.phoneticDictionnary:
#					for w in Global.phoneticDictionnary[b]:
#						if(phonetic[compt] == w["phonetic"][1]):
#							img = w["ressource_path"]
#							find = true
#							break
#					if(find):
#						break
#			arrayPicture.append(img)
#			compt += 1
#	return arrayPicture

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

	

