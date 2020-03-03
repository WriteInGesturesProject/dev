extends Node

var version : float
var pathExercisesFiles : Array
var loginAdmin : String
var passWordAdmin : String
var nameFile : String

func getVersion() -> float :
	return version

func setVersion(version : float) :
	self.version = version
	return ManageJson.putElement(nameFile, "Config/version", version)

func getPathExercisesFiles() -> Array :
	return pathExercisesFiles

func setPathExercisesFiles(oldPathExercisesFiles : String, newPathExercisesFiles : String) :
	var index = pathExercisesFiles.find(oldPathExercisesFiles)
	if index == -1 :
		print("Le nom de fichier à remplacer n'existe pas'")
		return -1
	else:
		pathExercisesFiles[index] = newPathExercisesFiles
		return ManageJson.putElement(nameFile, "Config/pathExercisesFiles", pathExercisesFiles)

func getLoginAdmin() -> String :
	return loginAdmin

func setLoginAdmin(loginAdmin : String) :
	self.loginAdmin = loginAdmin
	return ManageJson.putElement(nameFile, "Config/loginAdmin", loginAdmin)

func getPassWordAdmin() -> String :
	return passWordAdmin

func setPassWordAdmin(passWordAdmin : String) :
	self.passWordAdmin = passWordAdmin
	return ManageJson.putElement(nameFile, "Config/passWordAdmin", passWordAdmin)

func setAttribut(field : String, input):
	match field : 
		"version" :
			version = input
		"pathExercisesFiles" : 

			for path in input:
				pathExercisesFiles.append(path)
		"loginAdmin" : 
			loginAdmin = input
		"passWordAdmin" : 
			passWordAdmin = input
		"nameFile" : 
			nameFile = input
	return

func toString() -> String : 
	var res = "version : "+String(version)+"\n"
	res += "[ \n"
	for path in pathExercisesFiles:
		res += path+" , "
	res += "] \n"
	res += "loginAdmin : "+loginAdmin+"\n"	
	res += "passWordAdmin : "+passWordAdmin+"\n"
	res += "nameFile : "+nameFile+"\n"	
	return res
