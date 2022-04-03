extends Area2D


export var name_ = "none"
export var power = 10
export var health = 5


onready var ProgressBar 		= $ProgressBar
onready var AnimationPlayer		= $AnimationPlayer
onready var AudioStreamPlayer	= $AudioStreamPlayer


var _body = null


func _ready():
	ProgressBar.visible = false
	ProgressBar.max_value = health


func _process(delta):
	
	# If player interact with object
	if _body != null and Input.is_action_just_pressed("ui_accept"):
		
		# If player inventory empty
		if _body.isEmpty():
			
			# Object health -1
			health -= 1
			
			# Show progessbar and set value
			ProgressBar.visible = true
			ProgressBar.value = health
			
			# Play "hurt" sound and anim
			AudioStreamPlayer.stop()
			AnimationPlayer.stop()
			
			AnimationPlayer.play("Hit")
			AudioStreamPlayer.play()
			#yield(AudioStreamPlayer, "finished")

			# If object health = 0, give object to player and delete it
			if health < 1:
				_body.setItem(name_, power)
				queue_free()


func _on_body_entered(body):
	_body = body


func _on_body_exited(body):
	_body = null
