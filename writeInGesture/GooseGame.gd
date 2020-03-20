extends Control

const Exercise = preload("res://Exercise.gd")

var Ex : Exercise

var os = Global.os

var tts = Global.tts
var stt = Global.stt

var words = ""
var display = false
var incremented = false
var myWords = Global.customExercise.getAllWords()
var index = 0
var img = ""
var container
var board = []
var count = 0
var index_play = 5
var temp = []
var ind = index
var margin = 0.05
var ind_prec = ind

var RecordButton

# Called when the node enters the scene tree for the first time.
func _ready():	
	find_node("MarginContainer").set("custom_constants/margin_top",get_viewport().size.y / 12)
	_scaleImg()
	if(myWords.size() > 22):
		temp = []
		var rand = 0
		var check = []
		for i in range(0, 22):
			rand = randi() % (myWords.size())
			while(check.find(rand) != -1):
				rand = randi() % (myWords.size())
			check.append(rand)
			temp.append(myWords[rand])
		myWords = temp
	Ex = Global.current_ex
	if(Global.level == 1 || Global.level == 2):
		find_node("Word").visible = false
	if(Global.level == 2):
		find_node("ImgBorel").visible = false
	var numb = 0
	var i = 0
	for b in range(0,5):
		for w in range(0,8):
			if(board.size() >= myWords.size()):
				break
			if((b==0 && w==7) || (b==2 && (w==7 || w ==0)) || (b==4 && w==0) || (b==1 && w!=7) || (b==3 && w!=0)):
				var control_img = Control.new()
				find_node("gridImage").add_child(control_img)
			else :
				var control_img = Control.new()
				var image = TextureRect.new()
				if(Global.level == 0 || Global.level == 2):
					image.texture = Global.find_texture(myWords[i].getPath())
					i += 1
				elif(Global.level == 1):
					image.texture = load("res://assets/icons/questionmark.png")
				image.expand = true
				image.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
				image.rect_size.x = get_viewport().size.y / 6
				image.rect_size.y = get_viewport().size.y / 6
				board.append(image)
				find_node("gridImage").add_constant_override("vseparation",  get_viewport().size.y / 6)
				find_node("gridImage").add_constant_override("hseparation",  (get_viewport().size.y / 6)+10)
				control_img.add_child(image)
				find_node("gridImage").add_child(control_img)
		if(board.size() >= myWords.size()):
			break
	if(Global.level == 0 || Global.level == 1):
		Global.make_margin(find_node("Margin"), margin)
		var VectorMarge = get_viewport().size * (1- 2 * margin)
		var c = 0
		var phonetic = myWords[ind].getPhonetic()
		var arrayPicture = Global.phoneticToArrayPicturePath(phonetic)
		var lengthY = VectorMarge.y / 2.5
		var lengthX = lengthY * arrayPicture.size()
		if(lengthX > VectorMarge.x) :
			lengthX = VectorMarge.x
		container = Global.putBorelInHboxContainer(arrayPicture, lengthX, lengthY)
		find_node("ImgBorel").add_child(container)
		find_node("MarginWord").rect_min_size = find_node("Image").rect_size  + find_node("Word").get_rect().size
		find_node("MarginBorel").rect_min_size = Vector2(VectorMarge.x , lengthY)
		var rest = VectorMarge.y - find_node("MarginWord").rect_min_size.y -find_node("MarginBorel").rect_min_size.y
		find_node("MainBoxPopup").add_constant_override("separation", rest/2)
		find_node("Word").text = myWords[ind].getWord()
	board[0].modulate = "e86767"
	find_node("Image").texture = Global.find_texture(myWords[0].getPath())
	Global.score = 0
	Global.try = []
	for i in myWords:
		Global.try.append(false)
	find_node("Speak").rect_position.y += (find_node("Image").rect_size.y - 2*find_node("Speak").rect_size.y)/2
	find_node("Record").rect_position.y += (find_node("Image").rect_size.y - 2*find_node("Speak").rect_size.y)/2
	find_node("Timer").start()

func _changeColor():
	index += 1
	ind = index
	ind_prec = ind
	if(index >= 8 && index <=13):
		if(index==8):
			board[index-1].modulate = "A9A9A9"
		else : 
			board[index-1 + index_play +2].modulate = "A9A9A9"
		board[index + index_play].modulate = "e86767"
		ind = index + index_play
		index_play -= 2
	else :
		if(index == 14):
			board[index-1 + index_play +2].modulate = "A9A9A9"
		else :
			board[index-1].modulate = "A9A9A9"
		if(index < myWords.size()):
			board[index].modulate = "e86767"

