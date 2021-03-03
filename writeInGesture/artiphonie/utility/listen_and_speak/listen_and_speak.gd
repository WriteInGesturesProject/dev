extends Control

func _ready():
	$background.material.set_shader_param("blur_amount", 5.0)
