extends Button

enum REDIRECTION {back, home, custom}

export (REDIRECTION) var redirection = REDIRECTION.back
export var customPath : String = ""
export var customArgs : Array = []

func _ready():
	pass # Replace with function body.

func back_button_pressed():
	match redirection:
		REDIRECTION.home:
			Global.change_scene(Global.currentApp)
		REDIRECTION.back:
			Global.change_to_previous_scene()
		REDIRECTION.custom:
			Global.change_scene(customPath, customArgs)

