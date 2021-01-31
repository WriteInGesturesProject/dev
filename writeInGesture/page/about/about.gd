extends Control

var margin = 0.05
var vectorMarge

# Called when the node enters the scene tree for the first time.
func _ready():
	#make margin of the scene
	Global.make_margin(find_node("MarginContainer"),margin)
	vectorMarge = get_viewport().size *(1-2*margin)
	find_node("MarginContributors").rect_min_size.x = vectorMarge.x / 4
	find_node("MarginContributors").add_constant_override("margin_top",vectorMarge.y / 8)
	find_node("MarginContributors").add_constant_override("margin_bottom",vectorMarge.y / 12)
	Global.make_margin(find_node("MainPage"),0.015)
	#change size of button depending on the screen size
	find_node("Label").get_font("font").size = Global.h2Font

func _on_Back_pressed():
	Global.manageScreen.changeScene("res://page/home/home.tscn")

#open the url of the gitlab when click on it
func _on_goLinkPressed(url):
	OS.shell_open(url)


#######################################SCROLLING#################################################
#variable for scrolling 
var swiping = false
var release = false
var isswipping = false
var swipe_start
var swipe_mouse_start
var swipe_mouse_times = []
var swipe_mouse_positions = []

#make a scroll if there is too much information in the page
func _input(ev):
	if swiping and ev is InputEventMouseMotion:
		var delta = ev.position - swipe_mouse_start
		if(delta.length()>10):
			find_node("TextContributors").get_v_scroll().value = (swipe_start.y - delta.y)
			swipe_mouse_times.append(OS.get_ticks_msec())
			swipe_mouse_positions.append(ev.position)
			isswipping = true
	elif ev is InputEventMouseButton:
		if ev.pressed:
			release = false
			swiping = true
			swipe_start = Vector2(0,find_node("TextContributors").get_v_scroll().value)
			swipe_mouse_start = ev.position
			swipe_mouse_times = [OS.get_ticks_msec()]
			swipe_mouse_positions = [swipe_mouse_start]
		else:
			#When we release the button
			swipe_mouse_times.append(OS.get_ticks_msec())
			swipe_mouse_positions.append(ev.position)
			var source = Vector2(0, 
			find_node("TextContributors").get_v_scroll().value)
			var idx = swipe_mouse_times.size() - 1
			var now = OS.get_ticks_msec()
			var cutoff = now - 100
			for i in range(swipe_mouse_times.size() - 1, -1, -1):
				if swipe_mouse_times[i] >= cutoff: idx = i
				else: break
			var flick_start = swipe_mouse_positions[idx]
			var flick_dur = min(0.3, (ev.position - flick_start).length() / 1000)
			if flick_dur > 0.0:
				var tween = Tween.new()
				add_child(tween)
				var delta = ev.position - flick_start
				var target = source - delta * flick_dur * 15.0
				tween.interpolate_method(self, 'set_h_scroll', source.x, target.x, flick_dur, Tween.TRANS_LINEAR, Tween.EASE_OUT)
				tween.interpolate_method(self, 'set_v_scroll', source.y, target.y, flick_dur, Tween.TRANS_LINEAR, Tween.EASE_OUT)
				tween.interpolate_callback(tween, flick_dur, 'queue_free')
				tween.start()
			if isswipping:
				release = true
			else:
				release = false
			swiping = false
			isswipping =false
#######################################END_SCROLLING#################################################
