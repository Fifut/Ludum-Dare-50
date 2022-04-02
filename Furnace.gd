extends Area2D



var _body = null



# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()



func _process(delta):
	
	
	var time_left = round($Timer.get_time_left() )
	$Time.text = str(time_left)
	

	
	if _body != null and Input.is_action_just_pressed("ui_accept"):
		var item = _body.getItem()
		
		if item[0] != "none":
			print("Furnace : receive " + item[0])
			var time = $Timer.get_time_left()
			time += item[1]
			$Timer.set_wait_time(time)
			$Timer.start()
			print("Furnace : time " + str(time))
			Engine.setFire(true)
			
			if not $AudioStreamPlayer2D.is_playing():
				$AudioStreamPlayer2D.play()




func _on_body_entered(body):
	_body = body


func _on_body_exited(body):
	_body = null


func _on_Timer_timeout():
	$AudioStreamPlayer2D.stop()
	Engine.setFire(false)
