extends Control

var margin = 0.05
var vectorMarge

func _ready():
	#make margin of the scene
	Global.make_margin(find_node("MarginContainer"),margin)
	vectorMarge = get_viewport().size *(1-2*margin)
	find_node("MarginContributors").rect_min_size.x = vectorMarge.x / 4
	find_node("MarginContributors").add_constant_override("margin_top",vectorMarge.y / 8)
	find_node("MarginContributors").add_constant_override("margin_bottom",vectorMarge.y / 12)
	Global.make_margin(find_node("MainPage"),0.015)
	#change size of button depending on the screen size
	find_node("Label").get_font("font").size = Global.h2Font
	find_node("TextContributors").set_selection_enabled(true)
	var content = loadAboutContent()
	find_node("TextContributors").set_text(content)
	
func loadAboutContent() -> String:
	var file = File.new()
	file.open("res://data/aboutContent.txt", File.READ)
	var content = file.get_as_text()
	file.close()
	return content

func _on_Back_pressed():
	Global.change_scene("res://page/home/home.tscn")

#open the url of the gitlab when click on it
func _on_goLinkPressed(url):
	OS.shell_open(url)
