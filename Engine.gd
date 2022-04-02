extends Node


# Declare member variables here. Examples:
var _temperature
var _item = ""
var _fire_status: = true



# Called when the node enters the scene tree for the first time.
func _ready():
	_temperature = 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/VBoxContainer/Temperature.text = "Temperature " + str(_temperature)
	$Control/VBoxContainer/Item.text = "Item  " + str(_item)



func setItem(name: String):
	_item = name



func setFire(status: bool):
	if status:
		$Timer.stop()
		$Timer.start()
		_fire_status = true
	else:
		$Timer.stop()
		$Timer.start()
		_fire_status = false



func _on_Timer_timeout():
	
	if _fire_status and _temperature < 25:
		_temperature += 1
	elif not _fire_status:
		_temperature -= 1
