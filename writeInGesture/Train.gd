extends Control

#const TTSDriver = preload("res://modules/TTS/TTSDriver.gdns")

const Exercise = preload("res://Exercise.gd")
const MyDictionnary = preload("res://Dictionnary.gd")

var Ex : Exercise
var tts = Global.tts
var stt = Global.stt
var words = ""
var display = false
var incremented = false
var myWords : Array = []
var index = 0
var container = HBoxContainer.new()
var os = Global.os

func _ready():
	Ex = Global.current_ex
	myWords = Ex.getAllWords()
	Global.try = []
	for i in myWords:
		Global.try.append(false)
	
	if(Global.game == 2):
		find_node("Number").set_text(myWords[index].getPath())
		find_node("TextureRect2").visible = false
		find_node("Number").visible = true
		find_node("Word").set_text(myWords[index].getWord())
	else :
		find_node("TextureRect2").texture = load("res://art/" + myWords[index].getPath())
	var img = ""
	container = HBoxContainer.new()
	container.alignment = HBoxContainer.ALIGN_CENTER
	var c = 0
	var p = myWords[index].getPhonetic()
	while (c < len(p)):
		if(c + 1 < len(p) && p[c].to_ascii()[0] == 91 && p[c + 1].to_ascii()[0] == 3):
			img = "in.png"
			c += 1
		elif(c+1 < len(p) && p[c].to_ascii()[0] == 84 && p[c+1].to_ascii()[0] == 3):
			img = "on.png"
			c += 1
		elif(p[c].to_ascii()[0] == 226):
			img = "an.png"
		else :
			var find = false
			for b in Global.phoneticDictionnary:
				for w in Global.phoneticDictionnary[b]:
					if(p[c] == w["phonetic"][1]):
						img = w["ressource_path"]
						find = true
						break
				if(find):
					break
		var imgBorel = TextureRect.new()
		imgBorel.texture = load("res://art/imgBorel/"+img)
		container.add_child(imgBorel)
		c += 1
	find_node("ImgBorel").add_child(container)
	find_node("Word").set_text(myWords[index].getWord())
	Global.score = 0

func check_words(sentence):
	var words = sentence.split(" ")
	if(words == null || len(words) == 0):
		return false
	for w in words:
		if(check_homonyms(w.to_lower())):
			return true
	return false

func check_homonyms(w):
	var word = Global.wordDictionnary.getWord(myWords[index].getPhonetic())
	if(word == null):
		print("Word in check_homonyms is null")
		return false
	var h = word.getHomonym()
	for i in range(0, len(h)):
		if(w == h[i].to_lower()):
			return true
	return false

func _process(delta):
	if(stt != null && stt.isListening()):
		find_node("Record").set_text("En écoute")
	if(stt != null && !stt.isListening()):
		find_node("Record").set_text("Enregistrer")
	if(stt != null && display && stt.isDetectDone()):
		words = stt.getWords()
		find_node("Record").set_text("Vous avez dit : " + words)
		if(words == find_node("Number").text || check_words(words)):
			find_node("Oui").visible = true
			find_node("Non").visible = false
			find_node("Record").disabled = true
			if(incremented == false):
				Ex.setWordSuccess(Global.level, index, Ex.getWordSuccess(Global.level, index) + 1)
				Global.score += 1
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
			if(c+1 < len(p) && p[c].to_ascii()[0] == 91 && p[c+1].to_ascii()[0] == 3):
				img = "in.png"
				c += 1
			elif(c + 1 < len(p) && p[c].to_ascii()[0] == 84 && p[c + 1].to_ascii()[0] == 3):
				img = "on.png"
				c += 1
			elif(p[c].to_ascii()[0] == 226):
				img = "an.png"
			else :
				var find = false
				for b in Global.phoneticDictionnary:
					for w in Global.phoneticDictionnary[b]:
						if(p[c] == w["phonetic"][1]):
							img = w["ressource_path"]
							find = true
							break
					if(find):
						break
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
			Global.try[index] = true
			display = true
			Ex.setNbWordOccurrence(Global.level, index, Ex.getNbWordOccurrence(Global.level, index) + 1)
		else :
			stt.stopListen()
			find_node("Record").set_text("Enregistrer")
