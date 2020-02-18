extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tts = null
var stt = null
var os = ""
var words = ""
var display = false
var incremented = false
var myWords = Global.customExercise.getAllWords()
var index = 0
var img = ""
var container = HBoxContainer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	for b in range(0,2):
		for w in range(0,3):
				var control_img = Control.new()
				var colorR = ColorRect.new()
				colorR.color = "ffffff"
				control_img.add_child(colorR)
				var vBox = VBoxContainer.new()
				var word = Label.new()
				word.text = myWords[index].getWord()
				for c in myWords[index].getPhonetic():
					container = HBoxContainer.new()
					container.alignment = HBoxContainer.ALIGN_CENTER
					for b in Global.phoneticDictionnary:
						for w in Global.phoneticDictionnary[b]:
							if(c == w["phonetic"][1]):
								img = w["ressource_path"]
								break
					var boxImg = Control.new()
					var imgBorel = TextureRect.new()
					imgBorel.texture = load("res://art/imgBorel/"+img)
					imgBorel.expand = true
					imgBorel.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
					imgBorel.rect_size.x = (get_viewport().size.y / 2.5)/6
					imgBorel.rect_size.y = (get_viewport().size.y / 2.5)/6
					boxImg.add_child(imgBorel)
					container.add_child(boxImg)
				index += 1
				vBox.add_child(container)
				var box_image = Control.new()
				var image = TextureRect.new()
				image.texture = load("res://art/users/assistant.png")
				image.expand = true
				image.stretch_mode = TextureRect.STRETCH_SCALE_ON_EXPAND
				image.rect_size.x = (get_viewport().size.y / 2.5)/3
				image.rect_size.y = (get_viewport().size.y / 2.5)/3
				box_image.add_child(image)
				find_node("gridCard").add_constant_override("vseparation",  (get_viewport().size.y / 2.5)+10)
				find_node("gridCard").add_constant_override("hseparation",  (get_viewport().size.y / 2.5)+20)
				vBox.add_constant_override("vseparation",  (get_viewport().size.y / 7)+10)
				vBox.add_constant_override("hseparation",  (get_viewport().size.y / 7)+20)
				vBox.add_child(box_image)
				vBox.add_child(word)
				vBox.add_constant_override("separation", 10)
				control_img.add_child(vBox)
				find_node("gridCard").add_child(control_img)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://GameLevel.tscn")
