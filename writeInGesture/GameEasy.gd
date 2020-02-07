extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var myWords = Global.loadFileInArray("wordsAvailable")
var index = 0
var container = HBoxContainer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	if(Global.game == 2):
		get_node("ColorRect/MarginContainer/VBoxContainer/Number").set_text(Global.Number[Global.index])
		find_node("TextureRect").texture = load(Global.img_count[Global.index])
		get_node("ColorRect/MarginContainer/VBoxContainer/TextureRect2").visible = false
		get_node("ColorRect/MarginContainer/VBoxContainer/Number").visible = true
		get_node("ColorRect/MarginContainer/VBoxContainer/Word").set_text(Global.words_count[Global.index])
	elif(Global.game == 1):
		var img = ""
		find_node("TextureRect").visible = false
		container = HBoxContainer.new()
		container.alignment = HBoxContainer.ALIGN_CENTER
		for c in myWords[index]:
			img = Global.searchInDictionnary(c)
			var imgBorel = TextureRect.new()
			imgBorel.texture = load("res://art/imgBorel/"+img)
			container.add_child(imgBorel)
		find_node("ImgBorel").add_child(container)
		#get_node("ColorRect/MarginContainer/VBoxContainer/TextureRect2").textue = image du mot
		get_node("ColorRect/MarginContainer/VBoxContainer/Word").set_text(myWords[index])


func _on_Back_pressed():
	get_tree().change_scene("res://GameLevel.tscn")


func _on_Next_pressed():
	if(Global.game == 2):
		Global.index += 1
		if(Global.index == 10):
			get_tree().change_scene("res://GameEnd.tscn")
		else:
			get_node("ColorRect/MarginContainer/VBoxContainer/Number").set_text(Global.Number[Global.index])
			find_node("TextureRect").texture = load(Global.img_count[Global.index])
			get_node("ColorRect/MarginContainer/VBoxContainer/TextureRect2").visible = false
			get_node("ColorRect/MarginContainer/VBoxContainer/Word").visible = true
			get_node("ColorRect/MarginContainer/VBoxContainer/Word").set_text(Global.words_count[Global.index])
	elif(Global.game == 1):
		index += 1
		container.remove_and_skip()
		var img = ""
		find_node("TextureRect").visible = false
		if(index >= myWords.size()):
			get_tree().change_scene("res://GameEnd.tscn")
		else :
			container = HBoxContainer.new()
			container.alignment = HBoxContainer.ALIGN_CENTER
			container.name = "HBoxContainer"
			for c in myWords[index]:
				img = Global.searchInDictionnary(c)
				var imgBorel = TextureRect.new()
				imgBorel.texture = load("res://art/imgBorel/"+img)
				container.add_child(imgBorel)
			find_node("ImgBorel").add_child(container)
			#get_node("ColorRect/MarginContainer/VBoxContainer/TextureRect2").textue = image du mot
			get_node("ColorRect/MarginContainer/VBoxContainer/Word").set_text(myWords[index])
