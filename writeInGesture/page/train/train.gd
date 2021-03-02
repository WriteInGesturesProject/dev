extends Control

const Exercise = preload("res://entity/Exercise.gd")
const MyDictionnary = preload("res://entity/Dictionnary.gd")

var Ex : Exercise
var textToSpeech = Global.textToSpeech
var speechToText = Global.speechToText
var words = ""
var display = false
var incremented = false
var myWords : Array = []
var index = 0
var margin = 0.05
var VectorMarge
var drawWord


func _ready():
	Ex = Global.manageGame.current_ex
	myWords = Ex.getAllWords()
	Global.manageGame.try = []
	for i in myWords:
		Global.manageGame.try.append(false)
	
	Global.manageGame.score = 0
	var scene = preload("res://page/train/drawWord.tscn")
	drawWord = scene.instance()
#	var marginMain = MarginContainer.new()
#	Global.make_margin(marginmain, 0.015)
#	marginMain.add_child(drawWord)
	add_child(drawWord)
	drawWord.display(0,myWords[0],Ex,index)
	drawWord.tryindex = index
	
	
	add_child(Global.manageInstruction.instruction("train"))
	

func back():
	Global.change_scene("res://page/home/home.tscn")


func next():
	index += 1
	if(index >= myWords.size()):
		Global.change_scene("res://page/navigation/gameEnd.tscn")
	else :
		drawWord.display(0,myWords[index],Ex,index)
		drawWord.tryindex = index
		###SCENE
	incremented = false


