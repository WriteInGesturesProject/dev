extends Control

var mainBox : VBoxContainer
var avatarBox : VBoxContainer
var orthoBox : VBoxContainer
var main : MarginContainer
var coinBox : HBoxContainer
var size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	find_node("NamePlayer").text=Global.player.getName()
	find_node("Picture").texture=load("res://art/users/"+Global.player.getPathPicture())
	find_node("Play").rect_min_size.y = get_viewport().size.y/5
	find_node("Training").rect_min_size.y = get_viewport().size.y/5
	find_node("Change").rect_min_size.y = get_viewport().size.y/5
	find_node("Help").rect_min_size.y = get_viewport().size.y/5
	find_node("Admin").rect_min_size.y = get_viewport().size.y/5
	find_node("Admin").get_font("font").size = get_viewport().size.y/22
	find_node("NamePlayer").get_font("font").size = get_viewport().size.y/22
	
	mainBox = find_node("MainBox")
	avatarBox = find_node("AvatarBox")
	orthoBox = find_node("OrthoBox")
	main = find_node("Main")
	coinBox = find_node("CoinBox")
	size = get_viewport().size
	
	main.set("custom_constants/margin_right", size.x/20)
	main.set("custom_constants/margin_left", size.x/20)
	main.set("custom_constants/margin_top", size.y*0.03)
	main.set("custom_constants/margin_bottom", size.y*0.03)
	
	###Adjust Detail Texture Button
	find_node("Details").rect_size.y = size.y/6
	find_node("Details").rect_size.x = size.y/6
	find_node("Details").rect_position.x = size.y*0.03
	find_node("Details").rect_position.y = size.y*0.03
	
	###Adjust CoinBox 

	find_node("goldCoinPicture").rect_size = Vector2(size.y/10,size.y/10)
	find_node("silverCoinPicture").rect_size = Vector2(size.y/10,size.y/10)
	find_node("CoinBox").rect_min_size = Vector2(size.y/10,size.y/10)
	find_node("CoinGold").add_constant_override("separation",size.y/9)
	find_node("CoinSilver").add_constant_override("separation",size.y/9)
	find_node("CoinBox").add_constant_override("separation",size.y*0.03)
	
	
	###Adjust the main box
	mainBox.rect_min_size = Vector2(size.x/3,size.y*3/4)
	mainBox.rect_position.y = size.y*2/4
	avatarBox.rect_min_size = Vector2(size.x/5,size.y*3/4)
	orthoBox.rect_min_size = Vector2(size.x/5,size.y*3/4)
	
	find_node("MainHbox").add_constant_override("separation",int(size.x*7/120))
	
	find_node("Picture").rect_size = Vector2(avatarBox.rect_min_size.x,avatarBox.rect_min_size.x)
	avatarBox.add_constant_override("separation",int(avatarBox.rect_min_size.x*1.2))
	find_node("Gold").text = str(Global.player.getGold())
	find_node("Silver").text = str(Global.player.getSilver())
	
	find_node("Logo").rect_size = Vector2(size.y/2,size.y/2)
	find_node("Logo").rect_position.y = size.y*(-0.1)
	find_node("Logo").rect_position.x = size.x/2 - size.x/20 - size.y/4

func _on_Change_pressed():
	get_tree().change_scene("res://avatarspace.tscn")


func _on_Admin_pressed():
	if(!Global.dev) :
		get_tree().change_scene("res://speechTherapistMenu.tscn")
	else : 
		find_node("Popup").popup_centered_ratio(0.75)
		find_node("backgroundDark").visible = true


func _on_Play_pressed():
	get_tree().change_scene("res://GameChoose.tscn")


func _on_Help_pressed():
	get_tree().change_scene("res://interfaceGestureImproved.tscn")


func _on_Popup_popup_hide():
	if(find_node("backgroundDark") != null):
		find_node("backgroundDark").visible = false

func _on_Training_pressed():
	get_tree().change_scene("res://ExerciceMenu.tscn")


func _on_Details_pressed():
	get_tree().change_scene("res://About.tscn")
