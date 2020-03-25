extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var margin = 0.05
var vectorMarge
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.make_margin(find_node("MarginContainer"),margin)
	vectorMarge = get_viewport().size *(1-2*margin)
	find_node("MarginContributors").rect_min_size.x = vectorMarge.x / 4
	find_node("MarginContributors").add_constant_override("margin_top",vectorMarge.y / 6)
	find_node("MarginContributors").add_constant_override("margin_bottom",vectorMarge.y / 6)
	
	find_node("MarginRight").rect_min_size.x = vectorMarge.x / 4
	find_node("MarginRight").add_constant_override("margin_top",vectorMarge.y / 6)
	find_node("MarginRight").add_constant_override("margin_bottom",vectorMarge.y / 6)
	
	find_node("MarginSource").rect_min_size.x = vectorMarge.x / 4
	find_node("MarginSource").add_constant_override("margin_top",vectorMarge.y / 6)
	find_node("MarginSource").add_constant_override("margin_bottom",vectorMarge.y / 6)
	
	find_node("MainHBox").add_constant_override("separation",vectorMarge.x / 12)
	
	find_node("Test").get_font("font").size = vectorMarge.x/40
	Global.make_margin(find_node("MainPage"),0.015)
	find_node("Back").rect_size = Vector2(get_viewport().size.y*0.15, get_viewport().size.y*0.15)
	find_node("Link").get_font("font").size = find_node("Label3").get_font("font").size
	find_node("Link").rect_position.y = find_node("Link").rect_position.y + get_viewport().size.y * 0.01
	find_node("Link").connect("meta_clicked", self, "_goLinkPressed")


func _goLinkPressed(url):
	print("ok")
	OS.shell_open(url)


func _on_Back_pressed():
	get_tree().change_scene("res://home.tscn")
