extends Control

var os = Global.os

var tts = Global.tts
var stt = Global.stt

var words = ""
var display = false
var incremented = false
var myWords = Global.listenExercise.getAllWords()
var index = 0
var img = ""
var container
var line1 #line 1 in case of more than 3 borel image
var line2 #line 2 in case of more than 3 borel image
var choice #choix fait par l'enfant
var rand = 0 #choix aléatoire de l'image à trouver
var prevChoice : ColorRect
var plate : HBoxContainer
var sizeViewPort : Vector2

func mySize(word):
	var size = 0
	for i in word:
		if(i.to_ascii()[0] != 3):
			size += 1
	if(size == 1):
		return 1.7
	return size


# Called when the node enters the scene tree for the first time.
func _ready():
	plate = find_node("plate")
	prevChoice = null
	container = null
	sizeViewPort = get_viewport().size
	var sizeCardX = sizeViewPort.x * 0.30
	var sizeCardY = sizeViewPort.y * 0.70
	var separationCard = sizeViewPort.x*0.02 + sizeCardX
#	plate.margin_left = get_viewport().size.x * 0.2
#	plate.rect_position.x = plate.rect_position.x - (get_viewport().size.y / 2.2)/2
	find_node("marginPlate").add_constant_override("margin_left", sizeViewPort.x * 0.03)
#	find_node("marginPlate").set("custom_contants/margin_left", get_viewport().size.x * 0.2)
#	Choose word to say
	rand = randi() % 3 + 1
	
	if(index + 3 == myWords.size()):
		for b in range(0,3):
			var cont = Control.new()
			var controlBackground = Control.new()
			
#			Color rect background
			var colorR = ColorRect.new()
			colorR.color = "5472ae"
			colorR.rect_size.x = sizeCardX
			colorR.rect_size.y = sizeCardY
			colorR.name = str(b+1)
			
			var button : TextureButton = TextureButton.new()
			var controlButton : Control = Control.new()
			button.rect_size = colorR.rect_size
			button.connect("pressed", self, "_on_buttonChoosePressed", [colorR])
			controlBackground.add_child(colorR)
			
#			CardContainer
			var cardContainer = MarginContainer.new()
#			cardContainer.margin_top = sizeViewPort.y * 0.025
			
#			Image borel container
			var imgBorelContainer = VBoxContainer.new()
			imgBorelContainer.rect_size.x = sizeCardX
			imgBorelContainer.rect_size.y = sizeCardY
			imgBorelContainer.alignment = VBoxContainer.ALIGN_CENTER
			
#			Word Label
			var word = Label.new()
			word.text = myWords[index].getWord()
			word.align = Label.ALIGN_CENTER
			
			var phonetic = myWords[index].getPhonetic()
#			Catch image borel
			var arrayPicture = Global.phoneticToArrayPicturePath(phonetic)
#			More than 3 images borel
			if(arrayPicture.size() > 3):
				line1 = Global.putBorelInHboxContainer([arrayPicture[0],arrayPicture[1],arrayPicture[2]], sizeCardX-2 , sizeCardY*0.20)
				var tab = []
				for i in range(3, arrayPicture.size()):
					tab.append(arrayPicture[i])
				line2 = Global.putBorelInHboxContainer(tab, sizeCardX-2, sizeCardY*0.20)
				container = VBoxContainer.new()
				container.add_child(line1)
				container.add_child(line2)
			else :
				container = Global.putBorelInHboxContainer(arrayPicture, sizeCardX-2, (sizeCardX-2)/arrayPicture.size())
			
#			Display image borel if easy or medium level
			if(Global.level == 0 || Global.level == 1):
				imgBorelContainer.add_child(container)
			
#			Image Word
			var controlImageWord = Control.new()
			var imageWord = TextureRect.new()
			imageWord.texture = load("res://art/images/"+ myWords[index].getPath())
			imageWord.expand = true
			imageWord.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
			if(Global.level == 0 || Global.level == 1):
				if(mySize(myWords[index].getPhonetic()) > 3):
					_scaleImg(imageWord, sizeCardY*0.40)
				else :
					_scaleImg(imageWord, sizeCardY*0.45)
			else :
				_scaleImg(imageWord, sizeCardY*0.50)
			controlImageWord.add_child(imageWord)
			imageWord.rect_position.x = (sizeCardX - imageWord.rect_size.x)/2
			
#			if(Global.level == 0 || Global.level ==2):
#				hBox.add_child(controlImageWord)

			var vBoxCard = VBoxContainer.new()
#			If easy level display label Word
			
#			If easy or hard level display image of the word
			if(Global.level == 0 || Global.level == 1):
				vBoxCard.add_child(imgBorelContainer)
			if(Global.level == 0):
				vBoxCard.add_child(word)
#			if(Global.level == 0 || Global.level ==2):
			vBoxCard.add_child(controlImageWord)
				
			cardContainer.add_child(vBoxCard)
			
#			Container = container images borel
			var separation = sizeCardY - imageWord.rect_size.y - container.rect_min_size.y - word.get_minimum_size().y
			if(arrayPicture.size() > 3):
				cardContainer.add_constant_override("margin_top", separation/10)
				vBoxCard.add_constant_override("separation", separation/15)
			else : 
				cardContainer.add_constant_override("margin_top", separation/5)
				vBoxCard.add_constant_override("separation", separation/5)
#			print(imageWord.rect_size.y,  " , " , container.rect_min_size.y , " ,  " , word.get_minimum_size().y)

			controlBackground.add_child(cardContainer)
			
			plate.add_constant_override("separation", separationCard)
			var mainControl : Control = Control.new()
			controlButton.add_child(button)
			mainControl.add_child(controlBackground)
			mainControl.add_child(controlButton)
			plate.add_child(mainControl)
			
			find_node("VBoxContainer").set("custom_constants/separation", (get_viewport().size.y *0.15))
			index += 1
	else : 
		get_tree().change_scene("res://GameEnd.tscn")

func _scaleImg(textureRect, size):
	if textureRect.texture.get_size().y > textureRect.texture.get_size().x :
		textureRect.rect_size.y = size
		textureRect.rect_size.x = size * (textureRect.texture.get_size().x / textureRect.texture.get_size().y)
	else :
		textureRect.rect_size.x = size
		textureRect.rect_size.y = size * (textureRect.texture.get_size().y / textureRect.texture.get_size().x)

func _on_buttonChoosePressed(colorRect):
	if prevChoice != null :
		prevChoice.modulate = "ffffff"
	colorRect.modulate = "5472ae"
	match colorRect.name :
		"1":
			choice = 3
		"2":
			choice = 2
		"3":
			choice = 1
	find_node("Validate").disabled = false
	prevChoice = colorRect

func _on_Back_pressed():
	get_tree().change_scene("res://GameLevel.tscn")


func _on_Speak_pressed():
	if(stt != null && stt.isListening()):
		stt.stopListen()
		find_node("Record").set_text("Enregistrer")
	if(tts != null):
		var text = myWords[index - rand].getWord()
		match os:
			"X11":
				tts.speak(text, false)
			"Android":
				tts.speakText(text)

func _on_Validate_pressed():
	if(rand == choice):
		Global.score += 1
		Global.player.setSilver(Global.player.getSilver()+1)
	find_node("Validate").disabled = true
	for i in range(0, plate.get_child_count()):
		plate.get_child(i).queue_free()
	_ready()
