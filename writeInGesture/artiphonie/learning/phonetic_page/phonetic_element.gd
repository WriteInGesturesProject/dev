extends Control

var phoneticDemonstrationRessource := load("res://artiphonie/learning/phonetic_demonstration/phonetic_demonstration.tscn")
var phoneticName: String

func setup(_phoneticName: String):
	phoneticName = _phoneticName
	$button.text = "[" +phoneticName + "]"

func _on_button_pressed():
	var newPhoneticDemonstration: Control = phoneticDemonstrationRessource.instance()
	newPhoneticDemonstration.setup(phoneticName,
	Global.artiphonie.get_phonetic_picture(Global.artiphonie.convert_phonetic(phoneticName)),
	Global.artiphonie.get_phonetic_video(Global.artiphonie.convert_phonetic(phoneticName)))
	get_viewport().add_child(newPhoneticDemonstration)