func _scaleImg():
	var img = Global.find_texture(myWords[ind].getPath())
	find_node("Image").texture = img
	find_node("Image").rect_size.y = get_viewport().size.y / 2.5
	find_node("Image").rect_size.x = get_viewport().size.y / 2.5 * (img.get_size().x / img.get_size().y)
	find_node("MainBox").add_constant_override("separation", int(find_node("Image").rect_size.x) + 20)
	find_node("Image").get_parent().rect_size.y = find_node("Image").rect_size.y

func _change():
	if(index >= myWords.size()):
		return 
	_scaleImg()
	count = 0
	find_node("Record").disabled = false
	find_node("Next").visible = false
	display = false
	container.remove_and_skip()
	if(index >= myWords.size()):
		get_tree().change_scene("res://GameEnd.tscn")
	else :
		if(Global.level == 0 || Global.level == 1):
			var VectorMarge = get_viewport().size * (1- 2 * margin)
			var phonetic = myWords[ind].getPhonetic()
			var arrayPicture = Global.phoneticToArrayPicturePath(phonetic)
			var lengthY = VectorMarge.y / 2.5
			var lengthX = lengthY * arrayPicture.size()
			if(lengthX > VectorMarge.x) :
				lengthX = VectorMarge.x
			container = Global.putBorelInHboxContainer(arrayPicture, lengthX, lengthY)
			find_node("ImgBorel").add_child(container)
			find_node("MarginWord").rect_min_size.y = find_node("Image").rect_size.y  + find_node("Word").get_rect().size.y
			find_node("MarginBorel").rect_min_size = Vector2(VectorMarge.x  , lengthY)
			var rest = VectorMarge.y - find_node("MarginWord").rect_min_size.y -find_node("MarginBorel").rect_min_size.y
			find_node("MainBoxPopup").add_constant_override("separation", rest/2)
			find_node("Word").set_text(myWords[ind].getWord())
			
	incremented = false
	find_node("WordDetails").popup_centered_ratio(1)
	find_node("backgroundDark").visible = true


func _process(delta):
	if(stt != null && display && stt.isDetectDone()):
		words = stt.getWords()
		if(count == 2):
			find_node("Record").disabled = true
			find_node("Next").visible = true
		if(Global.check_words(words, myWords[ind])):
			find_node("Record").disabled = true
			if(incremented == false):
				find_node("Great").playing = true
				Global.score += 1
				Global.player.setSilver(Global.player.getSilver()+1)
				if(Global.level == 2):
					board[ind_prec].texture = load("res://art/images/"+board[ind_prec].getPath())
				incremented = true
				_changeColor()
				_on_WordDetails_popup_hide()
		elif(incremented == false):
			find_node("Boo").playing = true
			incremented = true


func _on_Speak_pressed():
	if(stt != null && stt.isListening()):
		stt.stopListen()
	if(tts != null):
		var text = myWords[ind].getWord()
		match os:
			"X11":
				tts.speak(text, false)
			"Android":
				tts.speakText(text)


func _on_Record_pressed():
	find_node("Great").playing = false
	find_node("Boo").playing = false
	incremented = false
	if(count == 2):
		find_node("Record").disabled = true
		find_node("Next").visible = true
	count += 1
	if(stt != null):
		if(stt.isListening() == false):
			stt.doListen()
			Global.try[index] = true
			display = true
			Ex.setNbWordOccurrence(Global.level, index, Ex.getNbWordOccurrence(Global.level, index) + 1)
		else :
			stt.stopListen()


func _on_Back_pressed():
	if(find_node("backgroundDark") != null):
		find_node("backgroundDark").visible = false
	find_node("WordDetails").visible = false
	get_tree().change_scene("res://GameLevel.tscn")


func _on_Next_pressed():
	_changeColor()
	_on_WordDetails_popup_hide()


func _on_WordDetails_popup_hide():
	if(find_node("backgroundDark") != null):
		find_node("backgroundDark").visible = false
	find_node("WordDetails").visible = false
	find_node("Timer").start()


func _on_Timer_timeout():
	if(index >= myWords.size()):
		get_tree().change_scene("res://GameEnd.tscn")
	elif(index == 0) :
		find_node("WordDetails").popup_centered_ratio(1)
		find_node("backgroundDark").visible = true
	else :
		_change()
