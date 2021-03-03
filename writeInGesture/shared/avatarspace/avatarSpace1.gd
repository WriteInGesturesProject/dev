extends Control



var itemCategoryRessource := preload("./item_category.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$playerName.text = Global.player.get_player_name()
	$Stars/StarsNumber.text = str(Global.player.get_stars())
	add_item_category()
	pass # Replace with function body.

func set_background():
	pass

func add_item_category() -> void:
	for i in 3:
		var newItemCategory = itemCategoryRessource.instance()
		#newItemCategory.setup(scenePath, difficulty[NAME], difficulty[LOCKED], difficulty[LOCKED_INFO])
		$HScrollBar/ItemCategory.add_child(newItemCategory)
		
func add_item() -> void:
	for i in 10:
		var newItemCategory = itemCategoryRessource.instance()
		#newItemCategory.setup(scenePath, difficulty[NAME], difficulty[LOCKED], difficulty[LOCKED_INFO])
		$ScrollContainer2/Item.add_child(newItemCategory)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
