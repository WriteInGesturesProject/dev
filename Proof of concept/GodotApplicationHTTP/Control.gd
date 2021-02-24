extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_Get_pressed():
	print ("GET HTTP")
	var query="firstname=gaetan&lastname=ruzafa"
	var header= ["From=ArthiphonieTest@gmail.com"]
	$HTTPRequestGet.request("http://requestbin.net/r/bz4kewhx?"+query,header,false,HTTPClient.METHOD_GET);


func _on_HTTPRequestGet_request_completed(result, response_code, headers, body):
	if result==HTTPRequest.RESULT_SUCCESS:
		print(response_code)
		if response_code==200:
			print(body.get_string_from_utf8())
		else:
			print("HTTP Error")

func _on_Button_Post_pressed():
	print("POST HTTP")
	var query="firstname=gaetan&lastname=ruzafa"
	var header= ["From=ArthiphonieTest@gmail.com","Content-Type: applicationArtiphonie","Content-Length: "+str(query.length())]
	$HTTPRequestPost.request("http://requestbin.net/r/bz4kewhx",header,false,HTTPClient.METHOD_POST,query);



func _on_HTTPRequestPost_request_completed(result, response_code, headers, body):
	if result==HTTPRequest.RESULT_SUCCESS:
		print(response_code)
		if response_code==200:
			print(body.get_string_from_utf8())
		else:
			print("HTTP Error")
