extends Control

var elementDifficultyRessource := preload("./element_difficulty.tscn")
var gameScenePath: String

var difficultyName: String

enum {NAME = 0, LOCKED = 1, LOCKED_INFO = 2}

func setup(title: String, scenePath: String, iconPath: String, difficulties: Array):
	$title.text = title
	gameScenePath = scenePath
	$icon.texture = load(iconPath)
	for difficulty in difficulties:
		var newElementDifficulty = elementDifficultyRessource.instance()
		newElementDifficulty.setup(scenePath, difficulty[NAME], difficulty[LOCKED], difficulty[LOCKED_INFO])
		$ScrollContainer/difficulty.add_child(newElementDifficulty)
