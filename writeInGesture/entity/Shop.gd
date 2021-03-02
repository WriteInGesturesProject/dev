extends Node

class_name Shop

var items: Array setget set_items, get_items

var sortedItems: Dictionary

func set_items(_items: Array) -> void:
	items = _items

func get_items() -> Array:
	return items

func add_item(item: Item) -> bool:
	#TODO: Make sure that there is no duplicate
	items.append(item)
	return true

func remove_item(position: int) -> bool:
	#TODO: Make sure the item is correctly removed
	items.remove(position)
	return true

func erase_item(item: Item) -> bool:
	#TODO: Make sure the item is correctly erased
	items.erase(item)
	return true

func get_items_by_type(type: String) -> Array:
	return sortedItems[type]
