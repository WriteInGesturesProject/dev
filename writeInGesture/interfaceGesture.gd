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

func _on_pire_pressed():
	var description = load("res://interfaceDescriptionGesture.tscn")
	
	var root = get_tree().get_root()
	var current_scene = root.get_child(root.get_child_count() - 1)
	var button = current_scene.find_node("pire")
	current_scene = description.instance()
	get_tree().get_root().add_child(current_scene)
	
	var parsed_name = button.get_text().split(" ")
	current_scene = root.get_child(root.get_child_count() - 1)
	current_scene.find_node("Sound").set_text(parsed_name[0])
	current_scene.find_node("Name").set_text(parsed_name[1])
