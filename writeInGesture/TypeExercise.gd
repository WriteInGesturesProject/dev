extends Node

#String name is already
var category : String
var syllableStruct : String
var vowelsType : String 
var ConsonantsType : String



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
		"ConsonantsType" : 
			ConsonantsType = input
	return 
	
func toString() -> String : 
	var res = "name : "+name+"\n"
	res +="category : "+category+"\n"
	res += "syllableStruct : "+syllableStruct+"\n"	
	res += "vowelsType : "+vowelsType+"\n"	
	res += "ConsonantsType : "+ConsonantsType +"\n"	
	return res
