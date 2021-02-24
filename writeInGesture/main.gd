extends Node

func _ready():
	if(Global.os == "Android"):
		var recordAudioPermission = false
		for grantedPermissions in OS.get_granted_permissions():
			recordAudioPermission = recordAudioPermission or grantedPermissions == "android.permission.RECORD_AUDIO"
		if !recordAudioPermission:
			OS.request_permission("RECORD_AUDIO")
			set_process(true)
		else:
			first_launch()
	#first_launch()

func _process(delta):
	for grantedPermissions in OS.get_granted_permissions():
		if grantedPermissions == "android.permission.RECORD_AUDIO":
			set_process(false)
			OS.alert("L'application va redémarrer dans 10 secondes pour appliquer la permission.", "Redémarrage imminent")
			$quit_timer.start()

func set_up_android():
	var permissions = Engine.get_singleton("AndroidPermissions")
	permissions.init(get_instance_id(), false)
	if(!permissions.isRecordAudioPermissionGranted()):
		Global.change_scene("res://tools/ManagePermission.tscn")
	else:
		Global.config.setRecordPermission(true)
		first_launch()

func first_launch():
	if(Global.config.getFirstLaunch()):
		Global.change_scene("res://page/home/firstLaunch.tscn")
	Global.change_scene("res://page/home/home.tscn")


func _on_quit_timer_timeout():
	get_tree().quit()
