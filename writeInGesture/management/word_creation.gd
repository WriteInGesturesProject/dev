extends Control

const ARASAAC_API_PICTOGRAMS_ID := "_id"

var lexiqueLight

var currentWord: Word
var currentIcon: Image

func _find_word():
	$background/ScrollContainer/VBoxContainer/phonetic/phonetic.text = ""
	$background/ScrollContainer/VBoxContainer/nbSyllable/nbSyllable.text = ""
	$background/ScrollContainer/VBoxContainer/syllableStruct/syllableStruct.text =""
	$background/ScrollContainer/VBoxContainer/icon.texture = null
	currentWord = null
	currentIcon = null
	
	var word: String = $background/ScrollContainer/VBoxContainer/word/word.text
	word = word.to_lower()
	var resultWord: Word = Word.new()
	resultWord.word = word
	
	var databaseWordResult = Global.database.get_word(word)
	if databaseWordResult != null:
		pass
	else:
		if Global.lexiqueLight == null:
			var tmp := CSVFile.new()
			if tmp.load_file(Global.LEXIQUE_LIGHT_PATH) != OK:
				printerr("Error while trying to load the lexique light file")
				return
			Global.lexiqueLight = tmp
			lexiqueLight = tmp
		var dictionaryLexiqueLight: Dictionary = lexiqueLight.get_map()
		if dictionaryLexiqueLight.has(word):
			var lexiqueLightHeaders: Dictionary = lexiqueLight.get_headers()
			var resultLexique = dictionaryLexiqueLight[word]
			resultWord.phonetic = resultLexique[lexiqueLightHeaders[Global.LEXIQUE_HEADER_PHONETIC]]
			resultWord.nbSyllable = int(resultLexique[lexiqueLightHeaders[Global.LEXIQUE_HEADER_NB_SYLLABLE]])
			resultWord.syllableStruct = resultLexique[lexiqueLightHeaders[Global.LEXIQUE_HEADER_SYLLABLE_STRUCT]]
	
	$background/ScrollContainer/VBoxContainer/phonetic/phonetic.text = Global.convert_phonetic(resultWord.phonetic)
	$background/ScrollContainer/VBoxContainer/nbSyllable/nbSyllable.text = String(resultWord.nbSyllable)
	$background/ScrollContainer/VBoxContainer/syllableStruct/syllableStruct.text = resultWord.syllableStruct
	currentWord = resultWord
	
	var databaseIconResult = Global.database.get_icon(word)
	if databaseIconResult != null:
		pass
	else:
		var http_request = HTTPRequest.new()
		add_child(http_request)
		http_request.connect("request_completed", self, "_arasaac_pictograms_fr_bestsearch_request_completed")
		var http_error = http_request.request("https://api.arasaac.org/api/pictograms/fr/bestsearch/" + word)
		if http_error != OK:
			print("An error occurred in the HTTP request.")

func _arasaac_pictograms_fr_bestsearch_request_completed(_result, _response_code, _headers, body):
	var bodyResponseArray: Array = JSON.parse(body.get_string_from_utf8()).result
	if bodyResponseArray.size() != 0:
		var http_request = HTTPRequest.new()
		add_child(http_request)
		http_request.connect("request_completed", self, "_arasaac_pictograms_id_request_completed")
		var http_error = http_request.request("https://api.arasaac.org/api/pictograms/" + String(bodyResponseArray[0][ARASAAC_API_PICTOGRAMS_ID]))
		if http_error != OK:
			print("An error occurred in the HTTP request.")

func _arasaac_pictograms_id_request_completed(_result, _response_code, _headers, body):
	var image = Image.new()
	currentIcon = image
	var image_error = image.load_png_from_buffer(body)
	if image_error != OK:
		print("An error occurred while trying to display the image.")
	var texture = ImageTexture.new()
	texture.create_from_image(image)
	$background/ScrollContainer/VBoxContainer/icon.texture = texture

func _on_save_pressed():
	pass
