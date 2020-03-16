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
	find_node("Picture").texture=load(Global.player.getPathPicture())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
	
	find_node("marginCoinBox").set("custom_constants/margin_right", int(size.x*7/120))
#	coinBox.set("rect", marginCoinBox - int(size.x*7/120))
#	coinBox.rect_size.x = coinBox.rect_size.x - int(size.x*7/120)
	
	mainBox.rect_min_size = Vector2(size.x/3,size.y*3/4)
	avatarBox.rect_min_size = Vector2(size.x/6,size.y*3/4)
	orthoBox.rect_min_size = Vector2(size.x/6,size.y*3/4)
	
	find_node("MainHbox").add_constant_override("separation",int(size.x*7/120))
	
	find_node("Picture").rect_size = Vector2(avatarBox.rect_min_size.x,avatarBox.rect_min_size.x)
	avatarBox.add_constant_override("separation",int(avatarBox.rect_min_size.x*1.2))
	find_node("Gold").text = str(Global.player.getGold())
	find_node("Silver").text = str(Global.player.getSilver())
	
	find_node("Logo").rect_size = Vector2(size.y/4,size.y/4)
	find_node("Logo").rect_position.x = size.x/2 - size.x/20 - size.y/8

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
