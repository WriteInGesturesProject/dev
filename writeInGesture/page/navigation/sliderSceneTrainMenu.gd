extends Control

const Exercise = preload("res://entity/Exercise.gd")

var Ex : Exercise
var play : int 
var scenePath : String
var currentPage

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func setUp(exercise, playVar, path):
	Ex = exercise
	find_node("Title").text = Ex.name
	match  Ex.name :
		"Couleurs" :
			find_node("TextureRect").texture = load("res://assets/icons/color.png")
		"Nombres" :
			find_node("TextureRect").texture = load("res://assets/icons/number.png")
		"Jours de la semaine" :
			find_node("TextureRect").texture = load("res://assets/icons/calendarMenu.png")
	play = playVar
	scenePath = path
	
func goScene(level : int ):
	Global.manageGame.current_ex = Ex
	Global.manageGame.level = level
	Global.manageGame.play = play
	Global.manageScreen.changeScene(scenePath)


func PlayPressed():
	goScene(0)
