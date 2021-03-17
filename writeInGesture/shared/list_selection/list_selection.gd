extends Control

# List selection scene which enables the user to change their list.

var listElementRessource := load("res://shared/list_selection/list_element.tscn")

signal active_list_changed(newListName)

func _ready():
	for list in Global.player.listOfWords:
		var newListElement = listElementRessource.instance()
		newListElement.setup(list)
		if Global.activeList.equals(list):
			newListElement.find_node("button").disabled = true
		newListElement.connect("active_list_changed", self, "_active_list_changed")
		connect("active_list_changed", newListElement, "_active_list_changed")
		$background/ScrollContainer/listes.add_child(newListElement)

func _active_list_changed(newListName: Words):
	emit_signal("active_list_changed", newListName)

func _on_done_pressed():
	queue_free()
