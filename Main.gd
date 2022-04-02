extends Node


var menu = preload("res://Menu.tscn")
var game = preload("res://World.tscn")

var menu_instance
var game_instance


func _ready():
	menu_instance = menu.instance()
	add_child(menu_instance)
	Engine.connect("start_game", self, "startGame" )
	Engine.connect("end_game", self, "endGame" )


func startGame():
	remove_child(menu_instance)
	
	game_instance = game.instance()
	add_child(game_instance)


func endGame():
	remove_child(game_instance)
	add_child(menu_instance)
