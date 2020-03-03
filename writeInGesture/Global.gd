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
var game = 1 # The type of training (1 -> MyGames, 2 -> Count, 3 -> Week, 4 -> Colors)
var play = 1 # The type of game (1 -> Goose, 2 -> Listen & Choose)
var dev = 0 # Developper mode (0 -> Disabled, 1 -> Enabled)

var try = [] # Check if the player tapped on record at least once on each word

var config : Config = Config.new()

var customExercise : Exercise = Exercise.new()
var gooseExercise : Exercise = Exercise.new()
var listenExercise : Exercise = Exercise.new()
var thirdExercise : Exercise = Exercise.new()


var countExercise : Exercise = Exercise.new()
var weekExercise : Exercise = Exercise.new()
var colorExercise : Exercise = Exercise.new()
var exercises = [customExercise, countExercise, weekExercise, colorExercise, gooseExercise, listenExercise, thirdExercise]

var player : Player = Player.new()
var wordsAvailable : WordsAvailable = WordsAvailable.new()
var wordDictionnary = MyDictionnary.new()
var phoneticDictionnary


# Called when the node enters the scene tree for the first time.
func _ready():
	os = OS.get_name()

	
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
	
	ManageJson.getElement(config.getPathExercisesFiles()[3], "Exercise", thirdExercise)
	thirdExercise.setAttribut("nameFile", config.getPathExercisesFiles()[3])
	
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
