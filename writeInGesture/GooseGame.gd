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
var scene 

var RecordButton

# Called when the node enters the scene tree for the first time.
func _ready():	
	find_node("MarginContainer").set("custom_constants/margin_top",get_viewport().size.y / 12)
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
					image.texture = load("res://assets/icons/help.png")
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
	board[0].modulate = "e86767"
	Global.score = 0
	for i in myWords:
		Global.try.append(false)
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



func _change():
	if(index >= myWords.size()):
		return 
	count = 0
	scene.find_node("Next").visible = false
	display = false
	if(index >= myWords.size()):
		get_tree().change_scene("res://GameEnd.tscn")
	else :
		scene.display(Global.level, myWords[index], Ex, index)
	find_node("WordDetails").popup_centered_ratio(1)
	find_node("backgroundDark").visible = true

func back():
	if(find_node("backgroundDark") != null):
		find_node("backgroundDark").visible = false
	find_node("WordDetails").visible = false
	get_tree().change_scene("res://GameLevel.tscn")


func next():
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
		var classe = preload("res://DrawWord.tscn")
		scene = classe.instance()
#		var marginMain = MarginContainer.new()
#		Global.make_margin(marginMain, 0.015)
#		marginMain.add_child(scene)
		find_node("WordDetails").add_child(scene)
		scene.display(Global.level, myWords[index], Ex, index)
		scene.find_node("Next").visible = false
		find_node("backgroundDark").visible = true
	else :
		_change()
