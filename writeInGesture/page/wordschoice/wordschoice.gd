extends Control

const Word = preload("res://entity/Word.gd")
const WordsAvailable = preload("res://entity/WordsAvailable.gd")
const MyDictionnary = preload("res://entity/Dictionnary.gd")
const Exercise = preload("res://entity/Exercise.gd")
const TypeExercise = preload("res://entity/TypeExercise.gd")
const CreationExercise = preload("res://tools/CreationExercise.gd")

var nameFile = "wordsAvailable"
var ImageFile = ""
var ImagePath = ""
var margin = 0.05
var marginVector


var wordsAvailable : WordsAvailable = Global.wordsAvailable
var dictionnary : MyDictionnary = Global.wordDictionnary

var bg = ColorRect.new()
var lastPopup

#######################################FUNCTION_FOR_SCENE###############################
func _ready():
	
	
	#####Put margin
	Global.make_margin(find_node("Margin"), margin)
	marginVector = (get_viewport().size)*(1- 2*(margin))
	
	###Put responsive VboxWords
	var wordsContainer = find_node("WordsContainer")
	wordsContainer.rect_min_size.x = marginVector.x/4
	wordsContainer.rect_min_size.y = marginVector.y - find_node("retour").rect_size.y + marginVector.y*margin - get_viewport().size.y * margin
	find_node("MarginWord").set("custom_constants/margin_top", find_node("retour").rect_size.y )
	find_node("MainContainer").add_constant_override("separation", marginVector.x/16)
	
	#Put responsive VboxEdit
	find_node("editContainer").rect_min_size.x = marginVector.x*11/16
	find_node("editContainer").rect_min_size.y = marginVector.y
	find_node("keyBoardContainer").rect_min_size.y =  marginVector.y*0.6
	find_node("HBoxContainerAdd").rect_min_size.y = marginVector.y*0.15
	find_node("HBoxContainerCreation").rect_min_size.y = marginVector.y*0.15
	find_node("editContainer").add_constant_override("separation", marginVector.y*0.024)
	find_node("gridKeyboard").rect_min_size.x = marginVector.x*10/16
	
	var words : Array = wordsAvailable.getAllWords()
	
	
	makeListWord()
	_createKeyboard(find_node("editContainer").rect_min_size.x,find_node("keyBoardContainer").rect_min_size.y )
	self.add_child(bg)
	find_node("MainContainer").rect_position.y = 100+ find_node("retour").rect_size.y

	###Pre load background color Rect
	bg.color = (Color(0,0,0,224))
	bg.anchor_bottom = 1 
	bg.anchor_right = 1
	bg.visible = false
	
	print()
	find_node("newWord").get_font("font","").size = find_node("Panel3").rect_size.y - 3


func removeAllChildren(nameNode): # remove all children of nameNode
	for i in range(0, find_node(nameNode).get_child_count()):
		find_node(nameNode).get_child(i).queue_free()

func makeListWord() : # Make the list of choosen word of the new exercice 
	removeAllChildren("wordsAvailableContainer")
	if(wordsAvailable.getAllWords().size() == 0):
		find_node("Creation").visible = false
	else :
		find_node("Creation").visible = true
	for word in wordsAvailable.getAllWords() :
		find_node("wordsAvailableContainer").add_child(createAvailableWordsList(word))
	pass

func _createKeyboard(lenghtX : float, lenghtY : float): # create the phonetic keyboard
	var sizeWord = 0
	for b in Global.phoneticDictionnary:
		for w in Global.phoneticDictionnary[b]:
			sizeWord += 1
	find_node("gridKeyboard").columns = sizeWord/4
	var columsNbWords =  sizeWord/4
	var rawNbWords = sizeWord/columsNbWords
	
	for b in Global.phoneticDictionnary:
		for w in Global.phoneticDictionnary[b]:
			var keyButton = Button.new()
			keyButton.theme = load("res://assets/theme/PhoneticTheme.tres")
			keyButton.text = w["phonetic"]
			keyButton.connect("pressed",self,"_on_keyButton_pressed", [keyButton])
			keyButton.rect_min_size = Vector2(lenghtX*0.95/columsNbWords,lenghtY*0.95/rawNbWords)
			#print(lenghtX/rawNbWords)
			find_node("gridKeyboard").add_child(keyButton)
	var keyDeleteButton = Button.new()
	keyDeleteButton.text = "Effacer"
	keyDeleteButton.theme = load("res://assets/theme/ButtonTheme.tres")
	keyDeleteButton.connect("pressed",self,"_on_keyButton_pressed", [keyDeleteButton])
	find_node("HBoxContainerAdd").add_child(keyDeleteButton)
	

