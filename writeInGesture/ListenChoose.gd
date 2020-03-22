extends Control

var os = Global.os

var tts = Global.tts
var stt = Global.stt

const Card = preload("res://ChooseCard.gd")

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

#func mySize(word):
#	var size = 0
#	for i in word:
#		if(i.to_ascii()[0] != 3):
#			size += 1
#	if(size == 1):
#		return 1.7
#	return size

var currentCard : Card
var card2 : Card
var card3 : Card

# Called when the node enters the scene tree for the first time.
func _ready():
	plate = find_node("plate")
	prevChoice = null
	sizeViewPort = get_viewport().size
	var sizeCard = Vector2(sizeViewPort.x/4, sizeViewPort.y*0.75)
	var yRest = - find_node("Speak").rect_size.y - find_node("Validate").rect_size.y - sizeCard.y + sizeViewPort.y
	
	plate.add_constant_override("separation", sizeCard.x + (sizeViewPort.x*0.25)/3)
	find_node("marginPlate").add_constant_override("margin_left", (sizeViewPort.x*0.25)/6)
	find_node("marginPlate").add_constant_override("margin_top", yRest/2)
	if(index+3 <= myWords.size()):
		rand = randi() % 2
		print(rand)
		for b in range(0,3):
			currentCard = Card.new()
			currentCard.name = String(b)
			find_node("plate").add_child(currentCard)
			currentCard.setUpCard(myWords[index+b], Global.level, sizeCard)
			currentCard.buttonSelection.connect("gui_input", self, "_cardSelected", [currentCard])
			if b == rand : 
				findCard = currentCard
		index += 3
	else :
		get_tree().change_scene("res://GameEnd.tscn")


func _cardSelected(event : InputEvent, card : Card) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if cardSelected != null :
			cardSelected.backgroundColor.color = "4b89bf"
		card.backgroundColor.color = "30698c"
		cardSelected = card
		find_node("Validate").disabled = false

func _on_Back_pressed():
	get_tree().change_scene("res://GameLevel.tscn")

func _on_Speak_pressed():
	if(stt != null && stt.isListening()):
		stt.stopListen()
		find_node("Record").set_text("Enregistrer")
	if(tts != null):
		var text = findCard.wordLabel.text
		print(text)
		match os:
			"X11":
				tts.speak(text, false)
			"Android":
				tts.speakText(text)

func _on_Validate_pressed():
	if(findCard.wordLabel.text == cardSelected.wordLabel.text):
		Global.score += 1
		Global.player.setSilver(Global.player.getSilver()+1)
	find_node("Validate").disabled = true
	cardSelected = null
	for i in range(0, plate.get_child_count()):
		plate.get_child(i).queue_free()
	_ready()
