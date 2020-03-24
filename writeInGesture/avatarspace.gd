extends Control

onready var buton = find_node("Button")
var current_texture
var current_avatar
var selected = false
var avatars = ["assistant.png","astronaut.png","businessman.png","captain.png","cashier.png","chef.png","concierge.png","cooker.png","courier.png","croupier.png","croupier-1.png","detective.png","disc-jockey.png","engineer.png","gentleman.png","nurse.png","stewardess.png","worker.png"]
var avatarToBuy
var avatarCoin = Global.player.getCoinAvatar()

func _ready():
	find_node("CancelBuy").rect_position.y = find_node("ValidateBuy").rect_position.y
	var margintop=(get_viewport().size.y -3*get_viewport().size.y/4.5 - get_viewport().size.y*0.05 - get_node("LineEdit").rect_size.y - find_node("goldImage").rect_size.y)/2
	get_node("MarginContainer").margin_left = (get_viewport().size.x -6*get_viewport().size.y/4.5 - get_viewport().size.y*0.05)/2
	get_node("MarginContainer").margin_top = margintop
	#making responsive UI elements
	
	get_node("LineEdit").rect_position.y = 3*get_viewport().size.y/ 4.5 +get_viewport().size.y*0.15 +margintop
	get_node("LineEdit").rect_position.x = get_viewport().size.x * 0.25
	get_node("LineEdit").rect_size.x = get_viewport().size.x/2
	find_node("LineEdit").text = Global.player.getName()
	
	get_node("Button").rect_position.y = 3*get_viewport().size.y/ 4.5 +get_viewport().size.y*0.15 +margintop
	get_node("Button").rect_size.x = get_viewport().size.x/3 
	get_node("Button").rect_position.x = find_node("LineEdit").rect_position.x + find_node("LineEdit").rect_size.x + get_viewport().size.x *0.01
	
	find_node("marginCoinBox").add_constant_override("margin_left", (get_viewport().size.x -6*get_viewport().size.y/4.5 - 50)/2)
	find_node("Gold").rect_position.y =  get_node("LineEdit").rect_position.y - 50 - get_viewport().size.y * 0.01
	find_node("Gold").text = str(Global.player.getGold())
	find_node("Gold").rect_position.x = get_viewport().size.x * 0.35
	find_node("Silver").rect_position.y = get_node("LineEdit").rect_position.y - 50 - get_viewport().size.y * 0.01
	find_node("Silver").rect_position.x = get_viewport().size.x * 0.35+ 60
	find_node("Silver").text = str(Global.player.getSilver())
	find_node("goldImage").rect_position.y = find_node("Gold").rect_position.y
	find_node("silverImage").rect_position.y = find_node("Silver").rect_position.y
	find_node("goldImage").rect_position.x = get_viewport().size.x * 0.35 - 60
	find_node("silverImage").rect_position.x = get_viewport().size.x * 0.35
	#addind avatars one by one
	var avatar_number = 0
	find_node("plate").add_constant_override("vseparation", get_viewport().size.y/4.5 + get_viewport().size.y *0.02)
	find_node("plate").add_constant_override("hseparation", get_viewport().size.y/4.5 + get_viewport().size.y *0.02)
	for i in range(3):
		for k in range(6):
			var image = TextureButton.new()
			var control_img = Control.new()
			image.set_normal_texture(load("res://art/users/"+avatars[i*6+k]))
			image.expand = true
			image.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
			image.rect_size.x = get_viewport().size.y / 4.5
			image.rect_size.y = get_viewport().size.y / 4.5
			image.name = str(i*6 + k)
			control_img.rect_size = image.rect_size
			image.connect("pressed",self,"_choice_pressed",[image])   #calling function on click
			control_img.add_child(image)
			avatar_number = avatar_number + 1
			find_node("plate").add_child(control_img)
	_colorAvatars()

