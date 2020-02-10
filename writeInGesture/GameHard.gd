
extends Control


func _ready():
	print("ddd")

func _on_Back_pressed():
	get_tree().change_scene("res://GameLevel.tscn")
