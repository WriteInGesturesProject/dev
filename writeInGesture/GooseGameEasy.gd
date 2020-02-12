extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tts = null
var stt = null
var os = ""
var display = false
var incremented = false

# Called when the node enters the scene tree for the first time.
func _ready():
	os = OS.get_name()
	match os:
		"X11":
			#tts = TTSDriver.new()
			set_process(true)
			if(tts != null):
				tts.set_voice("French (France)")
		"Android":
			if(Engine.has_singleton("GodotTextToSpeech")):
				tts = Engine.get_singleton("GodotTextToSpeech")
				tts.fireTTS()
			if(Engine.has_singleton("GodotSpeech")):
				stt = Engine.get_singleton("GodotSpeech")
	for b in range(0,5):
		for w in range(0,8):
			if((b==0 && w==7) || (b==2 && (w==7 || w ==0)) || (b==4 && w==0) || (b==1 && w!=7) || (b==3 && w!=0)):
				var control_img = Control.new()
				find_node("gridImage").add_child(control_img)
			else :
				var control_img = Control.new()
				var image = TextureRect.new()
				image.texture = load("res://art/users/assistant.png")
				image.expand = true
				image.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
				image.rect_size.x = 80
				image.rect_size.y = 80
				control_img.add_child(image)
				find_node("gridImage").add_child(control_img)

func _on_Speak_pressed(extra_arg_0):
	if(stt != null && stt.isListening()):
		stt.stopListen()
		find_node("Record").set_text("Enregistrer")
	if(tts != null):
		var text = "bonjour"
		match os:
			"X11":
				tts.speak(text, false)
			"Android":
				tts.speakText(text)

func _on_Record_pressed():
	if(stt != null):
		if(stt.isListening() == false):
			stt.doListen()
			display = true
		else :
			stt.stopListen()
			find_node("Record").set_text("Enregistrer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
