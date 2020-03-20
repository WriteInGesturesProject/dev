extends Control

onready var buton = find_node("Button")
var current_texture
var current_avatar
var selected = false
var avatars = ["assistant.png","astronaut.png","businessman.png","captain.png","cashier.png","chef.png","concierge.png","cooker.png","courier.png","croupier.png","croupier-1.png","detective.png","disc-jockey.png","engineer.png","gentleman.png","nurse.png","stewardess.png","worker.png"]

var avatarCoin = Global.player.getCoinAvatar()

func _ready():
	var margintop=(get_viewport().size.y -3*get_viewport().size.y/4.5 - 30 - get_node("LineEdit").rect_size.y - find_node("goldImage").rect_size.y)/2
	get_node("MarginContainer").margin_left = (get_viewport().size.x -6*get_viewport().size.y/4.5 - 50)/2
	get_node("MarginContainer").margin_top = margintop
	#making responsive UI elements
	get_node("Button").rect_position.y = 3*get_viewport().size.y/ 4.5 +30 +62 +10 +margintop
	get_node("Button").rect_size.x = get_viewport().size.x/3 
	get_node("Button").rect_position.x = get_node("MarginContainer").margin_left + get_viewport().size.x/2
	get_node("LineEdit").rect_position.y = 3*get_viewport().size.y/ 4.5 +30 +62 +10 +margintop
	get_node("LineEdit").rect_position.x = get_node("MarginContainer").margin_left
	get_node("LineEdit").rect_size.x = get_viewport().size.x/2
	find_node("marginCoinBox").add_constant_override("margin_left", (get_viewport().size.x -6*get_viewport().size.y/4.5 - 50)/2)
	find_node("Gold").rect_position.y =  get_node("LineEdit").rect_position.y - 50 - get_viewport().size.y * 0.01
	find_node("Gold").text = str(Global.player.getGold())
	find_node("Gold").rect_position.x = find_node("MarginContainer").margin_left
	find_node("Silver").rect_position.y = get_node("LineEdit").rect_position.y - 50 - get_viewport().size.y * 0.01
	find_node("Silver").rect_position.x = find_node("MarginContainer").margin_left + 60
	find_node("Silver").text = str(Global.player.getSilver())
	#addind avatars one by one
	var avatar_number = 0
	find_node("plate").add_constant_override("vseparation", get_viewport().size.y/4.5 + 10)
	find_node("plate").add_constant_override("hseparation", get_viewport().size.y/4.5 + 10)
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
			image.connect("gui_input",self,"_choice_pressed",[image])   #calling function on click
			control_img.add_child(image)
			avatar_number = avatar_number + 1
			find_node("plate").add_child(control_img)
	_colorAvatars()

func _colorAvatars():
	for c in find_node("plate").get_children():
		var image = c.get_child(0)
		var n = int(image.name)
		image.modulate = "ffffff"
		if(avatarCoin[n] == 0):
			#est dispo
			image.modulate = "ffffff"
		elif((n < 12 && avatarCoin[n] <= Global.player.getSilver()) || (n >= 12 && avatarCoin[n] <= Global.player.getGold())):
			#peut acheter
			image.modulate = Color(0.2,0.8,0.2)
		else : 
			#pas dispo
			image.modulate = Color(0.2,0.2,0.2)

func _choice_pressed(event, avatar):
	if (event is InputEventMouseButton):
		if(avatar.modulate == Color(0.2,0.8,0.2)):
			if(int(avatar.name) < 12):
				Global.player.setSilver(Global.player.getSilver() - avatarCoin[int(avatar.name)])
			else : 
				Global.player.setGold(Global.player.getGold() - avatarCoin[int(avatar.name)])
			Global.player.setCoinAvatar(int(avatar.name), 0)
			avatar.modulate = "ffffff"
			_colorAvatars()
			find_node("Gold").text = str(Global.player.getGold())
			find_node("Silver").text = str(Global.player.getSilver())
		elif (avatar.modulate != Color(0.2,0.2,0.2)):  #test if avatar is opened according to player level
			selected = true
			if(current_texture !=null):
				current_avatar.set_normal_texture(current_texture)
			current_texture = avatar.get_normal_texture()
			current_avatar = avatar
			var array = current_texture.resource_path.split('/')
			avatar.set_normal_texture(load("res://art/users/selected/"+array[4]))

func _on_Button_pressed():
		if (selected):  #if avatar selected save selected avatar and name
			var name=get_node("LineEdit").text
			Global.player.setName(name)
			var array = current_texture.resource_path.split('/')
			Global.player.setPathPicture(array[4])
		get_tree().change_scene("res://home.tscn")