func _colorAvatars():
	var list = find_node("plate").get_children()
	for i in range(0, len(list)):
		var c = list[i]
		var image = c.get_child(0)
		var n = int(image.name)
		image.modulate = "ffffff"
		if(avatarCoin[n] == 0):
			#available
			image.modulate = "ffffff"
		elif((n < 12 && avatarCoin[n] <= Global.player.getSilver()) || (n >= 12 && avatarCoin[n] <= Global.player.getGold())):
			#can buy
			image.modulate = "A9A9A9"
		else : 
			#not available
			image.modulate = "484343"
			
		if(avatarCoin[n] != 0 && len(c.get_children())==1):
			var contMoney = Control.new()
			var iconMoney = TextureRect.new()
			var nbMoney = Label.new()
			contMoney.add_child(iconMoney)
			contMoney.add_child(nbMoney)
			iconMoney.expand = true
			iconMoney.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
			if(n<12):
				iconMoney.texture = load("res://assets/icons/silverCoin.png")
				nbMoney.text = str(Global.player.getCoinAvatar()[n])
			else :
				iconMoney.texture = load("res://assets/icons/goldCoin.png")
				nbMoney.text = str(Global.player.getCoinAvatar()[n])
			iconMoney.rect_size = Vector2(40,40)
			iconMoney.rect_position.x = image.rect_position.x + image.rect_size.x*0.1
			iconMoney.rect_position.y = image.rect_position.y + image.rect_size.y/2 - 20
			nbMoney.rect_position.y = iconMoney.rect_position.y
			nbMoney.rect_position.x = iconMoney.rect_position.x + 40 + image.rect_size.x*0.03
			c.add_child(contMoney)
		print("ok ", c.get_children())

func _choice_pressed(avatar):
	if(avatar.modulate == Color("A9A9A9")):
		avatarToBuy = avatar
		find_node("ConfirmPopup").popup_centered_ratio(0.80)
		find_node("backgroundDark").visible = true
		find_node("confirmAsk").text = "Voulez-vous acheter cette icone pour : "
		if(int(avatar.name) < 12):
			find_node("nbCoin").text = str(Global.player.getCoinAvatar()[int(avatar.name)])+" pièces d'argent ?"
		else :
			find_node("nbCoin").text = str(Global.player.getCoinAvatar()[int(avatar.name)])+" pièces d'or ?"
	elif (avatar.modulate == Color("484343")):  #test if avatar is opened according to player level
		find_node("NotEnough").visible = true
		find_node("backgroundDark").visible = true
		find_node("Timer").start()
	else :
		selected = true
		if(current_texture !=null):
			current_avatar.remove_child(current_avatar.get_child(0))
		current_texture = avatar.get_normal_texture()
		current_avatar = avatar
		var control_val = Control.new()
		var val = TextureRect.new()
		control_val.add_child(val)
		val.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
		val.expand = true
		val.texture = load("res://assets/icons/validate.png")
		val.rect_position = avatar.rect_position
		val.rect_size = avatar.rect_size
		avatar.add_child(control_val)

func _on_Button_pressed():
		var name=get_node("LineEdit").text
		Global.player.setName(name)
		if (selected):  #if avatar selected save selected avatar and name
			var array = current_texture.resource_path.split('/')
			Global.player.setPathPicture(array[4])
		get_tree().change_scene("res://home.tscn")



func _on_ValidateBuy_pressed():
	if(int(avatarToBuy.name) < 12):
		Global.player.setSilver(Global.player.getSilver() - avatarCoin[int(avatarToBuy.name)])
	else : 
		Global.player.setGold(Global.player.getGold() - avatarCoin[int(avatarToBuy.name)])
	Global.player.setCoinAvatar(int(avatarToBuy.name), 0)
	avatarToBuy.modulate = "ffffff"
	find_node("Gold").text = str(Global.player.getGold())
	find_node("Silver").text = str(Global.player.getSilver())
	avatarToBuy.get_parent().remove_child(avatarToBuy.get_parent().get_child(1))
	_colorAvatars()
	find_node("ConfirmPopup").visible = false
	_on_ConfirmPopup_popup_hide()


func _on_ConfirmPopup_popup_hide():
	if(find_node("backgroundDark") != null):
		find_node("backgroundDark").visible = false


func _on_CancelBuy_pressed():
	find_node("ConfirmPopup").visible = false
	_on_ConfirmPopup_popup_hide()


func _on_Timer_timeout():
	find_node("NotEnough").visible = false
	_on_ConfirmPopup_popup_hide()
