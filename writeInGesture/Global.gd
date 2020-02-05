extends Node
class_name global

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var words = Array()
#words.add("Chibre")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func save(path, content):
	var file = File.new()
	file.open("res://data/"+path, file.READ_WRITE)
	file.seek_end()
	file.store_string("\n")
	file.store_string(content)
	file.close()
	
func loadFileInArray(path):
	var file = File.new()
	file.open("res://data/"+path, file.READ)
	#var content = file.get_as_text()
	var content = []
	var currentLine = file.get_line()
	while  currentLine != "":
		content.append(currentLine)
		currentLine = file.get_line()
	file.close()
	return content

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
