extends Control

var errorMsg : Label

func _ready():
	errorMsg = find_node("Error")
	errorMsg.text = "Mauvais mot de passe ou identifiant."
	errorMsg.add_color_override("font_color", Color(1,0,0))
	errorMsg.visible = false

func _on_submit_pressed():
	var login = Global.config.getLoginAdmin()
	var psswd = Global.config.getPassWordAdmin()
	if login == find_node("id").text && psswd == find_node("psswd").text :
		Global.change_scene("res://page/navigation/speechTherapistMenu.tscn")
	else :
		errorMsg.visible = true


func _on_resetPsswd_pressed():
	find_node("PopupReset").popup_centered_ratio(0.75)
