extends Control

# A scene which display the avatar of the player with all his equiped items

func _ready():
	update()

func update():
	match Global.player.gender:
		1:
			$head.texture = load("res://art/avatar/boy"+str(Global.player.ethnicity)+".png")
		2:
			$head.texture = load("res://art/avatar/girl"+str(Global.player.ethnicity)+".png")
	for child in $ItemContainer.get_children():
		child.queue_free()
	for item in Global.player.equipedItems:
			var newTexture = TextureRect.new()
			newTexture.expand = true
			newTexture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			newTexture.anchor_bottom = 1
			newTexture.anchor_right = 1
			newTexture.texture = load("res://art/shopImages/"+item.picturePath)
			$ItemContainer.add_child(newTexture)
			
			
