extends Node

const memoryCard := preload("./memory_card.tscn")

var listOfWords : Array
var cards : Array
var selected_cards : Array = []
var nbWord : int = 4
var nbFound : int = 0
var separationPercentage = 0.02
var nbWrongTry : int = 0

##Timer
onready var timer = $Timer
var time = 0

func _ready():
	match Global.get_arguments()[0]:
		"Facile":
			nbWord = 4
		"Normal":
			nbWord = 8
		"Difficile":
			nbWord = 12
	
	initTimer()

	#setUp the list of card for this party
	listOfWords = Global.get_n_word_from_active_list(nbWord)
	var nbCard = nbWord*2
	#setUp the grid of cards
	var gridCard = find_node("GridCards")
	var vectorSizeColumsRows = findColumnsRows(nbCard)
	var nbRow  = vectorSizeColumsRows.y
	var nbCol =  vectorSizeColumsRows.x
	gridCard.columns = nbCol
	#calcul the separation between 2 cards
	var separationX = gridCard.rect_size.x * nbCol * separationPercentage
	var separationY = gridCard.rect_size.y * nbRow * separationPercentage
	#calcul the card size depending on the page size
	var card_size = Vector2((gridCard.rect_size.x - separationX)/ nbCol, (gridCard.rect_size.y - separationY) / nbRow)
	
	gridCard.set("custom_constants/vseparation", card_size.y + (separationY / nbRow))
	gridCard.set("custom_constants/hseparation", card_size.x + (separationX / nbCol))
	
	#Creation of the memory card
	for i in range(0, 2): #create 2 cards for each word
		for w in listOfWords: # For each words
			var card = memoryCard.instance()
			card.init_card(w, card_size)
			#when card is pressed, called the _on_card_pressed function 
			card.connect("card_pressed",self,"_on_card_pressed")
			cards.append(card)
	cards.shuffle() # We put the cards in a random order
	for c in cards: # We add the cards to the grid
		gridCard.add_child(c) 
		
	
func _on_card_pressed(card):
	if(selected_cards.size() < 2 and !selected_cards.has(card)):
		selected_cards.append(card) # Add the card to the array
		if(card.textToSpeech != null):
			card.textToSpeech.speakText(card.imageWord) # Tell the word on the card
		card.set_texture(Global.load_icon(card.imagePath)) # Reveal the image of the card
	else:
		#only one card is selected or the card selected was aleady selected
		return

	if(selected_cards.size() == 2):
		var correct = selected_cards[0].imagePath == selected_cards[1].imagePath
		#show the two card for 1 second
		var t = Timer.new()
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start() # Wait for 1 second
		yield(t, "timeout")
		if(correct): # If the two cards have the same image
			nbFound += 1
#			Global.player.setSilver(Global.player.getSilver() + 1)
			selected_cards[0].get_node("backCardImage").visible = false # Hide the two cards
			selected_cards[1].get_node("backCardImage").visible = false
			if(nbFound == nbWord): # The game is finished
				game_end()
		else: # If the two cards aren't the same image
			nbWrongTry +=1
			for c in selected_cards:
				c.set_texture(load(c.cardBackPath)) # Rehide the cards
		selected_cards.clear()


#Calculat the number of col and row depending of the nuber of cards
func findColumnsRows(size : int) :
	var boolean = true
	var restmp
	for i in range (2, 7):
		for j in range (2, 5):
			if(size % i == 0 && size / i == j):
				return Vector2(i, j)
			if(i * j > size && boolean):
				boolean = false
				restmp = Vector2(i, j)
	return restmp

func initTimer():
	timer.start()

func calculate_score():
	var score : int
	if(nbWrongTry <= nbWord/2):
		score = 5
	elif(nbWrongTry <= nbWord):
		score = 4
	elif (nbWrongTry <= nbWord+nbWord/2):
		score = 3
	elif (nbWrongTry <= nbWord+nbWord):
		score = 2
	else: 
		score = 1
	return score
	
func game_end():
	var score = calculate_score()
	#args to send to game_end
	var args : Array = []
	args.append("res://artiphonie/memory/memory_game.tscn")
	args.append([])
	args.append("Memory")
	args.append("")
	args.append(score)
	args.append(time)
	Global.change_scene("res://shared/game_end/game_end.tscn", args)


func _on_Timer_timeout():
	time += 1
	updateTimer()

func updateTimer():
	find_node("TimerMinute").text = String(time/60)+" Minutes"
	find_node("TimerSeconde").text = String(time%60)+" Secondes"
