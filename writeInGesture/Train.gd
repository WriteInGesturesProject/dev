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
var margin = 0.05
var VectorMarge

func _scaleImg(lengthY : float):
	var img = Global.find_texture(myWords[index].getPath())
	find_node("Image").texture = img
	find_node("Image").rect_size.y = lengthY
	find_node("Image").rect_size.x = lengthY * (img.get_size().x / img.get_size().y)
	
#	##Center picture 
	find_node("Image").rect_position.x = - find_node("Image").rect_size.x * 0.3
	
	#Ajust Speak and Record button
	var separationButton = VectorMarge.x / 10
	find_node("Speak").rect_size.y = find_node("Image").rect_size.y * 0.45
	find_node("Speak").rect_size.x = find_node("Image").rect_size.y * 0.45
	find_node("Speak").rect_position.x = find_node("Image").rect_size.x/2 + separationButton
	find_node("Speak").get_parent().rect_min_size = find_node("Speak").rect_size
	
	find_node("Record").rect_size.y = find_node("Image").rect_size.y * 0.45
	find_node("Record").rect_size.x = find_node("Image").rect_size.y * 0.45
	find_node("Record").rect_position.x = find_node("Image").rect_size.x/2 + separationButton
	
	find_node("VBoxContainerButton").add_constant_override("separation",find_node("Image").rect_size.y * 0.1)
	
	##Put the size of the Image+Speak+Record Box
	find_node("Box").rect_min_size.y = find_node("Image").rect_size.y
	
func displayWord(word) :
	var phonetic = word.getPhonetic()
	#display Image
	var lengthY = VectorMarge.y * 0.3
	var lengthX = 0
	_scaleImg(lengthY)
	
	#Display Image Borel
	var arrayPicture = Global.phoneticToArrayPicturePath(phonetic)
	lengthY = VectorMarge.y * 0.4
	lengthX = lengthY * arrayPicture.size()
	if(lengthX > VectorMarge.x) :
		lengthX = VectorMarge.x
	print(lengthX,"  ",lengthY)
	container = Global.putBorelInHboxContainer(arrayPicture, lengthX, lengthY)
	print(container.rect_min_size)
	find_node("HBoxBorel").add_child(container)
	
	#Display Word
	find_node("Word").set_text(myWords[index].getWord())
	find_node("Word").get_font("font").size = VectorMarge.y * 0.1
	
	find_node("VBox").add_constant_override("separation",VectorMarge.y * 0.2 /4)
	

func _ready():
	Ex = Global.current_ex
	myWords = Ex.getAllWords()
	Global.try = []
	for i in myWords:
		Global.try.append(false)
	
	Global.score = 0
	
	#Display the scene
	Global.make_margin(find_node("MarginContainer"), margin)
	VectorMarge = get_viewport().size * (1-2*margin)
	find_node("HBoxBorel").rect_min_size.x = VectorMarge.x

	displayWord(myWords[index])
	
#	find_node("Speak").rect_position.y += (find_node("Image").rect_size.y - 2*find_node("Speak").rect_size.y)/2
#	find_node("Record").rect_position.y += (find_node("Image").rect_size.y - 2*find_node("Speak").rect_size.y)/2


func _process(delta):
	if(stt != null && display && stt.isDetectDone()):
		words = stt.getWords()
		if(words == str(index+1) || Global.check_words(words, myWords[index])):
			find_node("Record").disabled = true
			if(incremented == false):
				Ex.setWordSuccess(Global.level, index, Ex.getWordSuccess(Global.level, index) + 1)
				Global.score += 1
				find_node("Good").playing = true
				incremented = true
		elif(incremented == false):
			find_node("Wrong").playing = true
			incremented = true


func _on_Back_pressed():
	get_tree().change_scene("res://ExerciceMenu.tscn")


func _on_Next_pressed():
	find_node("Record").disabled = false
	display = false
	index += 1
	if(index >= myWords.size()):
		get_tree().change_scene("res://GameEnd.tscn")
	else :
		container.remove_and_skip()
		container.name = "HBoxContainer"
		
		displayWord(myWords[index])
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
