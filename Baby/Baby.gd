extends Area2D


onready var TimerCry 			= $TimerCry
onready var TimerRock 			= $TimerRock
onready var TimerEnd			= $TimerEnd
onready var AudioCry 			= $AudioCry
onready var AudioRock 			= $AudioRock
onready var AnimatedSprite 		= $AnimatedSprite
onready var ProgressBarGreen 	= $ProgressBarGreen
onready var ProgressBarRed	 	= $ProgressBarRed
onready var AnimationPlayer	 	= $AnimationPlayer


export var RockTimeAdd	:= 20
export var EndTime		:= 10


var _body = null


func _ready():
	TimerRock.set_wait_time(RockTimeAdd)
	TimerRock.start()
	
	# Display and hide progress bars
	ProgressBarGreen.visible = true
	ProgressBarGreen.max_value = RockTimeAdd
	
	ProgressBarRed.visible = false
	ProgressBarRed.max_value = EndTime


func _process(delta):
	
	# Set progress bars values
	ProgressBarGreen.value = TimerRock.get_time_left()
	ProgressBarRed.value = TimerEnd.get_time_left()
	
	if not Engine.getFire():
		_cry()
	
	# If player interact with baby when anim not playing
	if _body != null and not AnimatedSprite.is_playing() and Input.is_action_just_pressed("ui_accept"):
		
		# Play roock sound and anim
		AnimatedSprite.play()
		AudioRock.play()
		
		# Stop cry sound timer
		TimerCry.stop()
		
		# Stop end timer
		ProgressBarRed.visible = false
		TimerEnd.set_wait_time(EndTime)
		TimerEnd.stop()
		
		# Start rock timer
		ProgressBarGreen.visible = true
		TimerRock.set_wait_time(RockTimeAdd)
		TimerRock.start()


func _cry():
	if TimerCry.is_stopped():
		AudioCry.play()
		AnimationPlayer.play("Cry")
		TimerCry.start()
			
		ProgressBarGreen.visible = false
		ProgressBarRed.visible = true
		TimerEnd.start()


func _on_Baby_body_entered(body):
	_body = body


func _on_Baby_body_exited(body):
	_body = null


func _on_AnimatedSprite_animation_finished():
	AnimatedSprite.stop()


func _on_TimerSound_timeout():
	AudioCry.play()
	AnimationPlayer.play("Cry")


func _on_TimerRock_timeout():
	_cry()


func _on_TimerEnd_timeout():
	Engine.emit_signal("end_game")
