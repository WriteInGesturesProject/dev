extends Node

var id : String
var age : int
var integibility : float
var spokenLanguage : String
var pathPicture : String
var pathFile : String
#name is already in Node class

##Function getter and setter. It must to use beacause field of this class is private
func getId():
	return id

func setId(identifier : String):
	id = identifier
	return ManageJson.putElement(pathFile, "User/id", identifier)

func getAge():
	return age

func setAge(a : int):
	age = a
	return ManageJson.putElement(pathFile, "User/age", age)

func getIntegibility():
	return integibility

func setIntegibility(inte : float) :
	integibility = inte
	return ManageJson.putElement(pathFile, "User/integibility", integibility)
	
func getPathPicture() :
	return pathPicture

func setPathPicture(pathp : String) :
	pathPicture = pathp
	return ManageJson.putElement(pathFile, "User/pathPicture", pathPicture)

func getspokenLanguage() :
	return spokenLanguage

func setspokenLanguage(splan : String) :
	spokenLanguage = splan
	return ManageJson.putElement(pathFile, "User/spokenLanguage", spokenLanguage)
	
func getPathFile() :
	return pathFile
func setPathFile(pathF : String) :
	pathFile = pathF
	return 1
	

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
