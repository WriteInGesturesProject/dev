extends Control


#Variable

var firstname
var lastname
var age
var ID
var dictionnaryResult

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#GET PARTY
func _on_Button_Get_pressed():
	print ("GET HTTPS")
	var header= [] #To Complete
	if ID!=null:
		$HTTPRequestGet.request("https://artiphonie.westeurope.cloudapp.azure.com:8443//api/v1/enfant/"+ID,header,false,HTTPClient.METHOD_GET);
	else:
		print("Error ID")


func _on_HTTPRequestGet_request_completed(result, response_code, headers, body):
	if result==HTTPRequest.RESULT_SUCCESS:
		print(response_code)
		if response_code==200:
			print(body.get_string_from_utf8())
			dictionnaryResult=parse_json(body.get_string_from_utf8())
			print(dictionnaryResult)
			get_node("LabelResult/LabelFirstnameResult").text=dictionnaryResult.prenom
			get_node("LabelResult/LabelLasttnameResult").text=dictionnaryResult.nom
			get_node("LabelResult/LabelAgeResult").text=String(dictionnaryResult.age)
		else:
			print("HTTPS Error")


#POST PARTY
func _on_Button_Post_pressed():
	print("POST HTTPS")
	if firstname!=null && lastname!=null:
		var data_to_send={"prenom":firstname,"nom":lastname,"age":age}
		var query=JSON.print(data_to_send)
		var header= ["Content-Type:application/json","Content-Length: "+str(query.length())]
		print(query)
		$HTTPRequestPost.request("https://artiphonie.westeurope.cloudapp.azure.com:8443/api/v1/enfant",header,false,HTTPClient.METHOD_POST,query);
	else:
		print("Error : Fields Null")



func _on_HTTPRequestPost_request_completed(result, response_code, headers, body):
	if result==HTTPRequest.RESULT_SUCCESS:
		print(response_code)
		if response_code==200:
			print(body.get_string_from_utf8())
		else:
			print("HTTPS Error")

func _on_LineEditFirstname_text_changed(new_text):
	firstname=new_text
	print(firstname)
	
func _on_LineEditLastname_text_changed(new_text):
	lastname=new_text
	print(lastname)


func _on_LineEditAge_text_changed(new_text):
	age=new_text
	print(age)


func _on_LineID_text_changed(new_text):
	ID=new_text
	print(ID)
