extends Control

const Exercise = preload("res://entity/Exercise.gd")

var Ex = Global.gooseExercise

var myWords = Global.customExercise.getAllWords()
var currentCase = 0
var nbCase = 10
var indexInExercice = []
var trainScene = preload("res://page/train/drawWord.tscn").instance()
onready var background = $backgroundDark


# Called when the node enters the scene tree for the first time.
func _ready():	
	##Put the sprite on the begin ligne
	putSpriteOnBegin()
	add_child(Global.manageInstruction.instruction("gooseGame"))
	
	##Choose the words to display and the index in exercise tab
	var temp = []
	if(myWords.size() > nbCase):
		var rand = 0
		for i in range(0, nbCase):
			rand = randi() % (myWords.size())
			while(indexInExercice.find(rand) != -1):
				rand = randi() % (myWords.size())
			indexInExercice.append(rand)
			temp.append(myWords[rand])
			find_node("Case"+String(i+1)).visible = true
		myWords = temp
	else :
		nbCase = myWords.size()
		for i in range (0, myWords.size()) :
			indexInExercice.append(i)
			find_node("Case"+String(i+1)).visible = true
	
	#Display the drawWord scene
	add_child(trainScene)
	trainScene.visible = false 
	
	####Put manage game
	for i in range (0,nbCase):
		Global.manageGame.try.append(false)

	
func putSpriteOnBegin():
	find_node("Sprite").position = placeSpriteOnCase(find_node("Sprite"),find_node("BeginCase"))

func placeSpriteOnCase(src : Node, dest : Node):
	var destCenter = Vector2(dest.rect_position.x + dest.rect_size.x/2 , dest.rect_position.y + dest.rect_size.y/2)
	var size = src.texture.get_size()*src.scale
	return  Vector2(destCenter.x, destCenter.y - size.y/4)
	
	
func _on_Validate_pressed():
	find_node("Validate").disabled = true
	if(currentCase < nbCase ):
		if currentCase != 0 :
			find_node("Case"+String(currentCase)).texture = load("res://assets/icons/check.png")
		currentCase += 1
		goToCase()
	else :
		print("finish")
		Global.manageScreen.changeScene("res://page/navigation/gameEnd.tscn")

	
func goToCase() :
	var tween = find_node("Tween")
	var sprite = find_node("Sprite")
	var case = find_node("Case"+String(currentCase))
	var position = sprite.position
	var target = placeSpriteOnCase(sprite,case)
	tween.interpolate_property(sprite,"position",position,target,1,Tween.TRANS_QUINT,0)
	tween.start()
	
	
func _on_Tween_tween_all_completed():
	trainScene.tryindex = currentCase-1
	trainScene.display(Global.manageGame.level, myWords[currentCase-1], Ex, indexInExercice[currentCase-1])
	trainScene.find_node("Next").visible = false
	trainScene.visible = true
	background.visible = true

func back():
	if(find_node("backgroundDark") != null):
		find_node("backgroundDark").visible = false
	find_node("WordDetails").visible = false
	Global.manageScreen.changeScene("res://page/navigation/gameChoose.tscn")


func next():
	find_node("Validate").disabled = false
	trainScene.visible = false  
	background.visible = false 
	

func _on_Back_pressed():
	back()
