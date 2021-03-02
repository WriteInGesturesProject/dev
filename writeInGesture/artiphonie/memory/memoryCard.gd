extends TextureButton

var textToSpeech = Global.textToSpeech
var imageWord : String
var imagePath : String
var cardPath = "res://assets/icons/card.png" # This is the path of the back of the card
var selected_cards : Array

signal end()

#Initialize a card with a word
func init(word, size, selected_cards : Array):
	if(word == null):
		return
	self.selected_cards = selected_cards
	set_normal_texture(load(cardPath))
	set_expand(true)
	set_stretch_mode(TextureButton.STRETCH_SCALE)
	scale_img(texture_normal.get_size(), size)
	imagePath = word.getPath()
	imageWord = word.getWord()
	connect("pressed", self, "_on_Card_pressed")


##Scale the image to the proper size
func scale_img(realSize, size) :
	if(size.y > size.x) :
		rect_min_size.y = size.y
		rect_min_size.x = size.y * (realSize.x / realSize.y)
		if(rect_min_size.x > size.x) :
			rect_min_size.y = (size.x / rect_min_size.x) * rect_min_size.y
			rect_min_size.x = size.x
			#Center the image
			rect_position.y += (size.y - rect_min_size.y) / 2
		else :
			#Center the image
			rect_position.x += (size.x - rect_min_size.x) / 2
	else :
		rect_min_size.x = size.x
		rect_min_size.y = size.x * (realSize.y / realSize.x)
		if(rect_min_size.y > size.y) :
			rect_min_size.x = (size.y / rect_min_size.y) * rect_min_size.x
			rect_min_size.y = size.y
			#Center the image
			rect_position.x += (size.x - rect_min_size.x) / 2
		else :
			#Center the image
			rect_position.y += (size.y - rect_min_size.y) / 2



#This function is called when a card is pressed by the user
func _on_Card_pressed():
	if(selected_cards.size() < 2 && !selected_cards.has(self)):
		selected_cards.append(self) # Add the card to the array
		if(textToSpeech != null):
			textToSpeech.speakText(imageWord) # Tell the word on the card
		set_normal_texture(Global.find_texture(imagePath)) # Reveal the image of the card
	else:
		return
	if(selected_cards.size() == 2):
		var correct = selected_cards[0].imagePath == selected_cards[1].imagePath
		var t = Timer.new()
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start() # Wait for 1 second
		yield(t, "timeout")
		if(correct): # If the two cards have the same image
			Global.manageGame.score += 1
			Global.player.setSilver(Global.player.getSilver() + 1)
			selected_cards[0].visible = false # Hide the two cards
			selected_cards[1].visible = false
			if(Global.manageGame.score == Global.manageGame.current_ex.getNbWords() || Global.manageGame.score == Global.manageGame.maxCardsMemory): # The game is finished
				goToEnd()
				
		else: # If the two cards aren't the same image
			for c in selected_cards:
				c.set_normal_texture(load(c.cardPath)) # Rehide the cards
		selected_cards.clear()


func goToEnd():
	print("end")
	emit_signal("end")
	
	
		
