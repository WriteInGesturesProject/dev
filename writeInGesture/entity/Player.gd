extends Node

var id : String
var age : int
var integibility : float
var spokenLanguage : String
var picturePath : String
var nameFile : String
var gold : int
var silver : int
var coinAvatar : Array
var consigne : int 
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
	return picturePath

func setPathPicture(pathp : String) :
	picturePath = pathp
	return ManageJson.putElement(nameFile, "User/picturePath",picturePath)

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

func getGold():
	return gold

func setGold(a : int):
	gold = a
	return ManageJson.putElement(nameFile, "User/gold", gold)

func getSilver():
	return silver

func setSilver(a : int):
	silver = a
	return ManageJson.putElement(nameFile, "User/silver", silver)

func getCoinAvatar():
	return coinAvatar

func setCoinAvatar(ind, n):
	coinAvatar[ind] = n
	return ManageJson.putElement(nameFile, "User/coinAvatar", coinAvatar)
	
func getInstruction():
	return consigne

func setInstruction(cons):
	if(cons):
		consigne = 1
	else :
		consigne = 0
	return ManageJson.putElement(nameFile, "User/instruction", consigne)
	

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
		"picturePath" : 
			picturePath = input
		"nameFile" : 
			nameFile = input
		"gold" : 
			gold = input
		"silver" : 
			silver = input
		"coinAvatar":
			coinAvatar = input
		"instruction":
			consigne = input
	return

func toString() -> String : 
	var res = "id : "+String(id)+"\n"
	res +="name : "+name+"\n"
	res += "age : "+String(age)+"\n"	
	res += "integibility : "+String(integibility)+"\n"	
	res += "spokenLanguage : "+spokenLanguage +"\n"	
	res += "picturePath : "+ picturePath +"\n"	
	res += "nameFile : "+nameFile+"\n"	
	return res
