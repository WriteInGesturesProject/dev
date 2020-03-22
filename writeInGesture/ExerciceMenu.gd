extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.level = 0
	Global.play = 0
	find_node("MarginContainer").add_constant_override("margin_left",get_viewport().size.x/8)
	find_node("MarginContainer").add_constant_override("margin_right",get_viewport().size.x/8)
	find_node("MyGame").rect_min_size.y = get_viewport().size.y/5
	find_node("Count").rect_min_size.y = get_viewport().size.y/5
	find_node("WeekDays").rect_min_size.y = get_viewport().size.y/5
	find_node("Color").rect_min_size.y = get_viewport().size.y/5
	find_node("VBoxContainer").add_constant_override("separation",get_viewport().size.y/24)
	find_node("WeekDays").get_font("font").size = get_viewport().size.y/16



func _on_MyGame_pressed():
	Global.game = 1
	Global.current_ex = Global.customExercise
	get_tree().change_scene("res://Train.tscn")

func _on_Count_pressed():
	Global.game = 2
	Global.current_ex = Global.countExercise
	get_tree().change_scene("res://Train.tscn")

func _on_WeekDays_pressed():
	Global.game = 3
	Global.current_ex = Global.weekExercise
	get_tree().change_scene("res://Train.tscn")

func _on_Color_pressed():
	Global.game = 4
	Global.current_ex = Global.colorExercise
	get_tree().change_scene("res://Train.tscn")

func _on_Back_pressed():
	get_tree().change_scene("res://home.tscn")
