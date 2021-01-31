extends Node

const Config = preload("res://entity/Config.gd")
##This Node manage current scene on the screen


var tree : Node
var conf : Config
var currentScene
var popup

func _ready():
	pass
	

func setUp():
	if(Global.os == "Android") :
		var permissions = Engine.get_singleton("AndroidPermissions")
		permissions.init(get_instance_id(), false)
		if(!permissions.isRecordAudioPermissionGranted()):
			changeScene("res://tools/ManagePermission.tscn")
		else:
			Global.config.setRecordPermission(true)
			Firstlaunch()
	else:
		Firstlaunch()

func Firstlaunch():
	if(Global.config.getFirstLaunch()):
		print(Global.config.getFirstLaunch())
		changeScene("res://page/home/firstLaunch.tscn")
	changeScene("res://page/home/home.tscn")


func screenResearchPopup():
	print("screenResearch")
	var root = Global.get_tree().get_root()
	var current_scene = root.get_child(root.get_child_count() - 1)
#	current_scene.addChild(Node.new())

func changeScene(scene : String):
	if(currentScene != null):
		currentScene.free()
	# Add it to the active scene, as child of root.
	Global.get_tree().change_scene(scene)
	



