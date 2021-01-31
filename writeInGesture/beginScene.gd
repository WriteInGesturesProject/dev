extends Control


var sprite 
var animation 
var animationText
onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = find_node("Sprite")
	animation = find_node("AnimationPlayer")
	animationText = find_node("AnimationText")
	animation.play("run")
	animationText.play("text")
	sprite.position =  label.rect_position + label.rect_size/2
	sprite.position.y += 2*sprite.texture.get_height()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
