extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_wordsChoice_pressed():
	get_tree().change_scene("res://wordsChoice.tscn")


func _on_Connection_pressed():
	get_tree().change_scene("res://login.tscn")


func _on_statsButton_pressed():
	get_tree().change_scene("res://statistics.tscn")


func _on_back_pressed():
	get_tree().change_scene("res://home.tscn")
