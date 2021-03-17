extends Node

class_name Entity

# Class which is meant to be extended by all entities
# This simplify the process when handling entities
# For example when saving their ".json" (see Global.gd) 

# Usefull for debugging
func to_string() -> String:
	push_error("Function to_string() not implemented\n")
	return ""

# Usefull for saving an entity to json file
func to_dictionary() -> Dictionary:
	push_error("Function to_dictionary() not implemented\n")
	return {}

# Usefull for reading an entity from a json file
func from_dictionary(content: Dictionary) -> Entity:
	push_error("Function to_dictionary() not implemented\n")
	return self
