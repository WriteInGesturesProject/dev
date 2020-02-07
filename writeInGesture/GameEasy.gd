extends Control

var tts = null
var stt = null
var words = ""
var display = false
var incremented = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var myWords = Global.loadFileInArray("wordsAvailable")
var index = 0
var container = HBoxContainer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	if(Engine.has_singleton("GodotTextToSpeech")):
		tts = Engine.get_singleton("GodotTextToSpeech")
		tts.fireTTS()
	if(Engine.has_singleton("GodotSpeech")):
		stt = Engine.get_singleton("GodotSpeech")
	if(Global.game == 2):
		get_node("ColorRect/MarginContainer/VBoxContainer/Number").set_text(Global.Number[Global.index])
		find_node("TextureRect").texture = load(Global.img_count[Global.index])
		get_node("ColorRect/MarginContainer/VBoxContainer/TextureRect2").visible = false
		get_node("ColorRect/MarginContainer/VBoxContainer/Number").visible = true
		get_node("ColorRect/MarginContainer/VBoxContainer/Word").set_text(Global.words_count[Global.index])
	elif(Global.game == 1):
		var img = ""
		find_node("TextureRect").visible = false
		container = HBoxContainer.new()
		container.alignment = HBoxContainer.ALIGN_CENTER
		for c in myWords[index]:
			img = Global.searchInDictionnary(c)
			var imgBorel = TextureRect.new()
			imgBorel.texture = load("res://art/imgBorel/"+img)
			container.add_child(imgBorel)
		find_node("ImgBorel").add_child(container)
		#get_node("ColorRect/MarginContainer/VBoxContainer/TextureRect2").textue = image du mot
		get_node("ColorRect/MarginContainer/VBoxContainer/Word").set_text(myWords[index])
	Global.score[Global.level][Global.game - 1] = 0
	
func _process(delta):
	if(stt != null):
		words = stt.getWords()
		if(display == false):
			find_node("Oui").visible = false
			find_node("Non").visible = false
		elif(words == find_node("Word").text || words == find_node("Number").text):
			find_node("Oui").visible = true
			find_node("Non").visible = false
			find_node("Record").disabled = true
			if(incremented == false):
				Global.score[Global.level][Global.game - 1] += 1
				incremented = true
		else:
			find_node("Oui").visible = false
			find_node("Non").visible = true

func _on_Back_pressed():
	get_tree().change_scene("res://GameLevel.tscn")

func _on_Next_pressed():
	find_node("Record").disabled = false
	display = false
	if(Global.game == 2):
		Global.index += 1
		if(Global.index == 10):
			get_tree().change_scene("res://GameEnd.tscn")
		else:
			get_node("ColorRect/MarginContainer/VBoxContainer/Number").set_text(Global.Number[Global.index])
			find_node("TextureRect").texture = load(Global.img_count[Global.index])
			get_node("ColorRect/MarginContainer/VBoxContainer/TextureRect2").visible = false
			get_node("ColorRect/MarginContainer/VBoxContainer/Word").visible = true
			get_node("ColorRect/MarginContainer/VBoxContainer/Word").set_text(Global.words_count[Global.index])
	elif(Global.game == 1):
		index += 1
		container.remove_and_skip()
		var img = ""
		find_node("TextureRect").visible = false
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
			#get_node("ColorRect/MarginContainer/VBoxContainer/TextureRect2").textue = image du mot
			get_node("ColorRect/MarginContainer/VBoxContainer/Word").set_text(myWords[index])
	incremented = false

func _on_Speak_pressed(extra_arg_0):
	if(tts != null):
		tts.speakText(find_node("Word").text)

func _on_Record_pressed():
	if(stt != null):
		stt.doListen()
		display = true
