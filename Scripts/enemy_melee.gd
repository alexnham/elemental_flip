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
@onready var health = 2.0;

# Represents the player object
@onready var player = get_tree().get_first_node_in_group("Player")

# Load the blood particle scene
@onready var blood_particles = preload("res://Scenes/ParticleEffects/Blood.tscn")

# The enemies animation player
@onready var animation_player = $AnimationPlayer

# The direction the enemy is facing
var facing = "down"

# Whether the enemy can attack this frame
var can_attack = true

# Physics process method ran every frame
func _physics_process(_delta):
	move_and_animate()
	attack()


# Method to make the enemy take damage, and destroy node if health
func take_damage(damage_amount):
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
		can_attack = false
		get_tree().create_timer(attack_cooldown).timeout.connect(func(): can_attack = true)


# Method to kill the enemy
func die():
	queue_free()


# Method to move the enemy
func move_and_animate():
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