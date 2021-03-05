extends Control

var defaultIcon := load("res://assets/icons/icon.png")

var changeScene: bool
var learningScenePath: String
var sceneArgument: Array

func setup(title: String, _learningScenePath: String, iconPath: String = "", _sceneArgument: Array = []) -> void:
	$title.text = title
	learningScenePath = _learningScenePath
	if iconPath == "":
		$icon.texture = defaultIcon
	else:
		$icon.texture = load(iconPath)
	sceneArgument = _sceneArgument

func button_pressed():
	Global.change_scene(learningScenePath, sceneArgument)
