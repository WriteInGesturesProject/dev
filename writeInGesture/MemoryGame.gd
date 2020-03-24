extends Node


const Exercise = preload("res://Exercise.gd")
const Card = preload("res://MemoryCard.gd")

var os = Global.os
var Ex : Exercise = Global.memoryExercise
var words = Ex.getAllWords().duplicate(true)
var cards : Array
var selected_cards : Array = []
var max_cards = Global.max_cards
var nbCard = 0
var columns = 0
var separationPercentage = 0.02
var margin = 0.05


func _ready():
	#Center the title
	find_node("Label").rect_position.y = find_node("Back").rect_size.y/2
	#Make margin on the scene
	var viewport = get_viewport().size
	Global.make_margin(find_node("MarginContainer"),margin)
	var sizeMargin = viewport * (1-2*margin)
	find_node("Back").rect_size = Vector2(get_viewport().size.y*0.15, get_viewport().size.y*0.15)
	find_node("Main").add_constant_override("margin_left", get_viewport().size.y * 0.015)
	find_node("Main").add_constant_override("margin_top", get_viewport().size.y * 0.015)
	find_node("Main").add_constant_override("margin_right", get_viewport().size.y * 0.015)
	find_node("Main").add_constant_override("margin_bottom", get_viewport().size.y * 0.015)
	#Put margin top for the top button
	find_node("MarginContainer").set("custom_constants/margin_top", find_node("Back").rect_size.y+find_node("MarginContainer").get_constant("margin_top"))
	sizeMargin.y -= find_node("Back").rect_size.y
	
		
	#setUp the memory
	nbCard = min(words.size()*2,2*max_cards)
	var vectorSizeColumsRows = findColumnsRows(nbCard)
	var row = vectorSizeColumsRows.y
	columns =  vectorSizeColumsRows.x
	var separationX = sizeMargin.x * columns * separationPercentage
	var separationY = sizeMargin.y * row * separationPercentage
	var card_size = Vector2((sizeMargin.x-separationX)/columns, (sizeMargin.y- separationY)/row)
	var gridCard = find_node("GridCards")
	gridCard.columns = columns
	gridCard.set("custom_constants/vseparation", separationY/row)
	gridCard.set("custom_constants/hseparation", separationX/columns)
	gridCard.set("rect_position.x",100)
	gridCard.set("rect_position.y",separationY/2)
	
	
	#Craation of the memory 
	randomize()
	words.shuffle()
	words.resize(nbCard/2)
	for i in range(0, 2):
		for w in words:
			var card : Card = Card.new()
			var ctrl : Control = Control.new()
			card.rect_position.x =separationX/(2*columns)
			card.rect_position.y =separationY/(2*row)
			card.init(w, card_size, selected_cards)
			ctrl.rect_min_size = card_size
			ctrl.add_child(card)
			cards.append(ctrl)
	cards.shuffle()
	for c in cards:
		
		gridCard.add_child(c)
	
	
	
	
func findColumnsRows(size : int) :
	print("Size : ", size)
	var boolean = true
	var restmp
	for i in range (2,7):
		for j in range (2,5):
			if(size % i == 0 && size/i == j) :
				print("Answer :(colonne :", i," ligne :",j,")")
				return Vector2(i,j)
			if(i*j>size && boolean):
				boolean = false
				restmp = Vector2(i,j)
	print(restmp)
	return restmp
				 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://GameChoose.tscn")
