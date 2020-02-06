extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("eee")
	if get_node("/root/global").get_text() != null and get_node("/root/global").get_avatar() != null:
		get_node("MarginContainer2/VBoxContainer/HBoxContainer/VBoxContainer/NamePlayer").text=get_node("/root/global").get_text()
		get_node("MarginContainer2/VBoxContainer/HBoxContainer/VBoxContainer/Picture").texture=get_node("/root/global").get_avatar()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Change_pressed():
	get_tree().change_scene("res://avatarspace.tscn")
	pass # Replace with function body.

func _on_Admin_pressed():
	get_tree().change_scene("res://speechTherapistMenu.tscn")
	pass # Replace with function body.

func _on_Play_pressed():
	get_tree().change_scene("res://ExerciceMenu.tscn")
	pass # Replace with function body.


func _on_Help_pressed():
	get_tree().change_scene("res://interfaceGesture.tscn")
	pass # Replace with function body.
