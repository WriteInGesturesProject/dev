extends Control

const PHONETIC_PAGE_PATH := "res://artiphonie/learning/phonetic_page/phonetic_page.tscn"

func _ready():
	var file = File.new()
	file.open(Global.artiphonie.PATH_PHONETIC_TABLE_SORTED, file.READ)
	var phoneticType: Dictionary = JSON.parse(file.get_as_text()).result
	for phoneticTypeName in phoneticType.keys():
		$learning.add_learning_element(phoneticTypeName,
		PHONETIC_PAGE_PATH,
		phoneticType[phoneticTypeName]["iconPath"],
		[phoneticTypeName, phoneticType[phoneticTypeName]["phonetics"]])
	
	
	
	

