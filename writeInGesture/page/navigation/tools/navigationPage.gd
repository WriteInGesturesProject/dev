extends Control


var margin = 0.05
var vectorMarge : Vector2
var startswipping = false
var start_position_margin = Vector2(0,0)

### OBLIGATORY FIELD FOR SWIGPING PAGE
var currentPage = 0
var nodePage : Array #of node where there are the scene of one page
var sizePage = 0

signal change_page(i)

func _ready():
	### fix bug of séparation in godot
	find_node("HBoxContainer").add_constant_override("separation",0)
	
func setUp(node : Array, size : Vector2):
	nodePage = node
	sizePage = node.size()
	for i in range(0, sizePage):
		var control = Control.new()
		control.name = String(i)
		control.rect_min_size = Vector2(size.x, size.y)
		control.add_child(nodePage[i])
		find_node("HBoxContainer").add_child(control)
	

### Function if starting swiping detect
func _on_Swipe_detector_start_swiping(start_position):
	startswipping = find_node("MarginContainer").rect_global_position.x

### Actualise the view from de Detector
func _on_Swipe_detector_distance_from_last(current_position):
	if(find_node("MarginContainer").rect_global_position.x >= -(sizePage-1) * get_viewport().size.x && find_node("MarginContainer").rect_global_position.x <= 0):
#		print("current",current_position.x)
		find_node("MarginContainer").rect_global_position.x = startswipping+ current_position.x

#### FUNCTIONS IF SWIPPED
func _on_Swipe_detector_swiped(direction):
	if(direction.x == 1) :
		go_right_page()
	else:
		go_left_page()

func go_left_page() :
	if(currentPage > 0):
		var tween = find_node("Tween")
		var target = find_node("MarginContainer")
		var startpos = find_node("MarginContainer").rect_global_position
		var endpos = Vector2(-(currentPage-1) * get_viewport().size.x,find_node("MarginContainer").rect_global_position.y)
		tween.interpolate_property(target,"rect_global_position", startpos, endpos, 1,Tween.TRANS_QUINT, Tween.EASE_OUT)
		tween.start()
		currentPage -=1
		emit_signal("change_page",currentPage )
	else :
		var lastpos = -(currentPage) * get_viewport().size.x #####NEED TO HAVE COORDONATE OF THE NEAR PAGE
		go_near(lastpos);
#	print("left, current : ", currentPage)

func go_right_page():
	if(currentPage < sizePage-1):
		var tween = find_node("Tween")
		var target = find_node("MarginContainer")
		var startpos = find_node("MarginContainer").rect_global_position
		var endpos = Vector2(-(currentPage+1) * get_viewport().size.x,find_node("MarginContainer").rect_global_position.y)
		tween.interpolate_property(target,"rect_global_position", startpos, endpos, 1,Tween.TRANS_QUINT, Tween.EASE_OUT)
		tween.start()
		currentPage += 1
		emit_signal("change_page",currentPage )
	else :
		var lastpos = -(currentPage) * get_viewport().size.x #####NEED TO HAVE COORDONATE OF THE NEAR PAGE
		go_near(lastpos)
		
#	print("right, current : ", currentPage)
#### FUNCTIONS IF DRAGGED BUT NOT SWIPPED

func _on_Swipe_detector_swiped_canceled(start_position):
#	print("not swiping")
	var lastpos = -(currentPage) * get_viewport().size.x #####NEED TO HAVE COORDONATE OF THE NEAR PAGE
	go_near(lastpos);
	
func go_near(nearpage):
	var tween = find_node("Tween")
	var target = find_node("MarginContainer")
	var startpos = find_node("MarginContainer").rect_global_position
	var endpos = Vector2(nearpage,find_node("MarginContainer").rect_global_position.y)
	tween.interpolate_property(target,"rect_global_position", startpos, endpos, 1,Tween.TRANS_QUINT, Tween.EASE_OUT)
	tween.start()

func goToPage(page : int):
	var nearpage = -(page) * get_viewport().size.x
	var tween = find_node("Tween")
	var target = find_node("MarginContainer")
	var startpos = find_node("MarginContainer").rect_global_position
	var endpos = Vector2(nearpage,find_node("MarginContainer").rect_global_position.y)
	tween.interpolate_property(target,"rect_global_position", startpos, endpos, 1,Tween.TRANS_QUINT, Tween.EASE_OUT)
	tween.start()
	currentPage = page

####UTILS
func _on_retour_pressed():
	Global.change_scene("res://page/home/home.tscn")

