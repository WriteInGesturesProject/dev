extends Node


const Word = preload("res://entity/Word.gd")

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
	ManageJson.putElement(nameFile, "Dictionnary/version", version)

func setUserId(userId : int) -> void :
	self.userId = userId
	ManageJson.putElement(nameFile, "Dictionnary/userId", version)

func getAllWord() : 
	return words

func getWord(phonetic) -> Word :
	for currentWord in words :
		if(currentWord.getPhonetic() == phonetic):
			return currentWord
	#print("Mot avec la phonetic :"+phonetic+" non trouvé")
	return null

func addWord(word) -> int :
	var result = words.append(word)
	var w = words.find(word)
	word.setAttribut("parent", self)
	return ManageJson.addElement(nameFile, "Dictionnary/words", word.toDictionnary())
	
func updateWord(word : Word) :
	var err = ManageJson.removeElement(nameFile, "Dictionary/words", word.getPhonetic())
	if(!err):
		return ManageJson.addElement(nameFile, "Dictionnary/words", word.toDictionnary())
	else :
		return 0

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
					##print ("field :", field, " champ :", w[field])
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
