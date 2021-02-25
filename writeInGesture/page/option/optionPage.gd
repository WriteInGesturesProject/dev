extends Control

func _ready():
	find_node("Consigne").pressed = Global.player.getInstruction()

func _on_Back_pressed():
	Global.change_scene("res://page/home/home.tscn")


func _on_Consigne_pressed():
	Global.player.setInstruction(find_node("Consigne").pressed)
	Global.manageInstruction.wantInstruction = find_node("Consigne").pressed
	print(Global.player.getInstruction())


func _on_Button_pressed():
	$Popup.visible = true


func validate_pressed():
	$Token.text = $Popup/LineEdit.text
	$Popup.visible = false
