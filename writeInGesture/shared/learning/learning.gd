extends Control

var learningElementRessource := load("res://shared/learning/learning_element.tscn")
var defaultIcon := load("res://assets/icons/icon.png")

func add_learning_element(title: String, learningScenePath: String, iconPath: String = "") -> void:
	var newLearningElement = learningElementRessource.instance()
	newLearningElement.find_node("title").text = title
	newLearningElement.learningScenePath = learningScenePath
	if iconPath == "":
		newLearningElement.find_node("icon").texture = defaultIcon
	else:
		newLearningElement.find_node("icon").texture = load(iconPath)
	$ScrollContainer/HBoxContainer.add_child_below_node($ScrollContainer/HBoxContainer/filler_start, newLearningElement)
