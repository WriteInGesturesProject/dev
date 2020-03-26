extends Control

const Exercise = preload("res://Exercise.gd")
var Ex : Exercise


# Called when the node enters the scene tree for the first time.
func _ready():
	#load the current exercice depending of type of game chose
	match Global.play:
		1:
			Global.current_ex = Global.gooseExercise
		2:
			Global.current_ex = Global.listenExercise
		3:
			Global.current_ex = Global.memoryExercise
	var Ex = Global.current_ex
	
	#adjust size of button depending of screen size
	find_node("Back").rect_size = Vector2(get_viewport().size.y*0.15, get_viewport().size.y*0.15)

	#lock normal and hard level if necessary ->if the previous level has less than 50 in success percentage 
#	if(Ex.getSuccessPercentage(0) >= 50):
	find_node("lock1").visible = false
	find_node("Normal").disabled = false
#	if(Ex.getSuccessPercentage(1) >= 50):
	find_node("lock2").visible = false
	find_node("Hard").disabled = false

	#change margin and position for a good display, all depending of screen size 
	find_node("MarginContainer").add_constant_override("margin_left",get_viewport().size.x/8)
	find_node("MarginContainer").add_constant_override("margin_right",get_viewport().size.x/8)
	find_node("Easy").rect_min_size.y = get_viewport().size.y/4
	find_node("Normal").rect_min_size.y = get_viewport().size.y/4
	find_node("Hard").rect_min_size.y = get_viewport().size.y/4
	find_node("lock1").rect_size = Vector2(get_viewport().size.y/5, get_viewport().size.y/5)
	find_node("lock2").rect_size = Vector2(get_viewport().size.y/5, get_viewport().size.y/5)
	find_node("lock1").margin_top = get_viewport().size.y*0.04
	find_node("lock1").margin_left = get_viewport().size.y*0.04
	find_node("lock2").margin_top = get_viewport().size.y*0.04
	find_node("lock2").margin_left = get_viewport().size.y*0.04
	find_node("VBoxContainer").add_constant_override("separation",get_viewport().size.y/20)
	find_node("Normal").get_font("font").size = get_viewport().size.y/16
	Global.make_margin(find_node("Main"), 0.015)

func _on_Back_pressed():
	get_tree().change_scene("res://GameChoose.tscn")

#set the level variable to the correponding button and redirect to the current game

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
