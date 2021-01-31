extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.make_margin(find_node("Main"), 0.015)
	find_node("MarginContainer").add_constant_override("margin_left",get_viewport().size.x/8)
	find_node("MarginContainer").add_constant_override("margin_right",get_viewport().size.x/8)
	find_node("statsButton").rect_min_size.y = get_viewport().size.y/4
	find_node("wordsChoice").rect_min_size.y = get_viewport().size.y/4
	find_node("structButton").rect_min_size.y = get_viewport().size.y/4
	find_node("VBoxContainer").add_constant_override("separation",get_viewport().size.y/20)
	find_node("statsButton").get_font("font").size = get_viewport().size.y/16
	
	
	
func _on_wordsChoice_pressed():
	Global.manageScreen.changeScene("res://page/wordschoice/wordschoice.tscn")


func _on_Connection_pressed():
	Global.manageScreen.changeScene("res://login.tscn")


func _on_statsButton_pressed():
	Global.manageScreen.changeScene("res://page/statistics/statistics.tscn")


func _on_back_pressed():
	Global.manageScreen.changeScene("res://page/home/home.tscn")


func _on_Button_pressed():
	Global.manageScreen.changeScene("res://page/syllablestruct/syllableStruct.tscn")
