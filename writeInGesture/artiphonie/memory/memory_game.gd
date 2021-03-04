extends Node

#const Exercise = preload("res://entity/Exercise.gd")
const memoryCard := preload("./memory_card.tscn")

var listOfWords : Array
var cards : Array
var selected_cards : Array = []
var max_cards : int = 12
var nbCard : int
var score : int = 0
var separationPercentage = 0.02


##Timer
onready var timer = $Timer
var time = 0

func _ready():
	listOfWords = Global.player.listOfWords[0].words.duplicate(true)
	initTimer()
# deal with the instruction
#	var instruction : Node = Global.manageInstruction.instruction("memory")
#	if(instruction.get_signal_list()[0]["name"] == "on_Pass_Pressed") :
#		instruction.connect("on_Pass_Pressed", self, "initTimer")
#		add_child(instruction)
#	else :
#		initTimer()

	#setUp the number of card 
	nbCard = min(listOfWords.size() * 2, 2 * max_cards)
	var gridCard = find_node("GridCards")
	var vectorSizeColumsRows = findColumnsRows(nbCard)
	var nbRow  = vectorSizeColumsRows.y
	var nbCol =  vectorSizeColumsRows.x
	#calcul the separation between 2 cards
	var separationX = gridCard.rect_size.x * nbCol * separationPercentage
	var separationY = gridCard.rect_size.y * nbRow * separationPercentage
	#calcul the card size depending on the page size
	var card_size = Vector2((gridCard.rect_size.x - separationX)/ nbCol, (gridCard.rect_size.y - separationY) / nbRow)
	
	gridCard.columns = nbCol

	gridCard.set("custom_constants/vseparation", card_size.y + (separationY / nbRow))
	gridCard.set("custom_constants/hseparation", card_size.x + (separationX / nbCol))
	
	#Creation of the memory 
	randomize()
	listOfWords.shuffle() # Put the word in a random order
	listOfWords.resize(nbCard / 2) # Select a number of card
	for i in range(0, 2): #create 2 cards for each word
		for w in listOfWords: # For each words
			var card = memoryCard.instance()
			card.init_card(w, card_size)
			card.connect("card_pressed",self,"on_card_pressed")
			cards.append(card)
	cards.shuffle() # We put the cards in a random order
	for c in cards: # We add the cards to the grid
		gridCard.add_child(c) 
		
	
func on_card_pressed(card):
	if(selected_cards.size() < 2 and !selected_cards.has(card)):
		selected_cards.append(card) # Add the card to the array
		if(card.textToSpeech != null):
			card.textToSpeech.speakText(card.imageWord) # Tell the word on the card
		card.set_texture(Global.find_texture(card.imagePath)) # Reveal the image of the card
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
			score += 1
#			Global.player.setSilver(Global.player.getSilver() + 1)
			selected_cards[0].get_node("backCardImage").visible = false # Hide the two cards
			selected_cards[1].get_node("backCardImage").visible = false
			if(score == nbCard): # The game is finished
				end_game()
				print("finis")
		else: # If the two cards aren't the same image
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

func end_game():
#	Global.change_scene("res://page/navigation/gameEnd.tscn")
	pass


#func end():
#	var mini = Ex.getSuccessPercentage(0)
#	var moy = Ex.getSuccessPercentage(1)
#	var maxi = Ex.getSuccessPercentage(2)
#	var nb =  Ex.getNbSuccess() + 1
#
#	print(mini,moy,maxi)
#
#	##First time try
#	if(mini == 0):
#		Ex.setSuccessPercentage(0, time)
#		Ex.setSuccessPercentage(1, time)
#		Ex.setSuccessPercentage(2, time)
#	else :
#		if(time<mini) :
#			Ex.setSuccessPercentage(0, time)
#		if(time>maxi):
#			Ex.setSuccessPercentage(2, time)
#		moy = ((moy*(nb-1))+time)/nb
#		Ex.setSuccessPercentage(1,time)
#	Global.manageGame.time = time
#	Global.change_scene("res://page/navigation/gameEnd.tscn")

func _on_Timer_timeout():
	time += 1
	updateTimer()

func updateTimer():
	find_node("TimerMinute").text = String(time/60)+" Minutes"
	find_node("TimerSeconde").text = String(time%60)+" Secondes"
