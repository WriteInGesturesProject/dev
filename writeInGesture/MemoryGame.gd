extends Node


const Exercise = preload("res://Exercise.gd")
const Card = preload("res://Card.gd")

var os = Global.os
var Ex : Exercise = Global.memoryExercise
var words = Ex.getAllWords()
var cards : Array
var selected_cards : Array = []
var max_cards = Global.max_cards
var columns = 6
var separationPercentage = 0.02
var margin = 0.05


func _ready():
	#Center the title
	find_node("Label").rect_position.y = $Back.rect_size.y/2
	#Make margin on the scene
	var viewport = get_viewport().size
	Global.make_margin(find_node("MarginContainer"),margin)
	var sizeMargin = viewport * (1-2*margin)
	
	#Put margin top for the top button
	$MarginContainer.set("custom_constants/margin_top", $Back.rect_size.y+find_node("MarginContainer").get_constant("margin_top"))
	sizeMargin.y -= $Back.rect_size.y
	
	#Creation of the memory 
	var row = 2 * max_cards / columns
	var separationX = sizeMargin.x * columns * separationPercentage
	var separationY = sizeMargin.y * row * separationPercentage
	var card_size = Vector2((sizeMargin.x-separationX)/columns, (sizeMargin.y- separationY)/row)
	$MarginContainer/GridCards.columns = columns
	$MarginContainer/GridCards.set("custom_constants/vseparation", separationY/row)
	$MarginContainer/GridCards.set("custom_constants/hseparation", separationX/columns)
	$MarginContainer/GridCards.set("rect_position.x",100)
	$MarginContainer/GridCards.set("rect_position.y",separationY/2)
	
	randomize()
	words.shuffle()
	words.resize(max_cards)
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
		$MarginContainer/GridCards.add_child(c)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://GameChoose.tscn")
