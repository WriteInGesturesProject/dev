extends Node

class_name Item

var itemName: String setget set_item_name, get_item_name
var price: int setget set_price, get_price
var picturePath: String setget set_picture_path, get_picture_path
var itemType: String setget set_item_type, get_item_type

func set_item_name(_itemName: String) -> void:
	itemName = _itemName

func get_item_name() -> String:
	return itemName

func set_price(_price: int) -> void:
	price = _price

func get_price() -> int:
	return price

func set_picture_path(_picturePath: String) -> void:
	picturePath = _picturePath

func get_picture_path() -> String:
	return picturePath

func set_item_type(_itemType: String) -> void:
	itemType = _itemType

func get_item_type() -> String:
	return itemType

func to_string() -> String:
	var result := ""
	result += "itemName: " + itemName + "\n"
	result += "itemType: " + itemName + "\n"
	result += "price: " + String(price) + "\n"
	return result

func to_dictionary() -> Dictionary:
	var result := {}
	result["itemName"] = itemName
	result["price"] = price
	result["picturePath"] = picturePath
	result["itemType"] = itemType
	return result

func from_dictionary(content: Dictionary) -> Item:
	itemName = content["itemName"]
	price = content["price"]
	picturePath = content["picturePath"]
	itemType = content["itemType"]
	return self
