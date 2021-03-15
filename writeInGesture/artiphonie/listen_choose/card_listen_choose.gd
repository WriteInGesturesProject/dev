extends Control

var word : Word
var currentLayout : Control

signal card_pressed(card)

func setUpCard(_word : Word, difficulty : int, size : Vector2) -> void:
	
	#display the right layout depending on the difficulty 
	print("layout_" + String(difficulty))
	print(find_node("layout_" + String(difficulty)))
	print($CardButton.get_children())
	currentLayout = find_node("layout_" + String(difficulty))
	currentLayout.visible = true
		
	#set the paramter of the card
	word = _word
	currentLayout.find_node("word").text = _word.word
	currentLayout.find_node("picture").texture = Global.load_icon(word.iconPath)
	currentLayout.find_node("borel_maisonny_container").rect_min_size.x = size.x*0.85
	currentLayout.find_node("borel_maisonny_container").rect_min_size.y = size.y/3
	#set the card min size
	self.rect_min_size = size
	
	#add the borel maisonny images to the card
	extract_borel_maisonny()
	
func _on_CardButton_pressed():
	emit_signal("card_pressed",self)
	
#This function extract all the borel maisonny sign picture out of all the
#phonetic symbol of our function
func extract_borel_maisonny() -> void:
	for imgPath in Global.phonetic_to_array_picture_path(word.phonetic):
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

