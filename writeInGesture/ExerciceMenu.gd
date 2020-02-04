extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MyGame_pressed():
	get_tree().change_scene("res://GameLevel.tscn")


func _on_Count_pressed():
	get_tree().change_scene("res://GameLevel.tscn")


func _on_WeekDays_pressed():
	get_tree().change_scene("res://GameLevel.tscn")


func _on_MonoSyllabe_pressed():
	get_tree().change_scene("res://GameLevel.tscn")


func _on_Back_pressed():
	get_tree().change_scene("res://home.tscn")
