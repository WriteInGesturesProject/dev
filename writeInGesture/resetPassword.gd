extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var errorMsg = Label.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	errorMsg.text = "Erreur dans le formulaire."
	errorMsg.add_color_override("font_color", Color(1,0,0))
	find_node("VBoxContainer").add_child(errorMsg)
	errorMsg.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	var content = Global.loadFileInArray("userLog")
	if content[1] == find_node("oldPsswdField").text && find_node("newPsswdField").text == find_node("newPsswdField2").text :
		Global.rewriteFile("userLog",content[0]+"\n"+find_node("newPsswdField").text)
		get_tree().change_scene("res://login.tscn")
	else :
		errorMsg.visible = true
	print("ok")