extends Node2D

var state
var timer
var progress: ProgressBar
# Called when the node enters the scene tree for the first time.
func _ready():

	progress = $ProgressBar
	progress.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.global_position.x > 0:
		$Player/Interface/TextureProgressBar.set_value($Player/Interface/TextureProgressBar.get_value() + 5)
	elif $Player.global_position.x < 0:
		$Player/Interface/TextureProgressBar.set_value($Player/Interface/TextureProgressBar.get_value() - 5)
	print($Player/Interface/TextureProgressBar.get_value())
	progress.position = $Player.position
	if($Player/Interface/TextureProgressBar.get_value() > 9000):
		$Player.take_damage(0.001)
	elif($Player/Interface/TextureProgressBar.get_value() < 1000):
		print($Player.movement_speed)
		if($Player.movement_speed > 0):
			$Player.set_speed(-1)
	else:
		if($Player.movement_speed < 500):
				$Player.set_speed(1)
	
	if Input.is_action_just_pressed("swap"):
		timer = Timer.new()
		timer.wait_time = 3
		add_child(timer)
		timer.start()

		
	if Input.is_action_just_released("swap"):
		timer = null
		
	if timer:
		progress.visible = true

		progress.set_value(float((3-(timer.time_left))*100))
		if (progress.get_value() >= 100):
			swap()
			timer = null
	else:
		progress.visible = false

func swap():
	if($Player.global_position.x > 0):
		$Player.global_position = Vector2($Player.global_position.x - 8400, $Player.global_position.y)
	else:
		$Player.global_position = Vector2($Player.global_position.x + 8400, $Player.global_position.y)

	\
	
