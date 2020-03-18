extends Node

const Word = preload("res://Word.gd")
const TypeExercise = preload("res://TypeExercise.gd")

var version : float
var userId : String
var type : TypeExercise
var difficulty : int
var successPercentage : Array = []
var nbWords : int = 0
var words : Array = []
var nbSuccess : int
var nameFile : String
var nbWordsOccurrences : Array = []
var wordsSuccess : Array

func getVersion() : 
	return version

func setVersion(ver : float):
	version = ver
	return ManageJson.putElement(nameFile, "Exercise/version", version)

func getUserId() : 
	return userId

func setUserId(user : String):
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
	
func getSuccessPercentage(index : int):
	return successPercentage[index]

func setSuccessPercentage(index : int, value : float):
	successPercentage[index] = value
	return ManageJson.putElement(nameFile, "Exercise/successPercentage", successPercentage)

func putSuccessPercentage(sp : Array):
	successPercentage = sp
	return ManageJson.putElement(nameFile, "Exercise/successPercentage", successPercentage)

func getNbWordOccurrence(difficulty : int, index : int): 
	return nbWordsOccurrences[difficulty][index]

func setNbWordOccurrence(difficulty : int, index : int, value : int):
	nbWordsOccurrences[difficulty][index] = value
	return ManageJson.putElement(nameFile, "Exercise/nbWordsOccurrences", nbWordsOccurrences)

func putNbWordOccurrence(word : Array):
	nbWordsOccurrences = word
	return ManageJson.putElement(nameFile, "Exercise/nbWordsOccurrences", nbWordsOccurrences)

func getAllWords() -> Array :
	return words

func getNbWords(): 
	return nbWords

func setNbWords(nb : int):
	nbWords = nb
	return ManageJson.putElement(nameFile, "Exercise/nbWords", nbWords)

func getWord(phonetic) -> Word :
	for currentWord in words :
		if(currentWord.getPhonetic() == phonetic):
			return currentWord
	#print("Mot avec la phonetic :"+phonetic+" non trouvé")
	return null

func addWord(word) -> int :
	var result = words.append(word)
	setNbWords(words.size())
	return ManageJson.addElement(nameFile ,"Exercise/words", word.toDictionnary())

func getNbSuccess():
	return nbSuccess

func setNbSuccess(nb : int):
	nbSuccess = nb
	return ManageJson.putElement(nameFile, "Exercise/nbSuccess", nbSuccess)

func getName(): 
	return name

func setName(n : String):
	name = n
	return ManageJson.putElement(nameFile, "Exercise/name", name)
	
func getNameFile(): 
	return nameFile

func setNameFile(nF : String):
	nameFile = nF
	return 1

func getWordSuccess(difficulty : int, index : int): 
	return wordsSuccess[difficulty][index]

func setWordSuccess(difficulty : int, index : int, value : int):
	wordsSuccess[difficulty][index] = value
	return ManageJson.putElement(nameFile, "Exercise/wordsSuccess", wordsSuccess)

func putWordSuccess(word : Array):
	wordsSuccess = word
	return ManageJson.putElement(nameFile, "Exercise/wordsSuccess", wordsSuccess)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func updateType(t : TypeExercise):
	ManageJson.putElement(nameFile, "Exercise/type/name", type.name)
	ManageJson.putElement(nameFile, "Exercise/type/categorie", type.category)
	ManageJson.putElement(nameFile, "Exercise/type/syllableStruct", type.syllableStruct)
	ManageJson.putElement(nameFile, "Exercise/type/vowelsType", type.vowelsType)
	ManageJson.putElement(nameFile, "Exercise/type/consonantsType", type.consonantsType)

func setAttribut(field : String, input):
	match field : 
		"name" :
			name = input
		"version" :
			version = input
		"userId" :
			userId = input
		"type" :
			type = TypeExercise.new()
			type.setAttribut("parent", self)
			for x in input:
				type.setAttribut(x, input[x])
		"difficulty" :
			difficulty = int(input)
		"successPercentage" :
			successPercentage = input
		"nbWordsOccurrences" :
			for i in input:
				nbWordsOccurrences.append((i))
		"nbWords" :
			nbWords = int(input)
		"wordsSuccess" :
			for i in (input):
				wordsSuccess.append((i))
		"words" : 
			for word in input:
				var inputWord = Word.new()
				var w = input[word]
				for field in w :
					##print ("field :", field, " champ :", w[field])
					inputWord.setAttribut(field, w[field])
				words.append(inputWord)
		"nbSuccess":
			nbSuccess = input
		"nameFile" : 
			nameFile = input
			
	return

func toString() -> String : 
	var res = "version : "+String(version)+"\n"
	res += "userId : "+String(userId)+"\n"	
	res += "type : "+type.toString()+"\n"	
	res += "difficulty : "+String(difficulty)+"\n"	
	res += "successPercentage : "+String(successPercentage)+"\n"	
#	res += "nbWordsOccurrences : "+String(nbOccurrences)+"\n"	
	res += "nbWords : "+String(nbWords)+"\n"	
	res += "words : ["
	for word in words :
		res += "{" + word.toString() + "}\n"
	res+="] \n"
	res += "nameFile : "+nameFile+"\n"	
	return res
