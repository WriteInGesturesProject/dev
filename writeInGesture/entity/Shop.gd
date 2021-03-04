extends Entity

class_name Shop

var items: Array setget set_items, get_items

var sortedItems: Dictionary

func _init():
	items = []
	sortedItems = {}

func set_items(_items: Array) -> void:
	items = _items

func get_items() -> Array:
	return items

func add_item(item: Item) -> bool:
	for i in items:
		if item.equals(i):
			return false
	items.append(item)
	if sortedItems.has(item.itemType):
		var i := 0
		while i < sortedItems[item.itemType].size() and sortedItems[item.itemType][i].price <= item.price:
			i += 1
		sortedItems[item.itemType].insert(i, item)
	else:
		sortedItems[item.itemType] = [item]
	return true

func remove_item(position: int) -> bool:
	if position < 0 or position >= items.size():
		return false
	var item: Item = items[position]
	for i in range(sortedItems[item.itemType].size()):
		if item.equals(sortedItems[item.itemType][i]):
			sortedItems[item.itemType].remove(i)
			break
	items.remove(position)
	return true

func erase_item(item: Item) -> bool:
	for i in range(item.size()):
		if item.equals(items[i]):
			return remove_item(i)
	return false

func get_items_by_type(type: String) -> Array:
	return sortedItems[type]

func to_string() -> String:
	var result := ""
	for item in items:
		result += item.to_string()
		result += "\n ==== \n"
	return result

func to_dictionary() -> Dictionary:
	var result := {}
	result["items"] = []
	for item in items:
		result["items"].append(item.to_dictionary())
	return result

func from_dictionary(content: Dictionary) -> Entity:
	items = []
	for item in content["items"]:
		add_item(Item.new().from_dictionary(item))
	return self
