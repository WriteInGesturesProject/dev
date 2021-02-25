extends Control

var margin = 0.05
var vectorMarge : Vector2
var slider
var indicatorArray : Array
var currentPage = 0

func _ready():
	
	add_child(Global.manageInstruction.instruction("navigationHelp"))
	
	##Make the margin of 5% of the viewport 
	find_node("MarginContainer").set("custom_constants/margin_top", get_viewport().size.y * margin)
	find_node("MarginContainer").set("custom_constants/margin_bottom", get_viewport().size.y * margin)
	vectorMarge = Vector2(get_viewport().size.x, get_viewport().size.y * (1 - 2*margin))
	find_node("Slider").rect_min_size = Vector2(get_viewport().size.x,0.9*vectorMarge.y) 


	var nodeArray : Array =[]
	##Put all the button "sound"
	var dict = Global.phoneticDictionnary
	for i in range(0, dict.size()):
		var paragraph = dict.keys()[i]
		var array = dict[paragraph]
		var current_scene = load("res://page/navigation/sliderSceneHelp.tscn").instance()
		current_scene.dict = array
		current_scene.title = paragraph
		current_scene.size = find_node("Slider").rect_min_size 
		current_scene.currentPage = i
		nodeArray.append(current_scene)
	
	slider = load("res://page/navigation/tools/navigationPage.tscn").instance()
	slider.connect("change_page", self, "onChangePage",[])
	slider.setUp(nodeArray,find_node("Slider").rect_min_size)
	find_node("Slider").add_child(slider)
	
	##Display the indicator slider
	find_node("GridContainer").columns = nodeArray.size()
	find_node("GridContainer").add_constant_override("hseparation",0.05*vectorMarge.y )
	for i in range(0, nodeArray.size()):
		var button = TextureButton.new()
		button.texture_normal = load("res://assets/icons/dot.png")
		button.rect_min_size = Vector2(0.1*vectorMarge.y,0.1*vectorMarge.y)
		button.expand = true
		button.modulate.a = 0.2
		find_node("GridContainer").add_child(button)
		indicatorArray.append((button))
	indicatorArray[currentPage].modulate.a = 1
	
	slider.goToPage(currentPage)

func onChangePage(currentPage):
	for i in range (0, indicatorArray.size()):
		if i == currentPage :
			indicatorArray[i].modulate.a = 1
		else :
			indicatorArray[i].modulate.a = 0.2

func _process(delta):
	pass
	

func _on_Back_pressed():
		Global.change_scene("res://page/home/home.tscn")
