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
var separation = Vector2(10, 10)


func _ready():
	var viewport = get_viewport().size
	var row = 2 * max_cards / columns # The number of row
	var card_size = Vector2((viewport.x - (columns + 1) * separation.x) / columns, (viewport.y - $Back.rect_size.y - row * separation.y) / (row))
	$MarginContainer/GridCards.columns = columns
	$MarginContainer/GridCards.set("custom_constants/vseparation", separation.x)
	$MarginContainer/GridCards.set("custom_constants/hseparation", separation.y)
	$MarginContainer.set("custom_constants/margin_top", $Back.rect_size.y)
	$MarginContainer.set("custom_constants/margin_left", separation.x)
	randomize()
	words.shuffle()
	words.resize(max_cards)
	for i in range(0, 2):
		for w in words:
			var card : Card = Card.new()
			var ctrl : Control = Control.new()
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
