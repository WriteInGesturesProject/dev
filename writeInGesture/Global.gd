extends Node
class_name global

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var level = 1
var progress1 = [85,85,85,20]
var progress2 = [0,0,85,0]
var progress3 = [0,0,0,0]

var game = 1

var Number = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
var words_count = ["un", "deux", "trois", "quatre", "cinq", "six", "sept", "huit", "neuf", "dix"]
var img_count = ["res://art/imgBorel/[a].png", "res://art/imgBorel/[eu].png", "res://art/imgBorel/[a].png", "res://art/imgBorel/[i].png", "res://art/imgBorel/[o].png", "res://art/imgBorel/[u].png", "res://art/imgBorel/[é].png", "res://art/imgBorel/[è].png", "res://art/imgBorel/[e].png", "res://art/imgBorel/[ou].png"]
var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
