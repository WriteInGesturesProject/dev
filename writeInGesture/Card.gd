extends TextureButton


var tts = Global.tts
var imageWord : String
var imagePath : String
var cardPath = "res://art/card2.jpg"
var selected_cards : Array


func init(word, size, column : int, selected_cards : Array):
	self.selected_cards = selected_cards
	set_normal_texture(load(cardPath))
	set_expand(true)
	set_stretch_mode(TextureButton.STRETCH_SCALE)
	rect_min_size = size
	imagePath = "res://art/images/" + word.getPath()
	imageWord = word.getWord()
	connect("pressed", self, "_on_Card_pressed")


func _on_Card_pressed():
	if(selected_cards.size() < 2 && !selected_cards.has(self)):
		selected_cards.append(self)
		if(tts != null):
			tts.speakText(imageWord)
		set_normal_texture(load(imagePath))
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
			selected_cards[0].visible = false
			selected_cards[1].visible = false
			if(Global.score == Global.max_cards):
				get_tree().change_scene("res://GameEnd.tscn")
		else:
			for c in selected_cards:
				c.set_normal_texture(load(c.cardPath))
		selected_cards.clear()
