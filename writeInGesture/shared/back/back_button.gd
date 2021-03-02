extends Button

export var toHome: bool = false

func _ready():
	pass # Replace with function body.

func back_button_pressed():
	Global.change_to_previous_scene()
