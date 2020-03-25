extends Control

const Exercise = preload("res://Exercise.gd")
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
	
	Global.make_margin(find_node("Main"), 0.015)
	find_node("MarginCoinBox").set("custom_constants/margin_right", int(size.x*7/120))
	find_node("MarginCoinBox").set("custom_constants/margin_left", int(size.x*7/120))
	find_node("Gold").text = str(Global.player.getGold())
	find_node("Silver").text = str(Global.player.getSilver())
	find_node("Home").rect_size = Vector2(get_viewport().size.y*0.15, get_viewport().size.y*0.15)
	
#	find_node("Logo").rect_size = Vector2(size.y/4,size.y/4)
#	find_node("Logo").rect_position.x = size.x/2 - size.x/20 - size.y/8
	Ex = Global.current_ex
	if(Ex == null):
		#print("Ex in GameEnd is null")
		return
	
	var success = true
	for i in Global.try:
		if(!i):
			success = false
			break
	
	var total = Ex.getNbWords()
	if(Global.play == 2):
		success = true
		total /= 3
	elif(Global.play == 1 && total > 22):
		total = 22
	elif(Global.play == 3 && total > Global.max_cards):
		total = Global.max_cards
	var percent : float = float(Global.score) / total * 100
	var comment = ""
	if(percent < 50):
		comment = "Dommage, essaye encore !"
	else:
		comment = "Bravo !!"
	if(Global.play != 0):
		find_node("Money").set_text("Tu as gagné "+ str(Global.score) + " pièces argent")
		leftCoinSilver = Global.score
	else:
		find_node("Money").visible = false
	
	find_node("Comment").set_text(comment)
	find_node("Score").set_text("Ton score est de " + str(Global.score) + " sur " + str(total) + " soit " + str(int(percent)) + "%")
	if(Ex.getSuccessPercentage(Global.level) < percent):
		Ex.setSuccessPercentage(Global.level, percent)
	find_node("BestScore").set_text("Ton meilleur score est de " + str(int(Ex.getSuccessPercentage(Global.level))) + "%")
	if(success):
		Ex.setNbSuccess(Ex.getNbSuccess() + 1)
		leftCoinGold = 1
	
	find_node("Success").set_text("Tu as fini cet exercice " + str(Ex.getNbSuccess()) + " fois")
	find_node("Silver").text = str(Global.player.getSilver()-Global.score)
	find_node("Success").get_font("font").size = get_viewport().size.y/12
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	earnCoin("Gold")
	earnCoin("Silver")
	pass

func animationCoin(type : String) :
	var coin = Sprite.new()
	self.add_child(coin)
	var target
	var marginx = find_node("MarginCoinBox").get_constant("margin_right")
	var marginy = find_node("Main").get_constant("margin_top")
	if(type == "Gold"):
		coin.texture = load("res://assets/icons/goldCoin.png")
		target = Vector2(find_node("ControlGold").rect_global_position.x + marginx/2 , find_node("ControlGold").rect_global_position.y + marginy)
	else :
		coin.texture = load("res://assets/icons/silverCoin.png")
		target = Vector2(find_node("ControlSilver").rect_global_position.x + marginx/2 , find_node("ControlSilver").rect_global_position.y + marginy)
	coin.scale = Vector2(0.1,0.1)
	coin.position = get_viewport().size/2
	
	
	var tween = Tween.new()
	coin.add_child(tween)
	
	tween.interpolate_property(coin,"position",coin.position ,target,2,Tween.TRANS_QUINT,Tween.EASE_IN)
	tween.start()
	tween.interpolate_callback(self,2,"finishAnimation",coin,type)
	
func finishAnimation(coin : Sprite, type : String):
	coin.remove_and_skip()
	if(type == "Silver") :
		##The silver coin is increase during the game we just change it in frontEnd
		find_node("Silver").text = str(int(find_node("Silver").text)+1)
	else:
		Global.player.setGold(Global.player.getGold() + 1)
		find_node("Gold").text = str(Global.player.getGold())
		

func earnCoin(type :String) :
	if(type == "Silver") :
		if(leftCoinSilver > 0) :
			find_node("TimerSilver").start()
			animationCoin(type)
			leftCoinSilver -= 1
		else :
			find_node("TimerSilver").stop()
	else :
		if(leftCoinGold > 0) :
			find_node("TimerGold").start()
			animationCoin(type)
			leftCoinGold -= 1
		else :
			find_node("TimerGold").stop()

func _on_Home_pressed():
	get_tree().change_scene("res://home.tscn")

func _on_Timer_timeout():
	earnCoin(find_node("TimerSilver").editor_description)

func _on_TimerGold_timeout():
	earnCoin(find_node("TimerGold").editor_description)


func _on_Button_pressed():
	leftCoinSilver=1
	earnCoin("Silver")


func _on_Button2_pressed():
	leftCoinGold=1
	earnCoin("Gold")
