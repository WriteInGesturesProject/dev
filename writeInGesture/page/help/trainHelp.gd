extends Control

var margin = 0.05
var vectorMarge

var array : Array
var title : String
var currenSound = 0
var currentPage = 0


var goodAnswer = [0, 0]

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(Global.manageInstruction.instruction("trainHelp"))
	#Setup the current sound
	setUpSound()
#
	
func setUpSound():
	if(currenSound ==0) :
		find_node("LastOne").modulate.a = 0.2
	elif(currenSound == array.size()-1):
		find_node("NextOne").modulate.a = 0.2
	else :
		find_node("NextOne").modulate.a = 1
		find_node("LastOne").modulate.a = 1
	
	##Choose 2 sound, One right, One wrong 
	var rightSound = array[currenSound]
	var wrongSound = findOtherSound(rightSound, array)

	var rightImage = load("res://art/imgBorel/"+rightSound["ressource_path"])
	var wrongImage = load("res://art/imgBorel/"+wrongSound["ressource_path"])
	
	placeImageRandomly(rightImage, wrongImage)
	
	
	var listen = find_node("ListenAudio")
	var nameAudio = rightSound["ressource_path"].split(".")[0]
	print(nameAudio)
	listen.stream = load("res://art/videoBorel/"+nameAudio+".ogv")
	
	
func findOtherSound(sound : Dictionary, array : Array):
	var rand = randi() % (array.size())
	var current = array[rand]
	while(sound["phonetic"] == current["phonetic"]) :
		rand = randi() % (array.size())
		current = array[rand]
	return current 
	

func placeImageRandomly(right, wrong):
	var rand = randi() % (2)
	goodAnswer[rand] = 1
	if(rand == 0):
		goodAnswer[1] = 0
		goodAnswer[0] = 1
		find_node("BorelLeft").texture = right
		find_node("BorelRight").texture = wrong
	else :
		goodAnswer[1] = 1
		goodAnswer[0] = 0
		find_node("BorelLeft").texture = wrong
		find_node("BorelRight").texture = right

	find_node("ValidateRight").visible = false
	find_node("ValidateLeft").visible = false
	
func _on_LastOne_pressed():
	if(currenSound>0):
		currenSound -= 1
		setUpSound()


func _on_NextOne_pressed():
	if(currenSound<array.size()-1):
		currenSound += 1
		setUpSound()



func _on_Back_pressed():
	if(find_node("ListenAudio") != null) :
		find_node("ListenAudio").paused = true
	var scene = load("res://page/navigation/navigationHelp.tscn").instance()
	scene.currentPage = currentPage
	get_tree().get_root().add_child(scene)


func _on_Listen_pressed():
	find_node("ListenAudio").play()



	
func _on_Panel_gui_input(event):
	if(event is InputEventMouseButton) :
		print(goodAnswer[0])
		if(goodAnswer[0]):
#			"goodanser"
			find_node("ValidateLeft").texture = load("res://assets/icons/check.png")
			find_node("ValidateLeft").visible = true
		else :
#			wrong answer
			find_node("ValidateLeft").texture = load("res://assets/icons/cancel.png")
			find_node("ValidateLeft").visible = true

func _on_Panel2_gui_input(event):
	if(event is InputEventMouseButton) :
		print(goodAnswer[1])
		if(goodAnswer[1]):
#			"goodanser"
			find_node("ValidateRight").texture = load("res://assets/icons/check.png")
			find_node("ValidateRight").visible = true
		else :
#			wrong answer
			find_node("ValidateRight").texture = load("res://assets/icons/cancel.png")
			find_node("ValidateRight").visible = true
