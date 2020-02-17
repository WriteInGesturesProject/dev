extends Node

#String name is already
var category : String
var syllableStruct : String
var vowelsType : String 
var consonantsType : String

func getName() -> String:
	return name

func setName(name):
	self.name = name

func getCategory():
	return category

func setCategory(category):
	self.category = category

func getSyllableStruct():
	return syllableStruct

func setSyllableStruct(syllableStruct):
	self.syllableStruct = syllableStruct

func getVowelsType():
	return vowelsType

func setVowelsType(vowelsType):
	self.vowelsType = vowelsType

func getConsonantsType():
	return consonantsType

func setConsonantsType(consonantsType):
	self.consonantsType = consonantsType

func setAttribut(field : String, input):
	match field : 
		"name" :
			name = input
		"category" : 
			category = input
		"syllableStruct" : 
			syllableStruct = input
		"vowelsType" : 
			vowelsType = input
		"consonantsType" : 
			consonantsType = input
	return 
	
func toString() -> String : 
	var res = "name : "+name+"\n"
	res +="category : "+category+"\n"
	res += "syllableStruct : "+syllableStruct+"\n"	
	res += "vowelsType : "+vowelsType+"\n"	
	res += "consonantsType : "+consonantsType +"\n"	
	return res
