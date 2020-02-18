extends Control

#const TTSDriver = preload("res://modules/TTS/TTSDriver.gdns")

const Exercise = preload("res://Exercise.gd")

var tts = null
var stt = null
var words = ""
var display = false
var incremented = false
var os = ""
var myWords : Array = []
var index = 0
var container = HBoxContainer.new()

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
	match (Global.game):
		1:
			myWords = Global.customExercise.getAllWords()
		2:
			myWords = Global.countExercise.getAllWords()
		3:
			myWords = Global.weekExercise.getAllWords()
		4:
			myWords = Global.colorExercise.getAllWords()
	if(Global.game == 2):
		find_node("Number").set_text(myWords[index].getPath())
		find_node("TextureRect2").visible = false
		find_node("Number").visible = true
		find_node("Word").set_text(myWords[index].getWord())
	else :
		find_node("TextureRect2").texture = load("res://art/"+myWords[index].getPath())
	var img = ""
	container = HBoxContainer.new()
	container.alignment = HBoxContainer.ALIGN_CENTER
	var c = 0
	var p = myWords[index].getPhonetic()
	while (c < len(p)):
		print(p[c].to_ascii()[0])
		if(c+1 < len(p) && p[c].to_ascii()[0] == 91 && p[c+1].to_ascii()[0] == 3):
			img = "in.png"
			c += 1
		else :
			for b in Global.phoneticDictionnary:
				for w in Global.phoneticDictionnary[b]:
					if(p[c] == w["phonetic"][1]):
						img = w["ressource_path"]
		var imgBorel = TextureRect.new()
		imgBorel.texture = load("res://art/imgBorel/"+img)
		container.add_child(imgBorel)
		c += 1
	find_node("ImgBorel").add_child(container)
	find_node("Word").set_text(myWords[index].getWord())
	Global.score[Global.level][Global.game - 1] = 0
	
func _process(delta):
	if(stt != null && stt.isListening()):
		find_node("Record").set_text("En écoute")
	if(stt != null && !stt.isListening()):
		find_node("Record").set_text("Enregistrer")
	if(stt != null && display && stt.isDetectDone()):
		words = stt.getWords()
		find_node("Record").set_text("Vous avez dit : " + words)
		if(words.to_lower() == (find_node("Word").text).to_lower() || words == find_node("Number").text):
			find_node("Oui").visible = true
			find_node("Non").visible = false
			find_node("Record").disabled = true
			if(incremented == false):
				Global.score[Global.level][Global.game - 1] += 1
				incremented = true
		else:
			find_node("Oui").visible = false
			find_node("Non").visible = true
	else:
		find_node("Oui").visible = false
		find_node("Non").visible = false

func _on_Back_pressed():
	get_tree().change_scene("res://ExerciceMenu.tscn")

func _on_Next_pressed():
	find_node("Record").disabled = false
	find_node("Record").set_text("Enregistrer")
	find_node("Oui").visible = false
	find_node("Non").visible = false
	display = false
	index += 1
	if(index >= myWords.size()):
		get_tree().change_scene("res://GameEnd.tscn")
	else :
		if(Global.game == 2):
			if(index == myWords.size()):
				get_tree().change_scene("res://GameEnd.tscn")
			else:
				find_node("Number").set_text(myWords[index].getPath())
				find_node("TextureRect2").visible = false
				find_node("Word").visible = true
				find_node("Word").set_text(myWords[index].getWord())
		else :
			find_node("TextureRect2").texture = load("res://art/"+myWords[index].getPath())
		container.remove_and_skip()
		var img = ""
		container = HBoxContainer.new()
		container.alignment = HBoxContainer.ALIGN_CENTER
		container.name = "HBoxContainer"
		var c = 0
		var p = myWords[index].getPhonetic()
		print(myWords[index].getWord())
		while (c < len(p)):
			print(p[c].to_ascii()[0])
			if(c+1 < len(p) && p[c].to_ascii()[0] == 91 && p[c+1].to_ascii()[0] == 3):
				img = "in.png"
				c += 1
			elif(c+1 < len(p) && p[c].to_ascii()[0] == 84 && p[c+1].to_ascii()[0] == 3):
				img = "on.png"
				c += 1
			elif(p[c].to_ascii()[0] == 226):
				img = "an.png"
			else :
				for b in Global.phoneticDictionnary:
					for w in Global.phoneticDictionnary[b]:
						if(p[c] == w["phonetic"][1]):
							img = w["ressource_path"]
			var imgBorel = TextureRect.new()
			imgBorel.texture = load("res://art/imgBorel/"+img)
			container.add_child(imgBorel)
			c += 1
		find_node("ImgBorel").add_child(container)
		find_node("Word").set_text(myWords[index].getWord())
	incremented = false

func _on_Speak_pressed(extra_arg_0):
	if(stt != null && stt.isListening()):
		stt.stopListen()
		find_node("Record").set_text("Enregistrer")
	if(tts != null):
		var text = find_node("Word").text
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
