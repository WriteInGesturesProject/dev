extends Control

# Template scene for when a game ends 

# When a game ends he should change scene to this one
# and he should give those arguments:
# args[0]: String -> Path to the scene of the game just played
# args[1]: Array -> Arguments to give to the scene of the game just
#					played, to replay it with the same difficulty
#					(or other if the arguments are used for something else)
# args[2]: String -> Name of the game just played
# args[3]: String -> Difficulty played
# args[4]: int -> Number of stars gained (score in a way)
# args[5]: int -> If the game played relied on time then this is used to
#				  display the time in end game scene

# Not every arguments are used now, but they are sent anyway in the case
# where the end game scene is remade and needs more arguments. Because right now
# the game end scene is pretty bare-bone.

var args : Array
var gamePlayedScene : String
var argsToRestartGame : Array
var gamePlayedName : String
var difficulty : String
var scoreTmp : int
var score : int
var time : int
var starScale = Vector2(0.2,0.2)

func _ready():
	find_node("nbStars").text = str(Global.player.get_stars())
	
	args = Global.get_arguments()
	gamePlayedScene = args[0]
	argsToRestartGame = args[1]
	gamePlayedName = args[2]
	difficulty = args[3]
	score = args[4]
	time = args[5] 
	
	scoreTmp = score
	
	$gameName.text = gamePlayedName


func _process(delta):
	earnStar()

func animationStar(indexStar : int) :
	var star = Sprite.new()
	var size : Vector2
	var target : Vector2
	
	self.add_child(star)
	star.scale = starScale
	star.texture = load("res://assets/icons/centerStar.png")
	
	size = star.texture.get_size()*star.scale
	#if there are too much star for the scree, star overlay each other
	if (size.x*score>(self.rect_size.x/2)):
		size.x = (self.rect_size.x/2)/score
		
	target = Vector2(find_node("starsImage").rect_global_position.x+find_node("starsImage").rect_size.x/2, find_node("starsImage").rect_global_position.y+find_node("starsImage").rect_size.x/2)
	
	star.position.y = self.rect_size.y/2 - size.y
	star.position.x = self.rect_size.x/2 + (size.x * score/2) - (size.x * indexStar)

	#create the animation
	var tween = Tween.new()
	star.add_child(tween)
	tween.interpolate_property(star, "position", star.position, target, 2, Tween.TRANS_QUINT, Tween.EASE_IN)
	tween.start()
	tween.interpolate_callback(self, 2, "finishAnimation", star)


func finishAnimation(star: Sprite):
	star.remove_and_skip()
	Global.player.set_stars(Global.player.get_stars() + 1)
	find_node("nbStars").text = str(int(find_node("nbStars").text)+1)

func earnStar() :
	if(scoreTmp > 0) :
		animationStar(scoreTmp)
		scoreTmp -= 1

func _on_Replay_pressed():
		Global.change_scene(gamePlayedScene, argsToRestartGame)
