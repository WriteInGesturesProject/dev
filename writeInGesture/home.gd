extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tts = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if(Engine.has_singleton("GodotTextToSpeech")):
		tts = Engine.get_singleton("GodotTextToSpeech")
		tts.fireTTS() # fires up the TextToSpeech engine


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Admin_pressed():
	get_tree().change_scene("res://speechTherapistMenu.tscn")

func _on_Play_pressed():
	get_tree().change_scene("res://ExerciceMenu.tscn")


func _on_Help_pressed():
	get_tree().change_scene("res://interfaceGesture.tscn")

func _on_SpeakTest_pressed():
	tts.speakText("Ceci est un test pour la synthèse vocale !")
