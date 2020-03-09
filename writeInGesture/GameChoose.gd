extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.game = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GooseGame_pressed():
	Global.play = 1
	Global.current_ex = Global.gooseExercise
	get_tree().change_scene("res://GameLevel.tscn")


func _on_ListenChoose_pressed():
	Global.play = 2
	Global.score = 0 # _ready func is called every games
	Global.current_ex = Global.listenExercise
	get_tree().change_scene("res://GameLevel.tscn")


func _on_MemoryGame_pressed():
	Global.play = 3
	Global.score = 0
	Global.current_ex = Global.memoryExercise
	get_tree().change_scene("res://MemoryGame.tscn")


func _on_Back_pressed():
	get_tree().change_scene("res://home.tscn")



