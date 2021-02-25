extends Control

var mainBox : VBoxContainer
var avatarBox : VBoxContainer
var orthoBox : VBoxContainer
var main : MarginContainer
var coinBox : HBoxContainer
var size : Vector2

func _ready():
	
	add_child(Global.manageInstruction.instruction("home"))
	
	find_node("LearnLabel").get_font("font").size = Global.paragraph -2
	#chrge name and avatar from json files
	find_node("NamePlayer").text=Global.player.getName()
	find_node("Picture").texture=load("res://art/users/"+Global.player.getPathPicture())
	find_node("Gold").text = str(Global.player.getGold())
	find_node("Silver").text = str(Global.player.getSilver())

# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	print(body)

func _on_Change_pressed():
	Global.change_scene("res://page/avatarspace/avatarSpace.tscn")

#display the popup for connexion by admin persons, here the doctor
func _on_Admin_pressed():
	if(Global.dev) :
		Global.change_scene("res://page/navigation/speechTherapistMenu.tscn")
	else : 
		find_node("Popup").popup_centered_ratio(0.75)
		find_node("backgroundDark").visible = true


func _on_Play_pressed():
	Global.change_scene("res://page/navigation/gameChoose.tscn")


func _on_Help_pressed():
	Global.change_scene("res://page/navigation/navigationHelp.tscn")


func _on_Popup_popup_hide():
	if(find_node("backgroundDark") != null):
		find_node("backgroundDark").visible = false


func _on_About_pressed():
	Global.change_scene("res://page/about/about.tscn")


func _on_Train_pressed():
	Global.manageGame.current_ex = Global.customExercise
	Global.manageGame.level = 0
	Global.manageGame.play = 0
	Global.manageGame.game = 0
	Global.manageGame.score = 0
	Global.manageGame.try = []
	Global.change_scene("res://page/train/train.tscn")


func _on_Daily_pressed():
	Global.initVoiceRecording()
	Global.change_scene("res://page/navigation/exerciceMenu.tscn")



func _on_back_pressed():
	if(find_node("Popup") != null) :
		find_node("Popup").visible = false
		find_node("PopupReset").visible = false
		find_node("backgroundDark").visible = false


func _on_Option_pressed():
	Global.change_scene("res://page/option/optionPage.tscn")
