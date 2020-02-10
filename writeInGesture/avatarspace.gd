extends Control

var avatar
var check
onready var buton = get_node("Button")

func _ready():
	check = get_node("TextureRect")
	avatar = get_node("TextureRect8")
	buton.visible = false

func after_click(number):
	check.visible = true
	avatar = get_node("TextureRect"+str(number))
	check.rect_position.x=avatar.rect_position.x + 50
	check.rect_position.y=avatar.rect_position.y + 50
	buton.visible = true

func _on_TextureRect8_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(8)




func _on_TextureRect13_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(13)


func _on_TextureRect12_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(12)


func _on_TextureRect11_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(11)


func _on_TextureRect10_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(10)


func _on_TextureRect9_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(9)


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


func _on_TextureRect19_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(19)


func _on_TextureRect20_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(20)


func _on_TextureRect21_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(21)


func _on_TextureRect22_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(22)


func _on_TextureRect23_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(23)


func _on_TextureRect24_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(24)


func _on_TextureRect25_gui_input(event):
	if (event is InputEventMouseButton):
		after_click(25)


func _on_Button_gui_input(event):
	if (event is InputEventMouseButton):
		var name=get_node("TextEdit").text
		Global.set_avatar(avatar.texture)
		Global.set_name(name)
		get_tree().change_scene("res://home.tscn")
