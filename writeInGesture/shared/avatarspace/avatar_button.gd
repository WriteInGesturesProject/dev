extends Control

func _ready():
	$profilPicture.update()
	$Control/nbStars.text = str(Global.player.get_stars())
	
func _on_avatar_button_pressed():
	Global.change_scene("res://shared/avatarspace/avatar_space.tscn")
