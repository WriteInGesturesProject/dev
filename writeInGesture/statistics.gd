extends Control

const Exercise = preload("res://Exercise.gd")

var exerciseSelected : Exercise
var percentage : Array
# Called when the node enters the scene tree for the first time.
func _ready():
	var optionButton = find_node("exerciseChoice")
	optionButton.text = "Choisi un exercice"
	optionButton.add_item("Choisi un exercice")
	for exercise in Global.exercises:
		optionButton.add_item(exercise.name)

func _on_exerciseChoice_item_selected(id):
	var selected = find_node("exerciseChoice").selected
	var itemSelected = find_node("exerciseChoice").get_item_text(selected)
	for exercise in Global.exercises:
		if exercise.name == itemSelected : 
			exerciseSelected = exercise
			displayDifficultyChoice()
#			displayProgressBar()
#			displayStatisticsAllWords()
#			displayStatisticsWordsEasy()
			return;

func displayDifficultyChoice():
	find_node("difficultyChoice").visible = true
	

#func displayProgressBar():
	

func displayStatisticsWordsEasy():
	removeAllChildren("wordsEasy")
	print(percentage)

func displayStatisticsAllWords():
#	percentage.clear()
	removeAllChildren("statsExercises")
	var words = exerciseSelected.getAllWords()
	var index = 0
	for word in words:
		var hBox = HBoxContainer.new()
		var wordLabel = Label.new()
		wordLabel.text = word.getWord()
		hBox.add_child(wordLabel)
		var nbOccurs = exerciseSelected.getNbWordOccurrence(0, index)
		var nbSuccess = exerciseSelected.getWordSuccess(0, index)
		var stats = Label.new()
		var currentPercentage = 0
		if nbOccurs != 0:
			currentPercentage = (float(nbSuccess)/float(nbOccurs))*100
			percentage.append(currentPercentage)
		stats.text = " - Succès : "+String(nbSuccess)+"/"+String(nbOccurs)+" = "+String(int(currentPercentage))+"%"
		hBox.add_child(stats)
		index += 1
		find_node("statsExercises").add_child(hBox)

#func displayStatisticsWordsEasy():
func removeAllChildren(nameNode):
	# remove all children of node "statsExercises"
	for i in range(0, find_node(nameNode).get_child_count()):
		find_node(nameNode).get_child(i).queue_free()

func _on_back_pressed():
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
#			print("is swipping :",isswipping)
			if isswipping:
				release = true
			else:
				release = false
			swiping = false
			isswipping =false
