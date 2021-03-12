extends Control


var nodeShop : GridContainer
signal item_type_button_pressed 

func _ready():
	pass 


func _on_Button_pressed():
	emit_signal("item_type_button_pressed")
	nodeShop.visible = true



