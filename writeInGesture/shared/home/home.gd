extends Control

# The home template is meant to be used to be the home screen of every application

# Allow the list selection button to function
#TODO: Make the list selection button as a separate scene (just like the about button, back button, avatar button, ...)
var listSelectionRessource := load("res://shared/list_selection/list_selection.tscn")

var learnScenePath: String
var trainScenePath: String
var playScenePath: String
var currentApp: String 

# _currentApp: String -> Name of the current app (used to be given to the about button)
# The other arguments of setup are self-explanatory
func setup(_learnScenePath: String, _trainScenePath: String, _playScenePath: String, _currentApp: String, titleTexture: Texture = null, backgroundTexture: Texture = null):
	learnScenePath = _learnScenePath
	trainScenePath = _trainScenePath
	playScenePath = _playScenePath
	$about_button.currentApp = _currentApp


func learning_button_pressed():
	Global.change_scene(learnScenePath)

func training_button_pressed():
	Global.change_scene(trainScenePath)

func playing_button_pressed():
	Global.change_scene(playScenePath)

func _on_list_change_pressed():
	add_child(listSelectionRessource.instance())
