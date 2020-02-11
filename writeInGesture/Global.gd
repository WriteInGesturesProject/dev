extends Node
class_name global

var level = 1
var progress1 = [85,85,85,20]
var progress2 = [0,0,85,0]
var progress3 = [0,0,0,0]
var progress = [progress1, progress2, progress3]
var score1 = [0,0,0,0]
var score2 = [0,0,0,0]
var score3 = [0,0,0,0]
var score = [score1, score2, score3]

var game = 1

var Number = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
var words_count = ["un", "deux", "trois", "quatre", "cinq", "six", "sept", "huit", "neuf", "dix"]
var img_count = ["res://art/imgBorel/a.png", "res://art/imgBorel/eu.png", "res://art/imgBorel/a.png", "res://art/imgBorel/i.png", "res://art/imgBorel/o.png", "res://art/imgBorel/u.png", "res://art/imgBorel/et.png", "res://art/imgBorel/ai.png", "res://art/imgBorel/e.png", "res://art/imgBorel/ou.png"]
var index = 0

var dictionaryPhonetic = loadJSonInDic("phonetic.json")
var current_scene = null
var text
var avatar

func set_avatar(avatar):
	self.avatar = avatar

func set_name(text):
	self.text = text

func get_avatar():
	return avatar

func get_text():
	return text

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func saveStringInFile(path, content):
	print("[SAVE_STRING_INFILE]")
	var file = File.new()
	var err = file.open("user://data/"+path, file.READ_WRITE)
	if(err) :
		print("File : user://data/", path, "doesn't exist")
		rewriteFile(path,content)
		file.open("user://data/"+path, file.READ_WRITE)
	file.seek_end()
	if file.get_len() != 0 :
		file.store_string("\n")
	file.store_string(content)
	file.close()
	print("[SAVE_STRING_INFILE]")

func searchInDictionnary(carac):
	var dico = loadJSonInDic("phonetic.json")
	for b in dico:
		for w in dico[b]:
			if(w["phonetic"] == "["+carac+"]"):
				return w["ressource_path"]
	return ""

func rewriteFile(path, content):
	print("[WRITINGFILE]")
	var dir = Directory.new()
	var dir_name = "data"
	var user_dir = "user://"
	dir.open(user_dir)
	print( "User directory: " + user_dir )
	if( !dir.dir_exists( dir_name ) ):
		print( dir_name + " doesn't exist." )
		dir.make_dir_recursive( dir_name )
	else:
		print( dir_name + " exists." )
	var fp_user = File.new()
	var f_name = user_dir + dir_name + "/" + path;
	var err = fp_user.open( f_name, File.WRITE )
	print( f_name + " opened." )
	print( "fp_user error code: " + str(err) )
	fp_user.store_string(content)
	print( f_name + " written." )
	fp_user.close()
	print("[END_WRITINGFILE]")
	
func removeFile(path):
	print("[REMOVEFILE]")
	var dir = Directory.new()
	dir.remove("user://data/"+path)
	print("[END_REMOVEFILE] : user://data/",path )
	

func loadFileInArray(path):
	print("[LOADFILE]")
	var file = File.new()
	var content = []
	print("Trying to search path in user data : user://data/",path)
	var err = file.open( "user://data/"+path, File.READ )
	if(err) :
		print("File doesn't find in user data, trying in res data ")
		var err_res = file.open("res://data/"+path, file.READ)
		if(err_res):
			print("File doesn't found anywhere")
			return null;
		else :
			print("File found in res data, reading file and write in user data")
			var currentLine = file.get_line()
			var writing = currentLine
			while  currentLine != "":
				content.append(currentLine)
				currentLine = file.get_line()
				writing += "\n" + currentLine
			file.close()
			rewriteFile(path,writing)
	else :
		print("File found in user data, reading file")
		var currentLine = file.get_line()
		while  currentLine != "":
			content.append(currentLine)
			currentLine = file.get_line()
		file.close()
	print("[ENDLOADFILE]")
	return content
	
func loadJSonInDic(path):
	var file = File.new()
	file.open("res://data/"+path, file.READ)
	var text = file.get_as_text()
	var tmp  =JSON.parse(text)
	var dict = tmp.result
	file.close()
	return dict
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
