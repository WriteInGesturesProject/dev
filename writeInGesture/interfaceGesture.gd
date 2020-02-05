extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://home.tscn")



func _on_allbutton_pressed(arg):
	
	var description = load("res://interfaceDescriptionGesture.tscn")
	var root = get_tree().get_root()
	var current_scene = root.get_child(root.get_child_count() - 1)
	var button = current_scene.find_node(arg)
	current_scene = description.instance()
	get_tree().get_root().add_child(current_scene)
	current_scene = root.get_child(root.get_child_count() - 1)
	current_scene.find_node("Name").set_text(button.get_text())


func _on_agneau_pressed(extra_arg_0):
	pass # Replace with function body.
