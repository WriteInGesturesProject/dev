extends Node


const Exercise = preload("res://entity/Exercise.gd")
const Card = preload("./memoryCard.gd")

var os = Global.os
var Ex : Exercise = Global.memoryExercise
var words = Ex.getAllWords().duplicate(true)
var cards : Array
var selected_cards : Array = []
var max_cards = Global.manageGame.maxCardsMemory
var nbCard = 0
var columns = 0
var separationPercentage = 0.02
var margin = 0.05
var surMargin = 0.015

##Timer
onready var timer = $Timer
var time = 0


func _ready():
	
	
	var instruction : Node = Global.manageInstruction.instruction("memory")
	if(instruction.get_signal_list()[0]["name"] == "on_Pass_Pressed") :
		instruction.connect("on_Pass_Pressed", self, "initTimer")
		add_child(instruction)
	else :
		initTimer()
	
	#Center the title
#	find_node("Label").rect_position.y = find_node("Back").rect_size.y / 2
	#Make margin on the scene
	var viewport = get_viewport().size
	Global.make_margin(find_node("MarginContainer"), margin)
	var sizeMargin = viewport * (1 - 2 * (margin + surMargin))
	Global.make_margin(find_node("Main"), surMargin)
	#Put margin on top for the top button
	find_node("MarginContainer").set("custom_constants/margin_top", find_node("Back").rect_size.y + find_node("MarginContainer").get_constant("margin_top"))
	sizeMargin.y -= find_node("Back").rect_size.y	

	#setUp the memory
	nbCard = min(words.size() * 2, 2 * max_cards)
	var vectorSizeColumsRows = findColumnsRows(nbCard)
	var row = vectorSizeColumsRows.y
	columns =  vectorSizeColumsRows.x
	var separationX = sizeMargin.x * columns * separationPercentage
	var separationY = sizeMargin.y * row * separationPercentage
	var card_size = Vector2((sizeMargin.x - separationX) / columns, (sizeMargin.y - separationY) / row)
	var gridCard = find_node("GridCards")
	gridCard.columns = columns
	gridCard.set("custom_constants/vseparation", separationY / row)
	gridCard.set("custom_constants/hseparation", separationX / columns)
	gridCard.set("rect_position.x", 100)
	gridCard.set("rect_position.y", separationY / 2)
	
	
	#Creation of the memory 
	randomize()
	words.shuffle() # Put the word in a random order
	words.resize(nbCard / 2) # Select a number of card
	for i in range(0, 2):
		for w in words: # For each words
			var card : Card = Card.new()
			card.connect("end",self,"end")
			var ctrl : Control = Control.new()
			card.rect_position.x = separationX / (2 * columns)
			card.rect_position.y = separationY / (2 * row)
			card.init(w, card_size, selected_cards) # We create a card
			ctrl.rect_min_size = card_size
			ctrl.add_child(card)
			cards.append(ctrl)
	cards.shuffle() # We put the cards in a random order
	for c in cards: # We add the cards to the grid
		gridCard.add_child(c)
		
	


#This is the function that place the card properly in function of the number of cards
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


func _on_Back_pressed():
	Global.change_scene("res://page/navigation/gameChoose.tscn")

func end():
	var mini = Ex.getSuccessPercentage(0)
	var moy = Ex.getSuccessPercentage(1)
	var maxi = Ex.getSuccessPercentage(2)
	var nb =  Ex.getNbSuccess() + 1
	
	print(mini,moy,maxi)
	
	##First time try
	if(mini == 0):
		Ex.setSuccessPercentage(0, time)
		Ex.setSuccessPercentage(1, time)
		Ex.setSuccessPercentage(2, time)
	else :
		if(time<mini) :
			Ex.setSuccessPercentage(0, time)
		if(time>maxi):
			Ex.setSuccessPercentage(2, time)
		moy = ((moy*(nb-1))+time)/nb
		Ex.setSuccessPercentage(1,time)
	Global.manageGame.time = time
	Global.change_scene("res://page/navigation/gameEnd.tscn")

func _on_Timer_timeout():
	time += 1
	updateTimer()

func updateTimer():
	find_node("TimerMinute").text = String(time/60)+" Minutes"
	find_node("TimerSeconde").text = String(time%60)+" Secondes"
