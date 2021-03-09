extends Entity

class_name Word

var phonetic: String setget set_phonetic, get_phonetic
var word: String setget set_word, get_word
var homonym: Array setget set_homonym, get_homonym
var nbSyllable: int setget set_nb_syllable, get_nb_syllable
var syllableStruct: String setget set_syllable_struct, get_syllable_struct

func _init():
	phonetic = ""
	word = ""
	homonym = []
	nbSyllable = 0
	syllableStruct = ""

func set_phonetic(_phonetic : String) -> void:
	phonetic = _phonetic

func get_phonetic() -> String:
	return phonetic

func set_word(_word : String) -> void:
	word = _word

func get_word() -> String:
	return word

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


func equals(otherWord: Word) -> bool:
	var result := true
	result = result and otherWord.word == word
	result = result and otherWord.phonetic == phonetic
	result = result and otherWord.nbSyllable == nbSyllable
	result = result and otherWord.syllableStruct == syllableStruct
	return result


func to_string() -> String : 
	var result :=""
	result += "word: " + word + "\n"
	result += "phonetic: " + phonetic + "\n"
	result += "homonym: " + String(homonym) + "\n"
	result += "nbSyllable: " + String(nbSyllable) + "\n"
	result += "syllableStruct: " + syllableStruct + "\n"
	return result

func to_dictionary() -> Dictionary:
	var result ={}
	result["phonetic"]  = phonetic
	result["word"]  = word
	result["homonym"]  = homonym
	result["nbSyllable"]  = nbSyllable
	result["syllableStruct"]  = syllableStruct
	return result

func from_dictionary(content: Dictionary) -> Entity:
	phonetic = content["phonetic"]
	word = content["word"]
	homonym = content["homonym"]
	nbSyllable = content["nbSyllable"]
	syllableStruct = content["syllableStruct"]
	return self
