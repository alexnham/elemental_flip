extends CharacterBody2D

# Determines the players walking speed
@export var movement_speed:float = 500;

# The time between attacks
@export var attack_cooldown = 1.0;

# Distance for dash to travel
@export var dash_distance = 500;

# The time between dashes
@export var dash_cooldown = 2.0;


var kills = 0
# Access the animation player
@onready var animation_player_fire = get_node("AnimationPlayer");
@onready var animation_player_ice = get_node("ice")

# Represents if the player can currently attack
@onready var can_attack = true;

# Represents if the player can currently dash
@onready var can_dash = true;

# Represents if the player is currently dashing
@onready var is_dashing = false;

# Represents the players current health
var health = 5;
var slash_music = 0
# Reference to the hurtbox scene
@onready var hurtbox_scene = preload("res://Scenes/Player_Attackbox.tscn")

# Represents the current facing direction
var direction = "down"

var state = "FIRE"

# The amount you move in facing direction when slashing
const SLASH_OFFSET_AMOUNT = 0

# How long the player dashes for
const DASH_TIME = 0.15

# Hurtbox offset from player
const HURTBOX_OFFSET = 75

func _process(delta):
	$Kill_Count.set_text("Kills: " + str(kills))
	


# Physics process ran each frame
func _physics_process(_delta):
	player_movement()
	player_attack()
	player_dash()

	# Call move and slide for physics
	move_and_slide();

# Handles the players movement
func player_movement():
	if !is_dashing:
		# Move right
		if Input.is_action_pressed("right"):
			# Apply right velocity
			velocity = Vector2(movement_speed, 0)
			# Play right walking animation
			if !playing_slash():
				if(state == "FIRE"):
					animation_player_fire.play("walk_right")
				if(state == "ICE"):
					animation_player_ice.play("walk_right")
			# Set direction
			direction = "right"

		# Move left
		elif Input.is_action_pressed("left"):
			# Apply left velocity
			velocity = Vector2(-movement_speed, 0)
			# Play left walking animation
			if !playing_slash():
				if(state == "FIRE"):
					animation_player_fire.play("walk_left")
				if(state == "ICE"):
					animation_player_ice.play("walk_left")
			# Set direction
			direction = "left"

		# Move up
		elif Input.is_action_pressed("up"):
			# Apply up velocity
			velocity = Vector2(0, -movement_speed)
			# Play up walking animation
			if !playing_slash():
				if(state == "FIRE"):
					animation_player_fire.play("walk_up")
				if(state == "ICE"):
					animation_player_ice.play("walk_up")
			# Set direction
			direction = "up"
		
		# Move down
		elif Input.is_action_pressed("down"):
			# Apply down velocity
			velocity = Vector2(0, movement_speed)
			#Play down walking animation
			if !playing_slash():
				if(state == "FIRE"):
					animation_player_fire.play("walk_down")
				if(state == "ICE"):
					animation_player_ice.play("walk_down")
			# Set direction
			direction = "down"

		# No move
		else:
			# Stop currently playing animation
			var playing_animation
			if(state == "FIRE"):
				playing_animation = animation_player_fire.get_current_animation()
			if(state == "ICE"):
				playing_animation = animation_player_ice.get_current_animation()

			if playing_animation == "walk_left" or playing_animation == "walk_right" or playing_animation == "walk_up" or playing_animation == "walk_down":
				if(state == "FIRE"):
					animation_player_fire.stop()
				if(state == "ICE"):
					animation_player_ice.stop()

			# Apply no velocity
			velocity = Vector2(0,0)

func set_speed(value:float):
	movement_speed = value

