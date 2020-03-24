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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://home.tscn")
