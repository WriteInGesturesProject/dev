extends Control

# Main menu of the whole app

var listSelectionRessource := load("res://shared/list_selection/list_selection.tscn")

var appElementResource := load("res://shared/main_menu/app_element.tscn")

func _ready():
	for app in Global.apps:
		var newApp = appElementResource.instance()
		newApp.setup(app)
		$ScrollContainer/HBoxContainer.add_child_below_node($ScrollContainer/HBoxContainer/filler_start, newApp)

func _on_list_change_pressed():
	add_child(listSelectionRessource.instance())
