extends Button

# About button change scene to the about scene with the
# name of the current app as an arguments

# If we want to override the automated way of knowing the current
# app we can specify a special name.
# This is usefull when on the main menu (which is not an
# app by itself so we have to give the back button its name)
export var currentAppOverride: String = ""
var currentApp : String #name of the current app played in the global app

func about_button_pressed():
	if currentAppOverride == "":
		Global.change_scene("res://shared/about/about.tscn", [currentApp])
	else:
		Global.change_scene("res://shared/about/about.tscn", [currentAppOverride])
