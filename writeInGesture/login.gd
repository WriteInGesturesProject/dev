extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var errorMsg = Label.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	errorMsg.text = "Mauvais mot de passe ou identifiant."
	errorMsg.add_color_override("font_color", Color(1,0,0))
	find_node("VBoxContainer").add_child(errorMsg)
	errorMsg.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_submit_pressed():
	var login = Global.config.getLoginAdmin()
	var psswd = Global.config.getPassWordAdmin()
	if login == find_node("id").text && psswd == find_node("psswd").text :
		get_tree().change_scene("res://speechTherapistMenu.tscn")
	else :
		errorMsg.visible = true


func _on_resetPsswd_pressed():
	find_node("PopupReset").popup_centered_ratio(0.75)
