extends Node
class_name global

const MyDictionnary = preload("res://Dictionnary.gd")
const Player = preload("res://Player.gd")
const WordsAvailable = preload("res://WordsAvailable.gd")
const Exercise = preload("res://Exercise.gd")

var level = 1
var progress1 = [85,85,85,20]
var progress2 = [85,0,85,0]
var progress3 = [0,0,0,0]
var progress = [progress1, progress2, progress3]
var score1 = [0,0,0,0]
var score2 = [0,0,0,0]
var score3 = [0,0,0,0]
var score = [score1, score2, score3]

var game = 1
var play = 1

var customExercice = Exercise.new()
var countExercice = Exercise.new()
var weekExercice = Exercise.new()
var colorExercie = Exercise.new()
var GooseExercice = Exercise.new()
var ListenAndChooseExercice = Exercise.new()
var player = Player.new()
var wordsAvailable = WordsAvailable.new()
var wordDictionnary = MyDictionnary.new()
var phoneticDictionnary

# Called when the node enters the scene tree for the first time.
func _ready():
	loadEntity()

func loadEntity():
	#We need to remplace file by lastest version
	
	ManageJson.getElement("exercise.json", "Exercise", customExercice)
	customExercice.setAttribut("nameFile", "exercise.json")
	
	ManageJson.getElement("wordsAvailable.json", "WordsAvailable", wordsAvailable)
	wordsAvailable.setAttribut("nameFile", "wordsAvailable.json")
	
	ManageJson.getElement("dictionnary.json", "Dictionnary", wordDictionnary)
	wordDictionnary.setAttribut("nameFile", "dictionnary.json")
	
	var text = ManageJson.checkFileExistUserPath("phonetic.json")
	if text == "": 
		return 0
	var tmp = JSON.parse(text)
	phoneticDictionnary = tmp.result
	
	
	ManageJson.getElement("player.json", "User", player)
	player.setAttribut("nameFile", "player.json")
