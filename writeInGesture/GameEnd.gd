extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	find_node("Comment").set_text("Bravo !!")
	find_node("Score").set_text("Votre score est de " + str(Global.score[Global.level][Global.game - 1]) + " sur 10")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Home_pressed():
	Global.index = 0
	get_tree().change_scene("res://home.tscn")
