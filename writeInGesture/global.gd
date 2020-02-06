extends Node

var current_scene = null
var text
var avatar

func set_avatar(avatar):
	self.avatar = avatar

func set_name(text):
	self.text = text

func get_avatar():
	return avatar

func get_text():
	return text
