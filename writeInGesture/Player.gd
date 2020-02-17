extends Node

var id : String
var age : int
var integibility : float
var spokenLanguage : String
var pathPicture : String
var nameFile : String
#name is already in Node class


func getName():
	return name

func setName(na : String) :
	name = na
	return ManageJson.putElement(nameFile, "User/name", name)
##Function getter and setter. It must to use beacause field of this class is private
func getId():
	return id

func setId(identifier : String):
	id = identifier
	return ManageJson.putElement(nameFile, "User/id", identifier)

func getAge():
	return age

func setAge(a : int):
	age = a
	return ManageJson.putElement(nameFile, "User/age", age)

func getIntegibility():
	return integibility

func setIntegibility(inte : float) :
	integibility = inte
	return ManageJson.putElement(nameFile, "User/integibility", integibility)
	
func getPathPicture() :
	return pathPicture

func setPathPicture(pathp : String) :
	pathPicture = pathp
	return ManageJson.putElement(nameFile, "User/pathPicture", pathPicture)

func getspokenLanguage() :
	return spokenLanguage

func setspokenLanguage(splan : String) :
	spokenLanguage = splan
	return ManageJson.putElement(nameFile, "User/spokenLanguage", spokenLanguage)
	
func getPathFile() :
	return nameFile
func setPathFile(pathF : String) :
	nameFile = pathF
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
		"nameFile" : 
			nameFile = input
	return

func toString() -> String : 
	var res = "id : "+String(id)+"\n"
	res +="name : "+name+"\n"
	res += "age : "+String(age)+"\n"	
	res += "integibility : "+String(integibility)+"\n"	
	res += "spokenLanguage : "+spokenLanguage +"\n"	
	res += "pathPicture : "+ pathPicture +"\n"	
	res += "nameFile : "+nameFile+"\n"	
	return res