func _on_keyButton_pressed(keyButton): ## If we click on a button of the keyboard  we add the character in the "newWordLabel"
	var newWordLabel = find_node("newWord")
	if (keyButton.text == "Effacer") and (newWordLabel.text.length()>0) : #If the button presses if "Effacer" we erase the last charactere
		if(newWordLabel.text[-1].to_ascii()[0] == 3) :
			newWordLabel.text[-1] = ""
		newWordLabel.text[-1] = ""
	elif (keyButton.text != "Effacer") :
		newWordLabel.text += keyButton.text.split("[")[1].split("]")[0]


func _on_addWord_pressed(): ## If we click on "AddWord" button we add the word in the list of the new exercice
	var text = find_node("newWord").get_text()
	if(text == null || text == ""):
		return
	if !(wordsAvailable.getWord(text)) :# < 20:
		var word = dictionnary.getWord(text)
		if(word != null) :
			wordsAvailable.addWord(word)
			find_node("newWord").text = ""
			makeListWord()
		else :
			find_node("addWordLabel").text = "Le mot n'existe pas voulez vous l'ajouter ? \nLe mot est : \n"+ find_node("newWord").text 
			find_node("Popup").popup_centered_ratio(0.75)
			bg.visible = true
	else:
		find_node("StatePopup").popup_centered_ratio(1)
		find_node("labelState").text = "Le mot est déjà dans cet exercice"
		bg.visible = true
		find_node("Timer").start()

func createAvailableWordsList(word : Word):  ## We create one item of the availableWordList of the new Exercice
	#Creation of a new Hbox where there are the word, the phonetic of the word and a delete button
	var hBoxContainer = HBoxContainer.new()
	hBoxContainer.mouse_filter =Control.MOUSE_FILTER_PASS
	var currentLabel = Label.new()
	var wordLabel = Label.new()
	currentLabel.name = word.getWord()
	wordLabel.name = word.getWord()
	wordLabel.size_flags_horizontal = SIZE_EXPAND_FILL
	
	var buttonDelete = Button.new()
	buttonDelete.name = word.getWord()
	buttonDelete.icon = load("res://assets/icons/trash.png")
	buttonDelete.flat = true
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
	
	var panel = Panel.new()
	var stylebox = load("res://assets/theme/ItemList.tres")
	panel.set("custom_styles/panel", stylebox)
	
	var marginContainer = MarginContainer.new()
	marginContainer.set("custom_constants/margin_top", stylebox.expand_margin_bottom)
	marginContainer.set("custom_constants/margin_bottom", stylebox.expand_margin_bottom)
	marginContainer.set("custom_constants/margin_left", stylebox.expand_margin_bottom)
	marginContainer.set("custom_constants/margin_right", stylebox.expand_margin_bottom)
	marginContainer.add_child(panel)
	marginContainer.add_child(hBoxContainer)
	
	
	return marginContainer

func _on_deleteButton_pressed(button, label): #If we delete a word from the wordAvailable list we remove it from the list
	if(!release) :
		button.get_parent().get_parent().remove_and_skip()
		swiping = false 
		if(!wordsAvailable.removeWord(wordsAvailable.getWord(label.get_text()))) :
			print ("le mot n'est pas supprimé dans le fichier'")
		makeListWord()
		return 

func _on_Retour_pressed():
	Global.manageScreen.changeScene("res://page/navigation/speechTherapistMenu.tscn")

#######################################END_FUNCTION_FOR_SCENE###############################

#######################################ADD_WORD_IN_DICTIONNARY###############################
func _on_Popup_hide():
	bg.visible = false

func _on_no_pressed():
	find_node("Popup").visible = false
	find_node("Popup2").visible = false

func _on_yes_pressed():
	find_node("Popup2").popup_centered_ratio(0.75)
	find_node("Popup").visible = false
	bg.visible = true
	find_node("LinePhonetic").text = find_node("newWord").text

