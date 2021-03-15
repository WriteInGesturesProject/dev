extends Control

func _ready():
	#deal with the instruction
	var instruction = $Instruction
	instruction.setUp("home")
	$home.setup(Global.artiphonie.PATH_LEARNING, Global.artiphonie.PATH_TRAINING, Global.artiphonie.PATH_PLAYING, "artiphonie") 
