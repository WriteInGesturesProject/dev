extends Control

#const TTSDriver = preload("res://modules/TTS/TTSDriver.gdns")

const Exercise = preload("res://Exercise.gd")
const MyDictionnary = preload("res://Dictionnary.gd")

var Ex : Exercise
var tts = Global.tts
var stt = Global.stt
var words = ""
var display = false
var incremented = false
var myWords : Array = []
var index = 0
var os = Global.os
var margin = 0.05
var VectorMarge
var drawWord


func _ready():
	Ex = Global.current_ex
	myWords = Ex.getAllWords()
	Global.try = []
	for i in myWords:
		Global.try.append(false)
	
	Global.score = 0
	var scene = preload("res://DrawWord.tscn")
	drawWord = scene.instance()
#	var marginMain = MarginContainer.new()
#	marginMain.add_constant_override("margin_left", get_viewport().size.y * 0.015)
#	marginMain.add_constant_override("margin_top", get_viewport().size.y * 0.015)
#	marginMain.add_constant_override("margin_right", get_viewport().size.y * 0.015)
#	marginMain.add_constant_override("margin_bottom", get_viewport().size.y * 0.015)
#	marginMain.add_child(drawWord)
	add_child(drawWord)
	drawWord.display(0,myWords[0],Ex,index)

func back():
	get_tree().change_scene("res://ExerciceMenu.tscn")


func next():
	index += 1
	if(index >= myWords.size()):
		get_tree().change_scene("res://GameEnd.tscn")
	else :
		drawWord.display(0,myWords[index],Ex,index)
		###SCENE
	incremented = false


