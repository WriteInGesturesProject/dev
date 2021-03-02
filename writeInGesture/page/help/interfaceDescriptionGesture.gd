extends Control

var textToSpeech = null
var margin =0.05
var played = false
var currentPage

var array : Array
var title : String

func _ready():
	#Initialize TextToSpeech
	if(Engine.has_singleton("GodotTextToSpeech")):
		textToSpeech = Engine.get_singleton("GodotTextToSpeech")
		textToSpeech.fireTTS()

func _process(delta) : 
	if(!played):
		find_node("VideoPlayer").play()
		played = true 
	
func _on_Back_pressed():
	find_node("VideoPlayer").paused = true
	var scene = load("res://page/help/interfaceGesture.tscn").instance()
	scene.array = array
	scene.title = title
	scene.currentPage = currentPage
	get_tree().get_root().add_child(scene)

func _on_Speak_pressed():
	find_node("VideoPlayer").play()


func _on_VideoPlayer_gui_input(event):
	if(event is InputEventMouseButton) :
		find_node("VideoPlayer").play()
