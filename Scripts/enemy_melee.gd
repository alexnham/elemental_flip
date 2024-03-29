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
@onready var player_node = get_node_or_null("../Player")
var destination: Vector2
var target_position
var player_position
@onready var animation = $AnimationPlayer

# Method to make the enemy take damage, and destroy node if health
func take_damage(damage_amount):

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
						node.take_damage(1)

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
	queue_free()

# Physics process method ran every frame
func _physics_process(_delta):
	# Check if at current player position
	if(position != player_node.position):
		# Get distance on x axis from player
		var x_distance = abs(position.x - player_node.position.x)
		# Get distance on y axis from player
		var y_distance = abs(position.y - player_node.position.y)

		# Move towards player on whatever axis is currently further
		if (x_distance > y_distance):
			animation.play("fire_left")
			position = position.move_toward(Vector2(player_node.position.x, position.y), move_speed)
		else:
			animation.play("fire_down")
			position = position.move_toward(Vector2(position.x, player_node.position.y), move_speed)


func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		player_node.take_damage(0.5)



		# Set velocity to 0
		velocity = Vector2.ZERO
		move_and_slide()
