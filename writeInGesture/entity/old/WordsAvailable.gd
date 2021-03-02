extends Node

var words : Array
var nameFile : String;

const Word = preload("res://entity/Word.gd")

func getAllWords() -> Array :
	return words

func get_word(phonetic : String) -> Word :
	for currentWord in words :
		if(currentWord.get_phonetic() == phonetic):
			return currentWord
	#print("Mot avec la phonetic :"+phonetic+" non trouvé")
	return null

func addWord(word) -> int :
	words.append(word)
	return ManageJson.addElement(nameFile, "WordsAvailable/words", word.to_dictionary())

func removeWord(word) -> int :
	var error = words.erase(word)
	return ManageJson.removeElement(nameFile, "WordsAvailable/words", word.get_phonetic())

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

func to_string() -> String : 
	var res = "words : ["
	for word in words :
		res += "{" + word.to_string() + "}\n"
	res+="] \n"
	res += "nameFile : "+nameFile+"\n"	
	return res

