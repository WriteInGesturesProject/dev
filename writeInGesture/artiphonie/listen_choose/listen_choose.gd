extends Control

var CardSceneRessource = preload("res://artiphonie/listen_choose/card_listen_choose.tscn")

const NB_SCREEN_MAX = 10

var sizeCard : Vector2

var listOfUndoneWords : Array
var listOfUndoneSounds : Array

var cardToFind : Word

var nb_screen : int = 0
var nbRight : int = 0
var difficulty : String
var cardLayout : int

func _ready():
	#deal with the instruction
	var instruction = $Instruction
	instruction.setUp("listen_choose")
	
	var arguments = Global.get_arguments()
	difficulty = arguments[0]

	match difficulty:
		"[..] Phonetique":
			cardLayout = 0
			listOfUndoneWords = get_phonetic_list()
		"Facile":
			cardLayout = 1
			listOfUndoneWords = Global.activeList.words.duplicate(true)
		"Normal":
			cardLayout = 2
			listOfUndoneWords = Global.activeList.words.duplicate(true)
		"Difficile":
			cardLayout = 3
			listOfUndoneWords = Global.activeList.words.duplicate(true)
	
	
	
	#set up of the size of the cards
	var sizeScene = Vector2(self.rect_size.x,self.rect_size.y)
	sizeCard = Vector2(sizeScene.x/3, sizeScene.y*0.6)

	next_screen()
	
func next_screen():
	var currentCard
	#the game continue while we all the screen haven't been done
	#bt while there are still enough word available in listOfUndoneWords
	if(nb_screen < NB_SCREEN_MAX && listOfUndoneWords.size() >= 3):
		var wordsToShow = get_n_word_from_given_list(listOfUndoneWords,3)
		#for the 3 cards that will be displayed
		for i in range (0,3):
			currentCard = CardSceneRessource.instance()
			currentCard.name = String(i)
			find_node("cardGrid").add_child(currentCard)
			currentCard.setUpCard(wordsToShow[i], cardLayout, sizeCard)
			currentCard.connect("card_pressed", self, "_on_Validate_pressed")
		#choose randomly the card to find
		var cardAlea = randi() % 3
		cardToFind = wordsToShow[cardAlea]
		#delete the word to find to not choose it again
		listOfUndoneWords.erase(cardToFind)
		nb_screen +=1
	else :
		game_end()

#tell the word to find when the button is pressed
func _on_speak_pressed():
	if difficulty == "[..] Phonetique":
		$Sound.stream = load(str(Global.PHONETIC_VIDEO_PATH+cardToFind.word+Global.PHONETIC_VIDEO_EXTENSION))
		$Sound.play()
	else:
		match OS.get_name():
			"X11":
				Global.textToSpeech.speak(cardToFind.word, false)
			"Android":
				Global.textToSpeech.speakText(cardToFind.word)

#is called when a card is pressed
func _on_Validate_pressed(card):
	if(cardToFind.word == card.word.word):
		nbRight += 1
		find_node("Good").playing = true
	else : 
		find_node("Wrong").playing = true
	for i in range(0, $cardGrid.get_child_count()):
		$cardGrid.get_child(i).queue_free()
	next_screen()

#return n word from the fiven list
func get_n_word_from_given_list(list : Array , n: int) -> Array:
	var randomPositions: Array = []
	randomPositions.append(randi() % list.size())
	for i in range(n-1):
		var tmp = randi() % list.size()
		while tmp in randomPositions:
			tmp = (tmp + 1) % list.size()
		randomPositions.append(tmp)
	var result: Array = []
	for randomPosition in randomPositions:
		result.append(list[randomPosition])
	return result

func calculate_score():
	var score = (5 * nbRight)/nb_screen
	if score == 0:
		score+=1
	match difficulty:
		"Normal":
			score+=2
		"Difficile":
			score+=4
	return score
	
func game_end():
	var score = calculate_score()
	#args to send to game_end
	var args : Array = []
	args.append("res://artiphonie/listen_choose/listen_choose.tscn")
	args.append([difficulty])
	args.append("Ecoute et choisis")
	args.append("")
	args.append(score)
	args.append(12)
	Global.change_scene("res://shared/game_end/game_end.tscn", args)

func get_phonetic_list() -> Array:
	var dictionary = Global.phoneticTableResource.duplicate(true)
	var listOfSound : Array = []
	for sound in dictionary.keys():
		if dictionary[sound] != "":
			var w = Word.new()
			w.word = dictionary[sound]
			w.phonetic = sound
			w.iconPath = str("res://art/borel_maisony/icon/"+w.word+".png")
			listOfSound.append(w)
	return listOfSound
