extends Control

# Phonetic page is the page launched when the user select a
# category under learning in Artiphonie
# It is a page with phonetic sound, which are separated by type (voyelle nasalle, ...)

# The phonetic element are the button with the phonetic symbol on it

var phoneticElementResource := load("res://artiphonie/learning/phonetic_page/phonetic_element.tscn")

func _ready():
	#deal with the instruction
	var instruction = $Instruction
	instruction.setUp("learningDescription")
	
	setup(Global.get_arguments()[0], Global.get_arguments()[1])

func setup(phoneticType: String, phonetics: Array) -> void:
	$title.text = phoneticType
	for phonetic in phonetics:
		new_phonetic_element(phonetic)

func new_phonetic_element(phoneticName: String) -> void:
	var newPhoneticElement = phoneticElementResource.instance()
	newPhoneticElement.setup(phoneticName)
	$window/ScrollContainer/VBoxContainer.add_child(newPhoneticElement)
