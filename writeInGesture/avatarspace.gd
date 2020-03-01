extends Control

var level = 7 #between 1 and 9
var avatar
onready var buton = get_node("MarginContainer/VBoxContainer/HBoxContainer4/Button")
onready var text = get_node("MarginContainer/VBoxContainer/HBoxContainer/Label")
var current_texture
var current_avatar
var selected = false

func _ready():
	text.text = "Niveau: "+str(level)
	for i in range (level*2+1,19):
		get_node("MarginContainer/VBoxContainer/HBoxContainer"+str(int((i-1)/6) +1)+"/TextureRect" + str(i)).modulate = Color(0.2,0.2,0.2)
	
#	var content = Global.loadFileInArray("userinfo")
#	if (content !=null):
#		buton.visible = true
#		var textu = load(content[1])
#		for i in range (1,19):
#			if (get_node("MarginContainer/VBoxContainer/HBoxContainer"+str(int((i-1)/6) +1)+"/TextureRect" + str(i)) == textu ):
#				current_avatar = get_node("MarginContainer/VBoxContainer/HBoxContainer"+str(int((i-1)/6) +1)+"/TextureRect" + str(i))
#				current_texture = current_avatar.texture
#				current_avatar.texture = check
#		var name=get_node("MarginContainer/VBoxContainer/LineEdit")
#		name.text =content[0]


func _on_TextureRect_gui_input(event,number):
	if (event is InputEventMouseButton):
		avatar = get_node("MarginContainer/VBoxContainer/HBoxContainer"+str(int((number-1)/6) +1)+"/TextureRect" + str(number))
		if (avatar.modulate != Color(0.2,0.2,0.2)):
			selected = true
			if(current_texture !=null):
				current_avatar.texture = current_texture
			current_texture = avatar.texture
			current_avatar = avatar
			var array = avatar.texture.resource_path.split('/')
			avatar.texture = load("res://art/users/selected/"+array[4])


#test
func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_K:
		var name="uuu"
		Global.rewriteFile("userinfo",name+"\n"+str(current_texture.resource_path))
		get_tree().change_scene("res://home.tscn")

func _on_Button_gui_input(event):
	if (event is InputEventMouseButton):
		if (selected):
			var name=get_node("MarginContainer/VBoxContainer/LineEdit").text
			Global.rewriteFile("userinfo",name+"\n"+str(current_texture.resource_path))
		get_tree().change_scene("res://home.tscn")




