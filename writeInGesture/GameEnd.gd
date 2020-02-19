extends Control

const Exercise = preload("res://Exercise.gd")

var myWords
var Ex : Exercise

# Called when the node enters the scene tree for the first time.
func _ready():
	match (Global.game):
		1:
			myWords = Global.customExercise.getAllWords()
			Ex = Global.customExercise
		2:
			myWords = Global.countExercise.getAllWords()
			Ex = Global.countExercise
		3:
			myWords = Global.weekExercise.getAllWords()
			Ex = Global.weekExercise
		4:
			myWords = Global.colorExercise.getAllWords()
			Ex = Global.colorExercise
	find_node("Comment").set_text("Bravo !!")
	find_node("Score").set_text("Votre score est de " + str(Ex.getNbSuccess()) + " sur " + str(Ex.getNbWords()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Home_pressed():
	get_tree().change_scene("res://home.tscn")
