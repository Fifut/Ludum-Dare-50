extends Area2D


var _cold = false
var _body = null


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.visible = false


func _process(delta):

	if Engine.getTemperature() < 15 and not _cold:
		_cold = true
		$Label.visible = true
		$Timer.start()
	elif Engine.getTemperature() < 10: 
		Engine.emit_signal("end_game")
	
	
	if _body != null and Input.is_action_pressed("ui_accept") and _cold:
		$AnimatedSprite.play()
		
		if Engine.getTemperature() >= 15:
			_cold = false
			$Timer.stop()
	else:
		$AnimatedSprite.stop()



func _on_Timer_timeout():
	$AudioStreamPlayer.play()



func _on_body_entered(body):
	_body = body



func _on_Baby_body_exited(body):
	_body = null
