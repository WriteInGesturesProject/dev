extends Button

var currentApp : String #name of the current app played in the global app

func _ready():
	pass # Replace with function body.

func about_button_pressed():
	print(currentApp)
	Global.change_scene("res://shared/about/about.tscn", [currentApp])
