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
var container
var line1 #line 1 in case of more than 3 borel image
var line2 #line 2 in case of more than 3 borel image
var choice #choix fait par l'enfant
var rand = 0 #choix aléatoire de l'image à trouver
var group = [] #array for the three button object

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
	find_node("Plate").margin_top = get_viewport().size.y * 0.05
	group = []
	rand = randi() % 3 + 1
	if(index + 3 < myWords.size()):
		for b in range(0,3):
					var cont = Control.new()
					var control_img = Control.new()
					var colorR = ColorRect.new()
					colorR.color = "5472ae"
					colorR.rect_size.x = get_viewport().size.y / 2.2
					colorR.rect_size.y = get_viewport().size.y / 2.2
					colorR.name = str(b)
					group.append(colorR)
					control_img.add_child(colorR)
					var marg = MarginContainer.new()
					marg.margin_top = 10
					marg.margin_left = 20
					var vBox = VBoxContainer.new()
					vBox.rect_size.x = get_viewport().size.y / 2.2
					vBox.rect_size.y = get_viewport().size.y / 2.2
					vBox.alignment = VBoxContainer.ALIGN_CENTER
					
					var word = Label.new()
					word.text = myWords[index].getWord()
					word.align = Label.ALIGN_CENTER
					
					var c = 0
					var phonetic = myWords[index].getPhonetic()
					var arrayPicture = Global.phoneticToArrayPicturePath(phonetic)
					print(arrayPicture.size())
					if(arrayPicture.size() > 3):
						line1 = Global.putBorelInHboxContainer([arrayPicture[0],arrayPicture[1],arrayPicture[2]], (get_viewport().size.y / 2.3) , (get_viewport().size.y / 2.2)/  4.5)
						var tab = []
						for i in range(3, arrayPicture.size()):
							tab.append(arrayPicture[i])
						line2 = Global.putBorelInHboxContainer(tab, (get_viewport().size.y / 2.3) , (get_viewport().size.y / 2.2)/  4.5)
						container = VBoxContainer.new()
						container.add_child(line1)
						container.add_child(line2)
					else :
						container = Global.putBorelInHboxContainer(arrayPicture, (get_viewport().size.y / 2.3), (get_viewport().size.y / 2.2)/  (mySize(myWords[index].getPhonetic())+0.5))
					if(Global.level == 0 || Global.level == 1):
						vBox.add_child(container)
					var box_image = Control.new()
					var hBox = HBoxContainer.new()
					hBox.alignment = HBoxContainer.ALIGN_CENTER
					var image = TextureRect.new()
					image.texture = load("res://art/images/"+ myWords[index].getPath())
					image.expand = true
					image.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
					if(Global.level == 0 || Global.level == 1):
						if(mySize(myWords[index].getPhonetic()) >= 3):
							image.rect_size.x = (get_viewport().size.y / 6)
							image.rect_size.y = (get_viewport().size.y / 6)
						else :
							image.rect_size.x = (get_viewport().size.y / 2.2)/  (mySize(myWords[index].getPhonetic())+0.5)
							image.rect_size.y = (get_viewport().size.y / 2.2)/  (mySize(myWords[index].getPhonetic())+0.5)
					else :
						image.rect_size.x = (get_viewport().size.y / 2.2)
						image.rect_size.y = (get_viewport().size.y / 2.2)
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
					colorR.connect("mouse_entered",self,"_on_control_img_mouse_entered", [colorR])
					find_node("gridCard").add_child(control_img)
					index += 1
		find_node("game").add_constant_override("separation", get_viewport().size.y / 2.2 + 30)
	else : 
		get_tree().change_scene("res://GameEnd.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_control_img_mouse_entered(control):
	for col in group:
		col.modulate = "ffffff"
	control.modulate = "e86767"
	match control.name :
		"1":
			choice = 3
		"2":
			choice = 2
		"3":
			choice = 1
	find_node("Validate").disabled = false

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

func _on_Validate_pressed():
	if(rand == choice):
		Global.score += 1
		Global.player.setSilver(Global.player.getSilver()+1)
	find_node("Validate").disabled = true
	for i in range(0, find_node("gridCard").get_child_count()):
		find_node("gridCard").get_child(i).queue_free()
	_ready()
