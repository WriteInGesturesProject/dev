extends Node


const Exercise = preload("res://Exercise.gd")
const Card = preload("res://Card.gd")

var tts = Global.tts
var os = Global.os
var Ex : Exercise = Global.memoryExercise
var words = Ex.getAllWords()
var cards : Array
var selected_cards = []
var max_cards = Global.max_cards


# Called when the node enters the scene tree for the first time.
func _ready():
	var size = get_viewport().size
	$MarginContainer.set("custom_constants/margin_right", size.x * 0.1)
	$MarginContainer.set("custom_constants/margin_left", size.x * 0.03)
	$MarginContainer.set("custom_constants/margin_top", size.x * 0.1)
	$MarginContainer.set("custom_constants/margin_bottom", size.x * 0.1)
	randomize()
	words.shuffle()
	words.resize(max_cards)
	for i in range(0,2):
		for w in words:
			var card : Card = Card.new()
			var ctrl : Control = Control.new()
			card.init(w, size, $MarginContainer/GridCards.columns, selected_cards, tts)
			$MarginContainer/GridCards.add_constant_override("hseparation", card.rect_size.x + 10)
			$MarginContainer/GridCards.add_constant_override("vseparation", card.rect_size.y + 10)
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
