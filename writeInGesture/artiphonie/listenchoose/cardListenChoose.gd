extends Control

const Word = preload("res://entity/Word.gd")

var backgroundColor : Panel
var cardContainer : MarginContainer
var mainVBox : VBoxContainer
var imgBorelContainer : VBoxContainer
var wordLabel : Label
var word : Word
var vectorSize : Vector2
var test : ColorRect
var controlImageWord : Control
var selected : bool
var buttonSelection : Button

func _ready():
	buttonSelection = Button.new()
	backgroundColor = Panel.new()
	backgroundColor.set("custom_styles/panel", load("res://assets/theme/backgroundPanel.tres"))
	test = ColorRect.new()
	test.size_flags_horizontal = SIZE_EXPAND
	test.size_flags_vertical = SIZE_EXPAND
	test.color = "ffffff"
	cardContainer = MarginContainer.new()
	mainVBox = VBoxContainer.new()
	imgBorelContainer = VBoxContainer.new()
	wordLabel = Label.new()
	controlImageWord = Control.new()
	self.add_child(backgroundColor)
	mainVBox.add_child(imgBorelContainer)
	mainVBox.add_child(wordLabel)
	mainVBox.add_child(controlImageWord)
#	cardContainer.add_child(test)
#	mainVBox.size_flags_horizontal = SIZE_EXPAND_FILL
#	mainVBox.size_flags_vertical = SIZE_EXPAND_FILL
	cardContainer.add_child(mainVBox)
	self.add_child(cardContainer)
#	self.add_child(imgBorelContainer)
	self.add_child(buttonSelection)

func setUpCard(word : Word, level : int, size : Vector2) -> void:
	buttonSelection.rect_min_size = size
	buttonSelection.flat = true
	self.word = word
	self.rect_size = size
	var margin = 0.05
	cardContainer.set("custom_constants/margin_top", size.y * margin)
	cardContainer.set("custom_constants/margin_bottom", size.y * margin)
	cardContainer.set("custom_constants/margin_left", size.x * margin)
	cardContainer.set("custom_constants/margin_right", size.x * margin)
	cardContainer.rect_size = size
	vectorSize = size * (1 - 2*margin)
	mainVBox.rect_min_size = vectorSize
	test.rect_min_size = vectorSize
	var yRest = 1.0
#	Color rect background
	backgroundColor.set("custom_styles/panel", load("res://assets/theme/backgroundPanelSelected.tres"))
	backgroundColor.rect_size.x = size.x
	backgroundColor.rect_size.y = size.y
	
#	Create images Borel
	if level < 2 :
		imgBorelContainer.rect_min_size.x = vectorSize.x
		if level == 0 :
			imgBorelContainer.rect_min_size.y = vectorSize.y * 0.5
			yRest -= 0.5
		else : 
			imgBorelContainer.rect_min_size.y = vectorSize.y * 0.6
			yRest -= 0.6
		imgBorelContainer.alignment = VBoxContainer.ALIGN_CENTER
		setImgBorel()

#	Create label word
	wordLabel.text = word.get_word()
	wordLabel.set("custom_colors/font_color", Color(1,1,1))
	
	wordLabel.align = Label.ALIGN_CENTER
	yRest -= wordLabel.get_minimum_size().y / vectorSize.y
	
#	Create Image Word
	var imageWord = TextureRect.new()
	imageWord.texture = Global.find_texture(word.getPath())
	imageWord.expand = true
	if(Global.manageGame.level < 2):
		if(mySize(word.get_phonetic()) > 3):
			_scaleImg(imageWord, vectorSize.y * 0.2)
			yRest -= 0.2
		else :
			_scaleImg(imageWord, vectorSize.y * 0.40)
			yRest -= 0.40
	else :
		_scaleImg(imageWord, vectorSize.y * 0.90)
		yRest -= 0.90
	
	mainVBox.add_constant_override("separation", yRest/3*vectorSize.y)
	if level == 1:
		imageWord.visible = false
		cardContainer.margin_top = vectorSize.y/2 - imgBorelContainer.rect_min_size.y/2
	if level == 1 || level == 2:
		wordLabel.visible = false
	if level == 2 :
		imageWord.rect_position.y = (size.y/2)-(imageWord.rect_size.y/1.5)
		imgBorelContainer.visible = false
	
	controlImageWord.rect_size = imageWord.rect_size
	controlImageWord.add_child(imageWord)
	imageWord.rect_position.x = (vectorSize.x - imageWord.rect_size.x)/2

func setImgBorel() -> void :
#		Catch image borel
		var phonetic = word.get_phonetic()
		var arrayPicture = Global.phoneticToArrayPicturePath(phonetic)
		var line1 : HBoxContainer
#		More than 3 images borel
		if(arrayPicture.size() > 3):

			var line2 : HBoxContainer
			line1 = Global.putBorelInHboxContainer([arrayPicture[0],arrayPicture[1],arrayPicture[2]], imgBorelContainer.rect_min_size.x-2 , imgBorelContainer.rect_min_size.y/2)
			var tab = []
			for i in range(3, arrayPicture.size()):
				tab.append(arrayPicture[i])
			line2 = Global.putBorelInHboxContainer(tab, imgBorelContainer.rect_min_size.x-2, imgBorelContainer.rect_min_size.y/2)
			imgBorelContainer.add_child(line1)
			imgBorelContainer.add_child(line2)
		else :
			line1 = (Global.putBorelInHboxContainer(arrayPicture, vectorSize.x, (vectorSize.x)/arrayPicture.size()))
			imgBorelContainer.add_child(line1)

func _scaleImg(textureRect, size):
	if textureRect.texture.get_size().x < textureRect.texture.get_size().y :
		textureRect.rect_size.y = size
		textureRect.rect_size.x = size * (textureRect.texture.get_size().x / textureRect.texture.get_size().y)
#	elif textureRect.texture.get_size().x > vectorSize.x && textureRect.texture.get_size().y > size :
	else:
		textureRect.rect_size.x = vectorSize.x 
		textureRect.rect_size.y = textureRect.texture.get_size().y * (vectorSize.x / textureRect.texture.get_size().x)
		if textureRect.rect_size.y > size :
			textureRect.rect_size.x *= size / textureRect.rect_size.y
			textureRect.rect_size.y = size
#	else :
		

func mySize(word):
	var size = 0
	for i in word:
		if(i.to_ascii()[0] != 3):
			size += 1
	if(size == 1):
		return 1.7
	return size
