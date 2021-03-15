extends Control

var appElementResource := load("res://shared/main_menu/app_element.tscn")

func _ready():
	for app in Global.apps:
		var newApp = appElementResource.instance()
		newApp.setUp(app)
		$ScrollContainer/HBoxContainer.add_child_below_node($ScrollContainer/HBoxContainer/filler_start, newApp)


