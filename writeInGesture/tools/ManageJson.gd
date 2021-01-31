extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var userPath = "user://data/"
var resPath = "res://data/"

const Dictionnary = preload("res://entity/Dictionnary.gd")
const Word = preload("res://entity/Word.gd")
const Player = preload("res://entity/Player.gd")
const WordsAvailable = preload("res://entity/WordsAvailable.gd")
const Exercise = preload("res://entity/Exercise.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
#	var text = checkFileExistUserPath("test.json")
#	if text == "": 
#		return 0
#	var tmp = JSON.parse(text)
#	var test = tmp.result
#	#print(test)
#	var dictionnary = Dictionnary.new()
#	var player = Player.new()
#	var wordsAvailable = WordsAvailable.new()
#	var exercice = Exercise.new()
#	getElement("dictionnary.json", "Dictionnary", dictionnary)
#	getElement("player.json", "User", player)
#	getElement("wordsAvailable.json", "WordsAvailable", wordsAvailable)
#	getElement("exercice.json", "Exercice", exercice)
#	putElement("exercise.json", "Exercise/words/ni/phonetic", "test")
#	addElement("wordsAvailable.json", "WordsAvailable/words", test)
#	removeElement("wordsAvailable.json", "WordsAvailable/words", "test")
	pass


func removeFile(path):
	#print("[REMOVEFILE]")
	var dir = Directory.new()
	dir.remove("user://data/"+path)
	#print("[END_REMOVEFILE] : user://data/", path)


func checkFileExistUserPath(nameFile:String)->String:
	var file = File.new()
	var err = file.open(userPath+nameFile, file.READ)
	if(err):
		err = file.open(resPath+nameFile, file.READ)
		if(err):
			#print("File not found : ", nameFile)
			return "";
		else :
			var writing = file.get_as_text()
			rewriteFile(nameFile,writing)
	var text = file.get_as_text()
	file.close()
	return text

#nameFile : String 
#pathAttribute : String ex:"Exercice/Words"
#This function can change one element in a JSON File from the path file
func putElement(nameFile, pathAttribute, content):
	var text = checkFileExistUserPath(nameFile)
	if text == "": 
		return 0
	var tmp = JSON.parse(text)
	var dict = tmp.result
	var attributs = pathAttribute.split("/");
	var Dicttmp = dict
	for el in range(0, attributs.size()-1) :
		Dicttmp = Dicttmp[attributs[el]]
		if(Dicttmp == null) :
			#print("Wrong pathAttribute")
			return 0
	Dicttmp[attributs[-1]] = content 
	var jtstr = JSON.print(dict)
	rewriteFile(nameFile, jtstr)
	return 1

#pathFile : String 
#pathAttribute : String ex:"Exercice/Words"
#This function can put one element in a JSON File from the path file
func addElement(nameFile, pathAttribute, dictionnary):
	var text = checkFileExistUserPath(nameFile)
	if text == "": 
		return 0
	var tmp = JSON.parse(text)
	var dict = tmp.result
	var attributs = pathAttribute.split("/");
	var Dicttmp = dict
	for el in range(0, attributs.size()) :
		Dicttmp = Dicttmp[attributs[el]]
		if(Dicttmp == null) :
			#print("Wrong pathAttribute")
			return 0
	Dicttmp[dictionnary.keys()[0]] = dictionnary.get(dictionnary.keys()[0])
	var jtstr = JSON.print(dict)
	rewriteFile(nameFile, jtstr)
	return 1

#nameFile : String 
#pathAttribute : String ex:"Exercice/Words"
#node : Node ex:"Word"
#This function can get one element from a JSON File from the path file
func getElement(nameFile : String, pathAttribute : String, node : Node):
	var text = checkFileExistUserPath(nameFile)
	if text == "": 
		return 0
	
	var tmp = JSON.parse(text)
	var dict = tmp.result
	var attributs = pathAttribute.split("/");
	for el in attributs :
		dict  = dict[el] 
		if(dict == null) :
			#print("Wrong pathAttribute")
			return 0
	for field in dict :
		node.setAttribut(field, dict[field])
		##print (field," : ", dict[field])
	return 1

#nameFile : String 
#pathAttribute : String ex:"Exercice/Words"
#This function can change one element in a JSON File from the path file
func removeElement(nameFile, pathAttribute, content):
	var text = checkFileExistUserPath(nameFile)
	if text == "": 
		return 0
	var tmp = JSON.parse(text)
	var dict = tmp.result
	var attributs = pathAttribute.split("/");
	var Dicttmp = dict
	for el in range(0, attributs.size()) :
		Dicttmp = Dicttmp[attributs[el]]
		if(Dicttmp == null) :
			#print("Wrong pathAttribute")
			return 0

	Dicttmp.erase(content)
	var jtstr = JSON.print(dict)
	rewriteFile(nameFile, jtstr)
	return 1


func rewriteFile(nameFile, content):
	##print("[WRITINGFILE]")
	var dir = Directory.new()
	var fp_user = File.new()
	if(!dir.dir_exists(userPath)):
		dir.make_dir(userPath)
	var f_name = userPath + nameFile;
	var err = fp_user.open( f_name, File.WRITE )
	##print( f_name + " opened." )
	##print( "fp_user error code: " + str(err) )
	fp_user.store_string(content)
	#print( f_name + " written." )
	fp_user.close()
	##print("[END_WRITINGFILE]")
