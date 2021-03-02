extends Control

var time
var totalTime

var height
var heightPerSec 
var scrollvalue 
var firstTime = 1

signal on_Pass_Pressed()

func _ready():
	time = 0.0
	totalTime = $ListenInstruction.stream.get_length()

	$ListenInstruction.play()
	
	
	$Timer.start()
	

func _on_Button_pressed():
	self.visible = false
	$ListenInstruction.playing = false
	emit_signal("on_Pass_Pressed")


func _on_Timer_timeout():
	if(firstTime):
		height = $Panel/Text.get_content_height()
		heightPerSec = height/totalTime
		$Panel/Text.percent_visible = 0.0
		scrollvalue = -$Panel/Text.get_v_scroll().page*0.6
		firstTime=0
		print("aqui")
	else:
		if(time>= totalTime):
			$Timer.stop()
			$ListenInstruction.playing = false
		time += 0.1
		$Panel/Text.percent_visible = time / totalTime
		scrollvalue += heightPerSec/10
		if(scrollvalue >0):
			$Panel/Text.get_v_scroll().value = scrollvalue
	
