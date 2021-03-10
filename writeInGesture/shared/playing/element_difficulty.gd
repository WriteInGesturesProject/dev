extends Control

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
	print("Lien: " + gameScenePath)
	Global.change_scene(gameScenePath, [difficultyName])
