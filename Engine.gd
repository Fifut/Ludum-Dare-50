extends Node


# Declare member variables here. Examples:
var _temperature = 20
var _item = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/HBoxContainer/Temperature.text = "Temperature " + str(_temperature)
	$Control/HBoxContainer/Item.text = "Item  " + str(_item)


func _on_Timer_timeout():
	_temperature -= 1


func setItem(name: String):
	_item = name
