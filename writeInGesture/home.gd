extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tts = null

# Called when the node enters the scene tree for the first time.
func _ready():
	#if(find_node("Picture").rect_size.x > int(get_viewport().size.y/10)):
	#if Global.get_text() != null and Global.get_avatar() != null:
#		find_node("NamePlayer").text=Global.get_text()
#		find_node("Picture").texture=Global.get_avatar()
#		find_node("Picture").rect_size.x = find_node("Change").rect_size.x
#		find_node("Picture").rect_size.y = find_node("Change").rect_size.x
	if(Engine.has_singleton("GodotTextToSpeech")):
		tts = Engine.get_singleton("GodotTextToSpeech")
		tts.fireTTS() # fires up the TextToSpeech engine

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Change_pressed():
	get_tree().change_scene("res://avatarspace.tscn")
	pass # Replace with function body.

func _on_Admin_pressed():
	find_node("Popup").popup_centered_ratio(0.75)
	find_node("backgroundDark").visible = true
	#get_tree().change_scene("res://speechTherapistMenu.tscn")

func _on_Play_pressed():
	get_tree().change_scene("res://GameChoose.tscn")


func _on_Help_pressed():
	get_tree().change_scene("res://interfaceGestureImproved.tscn")

func _on_SpeakTest_pressed():
	if(tts != null):
		tts.speakText("Ceci est un test pour la synthèse vocale !")


func _on_Popup_popup_hide():
	if(find_node("backgroundDark") != null):
		find_node("backgroundDark").visible = false

func _on_Training_pressed():
	get_tree().change_scene("res://ExerciceMenu.tscn")
