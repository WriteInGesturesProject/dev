extends Node

class_name Entity

func to_string() -> String:
	push_error("Function to_string() not implemented\n")
	return ""

func to_dictionary() -> Dictionary:
	push_error("Function to_dictionary() not implemented\n")
	return {}

func from_dictionary(content: Dictionary) -> Entity:
	push_error("Function to_dictionary() not implemented\n")
	return self
