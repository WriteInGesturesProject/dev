extends Control

var margin = 0.05
var vectorMarge
var currentApp: String

func _ready():
	var content = loadAboutContent()
	find_node("TextContributors").set_text(content)
	find_node("TextContributors").set_selection_enabled(true)

func loadAboutContent() -> String:
	currentApp = Global.get_arguments()[0]
	if(currentApp != null):
		var file = File.new()
		file.open("res://data/"+currentApp+"/aboutContent.txt", File.READ)
		var content = file.get_as_text()
		file.close()
		print("content"+content)
		return content
	else:
		return ""

#open the url of the gitlab when click on it
func _on_goLinkPressed(url):
	OS.shell_open(url)
	

