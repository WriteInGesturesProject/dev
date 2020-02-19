extends Control

const Word = preload("res://Word.gd")
const WordsAvailable = preload("res://WordsAvailable.gd")
const MyDictionnary = preload("res://Dictionnary.gd")
const Exercise = preload("res://Exercise.gd")
const TypeExercise = preload("res://TypeExercise.gd")

var nameFile = "wordsAvailable"

var wordsAvailable : WordsAvailable = Global.wordsAvailable
var dictionnary : MyDictionnary = Global.wordDictionnary

var bg = ColorRect.new()

#######################################FUNCTION_FOR_SCENE###############################
func _ready():
	var words : Array = wordsAvailable.getAllWords()
	makeListWord()
	_createKeyboard()
	self.add_child(bg)
	
func removeAllChildren(nameNode):
	# remove all children of nameNode
	for i in range(0, find_node(nameNode).get_child_count()):
		find_node(nameNode).get_child(i).queue_free()

func makeListWord() :
	removeAllChildren("wordsAvailableContainer")
	for word in wordsAvailable.getAllWords() :
		find_node("wordsAvailableContainer").add_child(createAvailableWordsList(word))
	pass

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
			wordsAvailable.addWord(word)
			stateAddLabel.set_text("Le mot a été ajouté.")
			find_node("newWord").text = ""
			makeListWord()
		else :
			find_node("addWordLabel").text = "Le mot n'existe pas voulez vous l'ajouter ? \nLe mot est : \n"+ find_node("newWord").text 
			find_node("Popup").popup_centered_ratio(0.75)
			bg.color = (Color(0,0,0,224))
			bg.visible = true
			bg.anchor_bottom = 1 
			bg.anchor_right = 1
	else:
		stateAddLabel.set_text("Le mot existe déjà.")

func createAvailableWordsList(word : Word):
	var hBoxContainer = HBoxContainer.new()
	hBoxContainer.mouse_filter =Control.MOUSE_FILTER_PASS
	var currentLabel = Label.new()
	var wordLabel = Label.new()
	currentLabel.name = word.getWord()
	wordLabel.name = word.getWord()
	wordLabel.size_flags_horizontal = SIZE_EXPAND_FILL
	
	var buttonDelete = Button.new()
	buttonDelete.name = word.getWord()
	buttonDelete.icon = load("res://art/delete.png")
	buttonDelete.expand_icon = true
	buttonDelete.rect_size = Vector2(60,60)
	buttonDelete.connect("pressed",self,"_on_deleteButton_pressed", [buttonDelete, currentLabel])
	
	var control = Control.new()
	control.rect_min_size = buttonDelete.rect_size
	control.size_flags_horizontal
	control.add_child(buttonDelete)
	
	hBoxContainer.add_child(currentLabel)
	hBoxContainer.add_child(wordLabel)
	hBoxContainer.add_child(control)
	
	currentLabel.set_text(word.getPhonetic())
	wordLabel.set_text(" : " + word.getWord())
	return hBoxContainer

func _on_deleteButton_pressed(button, label):
	print("release : ", release)
	if(!release) :
		button.get_parent().get_parent().remove_and_skip()
		print("label text : ",label.get_text())
		swiping = false 
		if(!wordsAvailable.removeWord(wordsAvailable.getWord(label.get_text()))) :
			print ("le mot n'est pas supprimé dans le fichier'")
		return 

func _on_Retour_pressed():
	get_tree().change_scene("res://speechTherapistMenu.tscn")

#######################################END_FUNCTION_FOR_SCENE###############################

#######################################ADD_WORD_IN_DICTIONNARY###############################
func _on_Popup_hide():
		bg.visible = false

func _on_no_pressed():
	find_node("Popup").visible = false
	find_node("Popup2").visible = false

func _on_yes_pressed():
	find_node("Popup2").popup_centered_ratio(0.75)
	find_node("LinePhonetic").text = find_node("newWord").text
	pass

