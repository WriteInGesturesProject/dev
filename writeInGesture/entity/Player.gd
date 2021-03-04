extends Entity

class_name Player

var playerName: String setget set_player_name, get_player_name
var stars: int setget set_stars, get_stars
var ethnicity: int setget set_ethnicity, get_ethnicity
var gender: int setget set_gender, get_gender
var equipedItems: Array setget set_equiped_items, get_equiped_items
var unlockedItems: Array setget set_unlocked_items, get_unlocked_items
var listOfWords: Array setget set_list_of_words, get_list_of_words
var playerPath: String setget set_player_path, get_player_path

func _init():
	playerName = ""
	stars = 0
	ethnicity = 0
	gender = 0
	equipedItems = []
	unlockedItems = []
	listOfWords = []
	playerPath = ""

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

func set_equiped_items(_equipedItems: Array) -> void:
	equipedItems = _equipedItems

func get_equiped_items() -> Array:
	return equipedItems.duplicate(true)

func add_equiped_item(item: Item) -> bool:
	for i in equipedItems:
		if item.equals(i):
			return false
	equipedItems.append(item)
	return true

func remove_equiped_item(position: int) -> bool:
	if position < 0 or position >= equipedItems.size():
		return false
	equipedItems.remove(position)
	return true

func erase_equiped_item(item: Item) -> bool:
	for i in range(equipedItems.size()):
		if item.equals(equipedItems[i]):
			return remove_equiped_item(i)
	return false

func set_unlocked_items(_unlockedItems: Array) -> void:
	unlockedItems = _unlockedItems

func get_unlocked_items() -> Array:
	return unlockedItems.duplicate(true)

func add_unlocked_item(item: Item) -> bool:
	for i in unlockedItems:
		if item.equals(i):
			return false
	unlockedItems.append(item)
	return true

func remove_unlocked_item(position: int) -> bool:
	if position < 0 or position >= unlockedItems.size():
		return false
	unlockedItems.remove(position)
	return true

func erase_unlocked_item(item: Item) -> bool:
	for i in range(unlockedItems.size()):
		if item.equals(unlockedItems[i]):
			return remove_unlocked_item(i)
	return false

func set_list_of_words(_listOfWords: Array) -> void:
	listOfWords = _listOfWords

func get_list_of_words() -> Array:
	return listOfWords.duplicate(true)

func add_words(words: Words) -> bool:
	for w in listOfWords:
		if words.equals(w):
			return false 
	listOfWords.append(words)
	return true

func remove_words(position: int) -> bool:
	if position < 0 or position >= listOfWords.size():
		return false
	listOfWords.remove(position)
	return true

func erase_list_of_words(words: Words) -> bool:
	for i in range(listOfWords.size()):
		if words.equals(listOfWords[i]):
			return remove_words(i)
	return true

func set_player_path(_playerPath: String) -> void:
	playerPath = _playerPath

func get_player_path() -> String:
	return playerPath

func to_string() -> String:
	var result := ""
	result += "playerName: " + playerName + "\n"
	result += "stars: " + String(stars) + "\n"
	result += "ethnicity: " + String(ethnicity) + "\n"
	result += "gender: " + String(gender) + "\n"
	result += "==== equipedItems ==== \n"
	for item in equipedItems:
		result += item.to_string()
		result += "==== ==== ====\n"
	result += "==== unlockedItems ==== \n"
	for item in unlockedItems:
		result += item.to_string()
		result += "==== ==== ====\n"
	result += "==== listOfWords ==== \n"
	for words in listOfWords:
		result += words.to_string()
		result += "==== ==== ==== \n"
	return result

func to_dictionary() -> Dictionary:
	var result := {}
	result["playerName"] = playerName
	result["stars"] = stars
	result["ethnicity"] = ethnicity
	result["gender"] = gender
	result["playerPath"] = playerPath
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

func from_dictionary(content: Dictionary) -> Entity:
	playerName = content["playerName"]
	stars = content["stars"]
	ethnicity = content["ethnicity"]
	gender = content["gender"]
	playerPath = content["playerPath"]
	equipedItems = []
	for item in content["equipedItems"]:
		equipedItems.append(Item.new().from_dictionary(item))
	unlockedItems = []
	for item in content["unlockedItems"]:
		unlockedItems.append(Item.new().from_dictionary(item))
	listOfWords = []
	for words in content["listOfWords"]:
		listOfWords.append(Words.new().from_dictionary(words))
	
	return self
