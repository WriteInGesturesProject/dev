extends Node

const Word = preload("res://Word.gd")
const WordsAvailable = preload("res://WordsAvailable.gd")
const MyDictionnary = preload("res://Dictionnary.gd")
const Exercise = preload("res://Exercise.gd")
const TypeExercise = preload("res://TypeExercise.gd")

#######################################CREATION_OF_EXERCISE######################################
func creationExercise(exercise : Exercise, words : Array):
	var fileName = creationFileExercice(exercise)
	var newCustomExercise = Exercise.new()
	newCustomExercise.setNameFile(fileName)
	ManageJson.getElement(fileName, "Exercise", newCustomExercise)
	newCustomExercise.setVersion(exercise.getVersion()+0.1)
	newCustomExercise.setUserId(Global.player.getId())
	newCustomExercise.setName(exercise.getName())
	newCustomExercise.getType().setName(exercise.getType().getName())
	newCustomExercise.getType().setCategory(exercise.getType().getCategory())
	newCustomExercise.setNbWords(words.size())
	var nbWordsOccurrences =[]
	var wordsSuccess = []
	var sucessPercentage =[]
	for i in range(0,Global.nbDifficulty):
		var tmp = []
		for word in words:
			tmp.append(0)
		nbWordsOccurrences.append(tmp)
		wordsSuccess.append(tmp)
		sucessPercentage.append(0.0)

	for word in words:
		newCustomExercise.addWord(word)

	newCustomExercise.putNbWordOccurrence(nbWordsOccurrences)
	newCustomExercise.putWordSucess(wordsSuccess)
	newCustomExercise.putSucessPercentage(sucessPercentage)
	
	#Set new configuration
	Global.config.setPathExercisesFiles(exercise.getNameFile(),newCustomExercise.getNameFile())
	return newCustomExercise

	
func creationFileExercice(exercise : Exercise):
	var exerciseTemplate = {}
	var text = ManageJson.checkFileExistUserPath("exerciseTemplate.json")
	if text == "": 
		return 0
	var tmp = JSON.parse(text)
	var dict = tmp.result
	var fileName = exercise.getNameFile()
	print(fileName)
	var version = exercise.getVersion()
	version += 0.1
	fileName = fileName.split("_")[0]+"_"+String(version)+".json"
	ManageJson.rewriteFile(fileName, JSON.print(dict))
	return fileName
	
	
	
#######################################END_CREATION_OF_EXERCISE##################################

