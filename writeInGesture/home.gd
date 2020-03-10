extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("MarginContainer2/HBoxContainer/VBoxContainer2/VBoxContainer/NamePlayer").text=Global.player.getName()
	get_node("MarginContainer2/HBoxContainer/VBoxContainer/Control/Picture").texture=load(Global.player.getPathPicture())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Change_pressed():
	get_tree().change_scene("res://avatarspace.tscn")


func _on_Admin_pressed():
	if(!Global.dev) :
		get_tree().change_scene("res://speechTherapistMenu.tscn")
	else : 
		find_node("Popup").popup_centered_ratio(0.75)
		find_node("backgroundDark").visible = true


func _on_Play_pressed():
	get_tree().change_scene("res://GameChoose.tscn")


func _on_Help_pressed():
	get_tree().change_scene("res://interfaceGestureImproved.tscn")


func _on_Popup_popup_hide():
	if(find_node("backgroundDark") != null):
		find_node("backgroundDark").visible = false

func _on_Training_pressed():
	get_tree().change_scene("res://ExerciceMenu.tscn")
