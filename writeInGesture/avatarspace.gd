extends Control

var level = 7 #between 1 and 9
onready var buton = get_node("MarginContainer/VBoxContainer/HBoxContainer4/Button")
onready var text = get_node("MarginContainer/VBoxContainer/HBoxContainer/Label")
var current_texture
var current_avatar
var selected = false
var avatars = ["assistant.png","astronaut.png","businessman.png","captain.png","cashier.png","chef.png","concierge.png","cooker.png","courier.png","croupier.png","croupier-1.png","detective.png","disc-jockey.png","engineer.png","gentleman.png","nurse.png","stewardess.png","worker.png"]

func _ready():
	get_node("Button").rect_position.y = get_viewport().size.y - 90
	get_node("LineEdit").rect_position.y = get_viewport().size.y - 90
	get_node("Label").rect_position.y = get_viewport().size.y - 170
	get_node("Label").text = "Niveau: "+str(level)
	var avatar_number = 0
	var column = get_node("MarginContainer/VBoxContainer")
	for i in range(3):
		var line = HBoxContainer.new()
		for k in range(6):
			var image = TextureRect.new()
			var control_img = Control.new()
			image.texture = load("res://art/users/"+avatars[i*6+k])
			if (i*6+k > level):
				image.modulate = Color(0.2,0.2,0.2)
			image.expand = true
			image.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
			image.rect_size.x = get_viewport().size.y / 5
			image.rect_size.y = get_viewport().size.y / 5
			image.connect("gui_input",self,"pressed",[image])
			line.add_constant_override("separation", get_viewport().size.y / 5 +10)
			control_img.add_child(image)
			line.add_child(control_img)
			avatar_number = avatar_number + 1
		column.add_child(line)
		column.add_constant_override("separation", get_viewport().size.y/5 + 10)
	



func pressed(event,avatar):
	if (event is InputEventMouseButton):
		if (avatar.modulate != Color(0.2,0.2,0.2)):
			selected = true
			if(current_texture !=null):
				current_avatar.texture = current_texture
			current_texture = avatar.texture
			current_avatar = avatar
			var array = avatar.texture.resource_path.split('/')
			avatar.texture = load("res://art/users/selected/"+array[4])
		


func _on_Button_gui_input(event):
	if (event is InputEventMouseButton):
		if (selected):
			var name=get_node("LineEdit").text
			Global.rewriteFile("userinfo",name+"\n"+str(current_texture.resource_path))
		get_tree().change_scene("res://home.tscn")




