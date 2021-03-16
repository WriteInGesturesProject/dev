extends Control


signal item_button_pressed(Control)
var item : Item

func _ready():
	pass 

func setUp(_item : Item):
	item = _item
	find_node("ItemImage").texture = load("res://art/shopImages/"+item.picturePath)
	match Global.player.gender:
		1:
			$Button/Head.texture = load("res://art/avatar/boy"+str(Global.player.ethnicity)+".png")
		2:
			$Button/Head.texture = load("res://art/avatar/girl"+str(Global.player.ethnicity)+".png")
	var alreadyHas : bool = false
	for i in Global.player.unlockedItems:
		if item.equals(i):
			alreadyHas = true
	if not alreadyHas:		
		find_node("Price").text = str(item.price)
	else:
		find_node("Star").visible = false

func _on_Button_pressed():
	emit_signal("item_button_pressed", self)

