extends Control

const Word = preload("res://Word.gd")
const WordsAvailable = preload("res://WordsAvailable.gd")
const MyDictionnary = preload("res://Dictionnary.gd")

var nameFile = "wordsAvailable"

var wordsAvailable : WordsAvailable = Global.wordsAvailable
var dictionnary : MyDictionnary = Global.wordDictionnary

# Called when the node enters the scene tree for the first time.
func _ready():
	var words : Array = wordsAvailable.getAllWords()
	for i in range(0, words.size()):
		var currentHbox = _createAvailableWordsList(str(i), words[i], str(i), "X")
		find_node("wordsAvailableContainer").add_child(currentHbox)
	_createKeyboard()

func _createKeyboard():
	for b in Global.phoneticDictionnary:
		for w in Global.phoneticDictionnary[b]:
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
		newWordLabel.text += keyButton.text.split("[")[1].split("]")[0]
	
func _on_addWord_pressed():
	var stateAddLabel = find_node("stateAddLabel")
	stateAddLabel.add_color_override("font_color", Color(0,0,0))
	
	var text = find_node("newWord").get_text()
	if !(wordsAvailable.getWord(text)) :# < 20:
		var word = dictionnary.getWord(text)
		if(word != null) :
			var currentHbox = _createAvailableWordsList(text, word, text, "X")
			find_node("wordsAvailableContainer").add_child(currentHbox)
			wordsAvailable.addWord(word)
			stateAddLabel.set_text("Le mot a été ajouté.")
			find_node("newWord").text = ""
		else :
			print ("Le mot n'existe pas dans le dictionnaire, Voulez vous l'ajouter ?'")
	else:
		stateAddLabel.set_text("Le mot existe déjà.")

func _createAvailableWordsList(nameLabel, word : Word, nameButton, textButton):
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
	buttonDelete.connect("pressed",self,"_on_deleteButton_pressed", [buttonDelete, currentLabel])
	currentLabel.set_text(word.getPhonetic())
	currentLabel.add_color_override("font_color", Color(255,255,255))
	return hBoxContainer

func _on_deleteButton_pressed(button, label):
	print("release : ", release)
	if(!release) :
		button.get_parent().remove_and_skip()
		print("label text : ",label.get_text())
		swiping = false 
		if(!wordsAvailable.removeWord(wordsAvailable.getWord(label.get_text()))) :
			print ("le mot n'est pas supprimé dans le fichier'")
		return 

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
				
