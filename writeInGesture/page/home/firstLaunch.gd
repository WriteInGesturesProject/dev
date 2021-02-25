extends Control

var hasToken = false
var url = "URL du site"
var buttonCheckPressed = false

func _ready():
	Global.manageDatabase.connect("checkTokenResponse", self, "token")
	pass # Replace with function body.


func _on_Button_pressed():

	if(hasToken && !buttonCheckPressed):
		Global.player.setId($NameLine.text)
		Global.manageDatabase.checkToken()
		buttonCheckPressed = true
		

	else :
		Global.player.setName($NameLine.text)
		$NameLine.text = ""
		$Panel/Text.text = "Entre le Token de ton orthophoniste"
		$Link.visible = true
		hasToken = true

func token(isGoodToken):
	if(isGoodToken):
		Global.manageDatabase.creationTabs()
		Global.config.setFirstLaunch(false)
	else :
		buttonCheckPressed = false
		$error.visible = true


func _on_Link_pressed():
	OS.shell_open(url)
