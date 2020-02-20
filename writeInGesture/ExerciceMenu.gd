extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.level = 0
	Global.play = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MyGame_pressed():
	Global.game = 1
	get_tree().change_scene("res://Train.tscn")

func _on_Count_pressed():
	Global.game = 2
	get_tree().change_scene("res://Train.tscn")

func _on_WeekDays_pressed():
	Global.game = 3
	get_tree().change_scene("res://Train.tscn")

func _on_Color_pressed():
	Global.game = 4
	get_tree().change_scene("res://Train.tscn")

func _on_Back_pressed():
	get_tree().change_scene("res://home.tscn")
