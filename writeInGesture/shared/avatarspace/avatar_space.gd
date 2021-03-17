extends Control

# Avatar space is the place where the player can buy and equiped items

var ItemTypeScene := preload("./item_type.tscn")
var ItemScene := preload("./item.tscn")
var shop : Shop
var itemBying : Control
var dictionnaryResult

func _ready():
	
	$playerName.text = Global.player.get_player_name()
	$Stars/StarsNumber.text = str(Global.player.get_stars())
	
	shop = Shop.new()
	shop = Global.load_json(shop, "res://data/shopItem.json") 
	
	add_item_type()
	add_item()

#Add the item type button on top of the page
func add_item_type() -> void:
	var typeAlreadyIn : Array = []
	for itemArray in shop.sortedItems.values():
		if (itemArray[0] != null):
			var item = itemArray[0]
			var newItemType = ItemTypeScene.instance()
			newItemType.setUp(item)
			newItemType.connect("item_type_button_pressed", self, "_item_type_signal_received")
			$HScrollBar/ItemType.add_child(newItemType)
			typeAlreadyIn.append(item.itemType)

			var newNode = GridContainer.new()
			newNode.name = item.itemType
			newNode.set_columns(3)
			find_node("ScrollContainer2").add_child(newNode)
			newNode.visible = false
			newItemType.nodeShop = newNode

#Add the item button to the respective type panel
func add_item() -> void:
	for itemArray in shop.sortedItems.values():
		for item in itemArray:
			var newItem = ItemScene.instance()
			
			newItem.connect("item_button_pressed", self, "_item_signal_received")
			$ScrollContainer2.get_node(item.itemType).add_child(newItem)
			newItem.setUp(item)

#function called when a button of an item type is pressed
#this set invisible all the panel of item
func _item_type_signal_received():
	for child in $ScrollContainer2.get_children():
		child.visible = false
		
func _item_signal_received(itemScene :Control):
	#if the item wasn't already bought
	if not Global.player.unlockedItems.has(itemScene.item):
		#we check that the player have enough stars
		if itemScene.item.price <= Global.player.get_stars():
			itemBying = itemScene
			$ConfirmPurchase.visible = true
		else:
			$NotEnoughStars.visible = true
	#the player has already bough this item
	#then it can equip it
	else:
		Global.player.add_equiped_item(itemScene.item)
		updateShopVu()
		$profilPicture.update()

func _on_Validate_pressed():
	#substract the item price on the player's stars
	#Global.player.set_stars(Global.player.get_stars() - itemBying.item.price)
	
	#Case Demo
	print ("UPDATE HTTPS")
	var data_to_send={"nom" : "gaetan","prenom": Global.player.get_player_name(),"nb_etoile": Global.player.get_stars() - itemBying.item.price,"login": "ga","password": 123,"orthophoniste": {"id" : 1}}
	var query=JSON.print(data_to_send)
	var header= ["Content-Type:application/json","Content-Length: "+str(query.length())] #To Complete
	
	$HTTPRequest.request("https://artiphonie.westeurope.cloudapp.azure.com:8443/api/v1/enfant/"+String(Global.player.get_id_player()),header,false,HTTPClient.METHOD_PUT,query);
	
	$Stars/StarsNumber.text = str(Global.player.get_stars())
	#reset the button aspect
	itemBying.find_node("Star").visible = false
	itemBying.find_node("Price").visible = false
	$ConfirmPurchase.visible = false
	itemBying.find_node("Equiped").visible = true
	#add item to unlocked item and equiped it
	Global.player.add_unlocked_item(itemBying.item)
	Global.player.add_equiped_item(itemBying.item)
	updateShopVu()
	$profilPicture.update()

func _on_Cancel_pressed():
	$ConfirmPurchase.visible = false

func _on_Ok_pressed():
	$NotEnoughStars.visible = false

func _on_ValidateName_pressed():
	
	
	#Case Demo
	print ("UPDATE HTTPS")
	var data_to_send={"nom" : "gaetan","prenom": $playerName.text,"nb_etoile": Global.player.get_star(),"login": "ga","password": 123,"orthophoniste": {"id" : 1}}
	var query=JSON.print(data_to_send)
	var header= ["Content-Type:application/json","Content-Length: "+str(query.length())] #To Complete
	
	$HTTPRequest.request("https://artiphonie.westeurope.cloudapp.azure.com:8443/api/v1/enfant/"+String(Global.player.get_id_player()),header,false,HTTPClient.METHOD_PUT,query);
	

#need to be called when the profil picture is updated
#update the world "equiped" to the button related to equiped items
func updateShopVu():
	for containerType in $ScrollContainer2.get_children():
		for i in containerType.get_children():
			if Global.player.has_equiped_item(i.item):
				i.find_node("Equiped").visible = true
			else: 
				i.find_node("Equiped").visible = false



func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if result==HTTPRequest.RESULT_SUCCESS:
		print(response_code)
		if response_code==200:
			dictionnaryResult=parse_json(body.get_string_from_utf8())
			print(dictionnaryResult)
			Global.player.set_player_name(dictionnaryResult.prenom)
			Global.player.set_stars(dictionnaryResult.nb_etoile)
		else:
			print("HTTPS Error")

