extends Node


var phonetic
var word
var path
var homonym : Array
var nbSyllable : int 
var syllableStruct
var vowelsType
var consonantsType


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
	return

func toString() -> String : 
	var res = "phonetic : "+phonetic+"\n"
	res += "word : "+word+"\n"	
	res += "path : "+path+"\n"	
	res += "homonym : "+ String(homonym) +"\n"	
	res += "nbSyllable : "+String(nbSyllable) +"\n"	
	res += "syllableStruct : "+ syllableStruct +"\n"	
	res += "vowelsType : "+ vowelsType +"\n"	
	res += "consonantsType : "+ consonantsType +"\n"	
	return res
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
