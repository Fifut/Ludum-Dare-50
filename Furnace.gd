extends Area2D


onready var Timer 			= $Timer
onready var AnimationPlayer	= $AnimationPlayer
onready var AudioPut		= $AudioPut
onready var AudioFire		= $AudioFire
onready var ProgressBar		= $ProgressBar


var _body = null


func _ready():
	AudioFire.play()
	AnimationPlayer.set_current_animation("Fire burn")


func _process(delta):
	
	# Set progress bar value
	ProgressBar.value = Timer.get_time_left()
	

	# If player interact with furnace
	if _body != null and Input.is_action_just_pressed("ui_accept"):
		
		# Get player items
		var item = _body.getItem()
		
		# If items name is not null
		if item[0] != "none":
			
			# Add time to fire
			var time = Timer.get_time_left()
			time += item[1]
			Timer.set_wait_time(time)
			Timer.start()
			
			#Play put wood in fire sound and anim
			AudioPut.play()
			AnimationPlayer.set_current_animation("Fire burn")
			
			# Start fire sound if stoped
			if not AudioFire.is_playing():
				AudioFire.play()


func _on_body_entered(body):
	_body = body


func _on_body_exited(body):
	_body = null


# Fire stop
func _on_Timer_timeout():
	AudioFire.stop()
	AnimationPlayer.set_current_animation("Stop")
