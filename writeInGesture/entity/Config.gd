extends Node

var version : float
var pathExercisesFiles : Array
var loginAdmin : String
var passWordAdmin : String
var isFirstLaunch : bool
var isRecordPermission : bool
var nameFile : String
var token : String
var refreshToken : String
var localId : String

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
		#print("Le nom de fichier à remplacer n'existe pas'")
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
	
func getFirstLaunch() -> bool :
	return isFirstLaunch

func setFirstLaunch(fl : bool) :
	self.isFirstLaunch = fl
	return ManageJson.putElement(nameFile, "Config/isFirstLaunch", isFirstLaunch)
	
func getRecordPermission() -> bool :
	return isRecordPermission

func setRecordPermission(fl : bool) :
	self.isRecordPermission = fl
	return ManageJson.putElement(nameFile, "Config/isRecordPermission", isRecordPermission)

func getToken():
	return token

func setToken(newToken):
	token = newToken
	return ManageJson.putElement(nameFile, "Config/token", token)

func getRefreshToken():
	return refreshToken

func setRefreshToken(newToken):
	refreshToken = newToken
	return ManageJson.putElement(nameFile, "Config/refreshToken", refreshToken)
	
	
func getLocalId():
	return localId

func setLocalId(id):
	localId = id
	return ManageJson.putElement(nameFile, "Config/localId", localId)


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
		"isRecordPermission" :
			isRecordPermission = input
		"isFirstLaunch":
			isFirstLaunch = input
		"token" :
			token = input
		"refreshToken" :
			refreshToken = input
		"localId" :
			localId = input
			
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
