extends Control

# Learning template
# This template rely on learning element which contains an icon and a name, 
# and in this scene you can scroll through all the learning elements.

var learningElementResource := load("res://shared/learning/learning_element.tscn")

#add_learning_element -> add a learning element to the current scene
#title: String -> Self-explanatory
#learningScenePath: String -> Self-explanatory
#iconPath: String -> Path to an icon if the learning scene has one
#sceneArgument: Array -> Argument for the learning scene if needed
func add_learning_element(title: String, learningScenePath: String, iconPath: String = "", sceneArgument: Array = []) -> void:
	var newLearningElement = learningElementResource.instance()
	newLearningElement.setup(title, learningScenePath, iconPath, sceneArgument)
	$ScrollContainer/HBoxContainer.add_child_below_node($ScrollContainer/HBoxContainer/filler_start, newLearningElement)
