extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tts = null
var stt = null
var os = ""
var words = ""
var display = false
var incremented = false
var myWords = Global.customExercise.getAllWords()
var index = 0
var img = ""
var container = HBoxContainer.new()
var line1
var line2
var choice 

func mySize(word):
	var size = 0
	for i in word:
		print()
		if(i.to_ascii()[0] != 3):
			size += 1
	if(size == 1):
		return 1.7
	return size

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
	if(index + 3 < myWords.size()):
		for b in range(0,3):
					var control_img = Control.new()
					var colorR = ColorRect.new()
					colorR.color = "5472ae"
					colorR.rect_size.x = get_viewport().size.y / 2.2
					colorR.rect_size.y = get_viewport().size.y / 2.2
					control_img.add_child(colorR)
					index += 1
					var box_image = Control.new()
					var hBox = HBoxContainer.new()
					hBox.alignment = HBoxContainer.ALIGN_CENTER
					var image = TextureRect.new()
					image.texture = load("res://art/users/assistant.png")
					image.expand = true
					image.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
					image.rect_size.x = (get_viewport().size.y / 2.2) - 10
					image.rect_size.y = (get_viewport().size.y / 2.2) -10
					box_image.add_child(image)
					hBox.add_child(box_image)
					var vBox2 = VBoxContainer.new()
					vBox2.add_child(hBox)
					control_img.add_child(vBox2)
					find_node("gridCard").add_constant_override("hseparation",  (get_viewport().size.y / 2)+10)
					find_node("gridCard").add_child(control_img)
		find_node("Choice").add_constant_override("separation", (get_viewport().size.y / 2.2)/2)
		find_node("game").add_constant_override("separation", get_viewport().size.y / 2.2 + 30)
	else : 
		get_tree().change_scene("res://GameEnd.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://GameLevel.tscn")


func _on_Speak_pressed():
	if(stt != null && stt.isListening()):
		stt.stopListen()
		find_node("Record").set_text("Enregistrer")
	if(tts != null):
		var text = myWords[index-1].getWord()
		print(text)
		print(index)
		match os:
			"X11":
				tts.speak(text, false)
			"Android":
				tts.speakText(text)


func _on_Choice1_pressed():
	find_node("Choice2").pressed = false
	find_node("Choice3").pressed = false
	find_node("Validate").disabled = false
	choice = 1

func _on_Choice2_pressed():
	find_node("Choice1").pressed = false
	find_node("Choice3").pressed = false
	find_node("Validate").disabled = false
	choice = 2

func _on_Choice3_pressed():
	find_node("Choice2").pressed = false
	find_node("Choice1").pressed = false
	find_node("Validate").disabled = false
	choice = 3


func _on_Validate_pressed():
	#faire score
	find_node("Choice2").pressed = false
	find_node("Choice1").pressed = false
	find_node("Choice3").pressed = false
	find_node("Validate").disabled = true
	for i in range(0, find_node("gridCard").get_child_count()):
		find_node("gridCard").get_child(i).queue_free()
	_ready()
