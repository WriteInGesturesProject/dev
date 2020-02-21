extends Control

var os = Global.os

var tts = Global.tts
var stt = Global.stt

var words = ""
var display = false
var incremented = false
var myWords = Global.listenExercise.getAllWords()
var index = 0
var img = ""
var container = HBoxContainer.new()
var line1
var line2
var choice 
var rand = 0

func mySize(word):
	var size = 0
	for i in word:
		print()
		if(i.to_ascii()[0] != 3):
			size += 1
	if(size == 1):
		return 1.7
	return size


# Called when the node enters the scene tree for the first time.
func _ready():
	rand = randi() % 3 + 1
	print("rand " + str(rand))
	if(index + 3 < myWords.size()):
		for b in range(0,3):
					var control_img = Control.new()
					var colorR = ColorRect.new()
					colorR.color = "5472ae"
					colorR.rect_size.x = get_viewport().size.y / 2.2
					colorR.rect_size.y = get_viewport().size.y / 2.2
					control_img.add_child(colorR)
					var marg = MarginContainer.new()
					marg.margin_top = 10
					marg.margin_left = 20
					var vBox = VBoxContainer.new()
					vBox.rect_size.x = get_viewport().size.y / 2.2
					vBox.rect_size.y = get_viewport().size.y / 2.2
					vBox.alignment = VBoxContainer.ALIGN_CENTER
					vBox.add_constant_override("separation", (get_viewport().size.y / 2.2)/ (mySize(myWords[index].getPhonetic())+0.5))
					
					var word = Label.new()
					word.text = myWords[index].getWord()
					word.align = Label.ALIGN_CENTER
					
					if(mySize(myWords[index].getPhonetic()) > 3):
						container = VBoxContainer.new()
						line1 = HBoxContainer.new()
						line2 = HBoxContainer.new()
						container.add_constant_override("separation",(get_viewport().size.y / 2.2)/ 4.5 +10)
						line1.add_constant_override("separation", (get_viewport().size.y / 2.2)/ 4.5 +10)
						line2.add_constant_override("separation", (get_viewport().size.y / 2.2)/ 4.5 +10)
					else :
						container = HBoxContainer.new()
						container.add_constant_override("separation",(get_viewport().size.y / 2.2)/  (mySize(myWords[index].getPhonetic())+0.5) +10)
					var c = 0
					var p = myWords[index].getPhonetic()
					while (c < len(p)):
						if(c+1 < len(p) && p[c].to_ascii()[0] == 91 && p[c+1].to_ascii()[0] == 3):
							img = "in.png"
							c += 1
						elif(c+1 < len(p) && p[c].to_ascii()[0] == 84 && p[c+1].to_ascii()[0] == 3):
							img = "on.png"
							c += 1
						elif(p[c].to_ascii()[0] == 226):
							img = "an.png"
						else :
							var find = false
							for b in Global.phoneticDictionnary:
								for w in Global.phoneticDictionnary[b]:
									if(p[c] == w["phonetic"][1]):
										img = w["ressource_path"]
										find = true
										break
								if(find):
									break
						var imgBorel = TextureRect.new()
						imgBorel.texture = load("res://art/imgBorel/"+img)
						imgBorel.expand = true
						imgBorel.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
						if(mySize(myWords[index].getPhonetic()) > 3):
							imgBorel.rect_size.x = (get_viewport().size.y / 2.2)/  4.5
							imgBorel.rect_size.y = (get_viewport().size.y / 2.2)/  4.5
						else :
							imgBorel.rect_size.x = (get_viewport().size.y / 2.2)/  (mySize(myWords[index].getPhonetic())+0.5)
							imgBorel.rect_size.y = (get_viewport().size.y / 2.2)/  (mySize(myWords[index].getPhonetic())+0.5)
						var boxImg = Control.new()
						boxImg.add_child(imgBorel)
						c += 1
						if(mySize(myWords[index].getPhonetic()) > 3):
							if(line1.get_child_count() < 3):
								line1.add_child(boxImg)
							else :
								line2.add_child(boxImg)
						else :
							container.add_child(boxImg)
					if(mySize(myWords[index].getPhonetic()) > 3):
						container.add_child(line1)
						container.add_child(line2)
					if(Global.level == 0 || Global.level == 1):
						vBox.add_child(container)
					var box_image = Control.new()
					var hBox = HBoxContainer.new()
					hBox.alignment = HBoxContainer.ALIGN_CENTER
					var image = TextureRect.new()
					image.texture = load("res://art/users/assistant.png")
					image.expand = true
					image.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
					if(Global.level == 0 || Global.level == 1):
						image.rect_size.x = (get_viewport().size.y / 2.2)/4
						image.rect_size.y = (get_viewport().size.y / 2.2)/4
					else :
						image.rect_size.x = (get_viewport().size.y / 2.2) - 10
						image.rect_size.y = (get_viewport().size.y / 2.2) -10
					box_image.add_child(image)
					if(Global.level == 0 || Global.level ==2):
						hBox.add_child(box_image)
					var vBox2 = VBoxContainer.new()
					if(Global.level == 0):
						vBox2.add_child(word)
					if(Global.level == 0 || Global.level ==2):
						vBox2.add_child(hBox)
						vBox.add_child(vBox2)
					marg.add_child(vBox)
					control_img.add_child(marg)
					find_node("gridCard").add_constant_override("hseparation",  (get_viewport().size.y / 2)+10)
					find_node("gridCard").add_child(control_img)
					index += 1
		find_node("Choice").add_constant_override("separation", (get_viewport().size.y / 2.2)/2)
		find_node("game").add_constant_override("separation", get_viewport().size.y / 2.2 + 30)
	else : 
		get_tree().change_scene("res://GameEnd.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://GameLevel.tscn")


func _on_Speak_pressed():
	if(stt != null && stt.isListening()):
		stt.stopListen()
		find_node("Record").set_text("Enregistrer")
	if(tts != null):
		var text = myWords[index - rand].getWord()
		match os:
			"X11":
				tts.speak(text, false)
			"Android":
				tts.speakText(text)


func _on_Choice1_pressed():
	find_node("Choice2").pressed = false
	find_node("Choice3").pressed = false
	find_node("Validate").disabled = false
	choice = 3


func _on_Choice2_pressed():
	find_node("Choice1").pressed = false
	find_node("Choice3").pressed = false
	find_node("Validate").disabled = false
	choice = 2


func _on_Choice3_pressed():
	find_node("Choice2").pressed = false
	find_node("Choice1").pressed = false
	find_node("Validate").disabled = false
	choice = 1


func _on_Validate_pressed():
	if(rand == choice):
		Global.score += 1
	find_node("Choice1").pressed = false
	find_node("Choice2").pressed = false
	find_node("Choice3").pressed = false
	find_node("Validate").disabled = true
	for i in range(0, find_node("gridCard").get_child_count()):
		find_node("gridCard").get_child(i).queue_free()
	_ready()
