extends Area2D

# Represents enemy walking speed
@export var move_speed = 1.0

# Represents current enemy health
@onready var health = 2.0;

# Represents the player object
@onready var player_node = get_node_or_null("../Player")
var destination: Vector2
var target_position
var player_position

# Method to make the enemy take damage, and destroy node if health
func take_damage(damage_amount):
	health -= damage_amount
	if health <= 0:
		die()

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
			position = position.move_toward(Vector2(player_node.position.x, position.y), move_speed)
		else:
			position = position.move_toward(Vector2(position.x, player_node.position.y), move_speed)


func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		player_node.take_damage(0.5)

