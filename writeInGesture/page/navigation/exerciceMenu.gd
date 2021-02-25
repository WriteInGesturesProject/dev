extends Control

var slider
var currentPage = 0
var indicatorArray = []

func _ready():
	Global.manageGame.game = 0
	Global.manageGame.score = 0
	Global.manageGame.try = []
	
	add_child(Global.manageInstruction.instruction("exerciseMenu"))
	
	##Make the margin of 5% of the viewport 
	find_node("Slider").rect_min_size = Vector2(get_viewport().size.x,0.9*get_viewport().size.y) 

	var nodeArray : Array =[]

	var current_scene = load("res://page/navigation/sliderSceneTrainMenu.tscn").instance()
	current_scene.setUp(Global.countExercise,0,"res://page/train/train.tscn")
	current_scene.currentPage = 0
	nodeArray.append(current_scene)
	
	current_scene = load("res://page/navigation/sliderSceneTrainMenu.tscn").instance()
	current_scene.setUp(Global.colorExercise,0,"res://page/train/train.tscn")
	current_scene.currentPage = 0
	nodeArray.append(current_scene)
	
	current_scene = load("res://page/navigation/sliderSceneTrainMenu.tscn").instance()
	current_scene.setUp(Global.weekExercise,0,"res://page/train/train.tscn")
	current_scene.currentPage = 0
	nodeArray.append(current_scene)
	

	
	slider = load("res://page/navigation/tools/navigationPage.tscn").instance()
	slider.connect("change_page", self, "onChangePage",[])
	slider.setUp(nodeArray,find_node("Slider").rect_min_size)
	find_node("Slider").add_child(slider)
	
	##Display the indicator slider
	find_node("GridContainer").columns = nodeArray.size()
	find_node("GridContainer").add_constant_override("hseparation",0.05*get_viewport().size.y )
	for i in range(0, nodeArray.size()):
		var button = TextureButton.new()
		button.texture_normal = load("res://assets/icons/dot.png")
		button.rect_min_size = Vector2(0.1*get_viewport().size.y,0.1*get_viewport().size.y)
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

func _on_Back_pressed():
	Global.change_scene("res://page/home/home.tscn")
