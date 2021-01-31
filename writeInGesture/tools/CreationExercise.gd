extends Node

const Word = preload("res://entity/Word.gd")
const WordsAvailable = preload("res://entity/WordsAvailable.gd")
const MyDictionnary = preload("res://entity/Dictionnary.gd")
const Exercise = preload("res://entity/Exercise.gd")
const TypeExercise = preload("res://entity/TypeExercise.gd")

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
	var nbWordsOccurrences = []
	var wordsSuccess = []
	var successPercentage = []
	for i in range(0,Global.nbDifficulty):
		var tmp = []
		for word in words:
			tmp.append(0)
		nbWordsOccurrences.append(tmp)
		wordsSuccess.append(tmp)
		successPercentage.append(0.0)

	for word in words:
		newCustomExercise.addWord(word)

	newCustomExercise.putNbWordOccurrence(nbWordsOccurrences)
	newCustomExercise.putWordSuccess(wordsSuccess)
	newCustomExercise.putSuccessPercentage(successPercentage)
	
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
	
func updateExercises(wordsAvailable):
	#print("Creation of custom exercise")
	Global.customExercise = self.creationExercise(Global.customExercise, wordsAvailable)
	#print("Creation of goose exercise")
	Global.gooseExercise = self.creationExercise(Global.gooseExercise, wordsAvailable)
	#print("Creation of listen exercise")
	Global.listenExercise = self.creationExercise(Global.listenExercise, wordsAvailable)
	#print("Creation of memory exercise")
	Global.memoryExercise = self.creationExercise(Global.memoryExercise, wordsAvailable)
	Global.exercises = [Global.customExercise, Global.countExercise, Global.weekExercise, Global.colorExercise, Global.gooseExercise, Global.listenExercise, Global.memoryExercise]
	Global.database.update()

#######################################END_CREATION_OF_EXERCISE##################################

