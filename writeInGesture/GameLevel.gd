extends Control

const Exercise = preload("res://Exercise.gd")
var Ex : Exercise


# Called when the node enters the scene tree for the first time.
func _ready():
	match Global.play:
		1:
			Global.current_ex = Global.gooseExercise
		2:
			Global.current_ex = Global.listenExercise
		3:
			Global.current_ex = Global.memoryExercise
	var Ex = Global.current_ex
	if(Ex.getSuccessPercentage(0) >= 50):
		find_node("TextureRect").visible = false
		find_node("Normal").disabled = false
	if(Ex.getSuccessPercentage(1) >= 50):
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
