extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tts = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if(Engine.has_singleton("GodotTextToSpeech")):
		tts = Engine.get_singleton("GodotTextToSpeech")
		tts.fireTTS()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Back_pressed():
	get_tree().change_scene("res://interfaceGesture.tscn")


func _on_Speak_pressed():
	if(tts != null):
		tts.speakText(find_node("Name").text)
