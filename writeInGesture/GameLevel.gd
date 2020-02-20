extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if((Global.progress1[Global.play-1] >= 80)):
		find_node("TextureRect").visible = false
		find_node("Normal").disabled = false
	if( Global.progress2[Global.play-1] >= 80):
		find_node("TextureRect2").visible = false
		find_node("Hard").disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://GameChoose.tscn")

func _on_Easy_pressed():
	if(Global.play == 1):
		get_tree().change_scene("res://GooseGame.tscn")
	elif (Global.play == 2):
		get_tree().change_scene("res://ListenChoose.tscn")
	Global.level = 0
	
func _on_Normal_pressed():
	if(Global.play == 1):
		get_tree().change_scene("res://GooseGame.tscn")
	elif (Global.play == 2):
		get_tree().change_scene("res://ListenChoose.tscn")
	Global.level = 1

func _on_Hard_pressed():
	if(Global.play == 1):
		get_tree().change_scene("res://GooseGame.tscn")
	elif (Global.play == 2):
		get_tree().change_scene("res://ListenChoose.tscn")
	Global.level = 2
