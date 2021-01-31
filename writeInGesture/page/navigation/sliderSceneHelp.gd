extends Control

var dict : Array
var title : String
var size : Vector2
var currentPage =0

func _ready():
	find_node("Title").text = title
#	find_node("Title").get_font("font").size = Global.h1Font
#	find_node("TextureRect").texture = load("res://assets/icon/"+title+".png")

	##Responsive button : 30% of the size of screen 
	find_node("Learn").rect_min_size.y = size.y/3
	find_node("Train").rect_min_size.y = size.y/3
	find_node("Learn").rect_min_size.x = size.x*0.3
	find_node("Train").rect_min_size.x = size.x*0.3
#	find_node("Learn").get_font("font").size = Global.h2Font
#	find_node("Train").get_font("font").size = Global.h2Font
	
	##separation between button
	var separationButton =  size.y/15
	find_node("ButtonContainer").add_constant_override("separation", separationButton)
	##Size of the image
	find_node("TextureRect").rect_size = Vector2(find_node("Learn").rect_min_size.x, find_node("Learn").rect_min_size.y *2 )
	###Choose Image in function of the title
	match title :
		"VOYELLES NASALES" :
			find_node("TextureRect").texture = load("res://assets/icons/neza.png")
		"VOYELLES ORALES" :
			find_node("TextureRect").texture = load("res://assets/icons/bouchea.png")
		"SEMI-CONSONNES" :
			find_node("TextureRect").texture = load("res://assets/icons/semiConsonnes.png")
		"CONSONNES NASALES" :
			find_node("TextureRect").texture = load("res://assets/icons/nezb.png")
		"CONSONNES ORALES":
			find_node("TextureRect").texture = load("res://assets/icons/boucheb.png")
#
	##Center Main margin in horizontal
	var separation = size.x * 0.1
	find_node("MainMargin").set("custom_constants/margin_left", (size.x - (2*(find_node("Learn").rect_min_size.x)+separation))/2)
	find_node("HBoxMain").add_constant_override("separation",separation)

	##Center Main margin in horizontal
	find_node("MainMargin").set("custom_constants/margin_top", (size.y - (2*find_node("Learn").rect_min_size.y + separationButton))/2)


func _on_Learn_pressed():
	var next_scene = load("res://page/help/interfaceGesture.tscn").instance()
#	print(title)
	next_scene.title = title
	next_scene.array = dict
	next_scene.currentPage = currentPage
	
	get_tree().get_root().add_child(next_scene)


func _on_Train_pressed():
	var next_scene = load("res://page/help/trainHelp.tscn").instance()
	next_scene.title = title
	next_scene.array = dict
	next_scene.currentPage = currentPage
	get_tree().get_root().add_child(next_scene)
