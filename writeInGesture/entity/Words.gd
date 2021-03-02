extends Node

class_name Words

var listPath: String setget set_list_path, get_list_path
var listName: String setget set_list_name, get_list_name
var listIconPath: String setget set_list_icon_path, get_list_icon_path
var words: Array setget set_words, get_words

func set_list_path(_listPath: String) -> void:
	listPath = _listPath

func get_list_path() -> String:
	return listPath

func set_list_name(_listName: String) -> void:
	listName = _listName

func get_list_name() -> String:
	return listName

func set_list_icon_path(_listIconPath: String) -> void:
	listIconPath = _listIconPath

func get_list_icon_path() -> String:
	return listIconPath

func set_words(_words: Array) -> void:
	words = _words

func get_words() -> Array:
	return words.duplicate(true)

func add_word(word: Word) -> bool:
	#TODO: Make sure a word is added correctly
	words.append(word)
	return true

func erase_word(word: Word) -> bool:
	#TODO: Make sure a word is erased correctly
	words.erase(word)
	return true

func remove_word(position: int) -> bool:
	#TODO: Make sure a word is removed correctly
	words.remove(position)
	return true

func to_string() -> String:
	var result := ""
	result += "listName: " + listName + "\n"
	result += "listPath: " + listPath + "\n"
	result += "==== words ====\n"
	for word in words:
		result += word.to_string() + "==== ==== ====\n"
	return result

func to_dictionary() -> Dictionary:
	var result := {}
	result["listPath"] = listPath
	result["listName"] = listName
	result["listIconPath"] = listIconPath
	result["words"] = []
	for word in words:
		result["words"].append(word.to_dictionary())
	return result

func from_dictionary(content: Dictionary) -> Words:
	listPath = content["listPath"]
	listName = content["listName"]
	listIconPath = content["listIconPath"]
	words = []
	for word in content["words"]:
		words.append(Word.new().from_dictionary(word))
	return self
