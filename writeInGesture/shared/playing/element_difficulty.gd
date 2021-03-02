extends Control

var gameScenePath: String
var lockedInfo: String

func setup(scenePath: String, name: String, locked: bool, _lockedInfo: String):
	$name.text = name
	if not locked:
		$lock.visible = false
		$name.anchor_right = 1
	else:
		$name.disabled = true
		$lock.visible = true
		$name.anchor_right = 0.75

func name_pressed():
	Global.change_scene(gameScenePath, [name])