# Handles player attacking
func player_attack():
	if Input.is_action_pressed("attack") and can_attack and !is_dashing:
		# Handle cooldown
		can_attack = false
		get_tree().create_timer(attack_cooldown).timeout.connect(func(): can_attack = true)

		can_dash = false
		get_tree().create_timer(0.25).timeout.connect(func(): can_dash = true)
		
		# Play slash animation based off direction
		if direction == "down":
			if(state == "FIRE"):
				animation_player_fire.play("slash_down")
			if(state == "ICE"):
				animation_player_ice.play("slash_down")
			velocity = Vector2(0, 1).normalized() * SLASH_OFFSET_AMOUNT
		elif direction == "up":
			if(state == "FIRE"):
				animation_player_fire.play("slash_up")
			if(state == "ICE"):
				animation_player_ice.play("slash_up")
			velocity = Vector2(0, -1).normalized() * SLASH_OFFSET_AMOUNT
		elif direction == "left":
			if(state == "FIRE"):
				animation_player_fire.play("slash_left")
			if(state == "ICE"):
				animation_player_ice.play("slash_left")
			velocity = Vector2(-1, 0).normalized() * SLASH_OFFSET_AMOUNT
		elif direction == "right":
			if(state == "FIRE"):
				animation_player_fire.play("slash_right")
			if(state == "ICE"):
				animation_player_ice.play("slash_right")
			velocity = Vector2(1, 0).normalized() * SLASH_OFFSET_AMOUNT
		slash_music = (slash_music + 1) % 3
		if(slash_music == 0):
			$slash1.play()
		if(slash_music == 1):
			$slash2.play()
		if(slash_music == 2):
			$slash3.play()
		# Spawn in hurtbox and position
		var hurtbox = hurtbox_scene.instantiate()
		add_child(hurtbox)
		match direction:
			"right":
				hurtbox.position = Vector2(HURTBOX_OFFSET, 0)
			"left":
				hurtbox.position = Vector2(-HURTBOX_OFFSET, 0)
			"down":
				hurtbox.position = Vector2(0, HURTBOX_OFFSET)
			"up":
				hurtbox.position = Vector2(0, -HURTBOX_OFFSET)

		# Destroy hitbox after time
		get_tree().create_timer(0.05).timeout.connect(func(): 
			# Get colliding objects and deal damage
			for node in hurtbox.get_overlapping_bodies():
				if node.is_in_group("Enemy"):
					node.take_damage(1)
				if node.is_in_group("Boss"):
					node.take_damage(.25)

			hurtbox.free()
		)
# Handles player dashing
func player_dash():
	if Input.is_action_pressed("dash") and can_dash and !is_dashing:
		# Handle cooldown
		can_dash = false
		get_tree().create_timer(dash_cooldown).timeout.connect(func(): can_dash = true)

		is_dashing = true
		get_tree().create_timer(DASH_TIME).timeout.connect(func(): 
			is_dashing = false
			set_collision_mask_value(2, true)
			set_collision_layer_value(1, true)
		)

		# Disable collisions with enemy
		set_collision_layer_value(1, false)

		# Get particle emitter
		var dash_particles = get_node("DashParticles")

		# Apply directional variables and velocity
		if direction == "right":
			velocity = Vector2(1, 0).normalized() * dash_distance
			if(state == "FIRE"):
				animation_player_fire.play("dash_right")
			if(state == "ICE"):
				animation_player_ice.play("dash_right")
			dash_particles.direction = Vector2(-1, 0)
		elif direction == "left":
			velocity = Vector2(-1, 0).normalized() * dash_distance
			if(state == "FIRE"):
				animation_player_fire.play("dash_left")
			if(state == "ICE"):
				animation_player_ice.play("dash_left")
			dash_particles.direction = Vector2(1, 0)
		elif direction == "up":
			velocity = Vector2(0, -1).normalized() * dash_distance
			if(state == "FIRE"):
				animation_player_fire.play("dash_up")
			if(state == "ICE"):
				animation_player_ice.play("dash_up")
			dash_particles.direction = Vector2(0, 1)
		elif direction == "down":
			velocity = Vector2(0, 1).normalized() * dash_distance
			if(state == "FIRE"):
				animation_player_fire.play("dash_down")
			if(state == "ICE"):
				animation_player_ice.play("dash_down")
			dash_particles.direction = Vector2(0, -1)

		# Start particle emitter
		dash_particles.restart()

# Check if the slash animation is playing
func playing_slash():
	var playing_animation
	if(state == "FIRE"):
		playing_animation = animation_player_fire.get_current_animation()
	if(state == "ICE"):
		playing_animation = animation_player_ice.get_current_animation()
	if playing_animation == "slash_left" or playing_animation == "slash_right" or playing_animation == "slash_up" or playing_animation == "slash_down":
		return true
	else:
		return false
# Method to make the player take damage
func take_damage(amount):
	if(not is_dashing):
		health -= amount
	if health <= 0:
		get_tree().change_scene_to_file("res://Scenes/Landscape/DeathScene.tscn")
	$Interface.set_hearts(health)
