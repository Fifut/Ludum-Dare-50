extends Node



var menu = preload("res://Menu.tscn").instance()
var game = preload("res://World.tscn")


func _ready():
	add_child(menu)
	Engine.connect("start_game", self, "startGame" )


func startGame():
	remove_child(menu)
	add_child(game.instance( ))
