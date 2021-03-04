extends Control

var word: Word
var currentLayout: Control

signal pronounced(word, result)

func _ready():
	set_process(false)

#_word: Word -> The word we want the user to pronounce
#layout: int -> [1:7] number of the layout we want to use (see below)
#layout = 1 -> sound + picture + borel maisonny sign
#layout = 2 -> sound + borel maisonny signs
#layout = 3 -> sound + picture
#layout = 4 -> sound
#layout = 5 -> picture + borel maisonny signs
#layout = 6 -> picture
#layout = 7 -> borel maisonny signs
func setup(_word: Word, layout: int = 1):
	word = _word
	currentLayout = find_node("layout_" + String(layout))
	currentLayout.visible = true
	$background/word.text = word.word
	extract_borel_maisonny()
	currentLayout.find_node("picture").texture = Global.artiphonie.get_word_icon(word.iconPath)

#This function extract all the borel maisonny sign picture out of all the
#phonetic symbol of our function
func extract_borel_maisonny() -> void:
	for imgPath in Global.artiphonie.phonetic_to_array_picture_path(word.phonetic):
		add_borel_maisonny(currentLayout.find_node("borel_maisonny_container"), imgPath)

#This function add a picture of a phonetic symbole in borel maisonny sign to
#a given container. Before adding the picture, the function resize all the other
#picture present in the container.
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
				currentLayout.find_node("record").modulate = Color(1,1,1,0.5)
				Global.speechToText.doListen()
				set_process(true)
			else:
				currentLayout.find_node("record").modulate = Color(1,1,1,1)
				Global.speechToText.stopListen()
				set_process(false)

#The _process function in this scene is used only for the speech to text,
#basicaly we wait for the user to have said something and when he has said
#something Global.speechToText.isDetectDone() will return true. Then we analyse
#what the user said and we do what we have to do if what the user said is right
#or wrong.
func _process(_delta):
	match OS.get_name():
		"Android":
			if Global.speechToText.isError():
				currentLayout.find_node("record").modulate = Color(1,1,1,0.5)
				Global.speechToText.stopListen()
				Global.speechToText.doListen()
			if Global.speechToText.isDetectDone():
				currentLayout.find_node("record").modulate = Color(1,1,1,1)
				var sentence = Global.speechToText.getWords()
				set_process(false)
				Global.speechToText.stopListen()
				if Global.artiphonie.check_words(sentence, word):
					$correct.playing = true
				else:
					$incorrect.playing = true

func _on_correct_finished():
	#We wait for the sound to finish before signaling of the result
	emit_signal("pronounced", word, true)
	pass

func _on_incorrect_finished():
	#We wait for the sound to finish before signaling of the result
	emit_signal("pronounced", word, false)
	pass
