extends Control


func _ready():
	Global.game = 0
	Global.score = 0
	Global.try = []
	
	find_node("MarginContainer").add_constant_override("margin_left",get_viewport().size.x/8)
	find_node("MarginContainer").add_constant_override("margin_right",get_viewport().size.x/8)
	find_node("GooseGame").rect_min_size.y = get_viewport().size.y/4
	find_node("Listen&Choose").rect_min_size.y = get_viewport().size.y/4
	find_node("MemoryGame").rect_min_size.y = get_viewport().size.y/4
	find_node("VBoxContainer").add_constant_override("separation",get_viewport().size.y/20)
	find_node("MemoryGame").get_font("font").size = get_viewport().size.y/16
	find_node("Back").rect_size = Vector2(get_viewport().size.y*0.15, get_viewport().size.y*0.15)
	Global.make_margin(find_node("Main"), 0.015)


#set the play variable and redirect to the game level page

func _on_GooseGame_pressed():
	Global.play = 1
	Global.current_ex = Global.gooseExercise
	get_tree().change_scene("res://GameLevel.tscn")


func _on_ListenChoose_pressed():
	Global.play = 2
	Global.current_ex = Global.listenExercise
	get_tree().change_scene("res://GameLevel.tscn")

#redirect to the memory game because there is no levels
func _on_MemoryGame_pressed():
	Global.play = 3
	Global.current_ex = Global.memoryExercise
	get_tree().change_scene("res://MemoryGame.tscn")


func _on_Back_pressed():
	get_tree().change_scene("res://home.tscn")
