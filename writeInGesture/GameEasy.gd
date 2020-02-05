extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if(Global.game == 2):
		get_node("ColorRect/MarginContainer/VBoxContainer/Number").set_text(Global.Number[Global.index])
		get_node("ColorRect/MarginContainer/VBoxContainer/TextureRect").texture = load(Global.img_count[Global.index])
		get_node("ColorRect/MarginContainer/VBoxContainer/TextureRect2").visible = false
		get_node("ColorRect/MarginContainer/VBoxContainer/Word").visible = true
		get_node("ColorRect/MarginContainer/VBoxContainer/Word").set_text(Global.words_count[Global.index])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://GameLevel.tscn")


func _on_Next_pressed():
	if(Global.game == 2):
		Global.index += 1
		if(Global.index == 10):
			get_tree().change_scene("res://GameEnd.tscn")
		else:
			get_node("ColorRect/MarginContainer/VBoxContainer/Number").set_text(Global.Number[Global.index])
			get_node("ColorRect/MarginContainer/VBoxContainer/TextureRect").texture = load(Global.img_count[Global.index])
			get_node("ColorRect/MarginContainer/VBoxContainer/TextureRect2").visible = false
			get_node("ColorRect/MarginContainer/VBoxContainer/Word").visible = true
			get_node("ColorRect/MarginContainer/VBoxContainer/Word").set_text(Global.words_count[Global.index])
