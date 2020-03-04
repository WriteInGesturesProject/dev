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
	var phonetic = myWords[index].getPhonetic()
	var arrayPicture = Global.phoneticToArrayPicturePath(phonetic)
	container =  Global.putBorelInHboxContainer(arrayPicture, get_viewport().size.x, min(get_viewport().size.y/2,get_viewport().size.x/arrayPicture.size()))
	
	find_node("ImgBorel").add_child(container)
	find_node("Word").set_text(myWords[index].getWord())
	Global.score = 0


func _process(delta):
	if(stt != null && stt.isListening()):
		find_node("Record").set_text("En écoute")
	if(stt != null && !stt.isListening()):
		find_node("Record").set_text("Enregistrer")
	if(stt != null && display && stt.isDetectDone()):
		words = stt.getWords()
		find_node("Record").set_text("Vous avez dit : " + words)
		if(words == find_node("Number").text || Global.check_words(words, myWords[index])):
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
		container.name = "HBoxContainer"
		var phonetic = myWords[index].getPhonetic()
		var arrayPicture = Global.phoneticToArrayPicturePath(phonetic)
		container =  Global.putBorelInHboxContainer(arrayPicture, get_viewport().size.x, min(get_viewport().size.y/2,get_viewport().size.x/arrayPicture.size()))
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
