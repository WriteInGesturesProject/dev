extends Entity

class_name Word

var phonetic: String setget set_phonetic, get_phonetic
var word: String setget set_word, get_word
var iconPath: String setget set_icon_path, get_icon_path

func _init():
	phonetic = ""
	word = ""
	iconPath = ""

func set_phonetic(_phonetic : String) -> void:
	phonetic = _phonetic

func get_phonetic() -> String:
	return phonetic

func set_word(_word : String) -> void:
	word = _word

func get_word() -> String:
	return word

func set_icon_path(_iconPath : String) -> void:
	iconPath = _iconPath

func get_icon_path() -> String:
	return iconPath


func equals(otherWord: Word) -> bool:
	var result := true
	result = result and otherWord.word == word
	result = result and otherWord.phonetic == phonetic
	result = result and otherWord.iconPath == iconPath
	return result


func to_string() -> String : 
	var result :=""
	result += "word: " + word + "\n"
	result += "phonetic: " + phonetic + "\n"
	result += "iconPath: " + iconPath + "\n"
	return result

func to_dictionary() -> Dictionary:
	var result ={}
	result["phonetic"]  = phonetic
	result["word"]  = word
	result["iconPath"]  = iconPath
	return result

func from_dictionary(content: Dictionary) -> Entity:
	phonetic = content["phonetic"]
	word = content["word"]
	iconPath = content["iconPath"]
	return self
