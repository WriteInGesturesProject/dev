extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	find_node("Consigne").pressed = Global.player.getInstruction()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Back_pressed():
	Global.manageScreen.changeScene("res://page/home/home.tscn")


func _on_Consigne_pressed():
	Global.player.setInstruction(find_node("Consigne").pressed)
	Global.manageInstruction.wantInstruction = find_node("Consigne").pressed
	print(Global.player.getInstruction())


func _on_Button_pressed():
	$Popup.visible = true


func validate_pressed():
	$Token.text = $Popup/LineEdit.text
	$Popup.visible = false
