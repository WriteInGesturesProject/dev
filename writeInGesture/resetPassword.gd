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


func _on_submit_pressed():
	var psswd = Global.config.getPassWordAdmin()
	if psswd == find_node("oldPsswd").text && find_node("psswd").text == find_node("psswd2").text :
		Global.config.setPassWordAdmin(find_node("psswd").text)
		self.visible = false
	else :
		errorMsg.visible = true
