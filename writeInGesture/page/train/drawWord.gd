extends Control

const Word = preload("res://entity/Word.gd")
const Exercise = preload("res://entity/Exercise.gd")

var margin = 0.05
var easy = [0.15,0.35,0.4]
var normal = [0.15,0.3,0.45]
var hard = [0,0.7,0]

var currentDisplay
var VectorMarge
var separation 
var textToSpeech = Global.textToSpeech
var speechToText = Global.speechToText
var display = false
var incremented = false
var index
var Ex
var count = 0
var tryindex

var testDifficulty = 1
var wordTest

func _ready():
	pass
##########################################DISPLAY_VIEW########################################################
func display(level : int, word : Word, exercice : Exercise, ind : int) :
	wordTest = word
	Ex = exercice
	index = ind
	count = 0
	
	display = false
	incremented = false
	find_node("Record").disabled = false
	find_node("Record").modulate = Color(1,1,1,1)
	
	#### Make margin for Back Button and Next Button
	Global.make_margin(find_node("MainPage"), 0.015)
	find_node("Next").rect_size = Vector2(get_viewport().size.y*0.15, get_viewport().size.y*0.15)
	find_node("Next").rect_position = Vector2(get_viewport().size.x*0.97 - get_viewport().size.y*0.15, get_viewport().size.y*0.82)
	VectorMarge = get_viewport().size * (1-2*margin)
	
	###We choose the difficulty of the game
	if(level == 0) :
		currentDisplay = easy
		separation =VectorMarge.y *( (1 - (easy[0]+easy[1]+easy[2]))/2)
	elif (level == 1) :
		currentDisplay = normal
		separation =VectorMarge.y *( (1 - (normal[0]+normal[1]+normal[2]))/2)
	else :
		separation =VectorMarge.y *( 1 - (hard[0]+hard[1]+hard[2]))
#		find_node("ImageContainer").add_constant_override("margin_top", separation/2)
		find_node("WordContainer").visible = false
		find_node("ImgBorel").visible = false
		separation = 0
		currentDisplay = hard
	
	##We put the size of each container if function of the difficulty 
	find_node("VBox").add_constant_override("separation", separation)
	find_node("WordContainer").rect_min_size = Vector2(VectorMarge.x, VectorMarge.y * currentDisplay[0])
	find_node("ImageContainer").rect_min_size = Vector2(VectorMarge.x, VectorMarge.y * currentDisplay[1])
	find_node("ImgBorel").rect_min_size = Vector2(VectorMarge.x, VectorMarge.y * currentDisplay[2])
	
	###Display Word Container
	displayWord(word)
	###Display the Image container###
	displayImage(word)
	###Display Image Borel Container###
	displayBorel(word)
	

	
func displayWord(word: Word) :###Display Word Container
	if(Ex.getName() == "Jeu de l'oie") :
		find_node("Word").add_color_override("font_color", Color(1,1,1))
	find_node("Word").text = word.getWord()
	find_node("Word").get_font("font").size = find_node("WordContainer").rect_min_size.y /2

func displayImage(word : Word) :###Display Image Container

	var img = Global.find_texture(word.getPath())
	find_node("Image").texture = img
	var lenghtY = find_node("ImageContainer").rect_min_size.y
	find_node("Image").rect_size.y = lenghtY
	find_node("Image").rect_size.x = lenghtY * (img.get_size().x / img.get_size().y)

#	##Center picture 
	find_node("Image").rect_position.x =+ -find_node("Image").rect_size.x /2 + find_node("Speak").rect_size.x/2
	
	if(currentDisplay == normal) :
		find_node("Image").visible = false
	
	##Ajust button speak and record
	var separationButton = VectorMarge.x / 10
	find_node("Speak").rect_size.y = lenghtY * 0.45
	find_node("Speak").rect_size.x = lenghtY * 0.45

	find_node("Speak").get_parent().rect_min_size = find_node("Speak").rect_size

	find_node("Record").rect_size.y = lenghtY * 0.45
	find_node("Record").rect_size.x = lenghtY* 0.45
	if(currentDisplay != normal) :
		find_node("Speak").rect_position.x = find_node("Image").rect_size.x/2 + separationButton
		find_node("Record").rect_position.x = find_node("Image").rect_size.x/2 + separationButton

	find_node("VBoxContainerButton").add_constant_override("separation",lenghtY* 0.1)
	find_node("Record").disabled = false

	pass

