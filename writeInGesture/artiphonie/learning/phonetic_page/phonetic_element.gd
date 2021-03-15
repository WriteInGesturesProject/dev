extends Control

var phoneticDemonstrationRessource := load("res://artiphonie/learning/phonetic_demonstration/phonetic_demonstration.tscn")
var phoneticName: String

func setup(_phoneticName: String):
	phoneticName = _phoneticName
	$button.text = "[" + Global.convert_phonetic(phoneticName) + "]"

func _on_button_pressed():
	var newPhoneticDemonstration: Control = phoneticDemonstrationRessource.instance()
	newPhoneticDemonstration.setup(phoneticName,
	Global.phonetic_to_array_picture_path(phoneticName)[0],
	Global.phonetic_to_array_video_path(phoneticName)[0])
	get_viewport().add_child(newPhoneticDemonstration)
