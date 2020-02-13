extends Node
const Word = preload("res://Word.gd")
const TypeExercise = preload("res://TypeExercise.gd")

var version : float
var userId : int
var type : TypeExercise
var difficulty : int
var successPercentage : float
var nbOccurrences : int
var nbWords : int = 0
var words : Array = []
var nameFile : String 
var nbSuccess : int


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setAttribut(field : String, input):
	match field : 
		"version" :
			version = float(input)
		"userId" :
			userId = input
		"type" :
			type = TypeExercise.new()
			for x in input:
				type.setAttribut(x, input[x])
		"difficulty" :
			difficulty = int(input)
		"successPercentage" :
			successPercentage = float(input)
		"nbOccurrences" :
			nbOccurrences = int(input)
		"nbWords" :
			nbWords = int(input)
		"words" : 
			for word in input:
				var inputWord = Word.new()
				var w = input[word]
				for field in w :
					#print ("field :", field, " champ :", w[field])
					inputWord.setAttribut(field, w[field])
				words.append(inputWord)
		"nbSuccess":
			nbSuccess = int(nbSuccess)
		"nameFile" : 
			nameFile = input
	return

func toString() -> String : 
	var res = "version : "+String(version)+"\n"
	res += "userId : "+String(userId)+"\n"	
	res += "type : "+type.toString()+"\n"	
	res += "difficulty : "+String(difficulty)+"\n"	
	res += "successPercentage : "+String(successPercentage)+"\n"	
	res += "nbOccurrences : "+String(nbOccurrences)+"\n"	
	res += "nbWords : "+String(nbWords)+"\n"	
	res += "words : ["
	for word in words :
		res += "{" + word.toString() + "}\n"
	res+="] \n"
	res += "nameFile : "+nameFile+"\n"	
	return res
