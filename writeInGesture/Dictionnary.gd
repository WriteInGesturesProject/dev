extends Node


const Word = preload("res://Word.gd")

var version : float
var userId : int
var words : Array
var nameFile : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getVersion() -> float :
	return version

func getUserId() -> int :
	return userId

func setVersion(version : float) -> void :
	self.version = version

func setUserId(userId : int) -> void :
	self.userId = userId

#func getWords(phonetic : String) -> Word : 
#	return;
#
#func addWord(word : Word) -> int :
#	return;

func setAttribut(field : String, input):
	match field : 
		"version" : 
			version = input
		"userId" : 
			userId = input
		"words" : 
			for word in input:
				var inputWord = Word.new()
				var w = input[word]
				for field in w :
					#print ("field :", field, " champ :", w[field])
					inputWord.setAttribut(field, w[field])
				words.append(inputWord)
		"nameFile" : 
			nameFile = input
	return

func toString() -> String : 
	var res = "version : "+ String(version) +"\n"
	res += "userId : "+ String(userId) +"\n"	
	res += "words : \n"	
	for word in words :
		res += "{"+ word.toString() +"}\n"
	res += "] \n"	
	res += "nameFile : "+ nameFile +"\n"	
	return res
