extends Control

const Exercise = preload("res://entity/Exercise.gd")

var Ex : Exercise
var play : int 
var scenePath : String
var currentPage

func _ready():
	pass
	
func setUp(exercise, playVar, path):
	Ex = exercise
	find_node("Title").text = Ex.name
	match  Ex.name :
		"Jeu de l'oie" :
			find_node("TextureRect").texture = load("res://assets/icons/goosePlate.png")
		"Ecoute Et Choisit" :
			find_node("TextureRect").texture = load("res://assets/icons/ecoute.png")
		"Jeu du Memory" :
			find_node("TextureRect").texture = load("res://assets/icons/card.png")
#
	play = playVar
	scenePath = path
	if(Ex.getSuccessPercentage(0) >= 50):
		find_node("lock1").visible = false
		find_node("Normal").disabled = false
	if(Ex.getSuccessPercentage(1) >= 50):
		find_node("lock2").visible = false
		find_node("Hard").disabled = false
	if play == 3 :
		find_node("lock1").visible = false
		find_node("lock2").visible = false
		find_node("Easy").visible = false
		find_node("Normal").visible = false
		find_node("Hard").visible = false
		find_node("Memory").visible = true
	
func _on_Easy_pressed():
	goScene(0)


func _on_Normal_pressed():
	goScene(1)


func _on_Hard_pressed():
	goScene(2)
	
func goScene(level : int ):
	Global.manageGame.current_ex = Ex
	Global.manageGame.level = level
	Global.manageGame.play = play
	Global.change_scene(scenePath)


func _on_Memory_pressed():
	goScene(0)
