extends Node

const PATH_GOOSE_GAME := "res://artiphonie/goosegame/gooseGame.tscn"
const PATH_LISTEN_CHOOSE := "res://artiphonie/listenchoose/listenChoose.tscn"
const PATH_MEMORY := "res://artiphonie/memory/memoryGame.tscn"

const PATH_LEARNING := "res://artiphonie/learning/learning.tscn"
const PATH_PLAYING := "res://artiphonie/playing/playing.tscn"

const PHONETIC_PICTURE_PATH := "res://art/imgBorel/"
const PATH_PHONETIC_TABLE := "res://data/phonetic_table.json"
var phonetic_table: Array

const WORD_ICON_PATH := "res://art/images/"

func _init():
	load_phonetic_table()

func load_phonetic_table() -> void:
	var file = File.new()
	file.open(PATH_PHONETIC_TABLE, file.READ)
	phonetic_table = JSON.parse(file.get_as_text()).result

func phonetic_to_array_picture_path(phonetic : String) -> Array:
	var arrayPicture = []
	var i = 0
	var ressourcePath = ""
	while (i < len(phonetic)):
		if(i + 1 < len(phonetic) and phonetic[i].to_ascii()[0] == 91 and phonetic[i + 1].to_ascii()[0] == 3):
			ressourcePath = "in.png"
			i += 1
		elif(i + 1 < len(phonetic) and phonetic[i].to_ascii()[0] == 84 and phonetic[i + 1].to_ascii()[0] == 3):
			ressourcePath = "on.png"
			i += 1
		elif(phonetic[i].to_ascii()[0] == 226):
			ressourcePath = "an.png"
		else :
			for p in phonetic_table:
				if phonetic[i] == p["phonetic"]:
					ressourcePath = p["ressource_path"] 
					break
		ressourcePath = PHONETIC_PICTURE_PATH + ressourcePath
		arrayPicture.append(ressourcePath)
		i += 1
	return arrayPicture

func get_word_icon(iconPath: String) -> Resource:
	return load(WORD_ICON_PATH + iconPath)

func check_words(sentence: String, word: Word) -> bool:
	var sentenceWords = sentence.split(" ")
	if(sentenceWords == null || len(sentenceWords) == 0):
		return false
	for w in sentenceWords:
		if(check_homonyms(w.to_lower(), word)):
			return true
	return false

func check_homonyms(sentenceWord: String, word: Word):
	if word == null:
		return false
	var homonyms = word.getHomonym()
	for h in homonyms:
		if sentenceWord == h.to_lower():
			return true
	return false
