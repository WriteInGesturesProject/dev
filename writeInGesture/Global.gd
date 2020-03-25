extends Node
class_name global

const MyDictionnary = preload("res://Dictionnary.gd")
const Player = preload("res://Player.gd")
const WordsAvailable = preload("res://WordsAvailable.gd")
const Exercise = preload("res://Exercise.gd")
const Config = preload("res://Config.gd")

var os # Variable used to know on which plateform we are

var tts = null # The Text To Speech Object
var stt = null # The Speech To Text Object


var current_ex : Exercise # The exercise we are playing

var score # The score when in game
var level = 0 # The difficulty (0 -> Easy, 1 -> Medium, 2 -> Hard)
var nbDifficulty = 3
var game = 0 # The type of training (1 -> MyGames, 2 -> Count, 3 -> Week, 4 -> Colors)
var play = 0 # The type of game (1 -> Goose, 2 -> Listen & Choose, 3 -> Memory)
var dev = 0 # Developper mode (0 -> Disabled, 1 -> Enabled)
var max_cards = 12

var try = [] # Check if the player tapped on record at least once on each word

var config : Config = Config.new()

var customExercise : Exercise = Exercise.new()
var gooseExercise : Exercise = Exercise.new()
var listenExercise : Exercise = Exercise.new()
var memoryExercise : Exercise = Exercise.new()


var countExercise : Exercise = Exercise.new()
var weekExercise : Exercise = Exercise.new()
var colorExercise : Exercise = Exercise.new()
var exercises = [customExercise, countExercise, weekExercise, colorExercise, gooseExercise, listenExercise]

var player : Player = Player.new()
var wordsAvailable : WordsAvailable = WordsAvailable.new()
var wordDictionnary = MyDictionnary.new()
var phoneticDictionnary


# Called when the node enters the scene tree for the first time.
func _ready():
	os = OS.get_name()
	
	var osRequest = OS.request_permissions()
	
	match os:
		"X11":
			#tts = TTSDriver.new()
			set_process(true)
			if(tts != null):
				tts.set_voice("French (France)")
		"Android":
			if(Engine.has_singleton("GodotTextToSpeech")):
				tts = Engine.get_singleton("GodotTextToSpeech")
				tts.fireTTS()
			if(Engine.has_singleton("GodotSpeech")):
				stt = Engine.get_singleton("GodotSpeech")
	
	loadEntity()

func check_words(sentence, myword):
	var words = sentence.split(" ")
	if(words == null || len(words) == 0):
		return false
	for w in words:
		if(check_homonyms(w.to_lower(), myword)):
			return true
	return false

	
func check_homonyms(w, myword):
	var word = wordDictionnary.getWord(myword.getPhonetic())
	if(word == null):
		#print("Word in check_homonyms is null")
		return false
	var h = word.getHomonym()
	for i in range(0, len(h)):
		if(w == h[i].to_lower()):
			return true
	return false

func loadEntity():
	#We need to remplace file by lastest version
	ManageJson.getElement("config.json", "Config", config)
	config.setAttribut("nameFile", "config.json")
	
	ManageJson.getElement(config.getPathExercisesFiles()[0], "Exercise", customExercise)
	customExercise.setAttribut("nameFile", config.getPathExercisesFiles()[0])
	
	ManageJson.getElement(config.getPathExercisesFiles()[1], "Exercise", gooseExercise)
	gooseExercise.setAttribut("nameFile", config.getPathExercisesFiles()[1])
	
	ManageJson.getElement(config.getPathExercisesFiles()[2], "Exercise", listenExercise)
	listenExercise.setAttribut("nameFile", config.getPathExercisesFiles()[2])
	
	ManageJson.getElement(config.getPathExercisesFiles()[3], "Exercise", memoryExercise)
	memoryExercise.setAttribut("nameFile", config.getPathExercisesFiles()[3])
	
	ManageJson.getElement("wordsAvailable.json", "WordsAvailable", wordsAvailable)
	wordsAvailable.setAttribut("nameFile", "wordsAvailable.json")
	
	ManageJson.getElement("dictionnary.json", "Dictionnary", wordDictionnary)
	wordDictionnary.setAttribut("nameFile", "dictionnary.json")
	
	ManageJson.getElement("colors.json", "Exercise", colorExercise)
	colorExercise.setAttribut("nameFile", "colors.json")
	 
	ManageJson.getElement("week.json", "Exercise", weekExercise)
	weekExercise.setAttribut("nameFile", "week.json")
	
	ManageJson.getElement("number.json", "Exercise", countExercise)
	countExercise.setAttribut("nameFile", "number.json")
	
	var text = ManageJson.checkFileExistUserPath("phonetic.json")
	if text == "": 
		return 0
	var tmp = JSON.parse(text)
	phoneticDictionnary = tmp.result
	
	ManageJson.getElement("player.json", "User", player)
	player.setAttribut("nameFile", "player.json")

