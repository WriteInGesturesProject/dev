extends Node

class_name Player

var playerName: String setget set_player_name, get_player_name
var stars: int setget set_stars, get_stars
var ethnicity: int setget set_ethnicity, get_ethnicity
var gender: int setget set_gender, get_gender
var equipedItems: Array setget set_equiped_items, get_equiped_items
var unlockedItems: Array setget set_unlocked_items, get_unlocked_items
var listOfWords: Array setget set_list_of_words, get_list_of_words
var playerPath: String setget set_player_path, get_player_path

func set_player_name(_playerName: String) -> void:
	playerName = _playerName

func get_player_name() -> String:
	return playerName

func set_stars(_stars: int) -> void:
	stars = _stars

func get_stars() -> int:
	return stars

func set_ethnicity(_ethnicity: int) -> void:
	ethnicity = _ethnicity

func get_ethnicity() -> int:
	return ethnicity

func set_gender(_gender: int) -> void:
	gender = _gender

func get_gender() -> int:
	return gender

func set_equiped_items(_equipedItem: Array) -> void:
	equipedItem = _equipedItem

func get_equiped_items() -> Array:
	return equipedItem.duplicate(true)

func add_equiped_item(item) -> bool:
	#TODO: Make sure that you can't add two item of the same type
	equipedItem.append(item)
	return true

func remove_equiped_item(position: int) -> bool:
	#TODO: Make sure that the desired item is removed correctly
	equipedItem.remove(position)
	return true

func erase_equiped_item(item) -> bool:
	#TODO: Make sure that the disired item is erased correctly
	equipedItems.erase(item)
	return true

func set_unlocked_items(_equipedItem: Array) -> void:
	equipedItem = _equipedItem

func get_unlocked_items() -> Array:
	return equipedItem.duplicate(true)

func add_unlocked_item(item) -> bool:
	#TODO: Make sure that you can't add two item of the same item
	equipedItem.append(item)
	return true

func remove_unlocked_item(position: int) -> bool:
	#TODO: Make sure that the desired item is removed correctly
	equipedItem.remove(position)
	return true

func erase_unlocked_item(item) -> bool:
	#TODO: Make sure that the disired item is erased correctly
	equipedItems.erase(item)
	return true

func set_list_of_words(_listOfWords: Array) -> void:
	listOfWords = _listOfWords

func get_list_of_words() -> Array:
	return listOfWords.duplicate(true)

func add_words(words: Words) -> bool:
	#TODO: Make sure that words are added correctly (no name duplicate)
	listOfWords.append(words)
	return true

func remove_words(position: int) -> bool:
	#TODO: Make sure that words is removed correctly
	listOfWords.remove(position)
	return true

func erase_list_of_words(words: Words) -> bool:
	#TODO: Make sure that words is erased correctly
	listOfWords.erase(words)
	return true

func set_player_path(_playerPath: String) -> void:
	playerPath = _playerPath

func get_player_path() -> String:
	return playerPath

func to_string() -> String:
	var result := ""
	return result

func to_dictionary() -> Dictionary:
	var result := {}
	result["playerName"] = playerName
	result["stars"] = stars
	result["ethnicity"] = ethnicity
	result["gender"] = gender
	result["equipedItems"] = []
	for item in equipedItems:
		result["equipedItems"].append(item.to_dictionary())
	result["unlockedItems"] = []
	for item in unlockedItems:
		result["unlockedItems"].append(item.to_dictionary())
	result["listOfWords"] = []
	for words in listOfWords:
		result["listOfWords"].append(words.to_dictionary())
	return result

func from_dictionary(content: Dictionary) -> Item:
	playerName = content["playerName"]
	stars = content["stars"]
	ethnicity = content["ethnicity"]
	gender = content["gender"]
	equipedItems = []
	for item in content["equipedItems"]:
		equipedItems.append(Item.new().from_dictionary(item))
	unlockedItems = []
	for item in content["unlockedItems"]:
		unlockedItems.append(Item.new().from_dictionary(item))
	listOfWords = []
	for words in content["listOfWords"]:
		listOfWords.append(Words.new().from_dictionary(words))
	playerPath = content["playerPath"]
	return self
