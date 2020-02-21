extends Control

const Exercise = preload("res://Exercise.gd")
var Ex : Exercise

# Called when the node enters the scene tree for the first time.
func _ready():
	# Check if the game finished is a Training
	match Global.game:
		1:
			Ex = Global.customExercise
		2:
			Ex = Global.countExercise
		3:
			Ex = Global.weekExercise
		4:
			Ex = Global.colorExercise

	# Check if the game finished is a Game
	match Global.play:
		1:
			Ex = Global.gooseExercise
		2:
			Ex = Global.listenExercise
		3:
			Ex = Global.thirdExercise
	
	if(Ex == null):
		print("Ex in GameEnd is null")
		return
	
	var percent : float = float(Global.score) / Ex.getNbWords() * 100
	var comment = ""
	if(percent < 50):
		comment = "Dommage, essaye encore !"
	else:
		comment = "Bravo !!"
	find_node("Comment").set_text(comment)
	find_node("Score").set_text("Ton score est de " + str(Global.score) + " sur " + str(Ex.getNbWords()) + " soit " + str(int(percent)) + "%")
	if(Ex.getSuccessPercentage(Global.level) < percent):
		Ex.setSuccessPercentage(Global.level, percent)
	find_node("BestScore").set_text("Ton meilleur score est de " + str(int(Ex.getSuccessPercentage(Global.level))) + "%")
	
	var success = true
	for i in Global.try:
		if(!i):
			success = false
			break
	if(success):
		Ex.setNbSuccess(Ex.getNbSuccess() + 1)
	find_node("Success").set_text("Tu a fini cet exercice " + str(Ex.getNbSuccess()) + " fois")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Home_pressed():
	get_tree().change_scene("res://home.tscn")
