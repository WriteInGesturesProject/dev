extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var errorMsg = Label.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	errorMsg.text = "mauvais mot de passe ou identifiant."
	errorMsg.add_color_override("font_color", Color(1,0,0))
	find_node("VBoxContainer").add_child(errorMsg)
	errorMsg.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_submit_pressed():
	var content = Global.loadFileInArray("userLog")
	if content[0] == find_node("idField").text && content[1] == find_node("psswdField").text :
		get_tree().change_scene("res://speechTherapistMenu.tscn")
	else :
		errorMsg.visible = true


func _on_resetPsswd_pressed():
	get_tree().change_scene("res://resetPassword.tscn")
