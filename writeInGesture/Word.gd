extends Node


var phonetic : String
var word : String
var path : String
var homonym : Array
var nbSyllable : int 
var syllableStruct : String
var vowelsType :String
var consonantsType : String
var parent : Node # We need to know the parent's node for update word in file

func updateParent() : 
	return parent.updateWord(self)

func getPhonetic():
	return phonetic

func setPhonetic(phon : String):
	phonetic = phon
	return updateParent()
	
func getWord():
	return word

func setWord(w : String):
	word = w
	return updateParent()
	
func getPath():
	return path

func setPath(p : String):
	path = p
	return updateParent()
	
func getHomonym() -> Array :
	return homonym
	
func addHomonym(word : String) : 
	for el in homonym :
		if el == word :
			return 0
	homonym.append(word)
	return updateParent()

func setHomonym(w : Array):
	homonym = w
	return updateParent()

func getNbSyllable():
	return nbSyllable

func setNbSyllable(p : int):
	nbSyllable = p
	return updateParent()

func getSyllableStruct():
	return syllableStruct

func setSyllableStruct(p : String):
	syllableStruct = p
	return updateParent()

func getVowelsType() :
	return vowelsType

func setVowelsType( vt : String) : 
	vowelsType = vt
	return updateParent()

func getConsonantsType() :
	return consonantsType

func setConsonantsType( ct : String) : 
	consonantsType = ct
	return updateParent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setAttribut(field : String, input):
	match field : 
		"phonetic" : 
			phonetic = input
		"word" : 
			word = input
		"path" : 
			path = input
		"phonetic" : 
			phonetic = input
		"homonym" : 
			homonym = input
		"nbSyllable" : 
			nbSyllable = input
		"syllableStruct" : 
			syllableStruct = input
		"vowelsType" : 
			vowelsType = input
		"consonantsType" : 
			consonantsType = input
		"parent" : 
			parent = input
	return

func toString() -> String : 
	var res = "phonetic : "+phonetic+"\n"
	res += "word : "+word+"\n"	
	res += "path : "+path+"\n"	
	res += "homonym : "+ String(homonym) +"\n"	
	res += "nbSyllable : "+String(nbSyllable) +"\n"	
	res += "syllableStruct : "+ syllableStruct +"\n"	
	res += "vowelsType : "+vowelsType+"\n"	
	res += "consonantsType : "+consonantsType+"\n"	
	#res += "parent Node : "+parent.to_string()+"\n"
	return res

