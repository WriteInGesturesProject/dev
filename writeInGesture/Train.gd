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

func _scaleImg():
	var img = Global.find_texture(myWords[index].getPath())
	find_node("Image").texture = img
	find_node("Image").rect_size.y = get_viewport().size.y / 2.5
	find_node("Box").add_constant_override("separation", int(find_node("Image").rect_size.x) + 20)
	find_node("Image").rect_size.x = get_viewport().size.y / 2.5 * (img.get_size().x / img.get_size().y)

func _ready():
	Ex = Global.current_ex
	myWords = Ex.getAllWords()
	Global.try = []
	for i in myWords:
		Global.try.append(false)

	_scaleImg()
	var phonetic = myWords[index].getPhonetic()
	var arrayPicture = Global.phoneticToArrayPicturePath(phonetic)
	container =  Global.putBorelInHboxContainer(arrayPicture, get_viewport().size.x, min(get_viewport().size.y/2.3,get_viewport().size.x/arrayPicture.size()))
	find_node("ImgBorel").add_child(container)
	find_node("Word").set_text(myWords[index].getWord())
	Global.score = 0
	var margSize = get_viewport().size.y - get_viewport().size.y / 2.5 - container.rect_size.y - find_node("Word").rect_size.y - find_node("MainBox").get_constant("separation")
	find_node("MarginContainer").add_constant_override("margin_top", margSize / 2)
	find_node("Speak").rect_position.y += (find_node("Image").rect_size.y - 2*find_node("Speak").rect_size.y)/2
	find_node("Record").rect_position.y += (find_node("Image").rect_size.y - 2*find_node("Speak").rect_size.y)/2


func _process(delta):
	if(stt != null && display && stt.isDetectDone()):
		words = stt.getWords()
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
	find_node("Oui").visible = false
	find_node("Non").visible = false
	display = false
	index += 1
	if(index >= myWords.size()):
		get_tree().change_scene("res://GameEnd.tscn")
	else :
		_scaleImg()
		container.remove_and_skip()
		container.name = "HBoxContainer"
		var phonetic = myWords[index].getPhonetic()
		var arrayPicture = Global.phoneticToArrayPicturePath(phonetic)
		container =  Global.putBorelInHboxContainer(arrayPicture, get_viewport().size.x, min(get_viewport().size.y/2.3,get_viewport().size.x/arrayPicture.size()))
		find_node("ImgBorel").add_child(container)
		find_node("Word").set_text(myWords[index].getWord())
	incremented = false


func _on_Speak_pressed():
	if(stt != null && stt.isListening()):
		stt.stopListen()
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
