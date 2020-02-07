extends Node
class_name global

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#var words = Array()
#words.add("Chibre")

var level = 1
var progress1 = [85,85,85,20]
var progress2 = [0,0,85,0]
var progress3 = [0,0,0,0]

var game = 1

var Number = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
var words_count = ["un", "deux", "trois", "quatre", "cinq", "six", "sept", "huit", "neuf", "dix"]
var img_count = ["res://art/imgBorel/a.png", "res://art/imgBorel/eu.png", "res://art/imgBorel/a.png", "res://art/imgBorel/i.png", "res://art/imgBorel/o.png", "res://art/imgBorel/u.png", "res://art/imgBorel/et.png", "res://art/imgBorel/ai.png", "res://art/imgBorel/e.png", "res://art/imgBorel/ou.png"]
var index = 0

var dictionaryPhonetic = loadJSonInDic("phonetic.json")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func saveStringInFile(path, content):
	var file = File.new()
	file.open("res://data/"+path, file.READ_WRITE)
	file.seek_end()
	if file.get_len() != 0 :
		file.store_string("\n")
	file.store_string(content)
	file.close()

func rewriteFile(path, content):
	var file = File.new()
	file.open("res://data/"+path, file.WRITE)
	file.store_string(content)
	file.close()

func loadFileInArray(path):
	var file = File.new()
	file.open("res://data/"+path, file.READ)
	var content = []
	var currentLine = file.get_line()
	while  currentLine != "":
		content.append(currentLine)
		currentLine = file.get_line()
	file.close()
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
