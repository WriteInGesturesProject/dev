extends Control

# The avatar button is the scene which display the avatar and the stars of the player

func _ready():
	$nbStars.text = str(Global.player.get_stars())
	
func _on_avatar_button_pressed():
	Global.change_scene("res://shared/avatarspace/avatar_space.tscn")
