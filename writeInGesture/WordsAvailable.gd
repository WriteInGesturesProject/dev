extends Node


var words : Array
var nameFile : String;

const Word = preload("res://Word.gd")

func getAllWords() -> Array :
	return words

func getWord(phonetic : String) -> Word :
	for currentWord in words :
		if(currentWord.getPhonetic() == phonetic):
			return currentWord
	#print("Mot avec la phonetic :"+phonetic+" non trouvé")
	return null

func addWord(word) -> int :
	words.append(word)
	return ManageJson.addElement(nameFile, "WordsAvailable/words", word.toDictionnary())

func removeWord(word) -> int :
	var error = words.erase(word)
	return ManageJson.removeElement(nameFile, "WordsAvailable/words", word.getPhonetic())

func getNameFile() -> String : 
	return nameFile

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

