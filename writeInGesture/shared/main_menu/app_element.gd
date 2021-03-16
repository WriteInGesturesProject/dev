extends Control

var appScenePath: String
var appName: String

func setUp( _appName: String = "") -> void:
	appName = _appName
	appScenePath = "res://"+appName+"/"+appName+".tscn"
	$Panel/icon.texture = load("res://assets/"+appName+"/icon.png")
	$Panel/button/logo.texture = load("res://assets/"+appName+"/logo.png")
	self.visible = true

func button_pressed():
	Global.currentApp = appScenePath
	Global.change_scene(appScenePath)
