extends Node
class_name global

const MyDictionnary = preload("res://Dictionnary.gd")
const Player = preload("res://Player.gd")
const WordsAvailable = preload("res://WordsAvailable.gd")
const Exercise = preload("res://Exercise.gd")
const Config = preload("res://Config.gd")

var level = 1
var progress1 = [85,85,85,20]
var progress2 = [85,85,85,0]
var progress3 = [0,0,0,0]
var progress = [progress1, progress2, progress3]

var score #The score when in game
var difficulty = 0 #TODO Change when game in medium or hard
var nbDifficulty = 3
var game = 1
var play = 1
var dev = 1

var config : Config = Config.new()
var customExercise : Exercise = Exercise.new()
var gooseExercise : Exercise = Exercise.new()
var listenExercise : Exercise = Exercise.new()
var thirdExercise : Exercise = Exercise.new()

var countExercise : Exercise = Exercise.new()
var weekExercise : Exercise = Exercise.new()
var colorExercise : Exercise = Exercise.new()
var exercises = [customExercise, countExercise, weekExercise, colorExercise]

var player : Player = Player.new()
var wordsAvailable : WordsAvailable = WordsAvailable.new()
var wordDictionnary = MyDictionnary.new()
var phoneticDictionnary

# Called when the node enters the scene tree for the first time.
func _ready():
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
