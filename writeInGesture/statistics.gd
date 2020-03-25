extends Control

const Exercise = preload("res://Exercise.gd")

var exerciseSelected : Exercise
var difficultySelected : int
var percentages : Array
var wordsEasier : Array
var wordsHarder : Array
var allWords : Array

var progressBarNode : Node
var exerciseChoiceNode : Node
var difficultyChoiceNode : Node
var exerciseMostPlayed : Exercise
var sizeViewPort : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	print(Global.exercises[5])
	print(Global.listenExercise)
	find_node("back").rect_size = Vector2(get_viewport().size.y*0.15, get_viewport().size.y*0.15)
	Global.make_margin(find_node("Main"), 0.015)
	sizeViewPort = get_viewport().size
	findExerciseMostPlayer(Global.exercises)
	find_node("mostPlayed").text = "Le jeu le plus joué est le jeu : "+exerciseMostPlayed.getName()+", joué : "+String(exerciseMostPlayed.getNbSuccess())+" fois."
	exerciseChoiceNode = find_node("exerciseChoice")
	exerciseChoiceNode.text = "Choisis un exercice"
	exerciseChoiceNode.add_item("Choisis un exercice")
	exerciseChoiceNode.rect_min_size.y = sizeViewPort.y*0.1
	for exercise in Global.exercises:
		exerciseChoiceNode.add_item(exercise.name)
		
	difficultyChoiceNode = find_node("difficultyChoice")
	difficultyChoiceNode.text = "Choisis une difficulté"
	difficultyChoiceNode.add_item("Choisis une difficulté")
	difficultyChoiceNode.rect_min_size.y = sizeViewPort.y*0.1
	for index in range(0, Global.nbDifficulty):
		difficultyChoiceNode.add_item(String(index+1))
	
	progressBarNode = find_node("ProgressBar")

func findExerciseMostPlayer(exercises : Array):
	exerciseMostPlayed = exercises[0]
	for exercise in exercises:
		if exerciseMostPlayed.getNbSuccess() < exercise.getNbSuccess():
			exerciseMostPlayed = exercise

func _on_exerciseChoice_item_selected(id):
	var selectedIndex = exerciseChoiceNode.selected
	var itemSelected = exerciseChoiceNode.get_item_text(selectedIndex)
	if selectedIndex != 0 : 
		for exercise in Global.exercises:
			if exercise.name == itemSelected : 
				exerciseSelected = exercise
				if exerciseSelected.getType().getName() == "Entrainement":
					clean()
					difficultyChoiceNode.visible = false
					difficultySelected = 1
					displayStatisticsAllWords()
					progressBarNode.value = exerciseSelected.getSuccessPercentage(difficultySelected-1)
					progressBarNode.visible = true
					displayStatisticsWordsEasierHarder(3)
				else :
					clean()
					progressBarNode.visible = false
					difficultyChoiceNode.visible = true
					difficultyChoiceNode.select(0)
				return;
	progressBarNode.visible = false
	clean()

func _on_difficultyChoice_item_selected(id):
	clean()
	var selectedIndex = difficultyChoiceNode.selected
	difficultySelected = int(difficultyChoiceNode.get_item_text(selectedIndex))
	if selectedIndex != 0 : 
		displayStatisticsAllWords()
		progressBarNode.value = exerciseSelected.getSuccessPercentage(difficultySelected-1)
		progressBarNode.visible = true
		displayStatisticsWordsEasierHarder(3)
	else :
		progressBarNode.visible = false

func displayStatisticsWordsEasierHarder(nbMin : int):
	var nodeRootHarder = find_node("wordsHarder")
	var nodeRootEasier = find_node("wordsEasier")
	
	var titleHarder = Label.new()
	titleHarder.text = "Les mots les moins réussi :"
	nodeRootHarder.add_child(titleHarder)
	
	var titleEasier = Label.new()
	titleEasier.text = "Les mots les plus réussi :"
	nodeRootEasier.add_child(titleEasier)
	
	nodeRootHarder.visible = true
	var harder : Array
	var easier : Array
	var tmpIncrease = percentages.duplicate()
	tmpIncrease.sort()
	var tmpDecrease = tmpIncrease.duplicate()
	tmpDecrease.invert()
	for i in range(0,nbMin):
		harder.append(tmpIncrease[i])
		easier.append(tmpDecrease[i])
	
	for current in range(0, nbMin):
		var index = 0
		for percentage in percentages :
			if percentage == harder[current]:
				wordsHarder.append(index)
				var label = Label.new()
				label.text = allWords[index].getWord()+" avec "+String(int(percentage))+"% de réussite"
				nodeRootHarder.add_child(label)
				break;
			index += 1
		index = 0
		for percentage in percentages :
			if percentage == easier[current]:
				wordsEasier.append(index)
				var label = Label.new()
				label.text = allWords[index].getWord()+" avec "+String(int(percentage))+"% de réussite"
				nodeRootEasier.add_child(label)
				break;
			index += 1
func displayStatisticsAllWords():
	var title = Label.new()
	title.text = "Statistiques de tous les mots :"
	find_node("statsExercises").add_child(title)
	percentages.clear()
	allWords = exerciseSelected.getAllWords()
	var index = 0
	for word in allWords :
		var currentVbox = VBoxContainer.new()
		var wordLabel = Label.new()
		wordLabel.text = word.getWord()
		wordLabel.align = HALIGN_CENTER
		currentVbox.add_child(wordLabel)
		var nbOccurs = exerciseSelected.getNbWordOccurrence(difficultySelected-1, index)
		var nbSuccess = exerciseSelected.getWordSuccess(difficultySelected-1, index)
		var stats = Label.new()
		var currentpercentages = 0
		if nbOccurs != 0:
			currentpercentages = (float(nbSuccess)/float(nbOccurs))*100
			percentages.append(currentpercentages)
		else:
			percentages.append(0)
		var currentPercentage = ProgressBar.new()
		currentPercentage.value = int(currentpercentages)
		currentPercentage.size_flags_horizontal = SIZE_EXPAND_FILL
		var separator = ColorRect.new()
		separator.color = "bcdaf4"
		separator.size_flags_horizontal = SIZE_EXPAND_FILL
		separator.rect_min_size.y = 1
		stats.text = " - Succès : "+String(nbSuccess)+"/"+String(nbOccurs)+" = "+String(int(currentpercentages))+"%"
		currentVbox.add_child(currentPercentage)
		currentVbox.add_child(separator)
		currentVbox.add_constant_override("separation", 20)
		index += 1
		find_node("statsExercises").add_child(currentVbox)

func removeAllChildren(nameNode):
	# remove all children of node "statsExercises"
	for i in range(0, find_node(nameNode).get_child_count()):
		find_node(nameNode).get_child(i).queue_free()

func clean():
	removeAllChildren("statsExercises")
	removeAllChildren("wordsEasier")
	removeAllChildren("wordsHarder")

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
			if isswipping:
				release = true
			else:
				release = false
			swiping = false
			isswipping =false
