extends Button

export var currentAppOverride: String = ""
var currentApp : String #name of the current app played in the global app

func about_button_pressed():
	if currentAppOverride == "":
		Global.change_scene("res://shared/about/about.tscn", [currentApp])
	else:
		Global.change_scene("res://shared/about/about.tscn", [currentAppOverride])
