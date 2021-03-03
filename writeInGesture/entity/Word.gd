extends Entity

class_name Word

var phonetic: String setget set_phonetic, get_phonetic
var word: String setget set_word, get_word
var iconPath: String setget set_icon_path, get_icon_path
var homonym: Array setget set_homonym, get_homonym
var nbSyllable: int setget set_nb_syllable, get_nb_syllable
var syllableStruct: String setget set_syllable_struct, get_syllable_struct
var vowelsType: String setget set_vowels_type, get_vowels_type
var consonantsType: String setget set_consonants_type, get_consonants_type

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

func set_homonym(_homonyme : Array) -> void:
	homonym = _homonyme

func get_homonym() -> Array :
	return homonym.duplicate(true)
	
func add_homonym(basic_word: String) -> void: 
	if not basic_word in homonym:
		homonym.append(basic_word)

func set_nb_syllable(_nbSyllable : int) -> void:
	nbSyllable = _nbSyllable

func get_nb_syllable() -> int:
	return nbSyllable

func set_syllable_struct(_syllableStruct: String) -> void:
	syllableStruct = _syllableStruct

func get_syllable_struct() -> String:
	return syllableStruct

func set_vowels_type(_vowelsType: String) -> void: 
	vowelsType = _vowelsType

func get_vowels_type() -> String:
	return vowelsType

func set_consonants_type(_consonantsType: String) -> void: 
	consonantsType = _consonantsType

func get_consonants_type() -> String:
	return consonantsType


func equals(otherWord: Word) -> bool:
	var result := true
	result = result and otherWord.word == word
	result = result and otherWord.phonetic == phonetic
	result = result and otherWord.iconPath == iconPath
	result = result and otherWord.nbSyllable == nbSyllable
	result = result and otherWord.syllableStruct == syllableStruct
	result = result and otherWord.vowelsType == vowelsType
	result = result and otherWord.consonantsType
	return result


func to_string() -> String : 
	var result :=""
	result += "word: " + word + "\n"
	result += "phonetic: " + phonetic + "\n"
	result += "iconPath: " + iconPath + "\n"
	result += "homonym: " + String(homonym) + "\n"
	result += "nbSyllable: " + String(nbSyllable) + "\n"
	result += "syllableStruct: " + syllableStruct + "\n"
	result += "vowelsType: " + vowelsType + "\n"
	result += "consonantsType: " + consonantsType + "\n"
	return result

func to_dictionary() -> Dictionary:
	var result ={}
	result["phonetic"]  = phonetic
	result["word"]  = word
	result["iconPath"]  = iconPath
	result["homonym"]  = homonym
	result["nbSyllable"]  = nbSyllable
	result["syllableStruct"]  = syllableStruct
	result["vowelsType"]  = vowelsType
	result["consonantsType"]  = consonantsType
	return result

func from_dictionary(content: Dictionary) -> Entity:
	phonetic = content["phonetic"]
	word = content["word"]
	iconPath = content["iconPath"]
	homonym = content["homonym"]
	nbSyllable = content["nbSyllable"]
	syllableStruct = content["syllableStruct"]
	vowelsType = content["vowelsType"]
	consonantsType = content["consonantsType"]
	return self
