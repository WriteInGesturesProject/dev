extends Node

#String name is already
var category : String = ""
var syllableStruct : String = ""
var vowelsType : String = ""
var consonantsType : String =""
var parent : Node = null

func updateParent() :
	if(parent != null) :
		parent.updateType(self)

func getName() -> String:
	return name

func setName(name):
	self.name = name
	updateParent()

func getCategory():
	return category

func setCategory(category):
	self.category = category
	updateParent()

func getSyllableStruct():
	return syllableStruct

func setSyllableStruct(syllableStruct):
	self.syllableStruct = syllableStruct
	updateParent()

func getVowelsType():
	return vowelsType

func setVowelsType(vowelsType):
	self.vowelsType = vowelsType
	updateParent()

func getConsonantsType():
	return consonantsType

func setConsonantsType(consonantsType):
	self.consonantsType = consonantsType
	updateParent()

func setAttribut(field : String, input):
	match field : 
		"name" :
			name = input
		"categorie" : 
			category = input
		"syllableStruct" : 
			syllableStruct = input
		"vowelsType" : 
			vowelsType = input
		"consonantsType" : 
			consonantsType = input
		"parent" :
			parent = input
	return 
	
func to_string() -> String : 
	var res = "name : "+name+"\n"
	res +="category : "+category+"\n"
	res += "syllableStruct : "+syllableStruct+"\n"	
	res += "vowelsType : "+vowelsType+"\n"	
	res += "consonantsType : "+consonantsType +"\n"	
	return res
