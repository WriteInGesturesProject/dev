extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var nameFile = "wordsAvailable"
var contentFile = Global.loadFileInArray(nameFile)

# Called when the node enters the scene tree for the first time.
func _ready():
	print(contentFile)
	for i in range(0, contentFile.size()):
		var currentHbox = _createAvailableWordsList(str(i), contentFile[i], str(i), "X")
		get_node("MarginContainer/HBoxContainer/VBoxContainer").add_child(currentHbox)

func _on_addWord_pressed():
	var stateAddLabel = get_node("MarginContainer/HBoxContainer/VBoxContainer2/stateAddLabel")
	stateAddLabel.add_color_override("font_color", Color(0,0,0))
	var text = get_node("MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer/addWorldField").get_text()
	if !(contentFile.has(text)) && contentFile.size() < 20:
		contentFile.append(text)
		var currentHbox = _createAvailableWordsList(text, text, text, "X")
		get_node("MarginContainer/HBoxContainer/VBoxContainer").add_child(currentHbox)
		Global.saveStringInFile(nameFile,text)
		stateAddLabel.set_text("Le mot a été ajouté.")
	else:
		if contentFile.size() >= 20:
			stateAddLabel.set_text("Trop de mots ont été ajouté.")
		else :
			stateAddLabel.set_text("Le mot existe déjà.")

func _createAvailableWordsList(nameLabel, textLabel, nameButton, textButton):
	var hBoxContainer = HBoxContainer.new()
	var currentLabel = Label.new()
	currentLabel.name = nameLabel
	var buttonDelete = Button.new()
	currentLabel.size_flags_horizontal = SIZE_EXPAND_FILL
	hBoxContainer.add_child(currentLabel)
	hBoxContainer.add_child(buttonDelete)
	buttonDelete.name = nameButton
	buttonDelete.text = textButton
	buttonDelete.connect("pressed",self,"_on_deleteButton_pressed", [buttonDelete, currentLabel])
	currentLabel.set_text(textLabel)
	currentLabel.add_color_override("font_color", Color(0,0,0))
	return hBoxContainer

func _on_deleteButton_pressed(button, label):
	button.remove_and_skip()
	label.remove_and_skip()
	print("label text : ",label.get_text())
	var index = contentFile.find(label.get_text())
	contentFile.remove(index)
	print(contentFile)
	var newContent = _convertArrayToString(contentFile)
	Global.rewriteFile(nameFile, newContent)

func _convertArrayToString(content):
	var newContent = ""
	for i in range(0,content.size()):
		newContent += content[i]
		if(i != content.size()-1):
			newContent += "\n"
	return newContent

func _on_Retour_pressed():
	get_tree().change_scene("res://speechTherapistMenu.tscn")
