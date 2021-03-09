extends Control

var CardScene = preload("./card_listen_choose.tscn")

var textToSpeech = Global.textToSpeech


const NB_SCREEN = 10

var words = ""
var display = false
var incremented = false
var listOfWords : Array
var listOfUndoneWords : Array

var index : int = 0
var img = ""
var container
var line1 #line 1 in case of more than 3 borel image
var line2 #line 2 in case of more than 3 borel image
var choice #choix fait par l'enfant
var rand = 0 #choix aléatoire de l'image à trouver
var prevChoice : ColorRect
var plate : HBoxContainer
var sizeScene : Vector2
var cardSelected : CardScene
var cardToFind : CardScene
var indexWord : int
var score : int = 0
var difficulty : String
var sizeCard : Vector2
var currentCard : CardScene
#var card2 : Card
#var card3 : Card
var cardLayout : int

func _ready():
	
#	var arguments = Global.get_arguments()
#	difficulty = arguments[0]
	difficulty = "Facile"
	
	match difficulty:
		"Facile":
			cardLayout = 1
		"Normal":
			cardLayout = 2
		"Difficile":
			cardLayout = 3
			
	
	listOfWords = Global.activeList.words.duplicate(true)
	listOfUndoneWords = Global.activeList.words.duplicate(true)
	
	plate = find_node("plate")
	prevChoice = null
	sizeScene = Vector2(self.rect_size.x,self.rect_size.y)
	sizeCard = Vector2((sizeScene.x - 2*((sizeScene.x*0.25)/6))/3, sizeScene.y*0.6)
	
	var speakButton = find_node("speak")
	
	var validateButton = find_node("Validate")
	
	var yRest = - find_node("speak").rect_size.y - find_node("Validate").rect_size.y - sizeCard.y + sizeScene.y
#	plate.add_constant_override("separation", sizeCard.x + (sizeScene.x*0.25)/3)
	find_node("marginPlate").add_constant_override("margin_left", (sizeScene.x*0.25)/6)
	find_node("marginPlate").add_constant_override("margin_top", yRest/2 + speakButton.rect_size.y)
	next_screen()
	
func next_screen():
	if(index < NB_SCREEN && listOfUndoneWords.size() >= 3):
		var wordToFind = get_n_word_from_given_list(listOfUndoneWords,1)
		currentCard = CardScene.instance()
		currentCard.name = String(0)
		find_node("plate").add_child(currentCard)
		currentCard.setUpCard(wordToFind[0], cardLayout, sizeCard)
		currentCard.connect("card_pressed", self, "_on_Validate_pressed")
		cardToFind = currentCard
		listOfUndoneWords.erase(wordToFind[0])
		
		var wordsToComplete = get_n_word_from_given_list(listOfUndoneWords,2)
		for i in range (1,3):
			print("coucou")
			currentCard = CardScene.instance()
			currentCard.name = String(i)
			find_node("plate").add_child(currentCard)
			currentCard.setUpCard(wordsToComplete[i-1], cardLayout, sizeCard)
			currentCard.connect("card_pressed", self, "_on_Validate_pressed")
		index +=1
	else :
		game_end()

func _cardSelected(event : InputEvent, card : CardScene) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
#		if cardSelected != null :
#			cardSelected.backgroundColor.set("custom_styles/panel", load("res://assets/theme/backgroundPanelSelected.tres"))
#		card.backgroundColor.set("custom_styles/panel", load("res://assets/theme/backgroundPanel.tres"))
		cardSelected = card
#		_on_Validate_pressed()

func _on_speak_pressed():
	if(textToSpeech != null):
		var text = cardToFind.wordLabel.text
		match OS.get_name():
			"X11":
				textToSpeech.speak(text, false)
			"Android":
				textToSpeech.speakText(text)

func _on_Validate_pressed(card):
	if(cardToFind.find_node("layout_" + String(cardLayout)).find_node("word").text == card.word.word):
		print("score")
		score += 1
		find_node("Good").playing = true
	else : 
		find_node("Wrong").playing = true
	cardSelected = null
	for i in range(0, plate.get_child_count()):
		plate.get_child(i).queue_free()
	next_screen()


func _on_speakControl_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if(textToSpeech != null):
			var text = cardToFind.wordLabel.text
			print(text)
			match OS.get_name():
				"X11":
					textToSpeech.speak(text, false)
				"Android":
					textToSpeech.speakText(text)

func get_n_word_from_given_list(list : Array , n: int) -> Array:
	var randomPositions: Array = []
	randomPositions.append(randi() % list.size())
	for i in range(n-1):
		var tmp = randi() % list.size()
		while tmp in randomPositions:
			tmp = (tmp + 1) % list.size()
		randomPositions.append(tmp)
	var result: Array = []
	for randomPosition in randomPositions:
		result.append(list[randomPosition])
	return result


func calculate_score():
	return 2
	
func game_end():
	var score = calculate_score()
	#args to send to game_end
	var args : Array = []
	args.append("res://artiphonie/listen_choose/listen_choose.tscn")
	args.append([difficulty])
	args.append("Ecoute et choisis")
	args.append("")
	args.append(score)
	args.append(12)
	Global.change_scene("res://shared/game_end/game_end.tscn", args)