func _on_Confirm_pressed():
	var newWord : Word = Word.new()
	newWord.setAttribut("phonetic", find_node("LinePhonetic").text)
	newWord.setAttribut("word", find_node("LineWord").text)
	newWord.setAttribut("nbSyllable", find_node("LineNbSyllable").text.to_int())
	newWord.setAttribut("syllableStruct", find_node("LineStruct").text)
	newWord.setAttribut("vowelsType", find_node("LineVoyelsType").text)
	newWord.setAttribut("consonantsType", find_node("LineConsType").text)
	newWord.setHomonym(findHomonym(newWord.getWord()))
	if(newWord.getHomonym().size() == 0) :
		newWord.addHomonym(newWord.getWord())
	var err = dictionnary.addWord(newWord)
	if(err) :
		print("le mot a bien été ajouté")
		find_node("Popup").visible = false
		find_node("Popup2").visible = false
		_on_addWord_pressed()
	else :
		print("le mot n'a pas été ajouté")
	
func findHomonym(word : String) :
	var res = []
	var text = ManageJson.checkFileExistUserPath("homonym.json")
	if text == "": 
		return 0
	var tmp = JSON.parse(text)
	var dict = tmp.result
	var array = dict["Homonyms"]
	for homo in array:
		for el in homo :
			if(el == word) :
				res= homo
	return res
#######################################END_ADD_WORD_IN_DICTIONNARY###############################

#######################################CREATION_OF_EXERCISE######################################
func _on_Creation_pressed():
	var fileName = creationFileExercice()
	var newCustomExercise = Exercise.new()
	newCustomExercise.setNameFile(fileName)
	ManageJson.getElement(fileName, "Exercise", newCustomExercise)
	newCustomExercise.setVersion(Global.customExercise.getVersion()+0.1)
	newCustomExercise.setUserId(Global.player.getId())
	newCustomExercise.setName(Global.customExercise.getName())
	newCustomExercise.getType().setName("Entrainement")
	newCustomExercise.getType().setCategory("Custom")
	newCustomExercise.setNbWords(wordsAvailable.getAllWords().size())
	var nbWordsOccurrences =[]
	var wordsSuccess = []
	var sucessPercentage =[]
	for i in range(0,Global.nbDifficulty):
		var tmp = []
		for word in wordsAvailable.getAllWords():
			tmp.append(0)
		nbWordsOccurrences.append(tmp)
		wordsSuccess.append(tmp)
		sucessPercentage.append(0.0)

	for word in wordsAvailable.getAllWords():
		newCustomExercise.addWord(word)

	newCustomExercise.putNbWordOccurrence(nbWordsOccurrences)
	newCustomExercise.putWordSucess(wordsSuccess)
	newCustomExercise.putSucessPercentage(sucessPercentage)
	
	
	Global.config.setPathExercisesFiles(Global.customExercise.getNameFile(),newCustomExercise.getNameFile())
	Global.customExercise = newCustomExercise
	
	find_node("stateAddLabel").text = "L'exercice a bien été créé"
	var tmp = wordsAvailable.getAllWords()
	for word in tmp :
		wordsAvailable.removeWord(word)
	
func creationFileExercice():
	var exerciseTemplate = {}
	var text = ManageJson.checkFileExistUserPath("exerciseTemplate.json")
	if text == "": 
		return 0
	var tmp = JSON.parse(text)
	var dict = tmp.result
	var fileName = Global.customExercise.getNameFile()
	var version = Global.customExercise.getVersion()
	version += 0.1
	fileName = fileName.split("_")[0]+"_"+String(version)+".json"
	ManageJson.rewriteFile(fileName, JSON.print(dict))
	return fileName
	
	
	
#######################################END_CREATION_OF_EXERCISE##################################

#######################################SCROLLING#################################################
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
#			print("is swipping :",isswipping)
			if isswipping:
				release = true
			else:
				release = false
			swiping = false
			isswipping =false
				
#######################################END_SCROLLING#################################################

