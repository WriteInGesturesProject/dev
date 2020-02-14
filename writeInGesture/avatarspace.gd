extends Control

var level = 5 #between 1 and 9
var avatar
var check =load("res://art/users/checkmark.png")
onready var buton = get_node("MarginContainer/VBoxContainer/HBoxContainer4/Button")
onready var text = get_node("MarginContainer/VBoxContainer/HBoxContainer/Label")
var current_texture
var current_avatar

func _ready():
	buton.visible = false
	text.text = "Niveau: "+str(level)
	for i in range (level*2+1,19):
		get_node("MarginContainer/VBoxContainer/HBoxContainer"+str(int((i-1)/6) +1)+"/TextureRect" + str(i)).modulate = Color(0.2,0.2,0.2)
	
	var content = Global.loadFileInArray("userinfo")
	if (content !=null):
		buton.visible = true
		var textu = load(content[1])
		for i in range (1,19):
			if (get_node("MarginContainer/VBoxContainer/HBoxContainer"+str(int((i-1)/6) +1)+"/TextureRect" + str(i)) == textu ):
				current_avatar = get_node("MarginContainer/VBoxContainer/HBoxContainer"+str(int((i-1)/6) +1)+"/TextureRect" + str(i))
				current_texture = current_avatar.texture
				current_avatar.texture = check
		var name=get_node("MarginContainer/VBoxContainer/LineEdit")
		name.text =content[0]
			
func after_click(number):
	avatar = get_node("MarginContainer/VBoxContainer/HBoxContainer"+str(int((number-1)/6) +1)+"/TextureRect" + str(number))
	if (avatar.modulate != Color(0.2,0.2,0.2)):
		if(current_texture !=null):
			current_avatar.texture = current_texture
		current_texture = avatar.texture
		current_avatar = avatar
		avatar.texture = check
		buton.visible = true


func _on_TextureRect1_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(1)


func _on_TextureRect2_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(2)


func _on_TextureRect3_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(3)


func _on_TextureRect4_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(4)


func _on_TextureRect5_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(5)


func _on_TextureRect6_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(6)


func _on_TextureRect7_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(7)


func _on_TextureRect8_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(8)


func _on_TextureRect9_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(9)


func _on_TextureRect10_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(10)


func _on_TextureRect11_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(11)


func _on_TextureRect12_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(12)


func _on_TextureRect13_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(13)


func _on_TextureRect14_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(14)


func _on_TextureRect15_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(15)


func _on_TextureRect16_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(16)


func _on_TextureRect17_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(17)


func _on_TextureRect18_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(18)

#test
func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_K:
		var name=get_node("MarginContainer/VBoxContainer/LineEdit").text
		Global.rewriteFile("userinfo",name+"\n"+str(current_texture.resource_path))
		get_tree().change_scene("res://home.tscn")

func _on_Button_gui_input(event):
	if (event is InputEventMouseButton):
		var name=get_node("MarginContainer/VBoxContainer/LineEdit").text
		Global.rewriteFile("userinfo",name+"\n"+str(current_texture.resource_path))
		get_tree().change_scene("res://home.tscn")



