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
var myWords = Global.loadFileInArray("wordsAvailable")
var index = 0
var img = ""
var container = HBoxContainer.new()
var board = []

var count = 0

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
	var numb = 0
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
				image.rect_size.x = get_viewport().size.y / 8
				image.rect_size.y = get_viewport().size.y / 8
				board.append(image)
				find_node("gridImage").add_constant_override("vseparation",  get_viewport().size.y / 8)
				find_node("gridImage").add_constant_override("hseparation",  (get_viewport().size.y / 8)+10)
				control_img.add_child(image)
				find_node("gridImage").add_child(control_img)
	for c in myWords[index]:
			container = HBoxContainer.new()
			container.alignment = HBoxContainer.ALIGN_CENTER
			img = Global.searchInDictionnary(c)
			var imgBorel = TextureRect.new()
			imgBorel.texture = load("res://art/imgBorel/"+img)
			container.add_child(imgBorel)
	find_node("ImgBorel").add_child(container)
	find_node("Word").text = myWords[index]
	board[0].modulate = "e86767"

func _change():
	count = 0
	find_node("Record").disabled = false
	find_node("Record").set_text("Enregistrer")
	display = false
	index += 1
	board[index-1].modulate = "ffffff"
	board[index].modulate = "e86767"
	container.remove_and_skip()
	var img = ""
	if(index >= myWords.size()):
		get_tree().change_scene("res://GameEnd.tscn")
	else :
		container = HBoxContainer.new()
		container.alignment = HBoxContainer.ALIGN_CENTER
		container.name = "HBoxContainer"
		for c in myWords[index]:
			img = Global.searchInDictionnary(c)
			var imgBorel = TextureRect.new()
			imgBorel.texture = load("res://art/imgBorel/"+img)
			container.add_child(imgBorel)
		find_node("ImgBorel").add_child(container)
		find_node("Word").set_text(myWords[index])
	incremented = false

func _process(delta):
	if(stt != null && stt.isListening()):
		find_node("Record").set_text("En écoute")
	if(stt != null && !stt.isListening()):
		find_node("Record").set_text("Enregistrer")
	if(stt != null && display && stt.isDetectDone()):
		words = stt.getWords()
		find_node("Record").set_text("Vous avez dit : " + words)
		if(words == find_node("Word").text):
			find_node("Record").disabled = true
			if(incremented == false):
				Global.score[Global.level][Global.game - 1] += 1
				incremented = true
				_change()

func _on_Speak_pressed():
	if(stt != null && stt.isListening()):
		stt.stopListen()
		find_node("Record").set_text("Enregistrer")
	if(tts != null):
		var text = myWords[index]
		match os:
			"X11":
				tts.speak(text, false)
			"Android":
				tts.speakText(text)

func _on_Record_pressed():
	if(count == 2):
		_change()
		return
	count += 1
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


func _on_Back_pressed():
	get_tree().change_scene("res://GameChoose.tscn")
