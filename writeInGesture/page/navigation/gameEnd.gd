extends Control

const Exercise = preload("res://entity/Exercise.gd")

var Ex : Exercise

var mainBox : VBoxContainer
var main : MarginContainer
var coinBox : HBoxContainer
var size : Vector2
var leftCoinSilver = 0
var leftCoinGold = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	mainBox = find_node("MainBox")
	main = find_node("Main")
	coinBox = find_node("CoinBox")
	size = get_viewport().size

	find_node("Gold").text = str(Global.player.getGold())
	find_node("Silver").text = str(Global.player.getSilver())
	
	Ex = Global.manageGame.current_ex
	if(Ex == null):
		return
	
	var everyWordsTried = Global.manageGame.triedEveryWords()
	
	var total = Ex.getNbWords() # This is the total of word in the exercise 
	
	if(Global.manageGame.play == 2): # This is the Listen & Choose Game
		everyWordsTried = true
		total /= 3 # The total of word is divided by 3
		
	elif(Global.manageGame.play == 1 && total > 10): # We can only display 10 images on the GooseGame
		total = 10
	
	elif(Global.manageGame.play == 3 && total > Global.manageGame.maxCardsMemory): # We display only 12 images at max on the MemoryGame
		total = Global.manageGame.maxCardsMemory
	
	var percent : float = float(Global.manageGame.score) / total * 100 # This is the score in percentage
	

	
	if(Global.manageGame.play != 0): # The user didn't chose a training exercise
		if(Global.manageGame.score > 20) :
			Global.manageGame.score = 20
			leftCoinSilver = 20
		else : 
			leftCoinSilver = Global.manageGame.score
	
	if(Global.manageGame.play != 3) :
		_displayStars(find_node("star"),find_node("star2"),find_node("star3"),percent)
		if(Ex.getSuccessPercentage(Global.manageGame.level) < percent):
			Ex.setSuccessPercentage(Global.manageGame.level, percent)
		
		_displayStars(find_node("starBest"), find_node("starBest2"), find_node("starBest3"),int(Ex.getSuccessPercentage(Global.manageGame.level)))
	else :
		print("memoryGameEnd")
		find_node("star").visible = false
		find_node("star2").visible = false
		find_node("star3").visible = false
		find_node("starBest").visible = false
		find_node("starBest2").visible = false
		find_node("starBest3").visible = false
		
		find_node("time").visible = true
		find_node("currentTime").visible = true
		find_node("bestTime").visible = true
		
		var currentTime = Global.manageGame.time
		var bestTime = int(Ex.getSuccessPercentage(0))
		find_node("currentTime").text = String(currentTime/60)+" Minutes et "+String(currentTime%60)+ " Secondes"
		find_node("bestTime").text = String(bestTime/60)+" Minutes et "+String(bestTime%60)+ " Secondes"
		
	if(everyWordsTried):
		Ex.setNbSuccess(Ex.getNbSuccess() + 1)
		leftCoinGold = 1
	
	
	##NEED TO UPDATE BDD 
	Global.manageDatabase.updateTabs()


func _process(delta):
	earnCoin("Gold")
	earnCoin("Silver")

func _displayStars(star, star2, star3, percent):
	if(percent < 80):
		star3.modulate = Color(1,1,1,0.5)
	if(percent < 55):
		star2.modulate = Color(1,1,1,0.5)
	if(percent < 30):
		star.modulate = Color(1,1,1,0.5)

func animationCoin(type : String, indexCoin : int) :
	var coin = Sprite.new()
	var size
	self.add_child(coin)
	var target
	
	coin.scale = Vector2(0.3, 0.3)
	
	if(type == "Gold"):
		coin.texture = load("res://assets/icons/goldCoin.png")
		size = coin.texture.get_size()*coin.scale
		target = Vector2(find_node("TextureRectGold").rect_global_position.x+find_node("TextureRectGold").rect_size.x/2, find_node("TextureRectGold").rect_global_position.y+find_node("TextureRectGold").rect_size.x/2)
		coin.position.y = get_viewport().size.y / 2 + size.y / 1.5
	else :
		coin.texture = load("res://assets/icons/silverCoin.png")
		size = coin.texture.get_size()*coin.scale
		target = Vector2(find_node("TextureRectSilver").rect_global_position.x+find_node("TextureRectSilver").rect_size.x/2, find_node("TextureRectSilver").rect_global_position.y+find_node("TextureRectSilver").rect_size.x/2)
		coin.position.y = get_viewport().size.y / 2 - size.y / 1.5

	coin.position.x = get_viewport().size.x/2 + (size.x * Global.manageGame.score/2) - size.x * indexCoin
	
	var tween = Tween.new()
	coin.add_child(tween)
	tween.interpolate_property(coin, "position", coin.position, target, 2, Tween.TRANS_QUINT, Tween.EASE_IN)
	tween.start()
	tween.interpolate_callback(self, 2, "finishAnimation", coin, type)


func finishAnimation(coin : Sprite, type : String):
	coin.remove_and_skip()
	if(type == "Silver") :
		Global.player.setSilver(Global.player.getSilver() + 1)
		##The silver coin is increased during the game we just change it in frontEnd
		find_node("Silver").text = str(int(find_node("Silver").text)+1)
	else:
		Global.player.setGold(Global.player.getGold() + 1)
		find_node("Gold").text = str(Global.player.getGold())


func earnCoin(type :String) :
	if(type == "Silver") :
		if(leftCoinSilver > 0) :
			animationCoin(type, leftCoinSilver)
			leftCoinSilver -= 1
	else :
		if(leftCoinGold > 0) :
			animationCoin(type, leftCoinGold)
			leftCoinGold -= 1


func _on_Home_pressed():
	Global.manageScreen.changeScene("res://page/home/home.tscn")
	
func _on_Replay_pressed():
	if(Global.manageGame.play == 1): #GooseGame This is the  Game
		Global.manageScreen.changeScene("res://page/goosegame/gooseGame.tscn")
	elif(Global.manageGame.play == 2): #Listen & Choose
		Global.manageScreen.changeScene("res://page/listenchoose/listenChoose.tscn")
	elif(Global.manageGame.play == 3): #MemoryGame
		Global.manageScreen.changeScene("res://page/memory/memoryGame.tscn")

