extends Node


var words : Array
var nameFile : String;

const Word = preload("res://Word.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setAttribut(field : String, input):
	match field : 
		"words" : 
			for word in input:
				var inputWord = Word.new()
				var w = input[word]
				for field in w :
					inputWord.setAttribut(field, w[field])
				words.append(inputWord)
		"nameFile" : 
			nameFile = input
	return

func toString() -> String : 
	var res = "words : ["
	for word in words :
		res += "{" + word.toString() + "}\n"
	res+="] \n"
	res += "nameFile : "+nameFile+"\n"	
	return res

