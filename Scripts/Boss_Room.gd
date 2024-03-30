extends Node2D

var state
var timer
var progress: ProgressBar
var mod = 0
var boss

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	$Player/overfreeze.modulate = Color(1,1,1,0)
	$Player/overheat.modulate = Color(1,1,1,0)
	progress = $ProgressBar

	boss = $Boss
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.global_position.x < 0:
		if(is_instance_valid(boss)):
			$Boss.state = "FIRE"
			$Boss/fire_sprite.visible = true
			$Boss/ice_sprite.visible = false
		$Player/Interface/TextureProgressBar.set_value($Player/Interface/TextureProgressBar.get_value() + 2)
		$Player.state = "FIRE"

		$Player/fire_sprite.visible = true
		$Player/ice_sprite.visible = false
		
		if($Player/Interface/TextureProgressBar.get_value() < 1000):
			$Player/Interface/TextureProgressBar.set_value(1000)
			if($Player.movement_speed < 500):
				$Player.set_speed(500)
	elif $Player.global_position.x > 0:
		if(is_instance_valid(boss)):
			$Boss.state = "ICE"
			$Boss/fire_sprite.visible = false
			$Boss/ice_sprite.visible = true
		$Player/Interface/TextureProgressBar.set_value($Player/Interface/TextureProgressBar.get_value() - 2)
		$Player.state = "ICE"
		
		$Player/ice_sprite.visible = true
		$Player/fire_sprite.visible = false
		
		if($Player/Interface/TextureProgressBar.get_value() > 9000):
			$Player/Interface/TextureProgressBar.set_value(9000)



	progress.position = $Player.position
	if($Player/Interface/TextureProgressBar.get_value() > 9000):
		if(mod < 1):
			mod += 0.005
			$Player/overheat.modulate = Color(1,1,1,mod)
		if(not $burning.playing):
			$burning.play()
		$Player.take_damage(0.001)
	elif($Player/Interface/TextureProgressBar.get_value() < 1000):
		if(mod < 1):
			mod += 0.005
			$Player/overfreeze.modulate = Color(1,1,1,mod)
		if(not $freezing.playing):
			$freezing.play()
		if($Player.movement_speed > 0):
			$Player.set_speed($Player.movement_speed - 1)
	else:
		if(mod > 0 and str($Player/overfreeze.modulate) != "(1,1,1,0)" ):
			mod -= 0.005
			$Player/overfreeze.modulate = Color(1,1,1,mod)
		if(mod > 0 and str($Player/overheat.modulate) != "(1,1,1,0)" ):
			print("burn")
			mod -= 0.005
			$Player/overheat.modulate = Color(1,1,1,mod)
	
	if Input.is_action_just_pressed("swap"):
		timer = Timer.new()
		timer.wait_time = 3
		add_child(timer)
		timer.start()

		
	if (Input.is_action_just_released("swap") or Input.is_action_pressed("attack") or  Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right")  or Input.is_action_pressed("up")  or Input.is_action_pressed("dash")):
		
		timer = null
		
	if timer:
		progress.visible = true

		progress.set_value(float((3-(timer.time_left))*100))
		if (progress.get_value() >= 100):
			swap()
			timer = null
	else:
		progress.visible = false
		
	if(Input.is_action_just_pressed("Enter") and not is_instance_valid(boss)):
		get_tree().change_scene_to_file("res://Scenes/Landscape/Win.tscn")

func swap():
	if($Player.global_position.x > 0):
		$Player.global_position = Vector2($Player.global_position.x - 2500, $Player.global_position.y)
		if(is_instance_valid(boss)):
			$Boss.global_position = Vector2($Boss.global_position.x - 2500, $Boss.global_position.y)
	else:
		$Player.global_position = Vector2($Player.global_position.x + 2500, $Player.global_position.y)
		if(is_instance_valid(boss)):
			$Boss.global_position = Vector2($Boss.global_position.x + 2500, $Boss.global_position.y)
	
	


func _on_end_game_body_entered(body):
	if(not is_instance_valid(boss) and body.is_in_group("Player")):
		$End_Game/end_game.visible = true
		$End_Game/end_game2.visible = true
	
	pass # Replace with function body.
