extends Node


signal start_game


# Declare member variables here. Examples:
var _temperature
var _item = ""
var _fire_status: = true
var _score = 0




# Called when the node enters the scene tree for the first time.
func _ready():
	_temperature = 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/HUD/Control/VBoxContainer/Temperature.text = "Temperature " + str(_temperature)
	$CanvasLayer/HUD/Control/VBoxContainer/Item.text = "Item  " + str(_item)



func setItem(name: String):
	_item = name



func setFire(status: bool):
	if status:
		$CanvasLayer/HUD/Timer.stop()
		$CanvasLayer/HUD/Timer.start()
		_fire_status = true
	else:
		$CanvasLayer/HUD/Timer.stop()
		$CanvasLayer/HUD/Timer.start()
		_fire_status = false



func _on_Timer_timeout():
	
	if _fire_status and _temperature < 25:
		$CanvasLayer/HUD/Control/VBoxContainer/Temperature.modulate = "#00ff00"
		_temperature += 1
	elif not _fire_status:
		$CanvasLayer/HUD/Control/VBoxContainer/Temperature.modulate = "#ff0000"
		_temperature -= 1


func getScore():
	return _score
