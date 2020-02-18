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
var nbSuccess : int
var nameFile : String 

func getVersion() : 
	return version

func setVersion(ver : float):
	version = ver
	return ManageJson.putElement(nameFile, "Exercise/version", version)

func getUserId() : 
	return userId

func setUserId(user : float):
	userId = user
	return ManageJson.putElement(nameFile, "Exercise/userId", userId)

func getType() : 
	return type

func setType(t : TypeExercise):
	type = t
	return ManageJson.putElement(nameFile, "Exercise/type", type)

func getDifficulty() : 
	return difficulty

func setDifficulty(dif : int):
	difficulty = dif
	return ManageJson.putElement(nameFile, "Exercise/difficulty", difficulty)
	
func getSucessPercentage() : 
	return successPercentage

func setSucessPercentage(sp : float):
	successPercentage = sp
	return ManageJson.putElement(nameFile, "Exercise/successPercentage", successPercentage)

func getNbOccurrences(): 
	return nbOccurrences

func setNbOccurrences(no : int):
	nbOccurrences = no
	return ManageJson.putElement(nameFile, "Exercise/nbOccurrences", nbOccurrences)

func getAllWords() -> Array :
	return words

func getNbWords(): 
	return nbWords

func setNbWords(nb : int):
	nbWords = nb
	return ManageJson.putElement(nameFile, "Exercise/nbWords", nbOccurrences)

func getWord(phonetic) -> Word :
	for currentWord in words :
		if(currentWord.getPhonetic() == phonetic):
			return currentWord
	print("Mot avec la phonetic :"+phonetic+" non trouvé")
	return null

func addWord(word) -> int :
	var result = words.append(word)
	if(result == null):
		return 0
	setNbWords(words.size())
	return ManageJson.addElement(nameFile ,"Exercise/nbWords", word)
	
#var nameFile : String 

func getNbSuccess(): 
	return nbSuccess

func setNbSuccess(nb : int):
	nbSuccess = nb
	return ManageJson.putElement(nameFile, "Exercise/nbSuccesss", nbSuccess)
	
func getNameFile(): 
	return nameFile

func setNameFile(nF : String):
	nameFile = nF
	return 1

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