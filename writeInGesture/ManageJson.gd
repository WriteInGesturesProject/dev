extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var userPath = "user://data/"
var resPath = "res://data/"
const Word = preload("res://Word.gd")
const Player = preload("res://Player.gd")
const WordsAvailable = preload("res://WordsAvailable.gd")
const Exercise = preload("res://Exercise.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	var node = Word.new()
	var player = Player.new()
	var wordsAvailable = WordsAvailable.new()
	var exercice = Exercise.new()
	if(getElement("exercise.json", "Exercise", exercice)):
		print(exercice.toString())

#pathFile : String 
#pathAttribute : String ex:"Exercice/Words"
#This function can change one element in a JSON File from the path file
func putElement(pathFile, pathAttribute, content):
	return 0


#pathFile : String 
#pathAttribute : String ex:"Exercice/Words"
#This function can put one element in a JSON File from the path file
func addElement(pathFile, pathAttribute, content):
	return 0
	
#pathFile : String 
#pathAttribute : String ex:"Exercice/Words"
#This function can get one element from a JSON File from the path file
func getElement(nameFile : String, pathAttribute : String, node : Node):
	var file = File.new()
	var err = file.open(userPath+nameFile, file.READ)
	if(err):
		err = file.open(resPath+nameFile, file.READ)
		if(err):
			print("File not found : ", nameFile)
			return 0;
		else :
			var writing = file.get_as_text()
			rewriteFile(nameFile,writing)
	
	var text = file.get_as_text()
	file.close()
	var tmp = JSON.parse(text)
	var dict = tmp.result
	var attributs = pathAttribute.split("/");
	for el in attributs :
		#print(dict)
		dict  = dict[el] 
		if(dict == null) :
			print("Wrong pathAttribute")
			return 0
	for field in dict :
		node.setAttribut(field, dict[field])
		#print (field," : ", dict[field])
	return 1
	
#node : Node
#version : float
#userId : int 
func createNewFile(node, version, userId):
	return 0


func rewriteFile(nameFile, content):
	print("[WRITINGFILE]")
	var dir = Directory.new()
	var fp_user = File.new()
	var f_name = userPath+ nameFile;
	var err = fp_user.open( f_name, File.WRITE )
	print( f_name + " opened." )
	print( "fp_user error code: " + str(err) )
	fp_user.store_string(content)
	print( f_name + " written." )
	fp_user.close()
	print("[END_WRITINGFILE]")
