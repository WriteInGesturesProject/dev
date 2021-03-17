extends Control

# Scene which represent an item type button in the shop (a category)

var nodeShop : GridContainer
signal item_type_button_pressed 

func setUp(item: Item):
	find_node("itemTypePicture").texture = load("res://art/shopImages/"+item.picturePath)
	find_node("itemTypePicture").expand = true
	find_node("itemTypePicture").stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

func _on_Button_pressed():
	emit_signal("item_type_button_pressed")
	nodeShop.visible = true



