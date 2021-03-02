extends Control



var itemCategoryRessource := preload("./item_category.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$playerName.text = Global.player.getName()
	$StarsNumber.text = str(Global.player.getStars())
	pass # Replace with function body.

func add_item_category() -> void:
	for i in 3:
		var newItemCategory = itemCategoryRessource.instance()
		#newItemCategory.setup(scenePath, difficulty[NAME], difficulty[LOCKED], difficulty[LOCKED_INFO])
		$ScrollContainer/ItemCategory.add_child(newItemCategory)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
