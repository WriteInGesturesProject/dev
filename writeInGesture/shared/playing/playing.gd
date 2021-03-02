extends Control

const playingElementRessource := preload("./playing_element.tscn")

func add_playing_element(title: String, scenePath: String, iconPath: String, difficulties: Array) -> void:
	var newPlayingElements = playingElementRessource.instance()
	newPlayingElements.setup(title, scenePath, iconPath, difficulties)
	$ScrollContainer/HBoxContainer.add_child(newPlayingElements)
