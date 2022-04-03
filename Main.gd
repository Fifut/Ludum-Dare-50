extends Node


var menu = preload("res://Menu.tscn")
var game = preload("res://World.tscn")


var menu_instance
var game_instance


func _ready():
	# Add main menu scene
	menu_instance = menu.instance()
	add_child(menu_instance)
	
	# Connect self to start and end game signals
	Engine.connect("start_game", self, "startGame" )
	Engine.connect("end_game", self, "endGame" )


func startGame():
	# Remove main menu scene
	remove_child(menu_instance)
	
	# Add game scene
	game_instance = game.instance()
	add_child(game_instance)


func endGame():
	# Remove game scene
	remove_child(game_instance)
	
	# Add main menu scene
	add_child(menu_instance)
