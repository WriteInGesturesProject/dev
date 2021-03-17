extends Control

# The about scene is pretty self-explanatory, it show the about information
# related to the current app

func _ready():
	find_node("TextContributors").set_text(loadAboutContent())
	find_node("TextContributors").set_selection_enabled(true)

# This load the content of the about section, to know which content
# should be loaded it takes the arguments given when the scene changed
# which means when the about button pressed (see about_button.tscn/.gd)
func loadAboutContent() -> String:
	var currentApp: String = Global.get_arguments()[0]
	if(currentApp != null):
		var file = File.new()
		file.open("res://data/"+currentApp+"/aboutContent.txt", File.READ)
		var content = file.get_as_text()
		file.close()
		return content
	else:
		return ""

#open the url of the gitlab when click on it
func _on_goLinkPressed(url):
	OS.shell_open(url)
