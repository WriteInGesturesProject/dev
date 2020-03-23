extends TextureButton


var tts = Global.tts
var imageWord : String
var imagePath : String
var cardPath = "res://assets/icons/card.png"
var selected_cards : Array


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


func scale_img(realSize, size) :
	##Scale the image
	if(size.y > size.x) :
		rect_min_size.y = size.y
		rect_min_size.x = size.y * (realSize.x/realSize.y)
		if(rect_min_size.x > size.x) :
			rect_min_size.y = (size.x/rect_min_size.x) * rect_min_size.y
			rect_min_size.x = size.x
			##Center the image
			rect_position.y += (size.y - rect_min_size.y)/2
		else :
		##Center the image
			rect_position.x += (size.x - rect_min_size.x)/2
			
	else :
		rect_min_size.x = size.x
		rect_min_size.y = size.x * (realSize.y/realSize.x)
		if(rect_min_size.y > size.y) :
			rect_min_size.x = (size.y/rect_min_size.y) * rect_min_size.x
			rect_min_size.y = size.y
			##Center the image
			rect_position.x += (size.x - rect_min_size.x)/2
		else :
			##Center the image
			rect_position.y += (size.y - rect_min_size.y)/2
	
func _on_Card_pressed():
	if(selected_cards.size() < 2 && !selected_cards.has(self)):
		selected_cards.append(self)
		if(tts != null):
			tts.speakText(imageWord)
		set_normal_texture(Global.find_texture(imagePath))
	else:
		return
	if(selected_cards.size() == 2):
		var correct = selected_cards[0].imagePath == selected_cards[1].imagePath
		var t = Timer.new()
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		if(correct):
			Global.score += 1
			Global.player.setSilver(Global.player.getSilver() + 1)
			selected_cards[0].visible = false
			selected_cards[1].visible = false
			if(Global.score == Global.current_ex.getNbWords() || Global.score == Global.max_cards):
				get_tree().change_scene("res://GameEnd.tscn")
		else:
			for c in selected_cards:
				c.set_normal_texture(load(c.cardPath))
		selected_cards.clear()
