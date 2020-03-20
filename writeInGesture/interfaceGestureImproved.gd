extends Control

var swiping = false
var release = false
var isswipping = false
var swipe_start
var swipe_mouse_start
var swipe_mouse_times = []
var swipe_mouse_positions = []


# Called when the node enters the scene tree for the first time.
func _ready():
	var dict = Global.phoneticDictionnary
	for i in range(0, dict.size()):
		var currentVbox = VBoxContainer.new()
		var paragraph = dict.keys()[i]
		var array = dict[paragraph]
		var label = Label.new()
		label.text = paragraph
		label.add_color_override("font_color", Color(255,255,255))
		label.size_flags_horizontal = SIZE_EXPAND_FILL
		label.align = Label.ALIGN_CENTER
		currentVbox.add_child(label)
		for j in range(0, array.size()):
			var currentButton = Button.new()
			currentButton.theme = load("res://assets/theme/ButtonTheme.tres")
			var text = ""
			var dict2 = array[j]
			##print(dict2)
			for k in range (0,dict2.size()):
				if(k<3):
					var phonetic = dict2[dict2.keys()[k]]
					if(k>=1):
						text += " "
					text += phonetic
			currentButton.text = text
			currentVbox.add_child(currentButton)
			currentButton.name = text
			currentButton.connect("pressed",self,"_on_allbutton_pressed",[currentButton])
			currentButton.editor_description = dict2["ressource_path"]
		find_node("MainContainer").add_child(currentVbox)
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://home.tscn")


func _on_allbutton_pressed(arg):
	if(!release):
		var description = load("res://interfaceDescriptionGesture.tscn")
		var root = get_tree().get_root()
		var current_scene = root.get_child(root.get_child_count() - 1)
		
		current_scene = description.instance()
		get_tree().get_root().add_child(current_scene)
		current_scene = root.get_child(root.get_child_count() - 1)
		current_scene.find_node("Name").set_text(arg.get_text())
		
		var parsed_name = arg.get_text().split(" ")
		current_scene = root.get_child(root.get_child_count() - 1)
		current_scene.find_node("Sound").set_text(parsed_name[0])
		current_scene.find_node("Name").set_text(parsed_name[1])
		var texture = current_scene.find_node("Borel")
		
		var image = load("res://art/imgBorel/"+arg.editor_description)
		
		var video = current_scene.find_node("VideoPlayer")
		var stream = load("res://art/videoBorel/"+String(arg.editor_description).split(".")[0]+".ogv")
		
		if(stream == null):
			print("res://art/videoBorel/"+String(arg.editor_description).split(".")[0]+".ogv non trouvé")
		video.set_stream(stream)
		
		texture.texture = image
		texture.expand = true
		texture.stretch_mode = 6 #TextureRect.STRETCH_SCALE_ON_EXPAND
		
		

		


# Allows you to scroll a scroll container by dragging.
# Includes momentum.

func _input(ev):
	if swiping and ev is InputEventMouseMotion:
		var delta = ev.position - swipe_mouse_start
		##print(delta.length())
		if(delta.length()>10):
			$"MarginContainer/VBoxContainer/ScrollContainer".set_h_scroll(swipe_start.x - delta.x)
			$"MarginContainer/VBoxContainer/ScrollContainer".set_v_scroll(swipe_start.y - delta.y)
			swipe_mouse_times.append(OS.get_ticks_msec())
			swipe_mouse_positions.append(ev.position)
			isswipping = true
	elif ev is InputEventMouseButton:
		if ev.pressed:
			swiping = true
			swipe_start = Vector2($"MarginContainer/VBoxContainer/ScrollContainer".get_h_scroll(),
			 $"MarginContainer/VBoxContainer/ScrollContainer".get_v_scroll())
			swipe_mouse_start = ev.position
			swipe_mouse_times = [OS.get_ticks_msec()]
			swipe_mouse_positions = [swipe_mouse_start]
		else:
			#When we release the button
			swipe_mouse_times.append(OS.get_ticks_msec())
			swipe_mouse_positions.append(ev.position)
			var source = Vector2($"MarginContainer/VBoxContainer/ScrollContainer".get_h_scroll(), 
			$"MarginContainer/VBoxContainer/ScrollContainer".get_v_scroll())
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
			##print(isswipping)
			if isswipping:
				release = true
			else:
				release = false
			swiping = false
			isswipping =false
				
	
