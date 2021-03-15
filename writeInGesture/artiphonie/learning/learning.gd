extends Control

func _ready():
	#deal with the instruction
	var instruction = $Instruction
	instruction.setUp("learning")
	
	var file = File.new()
	file.open(Global.artiphonie.PATH_PHONETIC_TABLE_SORTED, file.READ)
	var phoneticType: Dictionary = JSON.parse(file.get_as_text()).result
	for phoneticTypeName in phoneticType.keys():
		$learning.add_learning_element(phoneticTypeName,
		"res://artiphonie/learning/phonetic_page/phonetic_page.tscn",
		phoneticType[phoneticTypeName]["iconPath"],
		[phoneticTypeName, phoneticType[phoneticTypeName]["phonetics"]])
	
	
	
	