#This function create an HboxContainer with the image path in array. the size of the hbox is legthX et lenghtY
func putBorelInHboxContainer(array : Array, lenghtX, lenghtY) :
	var size = array.size()
	var hbox = HBoxContainer.new()
	hbox.rect_min_size = Vector2(lenghtX, lenghtY)
	hbox.rect_size = Vector2(lenghtX, lenghtY)
	hbox.alignment = HBoxContainer.ALIGN_CENTER
	hbox.add_constant_override("separation", -1)
	for picturePath in array :
		var imgBorel = TextureRect.new()
		var control = Control.new()
		control.add_child(imgBorel)
		hbox.add_child(control)
		
		var image = load("res://art/imgBorel/"+picturePath)
		imgBorel.texture = image
		imgBorel.expand = true
		imgBorel.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
		
		if(size == 1) :
			imgBorel.rect_size = Vector2(min(lenghtY, lenghtX/size), min(lenghtY, lenghtX/size)) 
		else :
			imgBorel.rect_size = Vector2(min(lenghtY, lenghtX/size), min(lenghtY, lenghtX/size)) 
		if(image.get_size().x == 3000):
			imgBorel.rect_size.y = imgBorel.rect_size.y/1.5
			imgBorel.rect_position.y = control.rect_size.y/2+imgBorel.rect_size.y/4
		imgBorel.get_parent().size_flags_horizontal = Control.SIZE_EXPAND
		#Put the size of the controller parent
		imgBorel.get_parent().rect_size = Vector2(lenghtX/size, lenghtX/size)
		#put in center of the controller parent 
		imgBorel.rect_position.x = control.rect_size.x/2-imgBorel.rect_size.x/2

	return hbox
	
#Create an array of picturePath from a phonetic 
func phoneticToArrayPicturePath(phonetic : String) :
	var arrayPicture = []
	var compt = 0
	var img = ""
	while (compt < len(phonetic)):
			if(compt+1 < len(phonetic) && phonetic[compt].to_ascii()[0] == 91 && phonetic[compt+1].to_ascii()[0] == 3):
				img = "in.png"
				compt += 1
			elif(compt + 1 < len(phonetic) && phonetic[compt].to_ascii()[0] == 84 && phonetic[compt + 1].to_ascii()[0] == 3):
				img = "on.png"
				compt += 1
			elif(phonetic[compt].to_ascii()[0] == 226):
				img = "an.png"
			else :
				var find = false
				for b in Global.phoneticDictionnary:
					for w in Global.phoneticDictionnary[b]:
						if(phonetic[compt] == w["phonetic"][1]):
							img = w["ressource_path"]
							find = true
							break
					if(find):
						break
			arrayPicture.append(img)
			compt += 1
	return arrayPicture

func make_margin(margeContainer : MarginContainer, marge):
	margeContainer.set("custom_constants/margin_top", get_viewport().size.y * marge)
	margeContainer.set("custom_constants/margin_bottom", get_viewport().size.y * marge)
	margeContainer.set("custom_constants/margin_left", get_viewport().size.x * marge)
	margeContainer.set("custom_constants/margin_right", get_viewport().size.x * marge)
	return
	
func find_texture(path : String):
	var tex = load("res://art/images/" + path)
	if(tex == null):
		var image = Image.new()
		image.load("user://art/" + path)
		tex = ImageTexture.new()
		tex.create_from_image(image)
	return tex
