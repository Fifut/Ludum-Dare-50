extends Area2D



var _body = null



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	
	if _body != null and Input.is_action_just_pressed("ui_accept"):
		var item = _body.getItem()
		
		if item != "none":
			print("Furnace : receive " + item)
			var time = $Timer.get_time_left()
			time += 10
			$Timer.set_wait_time(time)
			print("Furnace : time " + str(time))




func _on_body_entered(body):
	_body = body


func _on_body_exited(body):
	_body = null
