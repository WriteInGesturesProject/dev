extends Node
const Exercise = preload("res://entity/old/Exercise.gd")

var current_ex : Exercise # The exercise we are playing

var try = [] # Check if the player tapped on record at least once on each word
var game : int = 0  # The type of training (1 -> MyGames, 2 -> Count, 3 -> Week, 4 -> Colors)
var play = 0 # The type of game (1 -> Goose, 2 -> Listen & Choose, 3 -> Memory)
var score : int # The score when in game
var level : int = 0 # The difficulty (0 -> Easy, 1 -> Medium, 2 -> Hard)
var maxCardsMemory = 12
var nbSilverWin : int = 0
var time = 0

func _ready():
	pass

# if goos game add coin silver 
func triedEveryWords():
	var tried = true
	for i in try: # Check if the user tried every words
		if(!i):
			tried = false
			break
	return tried
