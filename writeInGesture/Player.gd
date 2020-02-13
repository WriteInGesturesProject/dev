extends Node

var id : String
var age : int
var integibility : float
var spokenLanguage : String
var pathPicture : String
var pathFile : String
#name is already in Node class



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func setAttribut(field : String, input):
	match field : 
		"name" :
			name = input
		"id" : 
			id = input
		"age" : 
			age = input
		"integibility" : 
			integibility = input
		"spokenLanguage" : 
			spokenLanguage = input
		"pathPicture" : 
			pathPicture = input
		"pathFile" : 
			pathFile = input
	return

func toString() -> String : 
	var res = "id : "+String(id)+"\n"
	res +="name : "+name+"\n"
	res += "age : "+String(age)+"\n"	
	res += "integibility : "+String(integibility)+"\n"	
	res += "spokenLanguage : "+spokenLanguage +"\n"	
	res += "pathPicture : "+ pathPicture +"\n"	
	res += "pathFile : "+pathFile+"\n"	
	return res
