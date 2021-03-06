extends Control

const MyDictionnary = preload("res://entity/Dictionnary.gd")
const Exercise = preload("res://entity/Exercise.gd")
const TypeExercise = preload("res://entity/TypeExercise.gd")
const CreationExercise = preload("res://tools/CreationExercise.gd")

var buttonPress = []
var syllable =["Monosyllabe", "Bisyllabe", "Trisyllabe", "Quadrisyllabe", "Pentasyllabe",]
var struct =["CV","CVV","CVC"]
var wordFinal =[]
var lineStruct

var margin = 0.05
var marginVector 

func _ready():
	Global.make_margin(find_node("Margin"), margin)
	marginVector = (get_viewport().size)*(1- margin)
	
	#Put responsive Vbox
	find_node("HBoxMain").add_constant_override("separation", marginVector.x/6)
	var ybox = marginVector.y*0.75
	var yrest = marginVector.y*0.25
	find_node("NbSyllableContainer").rect_min_size = Vector2(marginVector.x/3,ybox)
	find_node("StructSyllableContainer").rect_min_size = Vector2(marginVector.x/3,ybox)
	
	yrest = yrest - find_node("Label").rect_size.y
	find_node("Creation").rect_min_size.y = yrest/2
	yrest = yrest/2
	find_node("Main").add_constant_override("separation", yrest/3)
	
	##Creation of all the columns for syllable 
	for el in range (0,syllable.size()) :
		var button = CheckBox.new()
		button.name = String(el+1)
		button.text = syllable[el]
		button.flat = false
		button.rect_min_size = Vector2(0,marginVector.y*0.75/(syllable.size()/0.75))
		button.align = Button.ALIGN_CENTER
		button.theme = load("res://assets/theme/ButtonTheme.tres")
		find_node("NbSyllableContainer").add_child(button)
		buttonPress.append(button)
		ybox = ybox - button.rect_size.y
	
	find_node("NbSyllableContainer").add_constant_override("separation", ybox/(syllable.size()+2))
	ybox = marginVector.y*0.75
	
	##Creation of all the columns for struct 
	for el in struct :
		var button = CheckBox.new()
		button.name = el
		button.text = el
		button.flat = false
		button.theme = load("res://assets/theme/ButtonTheme.tres")
		button.rect_min_size = Vector2(0,marginVector.y*0.75/(syllable.size()/0.75))
		button.align = Button.ALIGN_CENTER
		find_node("StructSyllableContainer").add_child(button)
		buttonPress.append(button)
		ybox = ybox - button.rect_size.y
	
	var vbox = VBoxContainer.new()
	var labelStruct = Label.new()
	labelStruct.text = "Autre"
	find_node("StructSyllableContainer").add_child(vbox)
	lineStruct = LineEdit.new()
	lineStruct.max_length = 20
	ybox = ybox - labelStruct.rect_size.y
	ybox = ybox - lineStruct.rect_size.y
	vbox.add_child(labelStruct)
	vbox.add_child(lineStruct)
	
	find_node("StructSyllableContainer").add_constant_override("separation", ybox/(struct.size()+4))

func _on_retour_pressed():
	Global.change_scene("res://page/navigation/speechTherapistMenu.tscn")


#When we created a new exercice we call this function 
func _on_Creation_pressed():
	##We find the parameter of the exercice to create
	var wordtoFind = []
	for button  in buttonPress:
		if(button.pressed) :
			wordtoFind.append(button.name)
	if(lineStruct.text.length()>0):
			wordtoFind.append(lineStruct.text)
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
	
##This function created a Array of word in function of the parameter wordtoFind
func searchWord(wordtoFind : Array):
	var nbsyl = []
	var struct = []
	var resultat =[]
	for el in wordtoFind :
		if(int(el)>0 and int(el)<syllable.size()+1) :
			nbsyl.append(int(el))
		else :
			struct.append(el.to_upper())
	for word in Global.wordDictionnary.getAllWord():
		if(nbsyl.size() > 0  and nbsyl.find(word.getNbSyllable())!= -1) :
			resultat.append(word)
		if(struct.size() > 0  and (struct.find(word.getSyllableStruct().to_upper()) != -1)) :
			if(resultat.find(word) == -1):
				resultat.append(word)
	var tmp = resultat.duplicate()
	for word in tmp :
		if(struct.size() > 0  and !(struct.find(word.getSyllableStruct().to_upper()) != -1)):
			resultat.remove(resultat.find(word))
		if(nbsyl.size() > 0  and !(nbsyl.find(word.getNbSyllable())!= -1)) :
			resultat.remove(resultat.find(word))
	return resultat

func _onCheckButtonPressed(extra_arg_0):
	pass # Replace with function body.
	

func removeAllChildren(nameNode):
	# remove all children of nameNode
	if(find_node(nameNode) != null):
		for i in range(0, find_node(nameNode).get_child_count()):
			find_node(nameNode).get_child(i).queue_free()

func _on_Popup_popup_hide():
	removeAllChildren("VBoxPopup")
	if(find_node("Popup") != null) :
		find_node("Popup").visible = false
		find_node("ConfirmationPopup").visible = false
		find_node("Background").visible = false 

func _on_Confirm_pressed():
	var creation = CreationExercise.new()
	if(wordFinal.size() >= 3) :
		creation.updateExercises(wordFinal)
		_on_Popup_popup_hide()
		find_node("Background").visible = true
		find_node("ConfirmationPopup").popup_centered_ratio(0.75)
		find_node("ConfirmationPopup").visible = true
		find_node("Timer").start(1.5)
	else :
		removeAllChildren("VBoxPopup")
		var label = Label.new()
		label.align = Label.ALIGN_CENTER
		label.text = "Veuillez au minimum faire un exercice avec au moins trois mots "
		find_node("VBoxPopup").add_child(label)



func _on_Timer_timeout():
	find_node("Background").visible = false
	find_node("ConfirmationPopup").visible = false

################################################################SCROLLING###################################################
var swiping = false
var release = false
var isswipping = false
var swipe_start
var swipe_mouse_start
var swipe_mouse_times = []
var swipe_mouse_positions = []
	
	
func _on_ScrollContainer_gui_input(ev):
	##print(ev)
	if swiping and ev is InputEventMouseMotion:
		var delta = ev.position - swipe_mouse_start
		##print(delta.length())
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

################################################################SCROLLING###################################################




func _on_Label_pressed():
	if(find_node("Popup") != null) :
		find_node("Popup").visible = false
		find_node("ConfirmationPopup").visible = false
		find_node("Background").visible = false 
