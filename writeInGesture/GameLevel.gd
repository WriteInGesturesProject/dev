extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if((Global.progress1[Global.game-1] >= 80)):
		get_node("ColorRect/MarginContainer/VBoxContainer/MarginContainer2/TextureRect").visible = false
		get_node("ColorRect/MarginContainer/VBoxContainer/MarginContainer2/Normal").disabled = false
	if( Global.progress2[Global.game-1] >= 80):
		get_node("ColorRect/MarginContainer/VBoxContainer/MarginContainer3/TextureRect").visible = false
		get_node("ColorRect/MarginContainer/VBoxContainer/MarginContainer3/Hard").disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://ExerciceMenu.tscn")
