extends Control

# App element is a brick for the main menu
# It represent the icon of the application

var appScenePath: String
var appName: String

# !!!!! This is important !!!!!
# This dictate the path of the home scene of the app and
# its icon and logo.
func setup( _appName: String = "") -> void:
	appName = _appName
	# This is the path of the home scene of the app
	appScenePath = "res://"+appName+"/"+appName+".tscn"
	# This is the path of the icon of the app
	$Panel/icon.texture = load("res://assets/"+appName+"/icon.png")
	# This is the path of the logo of the app
	$Panel/button/logo.texture = load("res://assets/"+appName+"/logo.png")
	self.visible = true

func button_pressed():
	Global.currentApp = appScenePath
	Global.change_scene(appScenePath)
