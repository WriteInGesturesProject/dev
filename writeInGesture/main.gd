extends Node

const firstLaunch := "res://page/home/firstLaunch.tscn"
const homePath := "res://page/home/home.tscn"

func _ready():
	match OS.get_name():
		"Android":
			var recordAudioPermission := false
			#We go through all the granted permission to see if the one for recording audio is granted
			for grantedPermissions in OS.get_granted_permissions():
				recordAudioPermission = recordAudioPermission or grantedPermissions == "android.permission.RECORD_AUDIO"
			#If not then we request it and wait for the user to accept it
			if !recordAudioPermission:
				OS.request_permission("RECORD_AUDIO")
				set_process(true)
			else:
				if(Engine.has_singleton("GodotTextToSpeech")):
					Global.textToSpeech = Engine.get_singleton("GodotTextToSpeech")
					Global.textToSpeech.fireTTS()
				else: #Error when launching GodotTextToSpeech
					OS.alert("L'application a rencontré une erreur avec son module \"text to speech\" et va s'arrété dans 10 secondes.", "Erreur")
					$quit_timer.start()
				if(Engine.has_singleton("GodotSpeech")):
					Global.speechToText = Engine.get_singleton("GodotSpeech")
				else: # Error when launching GodotSpeech
					OS.alert("L'application a rencontré une erreur avec son module \"speech to text\" et va s'arrété dans 10 secondes.", "Erreur")
					$quit_timer.start()
				launch()
		_: #default
			launch()

func _process(delta):
	match OS.get_name():
		"Android":
			for grantedPermissions in OS.get_granted_permissions():
				if grantedPermissions == "android.permission.RECORD_AUDIO":
					set_process(false)
					OS.alert("L'application va s'arrété dans 10 secondes pour appliquer la permission. Veuillez le relancer.", "Redémarrage requis")
					$quit_timer.start()
		_: #default
			set_process(false)

func launch() -> void:
	if(Global.config.getFirstLaunch()):
		Global.change_scene("res://page/home/firstLaunch.tscn")
	Global.change_scene("res://page/home/home.tscn")

func _on_quit_timer_timeout() -> void:
	get_tree().quit()