func _on_Confirm_pressed(): ###Whn we create a new word in a dictionnary
	if(find_node("OpenButton").text != "Ouvrir une image") :
		var newWord : Word = Word.new()
		newWord.setAttribut("phonetic", find_node("LinePhonetic").text)
		newWord.setAttribut("word", find_node("LineWord").text)
		newWord.setAttribut("nbSyllable", find_node("LineNbSyllable").text.to_int())
		newWord.setAttribut("syllableStruct", find_node("LineStruct").text)
		newWord.setAttribut("vowelsType", find_node("LineVoyelsType").text)
		newWord.setAttribut("consonantsType", find_node("LineConsType").text)
		newWord.setPath(ImageFile)
		newWord.setHomonym(findHomonym(newWord.getWord()))
		if(newWord.getHomonym().size() == 0) :
			newWord.addHomonym(newWord.getWord())
		var err = dictionnary.addWord(newWord)
		if(err) :
			#print("le mot a bien été ajouté")
			find_node("LinePhonetic").text = ""
			find_node("LineWord").text = ""
			find_node("LineStruct").text = ""
			find_node("LineNbSyllable").text = ""
			find_node("LineVoyelsType").text = ""
			find_node("LineConsType").text = ""
			find_node("Popup").visible = false
			find_node("Popup2").visible = false
			find_node("Creation").visible = true
			_on_addWord_pressed()
		else :
			print("le mot n'a pas été ajouté")
	else :
		find_node("StatePopup").popup_centered_ratio(1)
		find_node("labelState").text = "Veuillez ajouté une image pour ce mot"
		find_node("Popup2").visible = false
		bg.visible = true
		find_node("Timer").start()
		lastPopup = find_node("Popup2")
	
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
				res = homo
	return res
	
func _on_OpenButton_pressed(): ### Open Internet navigator to find a picture for the new Word
	var word = find_node("LineWord").text
	if(word == null || word == ""):
		find_node("Word").modulate = "ff0000"
		return
	find_node("FileDialog").rect_size = get_viewport().size - Vector2(50, 50)
	find_node("FileDialog").set_current_dir(OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS))
	find_node("FileDialog").popup()

func _on_SearchButton_pressed():
	var word = find_node("LineWord").text
	if(word == null || word == ""):
		find_node("Word").modulate = "ff0000"
		return
	var url = "https://www.google.com/search?q="
	url += word
	url += "&tbm=isch&tbs=sur%3Af"
	OS.shell_open(url)

func _on_FileDialog_file_selected(path):
	var word = find_node("LineWord").text
	if(word == null || word == ""):
		return
	ImageFile = word + "." + path.get_extension()
	ImagePath = "user://art/" + ImageFile
	var dir = Directory.new()
	dir.open("user://")
	if(!dir.dir_exists("art")):
		dir.make_dir("art")
	dir.copy(path, ImagePath)
	find_node("OpenButton").set_text(path.get_file())

#######################################END_ADD_WORD_IN_DICTIONNARY###############################

#######################################CREATION_OF_EXERCISE######################################
func _on_Creation_pressed(): ### For create a new exercice we use the class CreationExercice.gd
	var creation = CreationExercise.new()
	if(wordsAvailable.getAllWords().size() >= 3) :
		creation.updateExercises(wordsAvailable.getAllWords())
		find_node("StatePopup").popup_centered_ratio(1)
		find_node("labelState").text = "L'exercice a bien été créé "
		bg.visible = true
		find_node("Timer").start()

		var tmp = wordsAvailable.getAllWords().duplicate()
		for word in tmp :
			wordsAvailable.removeWord(word)
		makeListWord()	
		
	else : 
		find_node("StatePopup").popup_centered_ratio(1)
		find_node("labelState").text = "Veuillez au minimum faire un exercice avec au moins trois mots "
		bg.visible = true
		find_node("Timer").start()
	
	
#######################################END_CREATION_OF_EXERCISE######################################

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
	##print(ev)
	if swiping and ev is InputEventMouseMotion:
		var delta = ev.position - swipe_mouse_start
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
#			#print("is swipping :",isswipping)
			if isswipping:
				release = true
			else:
				release = false
			swiping = false
			isswipping =false
#######################################END_SCROLLING#################################################


func _on_Timer_timeout():
	if(find_node("StatePopup") != null) :
		find_node("StatePopup").visible = false
		bg.visible = false
	if(lastPopup != null):
		lastPopup.visible = true
		bg.visible = true
	find_node("Timer").stop()
	


func _on_Label_pressed():
	if(find_node("Popup") != null) :
		find_node("Popup").visible = false
		find_node("Popup2").visible = false
		find_node("FileDialog").visible = false
