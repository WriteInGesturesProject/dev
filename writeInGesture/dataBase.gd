extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const Sqlite = preload("res://addons/gd-sqlite/gdsqlite.gdns");

# Called when the node enters the scene tree for the first time.
func _ready():
	var db = Sqlite.new();
	var created = db.open("user://data/database.sql")
	if(!created):
		return
	var query_Player = "CREATE TABLE IF NOT EXISTS player ( "
	query_Player += "number INTEGER PRIMARY KEY,"
	query_Player += "name TEXT NOT NULL,"
	query_Player += "nbPiece INTEGER NOT NULL,"
	query_Player += "picture TEXT NOT NULL );"

	var query_Exercise = "CREATE TABLE IF NOT EXISTS exercise ( "
	query_Exercise += "versionNumber FLOAT PRIMARY KEY,"
	query_Exercise += "arrayPhonemesWords TEXT NOT NULL,"
	query_Exercise += "arrayWords TEXT NOT NULL);"
	
	var query_Stat = "CREATE TABLE IF NOT EXISTS statistic ( "
	query_Stat += "id INTEGER PRIMARY KEY,"
	query_Stat += "versionNumberExercise FLOAT"
	query_Stat += "arrayResult TEXT NOT NULL,"
	query_Stat += "playerNumber INTEGER NOT NULL);"
	
	if(!db.query(query_Player)) :
		print("query")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
