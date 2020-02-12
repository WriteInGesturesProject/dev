extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var nameFile = "wordsAvailable"
var contentFile = Global.loadFileInArray(nameFile)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, contentFile.size()):
		var currentHbox = _createAvailableWordsList(str(i), contentFile[i], str(i), "X")
		find_node("wordsAvailableContainer").add_child(currentHbox)
	_createKeyboard()

func _createKeyboard():
	for b in Global.dictionaryPhonetic:
		for w in Global.dictionaryPhonetic[b]:
			var keyButton = Button.new()
			keyButton.theme = load("res://fonts/phonetic.tres")
			keyButton.text = w["phonetic"]
			keyButton.connect("pressed",self,"_on_keyButton_pressed", [keyButton])
			keyButton.rect_min_size = Vector2(100,0)
			find_node("gridKeyboard").add_child(keyButton)
	var keyDeleteButton = Button.new()
	keyDeleteButton.text = "delete"
	keyDeleteButton.theme = load("res://fonts/phonetic.tres")
	keyDeleteButton.connect("pressed",self,"_on_keyButton_pressed", [keyDeleteButton])
	find_node("gridKeyboard").add_child(keyDeleteButton)
	

func _on_keyButton_pressed(keyButton):
	var newWordLabel = find_node("newWord")
	if (keyButton.text == "delete") and (newWordLabel.text.length()>0) :
		newWordLabel.text[-1] = ""
	elif (keyButton.text != "delete") :
		newWordLabel.text += keyButton.text[1]
	
func _on_addWord_pressed():
	var stateAddLabel = find_node("stateAddLabel")
	stateAddLabel.add_color_override("font_color", Color(0,0,0))
	var text = find_node("newWord").get_text()
	if !(contentFile.has(text)) && contentFile.size() :# < 20:
		contentFile.append(text)
		var currentHbox = _createAvailableWordsList(text, text, text, "X")
		find_node("wordsAvailableContainer").add_child(currentHbox)
		Global.saveStringInFile(nameFile,text)
		stateAddLabel.set_text("Le mot a été ajouté.")
		find_node("newWord").text = ""
	else:
		#if contentFile.size() >= 20:
		#	stateAddLabel.set_text("Trop de mots ont été ajouté.")
		#else :
		stateAddLabel.set_text("Le mot existe déjà.")

func _createAvailableWordsList(nameLabel, textLabel, nameButton, textButton):
	var hBoxContainer = HBoxContainer.new()
	hBoxContainer.mouse_filter =Control.MOUSE_FILTER_PASS
	var currentLabel = Label.new()
	currentLabel.name = nameLabel
	var buttonDelete = Button.new()
	buttonDelete.theme = load("res://fonts/ButtonTheme.tres")
	currentLabel.size_flags_horizontal = SIZE_EXPAND_FILL
	hBoxContainer.add_child(currentLabel)
	hBoxContainer.add_child(buttonDelete)
	buttonDelete.name = nameButton
	buttonDelete.text = textButton
	buttonDelete.connect("gui_input",self,"input_event",[])
	buttonDelete.connect("pressed",self,"_on_deleteButton_pressed", [buttonDelete, currentLabel])
	currentLabel.set_text(textLabel)
	currentLabel.add_color_override("font_color", Color(255,255,255))
	return hBoxContainer

func _on_deleteButton_pressed(button, label):
	print("release : ", release)
	if(!release) :
		button.get_parent().remove_and_skip()
		print("label text : ",label.get_text())
		var index = contentFile.find(label.get_text())
		contentFile.remove(index)
		print(contentFile)
		var newContent = _convertArrayToString(contentFile)
		Global.rewriteFile(nameFile, newContent)
		swiping = false 

func _convertArrayToString(content):
	var newContent = ""
	for i in range(0,content.size()):
		newContent += content[i]
		if(i != content.size()-1):
			newContent += "\n"
	return newContent

func _on_Retour_pressed():
	get_tree().change_scene("res://speechTherapistMenu.tscn")


#variable for scrolling 
var swiping = false
var release = false
var isswipping = false
var swipe_start
var swipe_mouse_start
var swipe_mouse_times = []
var swipe_mouse_positions = []


func _input(ev):
	#print(ev)
	if swiping and ev is InputEventMouseMotion:
		var delta = ev.position - swipe_mouse_start
		#print(delta.length())
		if(delta.length()>10):
			find_node("ScrollContainer").set_h_scroll(swipe_start.x - delta.x)
			find_node("ScrollContainer").set_v_scroll(swipe_start.y - delta.y)
			swipe_mouse_times.append(OS.get_ticks_msec())
			swipe_mouse_positions.append(ev.position)
			isswipping = true
	elif ev is InputEventMouseButton:
		if ev.pressed:
			release = false
			swiping = true
			swipe_start = Vector2(find_node("ScrollContainer").get_h_scroll(),
			find_node("ScrollContainer").get_v_scroll())
			swipe_mouse_start = ev.position
			swipe_mouse_times = [OS.get_ticks_msec()]
			swipe_mouse_positions = [swipe_mouse_start]
		else:
			#When we release the button
			swipe_mouse_times.append(OS.get_ticks_msec())
			swipe_mouse_positions.append(ev.position)
			var source = Vector2(find_node("ScrollContainer").get_h_scroll(), 
			find_node("ScrollContainer").get_v_scroll())
			var idx = swipe_mouse_times.size() - 1
			var now = OS.get_ticks_msec()
			var cutoff = now - 100
			for i in range(swipe_mouse_times.size() - 1, -1, -1):
				if swipe_mouse_times[i] >= cutoff: idx = i
				else: break
			var flick_start = swipe_mouse_positions[idx]
			var flick_dur = min(0.3, (ev.position - flick_start).length() / 1000)
			if flick_dur > 0.0:
				var tween = Tween.new()
				add_child(tween)
				var delta = ev.position - flick_start
				var target = source - delta * flick_dur * 15.0
				tween.interpolate_method(self, 'set_h_scroll', source.x, target.x, flick_dur, Tween.TRANS_LINEAR, Tween.EASE_OUT)
				tween.interpolate_method(self, 'set_v_scroll', source.y, target.y, flick_dur, Tween.TRANS_LINEAR, Tween.EASE_OUT)
				tween.interpolate_callback(tween, flick_dur, 'queue_free')
				tween.start()
			print("is swipping :",isswipping)
			if isswipping:
				release = true
			else:
				release = false
			swiping = false
			isswipping =false
				
