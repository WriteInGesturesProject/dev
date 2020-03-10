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


func _ready():
	var viewport = get_viewport().size
	var separation = Vector2($MarginContainer/GridCards.get_constant("hseparation"), $MarginContainer/GridCards.get_constant("vseparation"))
	var card_size = Vector2(viewport.x / columns, (viewport.y - $Back.rect_size.y) / (2 * max_cards / columns)) - separation
#	var separation_size = card_size + separation
	$MarginContainer/GridCards.columns = columns
	$MarginContainer.set("custom_constants/margin_top", $Back.rect_size.y)
	$MarginContainer.set("custom_constants/margin_left", separation.x / 2)
	randomize()
	words.shuffle()
	words.resize(max_cards)
	for i in range(0, 2):
		for w in words:
			var card : Card = Card.new()
			var ctrl : Control = Control.new()
			card.init(w, card_size, $MarginContainer/GridCards.columns, selected_cards)
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
