extends Control

var pronouncingRessource := load(Global.artiphonie.PATH_PRONOUNCING)

func _ready():
	setup()

func setup():
	#deal with the instruction	
	var instruction = $Instruction
	instruction.setUp("train")
	
	var cmpt = 0
	for word in Global.activeList.words:
		var newPronouncing = pronouncingRessource.instance()
		newPronouncing.setup(word, 1)
		$ScrollContainer/words.add_child(newPronouncing)
		cmpt += 1
