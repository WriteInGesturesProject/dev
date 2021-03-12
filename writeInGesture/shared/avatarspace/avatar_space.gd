extends Control



var ItemTypeScene := preload("./item_type.tscn")
var ItemScene := preload("./item.tscn")
var shop : Shop
var itemBying : Control
# Called when the node enters the scene tree for the first time.
func _ready():
	$playerName.text = Global.player.get_player_name()
	$Stars/StarsNumber.text = str(Global.player.get_stars())
	shop = Shop.new()
	shop = Global.load_json(shop, "res://data/shopItem.json") 

	add_item_type()
	add_item()
	pass # Replace with function body.

func set_background():
	pass

func add_item_type() -> void:
	var typeAlreadyIn : Array = []
	for itemArray in shop.sortedItems.values():
		if (itemArray[0] != null):
			var item = itemArray[0]
			var newItemType = ItemTypeScene.instance()
			newItemType.find_node("TextureRect").texture = load("res://art/shopImages/"+item.picturePath)
			newItemType.connect("item_type_button_pressed", self, "_item_type_signal_received")
			$HScrollBar/ItemCategory.add_child(newItemType)
			typeAlreadyIn.append(item.itemType)

			var newNode = GridContainer.new()
			newNode.name = item.itemType
			newNode.set_columns(3)
			find_node("ScrollContainer2").add_child(newNode)
			newNode.visible = false
			newItemType.nodeShop = newNode
			

func add_item() -> void:
	for itemArray in shop.sortedItems.values():
		for item in itemArray:
			var newItem = ItemScene.instance()
			
			newItem.connect("item_button_pressed", self, "_item_signal_received")
			$ScrollContainer2.get_node(item.itemType).add_child(newItem)
			newItem.setUp(item)

func _item_type_signal_received():
	for child in $ScrollContainer2.get_children():
		child.visible = false
		
func _item_signal_received(itemScene :Control):
	if not Global.player.unlockedItems.has(itemScene.item):
		if itemScene.item.price <= Global.player.get_stars():
			itemBying = itemScene
			$ConfirmPurchase.visible = true
		else:
			$NotEnoughStars.visible = true

func _on_Validate_pressed():
	Global.player.set_stars(Global.player.get_stars() - itemBying.item.price)
	$Stars/StarsNumber.text = str(Global.player.get_stars())
	itemBying.find_node("Star").visible = false
	itemBying.find_node("Price").visible = false
	$ConfirmPurchase.visible = false
	Global.player.add_unlocked_item(itemBying.item)


func _on_Cancel_pressed():
	$ConfirmPurchase.visible = false


func _on_Ok_pressed():
	$NotEnoughStars.visible = false


func _on_ValidateName_pressed():
	Global.player.set_player_name($playerName.text) 
