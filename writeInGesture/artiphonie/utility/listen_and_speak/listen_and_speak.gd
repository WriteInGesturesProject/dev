extends Control

var word: Word
var currentLayout: Control

func _ready():
	setup(Global.player.listOfWords[0].words[0], 1)

func setup(_word: Word, layout: int):
	word = _word
	currentLayout = find_node("layout_" + String(layout))
	
	currentLayout.find_node("word").text = word.word
	extract_borel_maisonny()
	currentLayout.find_node("picture").texture = Global.artiphonie.get_word_icon(word.iconPath)

func extract_borel_maisonny() -> void:
	for imgPath in Global.artiphonie.phonetic_to_array_picture_path(word.phonetic):
		add_borel_maisonny(currentLayout.find_node("borel_maisonny_container"), imgPath)

func add_borel_maisonny(container: HBoxContainer, imgPath: String) -> void:
	var newBorelMaisonny = TextureRect.new()
	newBorelMaisonny.expand = true
	newBorelMaisonny.stretch_mode = newBorelMaisonny.STRETCH_KEEP_ASPECT_CENTERED
	newBorelMaisonny.texture = load(imgPath)
	newBorelMaisonny.size_flags_horizontal = newBorelMaisonny.SIZE_SHRINK_CENTER
	var numberOtherBorelMaisonnyInContainer = container.get_child_count() + 1
	var maxSizeX = container.rect_min_size.x/numberOtherBorelMaisonnyInContainer
	var correctSize = min(maxSizeX, container.rect_min_size.y)
	newBorelMaisonny.rect_min_size.x = correctSize
	newBorelMaisonny.rect_min_size.y = correctSize
	for otherBorelMaisonny in container.get_children():
		otherBorelMaisonny.rect_min_size.x = correctSize
		otherBorelMaisonny.rect_min_size.y = correctSize
	container.add_child(newBorelMaisonny)

func _on_listen_pressed():
	match OS.get_name():
		"Android":
			Global.textToSpeech.speakText(word.word)

func _on_record_pressed():
	match OS.get_name():
		"Android":
			if not Global.speechToText.isListening():
				Global.speechToText.doListen()
				$Label.text = "Recording"
			else:
				Global.speechToText.stopListen()
				$Label.text = "Stopped recording"

func _process(delta):
	match OS.get_name():
		"Android":
			if Global.speechToText.isError():
				$Label.text = "Error" + String(Global.speechToText.getErrorState())
			if Global.speechToText.isDetectDone():
				$background/layout_1/word.text = "Detecter Youpi"
				var words = Global.speechToText.get_words()
				$Label.text = "words"
#				Global.speechToText.stopListen()
#				set_process(false)
