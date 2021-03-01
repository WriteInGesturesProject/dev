extends Control


#Variable

var firstname
var lastname
var token
var ID
var dictionnaryResult

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#GET PARTY
func _on_Button_Get_pressed():
	print ("GET HTTP")
	var header= [] #To Complete
	if ID!=null:
		$HTTPRequestGet.request("http://localhost:8080/api/v1/enfant/"+ID,header,false,HTTPClient.METHOD_GET);
	else:
		print("Error ID")


func _on_HTTPRequestGet_request_completed(result, response_code, headers, body):
	if result==HTTPRequest.RESULT_SUCCESS:
		print(response_code)
		if response_code==200:
			print(body.get_string_from_utf8())
			dictionnaryResult=parse_json(body.get_string_from_utf8())
			print(dictionnaryResult)
			get_node("LabelResult/LabelFirstnameResult").text=dictionnaryResult.firstname
			get_node("LabelResult/LabelLasttnameResult").text=dictionnaryResult.lastname
			get_node("LabelResult/LabelTokenResult").text=String(dictionnaryResult.token)
		else:
			print("HTTP Error")


#POST PARTY
func _on_Button_Post_pressed():
	print("POST HTTP")
	if firstname!=null && lastname!=null:
		var data_to_send={"firstname":firstname,"lastname":lastname,"token":token}
		var query=JSON.print(data_to_send)
		var header= ["Content-Type:application/json","Content-Length: "+str(query.length())]
		print(query)
		$HTTPRequestPost.request("http://localhost:8080/api/v1/enfant",header,false,HTTPClient.METHOD_POST,query);
	else:
		print("Error : Fields Null")



func _on_HTTPRequestPost_request_completed(result, response_code, headers, body):
	if result==HTTPRequest.RESULT_SUCCESS:
		print(response_code)
		if response_code==200:
			print(body.get_string_from_utf8())
		else:
			print("HTTP Error")

func _on_LineEditFirstname_text_changed(new_text):
	firstname=new_text
	print(firstname)
	
func _on_LineEditLastname_text_changed(new_text):
	lastname=new_text
	print(lastname)


func _on_LineEditToken_text_changed(new_text):
	token=new_text
	print(token)


func _on_LineID_text_changed(new_text):
	ID=new_text
	print(ID)
