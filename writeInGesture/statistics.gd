extends Control

const Exercise = preload("res://Exercise.gd")

var exerciseSelected : Exercise
var difficultySelected : int
var percentage : Array
var wordsEasier : Array
var wordsHarder : Array
var allWords : Array

var progressBarNode : Node
var exerciseChoiceNode : Node
var difficultyChoiceNode : Node
var exerciseMostPlayed : Exercise
# Called when the node enters the scene tree for the first time.
func _ready():
	findExerciseMostPlayer(Global.exercises)
	find_node("mostPlayed").text = "Le jeu le plus joué est le jeu : "+exerciseMostPlayed.getName()+", joué : "+String(exerciseMostPlayed.getNbSuccess())+" fois."
	exerciseChoiceNode = find_node("exerciseChoice")
	exerciseChoiceNode.text = "Choisi un exercice"
	exerciseChoiceNode.add_item("Choisi un exercice")
	for exercise in Global.exercises:
		exerciseChoiceNode.add_item(exercise.name)
		
	difficultyChoiceNode = find_node("difficultyChoice")
	difficultyChoiceNode.text = "Choisi une difficulté"
	difficultyChoiceNode.add_item("Choisi une difficulté")
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
					progressBarNode.value = exerciseSelected.getSucessPercentage(difficultySelected-1)
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
		progressBarNode.value = exerciseSelected.getSucessPercentage(difficultySelected-1)
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
	var tmp = percentage.duplicate()
	tmp.sort()
	for i in range(0,nbMin):
		harder.append(tmp[i])
		easier.append(tmp[i])
	for current in range(0, nbMin):
		for index in range (0,percentage.size()) :
			if percentage[index] == harder[current]:
				wordsHarder.append(index)
				var label = Label.new()
				label.text = allWords[index].getWord()+" avec "+String(int(percentage[index]))+"% de réussite"
				nodeRootHarder.add_child(label)
				break;

func displayStatisticsAllWords():
	var title = Label.new()
	title.text = "Statistiques de tous les mots :"
	find_node("statsExercises").add_child(title)
	percentage.clear()
	allWords = exerciseSelected.getAllWords()
	var index = 0
	for word in allWords :
		var hBox = HBoxContainer.new()
		var wordLabel = Label.new()
		wordLabel.text = word.getWord()
		hBox.add_child(wordLabel)
		var nbOccurs = exerciseSelected.getNbWordOccurrence(difficultySelected-1, index)
		var nbSuccess = exerciseSelected.getWordSuccess(difficultySelected-1, index)
		var stats = Label.new()
		var currentPercentage = 0
		if nbOccurs != 0:
			currentPercentage = (float(nbSuccess)/float(nbOccurs))*100
			percentage.append(currentPercentage)
		else:
			percentage.append(0)
		stats.text = " - Succès : "+String(nbSuccess)+"/"+String(nbOccurs)+" = "+String(int(currentPercentage))+"%"
		hBox.add_child(stats)
		index += 1
		find_node("statsExercises").add_child(hBox)

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
