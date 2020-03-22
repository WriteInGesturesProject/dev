extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tts = null
var margin =0.05
var played = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#Initialize TextToSpeech
	if(Engine.has_singleton("GodotTextToSpeech")):
		tts = Engine.get_singleton("GodotTextToSpeech")
		tts.fireTTS()
	
	#Make margin
	Global.make_margin(find_node("MarginContainer"), margin)
	var ymainbox = get_viewport().size.y * (1-margin*2) 
	var xmainbox = get_viewport().size.x * (1-margin*2) 
	find_node("Title").rect_min_size.y = find_node("Back").rect_size.y - get_viewport().size.y * margin
	
	find_node("Title").get_font("font").size = find_node("Title").rect_min_size.y/2
	print(find_node("Title").rect_min_size.y/2)
	ymainbox -= find_node("Title").rect_min_size.y
	ymainbox -= find_node("EndBox").rect_size.y 
	
	#Put the Listen button on the right place
	find_node("Listen").rect_min_size = Vector2(ymainbox*0.2 ,ymainbox*0.2)
	ymainbox -= find_node("Listen").rect_min_size.y
	
	#Make separation
	find_node("VBoxContainer").add_constant_override("separation",ymainbox*0.05)
	ymainbox -= 2*find_node("VBoxContainer").get_constant("separation")
	
	#Place the Borel image on the right place
	var texture = find_node("Borel")
	texture.rect_size = Vector2(ymainbox, ymainbox) 
	texture.get_parent().rect_size = texture.rect_size
	
	#Place the Video Borel on the right place 
	var video = find_node("VideoPlayer")
	var realsize = video.rect_size
	video.expand = true
	video.rect_size = Vector2(ymainbox*(realsize.x/realsize.y), ymainbox) 
	find_node("Panel").rect_size = texture.rect_size
	var centervideo = (video.rect_size.y - video.rect_size.x)/2
	var centermarge = (xmainbox/2)*0.1
	video.rect_position = Vector2(xmainbox/2 + centermarge + centervideo,0)
	find_node("Panel").rect_position = Vector2(video.rect_position.x - centervideo, video.rect_position.y)
	texture.rect_position = Vector2(xmainbox/2 - ymainbox - centermarge ,0)

	
	find_node("MainBox").rect_min_size = Vector2(xmainbox, ymainbox) 


func _process(delta) : 
	if(!played):
		find_node("VideoPlayer").play()
		played = true 
	
func _on_Back_pressed():
	find_node("VideoPlayer").paused = true
	get_tree().change_scene("res://interfaceGestureImproved.tscn")
	
func _on_Speak_pressed():
	find_node("VideoPlayer").play()


func _on_VideoPlayer_gui_input(event):
	if(event is InputEventMouseButton) :
		find_node("VideoPlayer").play()
