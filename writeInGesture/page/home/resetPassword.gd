extends Control

var errorMsg = Label.new()

func _ready():
	errorMsg.text = "Erreur dans le formulaire."
	errorMsg.add_color_override("font_color", Color(1,0,0))
	errorMsg.visible = false

func _on_submit_pressed():
	var psswd = Global.config.getPassWordAdmin()
	if psswd == find_node("oldPsswd").text && find_node("psswd").text == find_node("psswd2").text :
		Global.config.setPassWordAdmin(find_node("psswd").text)
		self.visible = false
	else :
		errorMsg.visible = true
