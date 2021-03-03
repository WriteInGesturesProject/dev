extends Node

var textToSpeech = Global.textToSpeech
var imageWord : String
var imagePath : String
var cardBackPath = "res://assets/icons/card.png" # This is the path of the back of the card

signal card_pressed(card)

#Initialize a card with a word
func init_card(word, size):
	if(word == null):
		return
	$backCardImage.set_normal_texture(load(cardBackPath))
	$backCardImage.set_expand(true)
	$backCardImage.set_stretch_mode(TextureButton.STRETCH_SCALE)
	self.scale_img($backCardImage.texture_normal.get_size(), size)
	imagePath = word.get_icon_path()
	imageWord = word.get_word()
	#when card is pressed, called the _on_card_pressed function from memory_game
	connect("card_pressed", self, "_on_card_pressed")


##Scale the image to the proper size
func scale_img(realSize, size) :
	if(size.y > size.x) :
		$backCardImage.rect_min_size.y = size.y
		$backCardImage.rect_min_size.x = size.y * (realSize.x / realSize.y)
		if($backCardImage.rect_min_size.x > size.x) :
			$backCardImage.rect_min_size.y = (size.x / $backCardImage.rect_min_size.x) * $backCardImage.rect_min_size.y
			$backCardImage.rect_min_size.x = size.x
			#Center the image
			$backCardImage.rect_position.y += (size.y - $backCardImage.rect_min_size.y) / 2
		else :
			#Center the image
			$backCardImage.rect_position.x += (size.x - $backCardImage.rect_min_size.x) / 2
	else :
		$backCardImage.rect_min_size.x = size.x
		$backCardImage.rect_min_size.y = size.x * (realSize.y / realSize.x)
		if($backCardImage.rect_min_size.y > size.y) :
			$backCardImage.rect_min_size.x = (size.y / $backCardImage.rect_min_size.y) * $backCardImage.rect_min_size.x
			$backCardImage.rect_min_size.y = size.y
			#Center the image
			$backCardImage.rect_position.x += (size.x - $backCardImage.rect_min_size.x) / 2
		else :
			#Center the image
			$backCardImage.rect_position.y += (size.y - $backCardImage.rect_min_size.y) / 2

func set_texture(img):
	return $backCardImage.set_normal_texture(img)

#This function is called when a card is pressed by the user
func _on_backCardImage_pressed():
		emit_signal("card_pressed",self)
		var t = Timer.new()
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start() # Wait for 1 second
	


func goToEnd():
	print("end")
	emit_signal("end")
	
	
		



