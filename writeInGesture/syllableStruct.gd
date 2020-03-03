extends Control

const MyDictionnary = preload("res://Dictionnary.gd")
const Exercise = preload("res://Exercise.gd")
const TypeExercise = preload("res://TypeExercise.gd")
const CreationExercise = preload("res://CreationExercise.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buttonPress = []
var syllable =["Monosyllabe", "Bisyllabe", "Trisyllabe"]
var struct =["CV","CVV","CVC","CVCC","VCVC"]
var wordFinal =[]


# Called when the node enters the scene tree for the first time.
func _ready():
	find_node("HBoxMain").add_constant_override("separation", get_viewport().size.x/6)
	for el in range (0,syllable.size()) :
		var button = CheckBox.new()
		button.name = String(el+1)
		button.text = syllable[el]
		button.flat = true
		button.align = Button.ALIGN_CENTER
		find_node("NbSyllableContainer").add_child(button)
		buttonPress.append(button)
		
	for el in struct :
		var button = CheckBox.new()
		button.name = el
		button.text = el
		button.flat = true
		button.align = Button.ALIGN_CENTER
		find_node("StructSyllableContainer").add_child(button)
		buttonPress.append(button)

func _on_retour_pressed():
	get_tree().change_scene("res://speechTherapistMenu.tscn")


func _on_Creation_pressed():
	var wordtoFind = []
	for button  in buttonPress:
		if(button.pressed) :
			wordtoFind.append(button.name)
	var words = searchWord(wordtoFind)
	var popup = find_node("Popup")
	
	popup.popup_centered_ratio(0.75)
	
	find_node("PopupLabel").text = String(words.size())+ " mots proposés :"
	for word in words:
		var label = Label.new()
		label.align = Label.ALIGN_CENTER
		label.text = word.getWord()+" : "+word.getPhonetic()
		find_node("VBoxPopup").add_child(label)
	
	popup.visible = true
	find_node("Background").visible = true
	
	wordFinal = words
	
	#for word in words:
	#	print("mot : ", word.getWord(),", ",word.getNbSyllable(),", ",word.getSyllableStruct())
	
func searchWord(wordtoFind : Array):
	var nbsyl = []
	var struct = []
	var resultat =[]
	for el in wordtoFind :
		if(int(el)>0 and int(el)<4) :
			nbsyl.append(int(el))
		else :
			struct.append(el.to_upper())
	print(nbsyl)
	print(struct)
	for word in Global.wordDictionnary.getAllWord():
		if(nbsyl.size() > 0  and nbsyl.find(word.getNbSyllable())!= -1) :
			#print("add : ",  word.getWord(),", ",word.getNbSyllable(),", ",word.getSyllableStruct())
			resultat.append(word)
		if(struct.size() > 0  and (struct.find(word.getSyllableStruct().to_upper()) != -1)) :
			#print("add :",  word.getWord(),", ",word.getNbSyllable(),", ",word.getSyllableStruct())
			if(resultat.find(word) == -1):
				resultat.append(word)
	var tmp = resultat.duplicate()
	for word in tmp :
		if(struct.size() > 0  and !(struct.find(word.getSyllableStruct().to_upper()) != -1)):
			#print("remove struct :",  word.getWord(),", ",word.getNbSyllable(),", ",word.getSyllableStruct())
			resultat.remove(resultat.find(word))
		if(nbsyl.size() > 0  and !(nbsyl.find(word.getNbSyllable())!= -1)) :
			#print("remove syll : ", word.getWord(),", ",word.getNbSyllable(),", ",word.getSyllableStruct())
			resultat.remove(resultat.find(word))
	return resultat

func _onCheckButtonPressed(extra_arg_0):
	pass # Replace with function body.


var swiping = false
var release = false
var isswipping = false
var swipe_start
var swipe_mouse_start
var swipe_mouse_times = []
var swipe_mouse_positions = []
	
	
func _on_ScrollContainer_gui_input(ev):
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

func removeAllChildren(nameNode):
	# remove all children of nameNode
	for i in range(0, find_node(nameNode).get_child_count()):
		find_node(nameNode).get_child(i).queue_free()

func _on_Popup_popup_hide():
	removeAllChildren("VBoxPopup")
	if(find_node("Popup") != null) :
		find_node("Popup").visible = false
		find_node("ConfirmationPopup").visible = false
		find_node("Background").visible = false 

func _on_Confirm_pressed():
	if(wordFinal.size() > 0) :
		var creation = CreationExercise.new()
		print("Creation of custom exercise")
		Global.customExercise = creation.creationExercise(Global.customExercise, wordFinal)
		print("Creation of goose exercise")
		Global.gooseExercise = creation.creationExercise(Global.gooseExercise, wordFinal)
		print("Creation of memory exercise")
		Global.listenExercise = creation.creationExercise(Global.listenExercise, wordFinal)
		print("Creation of third exercise")
		Global.thirdExercise = creation.creationExercise(Global.thirdExercise, wordFinal)
		_on_Popup_popup_hide()
		find_node("Background").visible = true
		find_node("ConfirmationPopup").popup_centered_ratio(0.75)
		find_node("ConfirmationPopup").visible = true
		find_node("Timer").start(1.5)
	else :
		removeAllChildren("VBoxPopup")
		var label = Label.new()
		label.align = Label.ALIGN_CENTER
		label.text = "Il n'y a pas de mots"
		find_node("VBoxPopup").add_child(label)



func _on_Timer_timeout():
	find_node("Background").visible = false
	find_node("ConfirmationPopup").visible = false
