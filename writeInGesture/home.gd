extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tts = null

# Called when the node enters the scene tree for the first time.
func _ready():
	print("eee")
	if Global.get_text() != null and Global.get_avatar() != null:
		get_node("MarginContainer2/VBoxContainer/HBoxContainer/VBoxContainer/NamePlayer").text=Global.get_text()
		get_node("MarginContainer2/VBoxContainer/HBoxContainer/VBoxContainer/Picture").texture=Global.get_avatar()
	if(Engine.has_singleton("GodotTextToSpeech")):
		tts = Engine.get_singleton("GodotTextToSpeech")
		tts.fireTTS() # fires up the TextToSpeech engine


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Change_pressed():
	get_tree().change_scene("res://avatarspace.tscn")
	pass # Replace with function body.

func _on_Admin_pressed():
	get_tree().change_scene("res://speechTherapistMenu.tscn")

func _on_Play_pressed():
	get_tree().change_scene("res://ExerciceMenu.tscn")


func _on_Help_pressed():
	get_tree().change_scene("res://interfaceGestureImproved.tscn")

func _on_SpeakTest_pressed():
	if(tts != null):
		tts.speakText("Ceci est un test pour la synthèse vocale !")
