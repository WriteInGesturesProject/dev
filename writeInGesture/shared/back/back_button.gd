extends Button

# The back button is one the scene that is used pretty much everywhere.
# The back button as 3 states:
# back: Return to the previous scene (which is the scene the player previously was on)
#		so this is usefull when we want to automate the process which is most of the
#		however it does not work when we don't want the player to go back to the previous
#		scene, for example in a game when the player go to the end game scene we want him
#		to go back to the home page which is not the previous scene
# home: Return to the home scene of the current app
# custom: Here you specify the path and the args given and it could go anywhere

enum REDIRECTION {back, home, custom}

export (REDIRECTION) var redirection = REDIRECTION.back
export var customPath : String = ""
export var customArgs : Array = []

func back_button_pressed():
	match redirection:
		REDIRECTION.home:
			Global.change_scene(Global.currentApp)
		REDIRECTION.back:
			Global.change_to_previous_scene()
		REDIRECTION.custom:
			Global.change_scene(customPath, customArgs)

