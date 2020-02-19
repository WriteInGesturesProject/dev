extends Control

const MyDictionnary = preload("res://Dictionnary.gd")
const Exercise = preload("res://Exercise.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buttonPress = []
var syllable =["Monosyllabe", "Bisyllabe", "Trisyllabe"]
var struct =["CV","CVV","CVC"]


# Called when the node enters the scene tree for the first time.
func _ready():
	find_node("HBoxMain").add_constant_override("separation", get_viewport().size.x/6)
	for el in range (0,syllable.size()) :
		var button = CheckBox.new()
		button.name = String(el+1)
		button.text = syllable[el]
		button.flat = true
		button.align = Button.ALIGN_CENTER
		find_node("NbSyllableContainer").add_child(button)
		buttonPress.append(button)
		
	for el in struct :
		var button = CheckBox.new()
		button.name = el
		button.text = el
		button.flat = true
		button.align = Button.ALIGN_CENTER
		find_node("StructSyllableContainer").add_child(button)
		buttonPress.append(button)

func _on_retour_pressed():
	get_tree().change_scene("res://speechTherapistMenu.tscn")


func _on_Creation_pressed():
	var wordtoFind = []
	for button  in buttonPress:
		if(button.pressed) :
			wordtoFind.append(button.name)
	var words = searchWord(wordtoFind)
	
func searchWord(wordtoFind : Array):
	var nbsyl = []
	var struct = []
	var resultat =[]
	for el in wordtoFind :
		if(int(el)>0 and int(el)<4) :
			nbsyl.append(int(el))
		else :
			struct.append(el.to_upper())
	print(nbsyl)
	print(struct)
	for word in Global.wordDictionnary.getAllWord():
		if(nbsyl.size() > 0  and nbsyl.find(word.getNbSyllable())!= -1) :
			print(word.getWord())
			resultat.append(word)
	for word in resultat :
		if(struct.size() > 0  and !(struct.find(word.getSyllableStruct().to_upper()) != -1)):
			print("remove :", word.getWord())
			resultat.remove(resultat.find(word))
	return resultat

func _onCheckButtonPressed(extra_arg_0):
	pass # Replace with function body.
