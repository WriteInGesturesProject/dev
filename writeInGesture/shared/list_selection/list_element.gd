extends Control

# List element is a brick of list selection

var list: Words

signal active_list_changed(newList)

func setup(_list: Words) -> void:
	list = _list
	$button.text = list.listName
	if list.listIconPath != "":
		$button.icon = load(list.listIconPath)

func _on_button_pressed() -> void:
	emit_signal("active_list_changed", list)
	Global.activeList = list
	$button.disabled = true

func _active_list_changed(newList: Words):
	if not newList.equals(list):
		$button.disabled = false
