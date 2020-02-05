extends Control

var avatar
onready var buton = get_node("Button")

func _ready():
	avatar = get_node("TextureRect8")
	buton.visible = false



func _on_TextureRect8_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect8")
		avatar.modulate = Color(0,0,0)
		buton.visible = true




func _on_TextureRect13_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect13")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect12_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect12")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect11_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect11")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect10_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect10")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect9_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect9")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect14_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect14")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect15_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect15")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect16_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect16")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect17_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect17")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect18_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect18")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect19_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect19")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect20_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect20")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect21_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect21")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect22_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect22")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect23_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect23")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect24_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect24")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_TextureRect25_gui_input(event):
	if (event is InputEventMouseButton):
		avatar.modulate = Color(1,1,1)
		avatar = get_node("TextureRect25")
		avatar.modulate = Color(0,0,0)
		buton.visible = true


func _on_Button_gui_input(event):
	if (event is InputEventMouseButton):
		get_tree().change_scene("res://home.tscn")
