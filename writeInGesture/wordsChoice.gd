extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var contentFile = Global.loadFileInArray("wordsAvailable")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(contentFile)
	for i in range(0, contentFile.size()):
		var currentLabel = Label.new()
		currentLabel.set_text(contentFile[i])
		currentLabel.add_color_override("font_color", Color(0,0,0))
		get_node("MarginContainer/HBoxContainer/VBoxContainer").add_child(currentLabel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Retour_pressed():
	get_tree().change_scene("res://speechTherapistMenu.tscn")


func _on_addWord_pressed():
	var stateAddLabel = get_node("MarginContainer/HBoxContainer/VBoxContainer2/stateAddLabel")
	stateAddLabel.add_color_override("font_color", Color(0,0,0))
	var text = get_node("MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer/TextEdit").get_text()
	if !(contentFile.has(text)) && contentFile.size() < 20:
		contentFile.append(text)	
		var currentLabel = Label.new()
		currentLabel.set_text(text)
		currentLabel.add_color_override("font_color", Color(0,0,0))
		get_node("MarginContainer/HBoxContainer/VBoxContainer").add_child(currentLabel)
		Global.saveStringInFile("wordsAvailable",text)
		stateAddLabel.set_text("Le mot a été ajouté.")
	else:
		if contentFile.size() >= 20:
			stateAddLabel.set_text("Trop de mots ont été ajouté.")
		else :
			stateAddLabel.set_text("Le mot existe déjà.")
