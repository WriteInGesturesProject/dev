extends Control

# Playing template
# Which rely on playing elements (which rely on element difficulty)
# Each playing elements is a game that the user can play.
# To launch a game the user press on a difficulty and the difficulty launch
# the game with the difficulty as an arguments.

const playingElementRessource := preload("./playing_element.tscn")

# title: String -> Title of the game
# scenePath: String -> Path of the scene to load when the game is selected
# iconPath: String -> Path of an icon for the game
# difficulties: Array -> Array contening the information related to the difficulty of the game
# difficulties[i] -> [difficultyName: String, locked: bool:, lockedInfo: String]
#	difficultyName: String -> Name of the difficulty ("Easy", "Timed", "Impossible")
#	locked: bool -> Is the difficulty available right now
#	lockedInfo: String -> If the difficulty is not available how to unlock it
func add_playing_element(title: String, scenePath: String, iconPath: String, difficulties: Array) -> void:
	var newPlayingElements = playingElementRessource.instance()
	newPlayingElements.setup(title, scenePath, iconPath, difficulties)
	$ScrollContainer/HBoxContainer.add_child(newPlayingElements)
