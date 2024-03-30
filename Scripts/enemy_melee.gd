extends CharacterBody2D

# Represents enemy walking speed
@export var move_speed = 1.0

# How close the player must be for the enemy to begin following them
@export var alert_range = 500

# How far the enemy will stop from the player when following
@export var stop_distance = 150

# The cooldown between attacks
@export var attack_cooldown = 2

# How close the enemy must be to attack
@export var attack_range = 175

# Represents current enemy health
@export var health = 2.0;

# Represents the enemies damage per hit
@export var damage = 1;

# Represents the player object
@onready var player = get_tree().get_first_node_in_group("Player")

# Load the blood particle scene
@onready var blood_particles = preload("res://Scenes/ParticleEffects/Blood.tscn")

# The enemies animation player
@onready var animation_player = $AnimationPlayer

# The enemies sword sprite
@onready var sword_sprite = $Sword

# Reference to the hurtbox scene
@onready var hurtbox_scene = preload("res://Scenes/Enemy_Attackbox.tscn")

# The direction the enemy is facing
var facing = "down"

# Whether the enemy can attack this frame
var can_attack = true

# Whether or not the enemy can currently move
var can_move = true

# Hurtbox offset from enemy
const HURTBOX_OFFSET = 100

# Physics process method ran every frame
func _physics_process(_delta):
	if player:
		attack()

		if can_move:
			move_and_animate()


# Method to make the enemy take damage, and destroy node if health
func take_damage(damage_amount):
	$AudioStreamPlayer.play()
	# Spawn blood particles on enemy
	var particle_instance = blood_particles.instantiate()
	get_parent().add_child(particle_instance)
	particle_instance.position = get_global_position()
	particle_instance.restart()

	# Subtract damage from health
	health -= damage_amount

	# Call die method on health below 0
	if health <= 0:
		die()


func attack():
	# Check if enemy can attack and is alive
	if can_attack and health > 0 and position.distance_to(player.global_position) <= attack_range:
		# Disable attacking and movement
		can_attack = false
		can_move = false

		# Create timer to handle attack cooldown
		get_tree().create_timer(attack_cooldown).timeout.connect(func(): can_attack = true)

		# Stop animations
		animation_player.stop()

		# Show and position sword
		sword_sprite.visible = true
		if facing == "down":
			sword_sprite.rotation_degrees = 45
		elif facing == "up":
			sword_sprite.rotation_degrees = 225
		elif facing == "left":
			sword_sprite.rotation_degrees = 135
		elif facing == "right":
			sword_sprite.rotation_degrees = 315

		# Create timer to launch attack
		get_tree().create_timer(0.5).timeout.connect(func(): 
			# Spawn in hurtbox and position
			var hurtbox = hurtbox_scene.instantiate()
			add_child(hurtbox)

			# Spin sword sprite and position hurtbox
			var tween = create_tween()
			if facing == "down":
				sword_sprite.rotation_degrees = 45
				tween.tween_property(sword_sprite, "rotation", deg_to_rad(225), .5)
				hurtbox.position = Vector2(0, HURTBOX_OFFSET)
			elif facing == "up":
				sword_sprite.rotation_degrees = 225
				tween.tween_property(sword_sprite, "rotation", deg_to_rad(405), .5)
				hurtbox.position = Vector2(0, -HURTBOX_OFFSET)
			elif facing == "left":
				sword_sprite.rotation_degrees = 135
				tween.tween_property(sword_sprite, "rotation", deg_to_rad(315), .5)
				hurtbox.position = Vector2(-HURTBOX_OFFSET, 0)
			elif facing == "right":
				sword_sprite.rotation_degrees = 315
				tween.tween_property(sword_sprite, "rotation", deg_to_rad(495), .5)
				hurtbox.position = Vector2(HURTBOX_OFFSET, 0)

			# Deal damage and destroy hitbox
			get_tree().create_timer(0.05).timeout.connect(func(): 
				# Get colliding objects and deal damage
				for node in hurtbox.get_overlapping_bodies():
					if node.is_in_group("Player"):
						print("HIT")
						node.take_damage(0.5)

				hurtbox.queue_free()
			)
		
			# Timer to enable movement and hide sword
			get_tree().create_timer(.5).timeout.connect(func(): 
				can_move = true
				sword_sprite.visible = false
			)
		)


# Method to kill the enemy
func die():
	player.kills += 1
	var heartScene = preload("res://Scenes/health_pick_up.tscn")
	var randomNumber = randi_range(1, 5)
	if randomNumber == 1:
		var heartNode = heartScene.instantiate()
		get_parent().add_child(heartNode)
		heartNode.global_position = global_position
	queue_free()


# Method to move the enemy
func move_and_animate():
	if player:
		# Get the distance to the player and check if they are within the alert range
		var distance_to_player = global_position.distance_to(player.global_position)
		if distance_to_player <= alert_range and distance_to_player > stop_distance:
			# Get the direction to the player
			var direction = position.direction_to(player.global_position)

			# Play correct animation
			if (direction.x > 0 and abs(direction.x) > abs(direction.y)):
				animation_player.play("walk_right")
				facing = "right"
			elif (direction.x < 0 and abs(direction.x) > abs(direction.y)):
				animation_player.play("walk_left")
				facing = "left"
			elif direction.y > 0:
				animation_player.play("walk_down")
				facing = "down"
			elif direction.y < 0:
				animation_player.play("walk_up")
				facing = "up"

			# Set the velocity to the direction * the move speed
			velocity = direction * move_speed
			move_and_slide()
		else:
			# Play correct animation
			if facing == "down":
				animation_player.play("idle_down")
			elif facing == "up":
				animation_player.play("idle_up")
			elif facing == "left":
				animation_player.play("idle_left")
			elif facing == "right":
				animation_player.play("idle_right")
	else:
		# Play correct animation
		if facing == "down":
			animation_player.play("idle_down")
		elif facing == "up":
			animation_player.play("idle_up")
		elif facing == "left":
			animation_player.play("idle_left")
		elif facing == "right":
			animation_player.play("idle_right")

		# Set velocity to 0
		velocity = Vector2.ZERO
		move_and_slide()
