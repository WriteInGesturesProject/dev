extends Node

const firstLaunch := "res://page/home/firstLaunch.tscn"
const homePath := "res://page/home/home.tscn"

func _ready():
	if(Global.os == "Android"):
		var recordAudioPermission = false
		#We go through all the granted permission to see if the one for recording audio is granted
		for grantedPermissions in OS.get_granted_permissions():
			recordAudioPermission = recordAudioPermission or grantedPermissions == "android.permission.RECORD_AUDIO"
		#If not then we request it and wait for the user to accept it
		if !recordAudioPermission:
			OS.request_permission("RECORD_AUDIO")
			set_process(true)
		else:
			launch()
	else:
		launch()

func _process(delta):
	for grantedPermissions in OS.get_granted_permissions():
		if grantedPermissions == "android.permission.RECORD_AUDIO":
			set_process(false)
			OS.alert("L'application va redémarrer dans 10 secondes pour appliquer la permission.", "Redémarrage imminent")
			$quit_timer.start()

func launch():
	if(Global.config.getFirstLaunch()):
		Global.change_scene("res://page/home/firstLaunch.tscn")
	Global.change_scene("res://page/home/home.tscn")

func _on_quit_timer_timeout():
	get_tree().quit()
