extends Node

var instructionTab : Array
var wantInstruction : bool

func _ready():
	pass

func setUp():
	wantInstruction = Global.player.getInstruction()
	instructionTab = []

func listenInstruction(instruction):
	instructionTab.append(instruction)
	
func alreadyListenInstruction(instruction):
	return ((instructionTab.find(instruction) != -1) || (wantInstruction == false))
	
func makeInstruction(page : String):
	var file = File.new()
	var err = file.open("res://art/instruction/"+page+".json", file.READ)
	var json = file.get_as_text()
	file.close()
	var dict = JSON.parse(json).result
	var sound = dict["sound"]
	var text = dict["text"]
	
	var scene = load("res://page/instruction/instruction.tscn").instance()
	scene.find_node("ListenInstruction").stream = load("res://art/instruction/"+sound)
	scene.find_node("Text").text = text
	return scene
	
func instruction(scene : String):
	if(!alreadyListenInstruction(scene)):
		listenInstruction(scene)
		return makeInstruction(scene)
	else :
		return Node.new()
		
