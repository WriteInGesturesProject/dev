extends Control

# Element difficulty see playing.tscn and playing_element.tscn 

# TODO: Rebuild element difficulty to display the reason why a difficulty is
# locked (the information should be stored in locked info).

var gameScenePath: String
var lockedInfo: String
var difficultyName: String

func setup(_gameScenePath: String, _difficultyName: String, locked: bool, _lockedInfo: String):
	gameScenePath = _gameScenePath
	difficultyName = _difficultyName
	$name.text = _difficultyName
	if not locked:
		$lock.visible = false
		$name.anchor_right = 1
	else:
		$name.disabled = true
		$lock.visible = true
		$name.anchor_right = 0.75

func name_pressed():
	Global.change_scene(gameScenePath, [difficultyName])
