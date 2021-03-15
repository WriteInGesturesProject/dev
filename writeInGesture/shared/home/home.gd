extends Control

var listSelectionRessource := load("res://shared/list_selection/list_selection.tscn")

var learnScenePath: String
var trainScenePath: String
var playScenePath: String
var currentApp: String 

func _ready():
	pass

func setup(_learnScenePath: String, _trainScenePath: String, _playScenePath: String, _currentApp: String, titleTexture: Texture = null, backgroundTexture: Texture = null):
	learnScenePath = _learnScenePath
	trainScenePath = _trainScenePath
	playScenePath = _playScenePath
	$about_button.currentApp = _currentApp

#	$title.texture = titleTexture
#
#	backgroundTexture.set("Size", Vector2(1280, 720))
#	$background.texture = backgroundTexture

func learning_button_pressed():
	Global.change_scene(learnScenePath)

func training_button_pressed():
	Global.change_scene(trainScenePath)

func playing_button_pressed():
	Global.change_scene(playScenePath)

func _on_list_change_pressed():
	add_child(listSelectionRessource.instance())
