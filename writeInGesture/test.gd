extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("./test.json", file.READ)
	var text = file.get_as_text()
	file.close()
	print(JSON.parse(text).result)

