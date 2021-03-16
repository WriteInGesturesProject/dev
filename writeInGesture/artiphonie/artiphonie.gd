extends Control

func _ready():
	#deal with the instruction
	$Instruction.setUp("home")
	$home.setup(Global.artiphonie.PATH_LEARNING, Global.artiphonie.PATH_TRAINING, Global.artiphonie.PATH_PLAYING, "artiphonie") 
