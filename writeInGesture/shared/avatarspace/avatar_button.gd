extends Control

# The avatar button is the scene which display the avatar and the stars of the player
var dictionnaryResult

func _ready():
	print ("GET HTTPS")
	var header= [] #To Complete
	$HTTPRequest.request("https://artiphonie.westeurope.cloudapp.azure.com:8443/api/v1/enfant/"+String(Global.player.get_id_player()),header,false,HTTPClient.METHOD_GET);
	
	
func _on_avatar_button_pressed():
	Global.change_scene("res://shared/avatarspace/avatar_space.tscn")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if result==HTTPRequest.RESULT_SUCCESS:
		print(response_code)
		if response_code==200:
			dictionnaryResult=parse_json(body.get_string_from_utf8())
			print(dictionnaryResult)
			Global.player.set_player_name(dictionnaryResult.prenom)
			Global.player.set_stars(dictionnaryResult.nb_etoile)
			$nbStars.text = str(Global.player.get_stars())
		else:
			print("HTTPS Error")

