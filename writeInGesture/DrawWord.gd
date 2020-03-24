extends Control

const Word = preload("res://Word.gd")
const Exercise = preload("res://Exercise.gd")

var margin = 0.05
var easy = [0.15,0.35,0.4]
var normal = [0,0.4,0.4]
var hard = [0,0.7,0]

var currentDisplay
var VectorMarge
var separation 
var tts = Global.tts
var stt = Global.stt
var display = false
var incremented = false
var index
var Ex
var count = 0

var testDifficulty = 1
var wordTest
# Called when the node enters the scene tree for the first time.
func _ready():
#	display(2,Global.wordDictionnary.getAllWord()[195],null,0)
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
	find_node("Next").rect_size = Vector2(get_viewport().size.y*0.15, get_viewport().size.y*0.15)
	find_node("Back").rect_size = Vector2(get_viewport().size.y*0.15, get_viewport().size.y*0.15)
	Global.make_margin(find_node("MarginContainer"), margin)
	VectorMarge = get_viewport().size * (1-2*margin)
	if(level == 0) :
		currentDisplay = easy
		separation =VectorMarge.y *( (1 - (easy[0]+easy[1]+easy[2]))/2)
	elif (level == 1) :
		currentDisplay = normal
		separation =VectorMarge.y *( 1 - (normal[0]+normal[1]+normal[2]))
		find_node("WordContainer").visible = false
	else :
		separation =VectorMarge.y *( 1 - (hard[0]+hard[1]+hard[2]))
		find_node("ImageContainer").add_constant_override("margin_top", separation/2)
		find_node("WordContainer").visible = false
		find_node("ImgBorel").visible = false
		separation = 0
		currentDisplay = hard
	
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
	
	##Make the separation
	
func displayWord(word: Word) :
	find_node("Word").text = word.getWord()
	find_node("Word").get_font("font").size = find_node("WordContainer").rect_min_size.y /2

func displayImage(word : Word) :

	var img = Global.find_texture(word.getPath())
	find_node("Image").texture = img
	var lenghtY = find_node("ImageContainer").rect_min_size.y
	find_node("Image").rect_size.y = lenghtY
	find_node("Image").rect_size.x = lenghtY * (img.get_size().x / img.get_size().y)

#	##Center picture 
	find_node("Image").rect_position.x =+ -find_node("Image").rect_size.x /2 + find_node("Speak").rect_size.x/2
	
	##Ajust button speak and record
	var separationButton = VectorMarge.x / 10
	find_node("Speak").rect_size.y = lenghtY * 0.45
	find_node("Speak").rect_size.x = lenghtY * 0.45
	find_node("Speak").rect_position.x = find_node("Image").rect_size.x/2 + separationButton
	find_node("Speak").get_parent().rect_min_size = find_node("Speak").rect_size

	find_node("Record").rect_size.y = lenghtY * 0.45
	find_node("Record").rect_size.x = lenghtY* 0.45
	find_node("Record").rect_position.x = find_node("Image").rect_size.x/2 + separationButton

	find_node("VBoxContainerButton").add_constant_override("separation",lenghtY* 0.1)
	find_node("Record").disabled = false

	pass

func displayBorel(word : Word) :
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

func _process(delta):
	if(stt != null && display && stt.isDetectDone()):
		var words = stt.getWords()
		if(Global.check_words(words, wordTest)):
				find_node("Record").disabled = true
				if(incremented == false):
						incremented = true
						find_node("Good").playing = true
						Ex.setWordSuccess(Global.level, index, Ex.getWordSuccess(Global.level, index) + 1)
						Global.score += 1
						if(Ex.getName() == "Jeu de l'oie") :
							print("coin +1")
							Global.player.setSilver(Global.player.getSilver()+1)
							self.get_parent().get_parent().next()
		elif(incremented == false):
				find_node("Wrong").playing = true
				incremented = true



func _on_Speak_pressed():
	print("speak")
	if(stt != null && stt.isListening()):
		stt.stopListen()
	if(tts != null):
		var text = find_node("Word").text
		match Global.os:
			"X11":
				tts.speak(text, false)
			"Android":
				tts.speakText(text)


func _on_Record_pressed():
	print("record")
	find_node("Wrong").playing = false
	find_node("Good").playing = false
	incremented = false
	if(count == 2):
		find_node("Record").disabled = true
		find_node("Next").visible = true
	count += 1
	if(stt != null):
		if(stt.isListening() == false):
			stt.doListen()
			display = true
			Global.try[index] = true
			print("Trying,",index)
			Ex.setNbWordOccurrence(Global.level, index, Ex.getNbWordOccurrence(Global.level, index) + 1)
		else :
			stt.stopListen()

func _on_Back_pressed():
	if(self.get_parent().get_parent() is Popup) :
		#if it is the goose game popup
		self.get_parent().get_parent().get_parent().back()
	else :
		#if it is the train scene
		self.get_parent().get_parent().back()
	self.remove_and_skip()


func _on_Next_pressed():
	if(self.get_parent().get_parent() is Popup) :
		self.get_parent().get_parent().get_parent().next()
	else :
		self.get_parent().get_parent().next()
	find_node("Record").disabled = false
	display = false


###################################END_CONTROLLING_RECORDING######################################################
