extends Control

var time
var totalTime

var height
var heightPerSec 
var scrollvalue 
var firstTime = 1

signal on_Pass_Pressed()

func _ready():
	pass
	
func setUp(pageName: String) -> bool:
	if(Global.instructionAlreadyPlayed.has(pageName) || !Global.player.instruction):
		self.visible = false
		return false
	else:
		Global.instructionAlreadyPlayed.append(pageName)
		makeInstruction(pageName)
		return true

func _on_Button_pressed():
	self.visible = false
	$ListenInstruction.playing = false
	emit_signal("on_Pass_Pressed")

#deal with the text scroll
func _on_Timer_timeout():
	if(firstTime):
		height = $Panel/InstructionText.get_content_height()
		heightPerSec = height/totalTime
		$Panel/InstructionText.percent_visible = 0.0
		scrollvalue = -$Panel/InstructionText.get_v_scroll().page*0.6
		firstTime=0
	else:
		if(time>= totalTime):
			$Timer.stop()
			$ListenInstruction.playing = false
		time += 0.1
		$Panel/InstructionText.percent_visible = time / totalTime
		scrollvalue += heightPerSec/10
		if(scrollvalue >0):
			$Panel/InstructionText.get_v_scroll().value = scrollvalue

func makeInstruction(page : String):
	var file = File.new()
	var err = file.open("res://art/instruction/"+page+".json", file.READ)
	var json = file.get_as_text()
	file.close()
	var dict = JSON.parse(json).result
	var sound = dict["sound"]
	print(sound)
	var text = dict["text"]

	$ListenInstruction.stream = load("res://art/instruction/"+sound)
	$Panel/InstructionText.text = text
	time = 0.0
	totalTime = $ListenInstruction.stream.get_length()
	$Timer.start()
	$ListenInstruction.play()