func displayBorel(word : Word) :###Display Borel Container
	if(find_node("HBoxBorel").get_child_count() >0 && find_node("HBoxBorel").get_child(0) != null) :
		find_node("HBoxBorel").get_child(0).remove_and_skip()
	var arrayPicture = Global.phoneticToArrayPicturePath(word.getPhonetic())
	var lengthY = find_node("ImgBorel").rect_min_size.y
	var lengthX = lengthY * arrayPicture.size()
	if(lengthX > VectorMarge.x) :
		lengthX = VectorMarge.x
#	print(lengthX,"  ",lengthY)
	var container = Global.putBorelInHboxContainer(arrayPicture, lengthX, lengthY)
	find_node("HBoxBorel").add_child(container)
	
	pass 

##########################################END_DISPLAY_VIEW########################################################

###################################CONTROLLING_RECORDING######################################################

func _process(delta): #This function check if we speak the right word
	if(speechToText != null):
		if(!speechToText.isListening()):
			find_node("Record").modulate = Color(1,1,1,1)
	
	if(speechToText != null && display && speechToText.isDetectDone()):
		find_node("Record").modulate = Color(1,1,1,1)
		var words = speechToText.getWords()
		print(words)
		if(Global.check_words(words, wordTest)):
				find_node("Record").disabled = true
				find_node("Record").modulate = Color(1,1,1,0.2)
				if(incremented == false):
						incremented = true
						find_node("Good").playing = true
						Ex.setWordSuccess(Global.manageGame.level, index, Ex.getWordSuccess(Global.manageGame.level, index) + 1)
						Global.manageGame.score += 1
						if(Ex.getName() == "Jeu de l'oie") :
							_on_Next_pressed()
		elif(incremented == false):
				print("trompe")
				find_node("Wrong").playing = true
				find_node("Record").modulate = Color(1,1,1,1)
				incremented = true



func _on_Speak_pressed(): #If we pressed on the speakButton
	if(speechToText != null && speechToText.isListening()):
		speechToText.stopListen()
		find_node("Record").modulate = Color(1,1,1,1)
	if(textToSpeech != null):
		var text = find_node("Word").text
		match OS.get_name():
			"X11":
				textToSpeech.speak(text, false)
			"Android":
				textToSpeech.speakText(text)


func _on_Record_pressed(): #If we pressed on the recordButton
	find_node("Wrong").playing = false
	find_node("Good").playing = false
	incremented = false
	if(count == 2):
		find_node("Record").disabled = true
		find_node("Record").modulate = Color(1,1,1,0.2)
		find_node("Next").visible = true
	if(Ex.getName() == "Jeu de l'oie") :
		count += 1
	if(speechToText != null):
		if(speechToText.isListening() == false):
			speechToText.doListen()
			find_node("Record").modulate = Color(1,1,1,0.5)
			display = true
			Global.manageGame.try[tryindex] = true
			Ex.setNbWordOccurrence(Global.manageGame.level, index, Ex.getNbWordOccurrence(Global.manageGame.level, index) + 1)
		else :
			find_node("Record").modulate = Color(1,1,1,1)
			speechToText.stopListen()

func _on_Back_pressed():
	if(self.get_parent() is Popup) :
		#if it is the goose game popup
		self.get_parent().get_parent().back()
	else :
		#if it is the train scene
		self.get_parent().back()
	self.remove_and_skip()


func _on_Next_pressed():
	if(self.get_parent() is Popup) :
		self.get_parent().get_parent().next()
	else :
		self.get_parent().next()
	find_node("Record").disabled = false
	display = false


###################################END_CONTROLLING_RECORDING######################################################
