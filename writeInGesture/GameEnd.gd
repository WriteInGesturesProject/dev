extends Control

const Exercise = preload("res://Exercise.gd")
var Ex : Exercise

# Called when the node enters the scene tree for the first time.
func _ready():
	Ex = Global.current_ex
	
	if(Ex == null):
		print("Ex in GameEnd is null")
		return
	
	var total = Ex.getNbWords()
	if(Global.play == 2):
		total /= 3
	var percent : float = float(Global.score) / total * 100
	var comment = ""
	if(percent < 50):
		comment = "Dommage, essaye encore !"
	else:
		comment = "Bravo !!"
	find_node("Comment").set_text(comment)
	find_node("Score").set_text("Ton score est de " + str(Global.score) + " sur " + str(total) + " soit " + str(int(percent)) + "%")
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
	find_node("Success").set_text("Tu as fini cet exercice " + str(Ex.getNbSuccess()) + " fois")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Home_pressed():
	get_tree().change_scene("res://home.tscn")
