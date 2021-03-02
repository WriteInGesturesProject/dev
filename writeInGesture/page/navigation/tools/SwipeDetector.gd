extends Node

var MAX_DIAGONAL_SLOPE = 1.3
var MIN_SWIPE = 200
var BEGIN_SWIPE_MIN = 10

signal swiped(direction)
signal swiped_canceled(start_position)
signal distance_from_last(current_position)
signal start_swiping(start_position)

var start = false
var swipe_start_position = Vector2()
var last_position = Vector2()
var current_distance = Vector2()

func _input(event : InputEvent):
	if(start && event.position.distance_to(swipe_start_position) > BEGIN_SWIPE_MIN && event is InputEventMouseMotion ):
#		print(event)
		emit_signal("distance_from_last",event.position - last_position)
#		last_position = event.position 
	if not event is InputEventMouseButton :
		return
	if event.pressed :
		start = true
		_start_detection(event.position)
	else :
		_end_detection(event.position)
	

func _start_detection(pos):
	emit_signal("start_swiping",pos)
	swipe_start_position = pos
	last_position = pos
	

func _end_detection(pos):
	start = false
	var distance = pos.distance_to(swipe_start_position)
	
	var direction = (pos - swipe_start_position).normalized()
#	print(abs(direction.x) + abs(direction.y))
	if(abs(direction.x) + abs(direction.y) >= MAX_DIAGONAL_SLOPE || distance < MIN_SWIPE) :
		emit_signal("swiped_canceled", swipe_start_position)
		return
	#-1 left 1 right
	if abs(direction.x) > abs(direction.y) :
		emit_signal('swiped', Vector2(-sign(direction.x),0.0))
	else :
		emit_signal('swiped', Vector2(0.0,-sign(direction.y)))

