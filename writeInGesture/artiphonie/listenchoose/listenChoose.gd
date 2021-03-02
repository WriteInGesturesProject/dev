extends Control

var textToSpeech = Global.textToSpeech
var speechToText = Global.speechToText

const Card = preload("./cardListenChoose.gd")

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
var cardSelected : Card
var findCard : Card
var indexWord : int

var currentCard : Card
var card2 : Card
var card3 : Card

func _ready():
	
	add_child(Global.manageInstruction.instruction("listen"))
	
	plate = find_node("plate")
	prevChoice = null
	sizeViewPort = get_viewport().size
	var sizeCard = Vector2(sizeViewPort.x/4, sizeViewPort.y*0.6)
	
	var speakButton = find_node("speak")
	
	var validateButton = find_node("Validate")
	
	var yRest = - find_node("speak").rect_size.y - find_node("Validate").rect_size.y - sizeCard.y + sizeViewPort.y
	plate.add_constant_override("separation", sizeCard.x + (sizeViewPort.x*0.25)/3)
	find_node("marginPlate").add_constant_override("margin_left", (sizeViewPort.x*0.25)/6)
	find_node("marginPlate").add_constant_override("margin_top", yRest/2 + speakButton.rect_size.y)
	if(index+3 <= myWords.size()):
		rand = randi() % 3
		for b in range(0,3):
			currentCard = Card.new()
			currentCard.name = String(b)
			find_node("plate").add_child(currentCard)
			currentCard.setUpCard(myWords[index+b], Global.manageGame.level, sizeCard)
			currentCard.buttonSelection.connect("gui_input", self, "_cardSelected", [currentCard])
			if b == rand : 
				indexWord = index+b
				findCard = currentCard
		index += 3
	else :
		Global.change_scene("res://page/navigation/gameEnd.tscn")

func _cardSelected(event : InputEvent, card : Card) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if cardSelected != null :
			cardSelected.backgroundColor.set("custom_styles/panel", load("res://assets/theme/backgroundPanelSelected.tres"))
		card.backgroundColor.set("custom_styles/panel", load("res://assets/theme/backgroundPanel.tres"))
		cardSelected = card
		_on_Validate_pressed()

func _on_Back_pressed():
	Global.change_scene("res://page/navigation/gameChoose.tscn")

func _on_speak_pressed():
	if(speechToText != null && speechToText.isListening()):
		speechToText.stopListen()
	if(textToSpeech != null):
		var text = findCard.wordLabel.text
		match OS.get_name():
			"X11":
				textToSpeech.speak(text, false)
			"Android":
				textToSpeech.speakText(text)

func _on_Validate_pressed():
	Global.listenExercise.setNbWordOccurrence(Global.manageGame.level, indexWord, Global.listenExercise.getNbWordOccurrence(Global.manageGame.level, indexWord) + 1)
	if(findCard.wordLabel.text == cardSelected.wordLabel.text):
		Global.manageGame.score += 1
		find_node("Good").playing = true
		Global.listenExercise.set_wordSuccess(Global.manageGame.level, indexWord, Global.listenExercise.get_wordSuccess(Global.manageGame.level, indexWord) + 1)
	else : 
		find_node("Wrong").playing = true
	cardSelected = null
	for i in range(0, plate.get_child_count()):
		plate.get_child(i).queue_free()
	_ready()


func _on_speakControl_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if(textToSpeech != null):
			var text = findCard.wordLabel.text
			print(text)
			match OS.get_name():
				"X11":
					textToSpeech.speak(text, false)
				"Android":
					textToSpeech.speakText(text)
