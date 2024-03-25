extends CharacterBody2D

# The players movement speed in pixels/second
var move_speed: float = 1000.0
# ui grab
var ui: Control
# signal to allow damage
signal enemy_damage
# health
var health: float = 5
# The cooldown time for the players basic attack
var attack_cooldown: int = 2
var rotationAmount = 45
var track_rotation = 45

# The players character sprite
var player_sprite
# the weapon sprite
var weapon
# Represents if the attack is on cooldown
var can_attack: bool

# A timer to track the cooldown of the attack
var attack_timer: Timer
var attack_length: Timer
var background: Node2D

func _ready():
	# Access the character and weapon sprites
	player_sprite = $CharacterSprite
	weapon = $Weapon
	background = get_parent()


	# Create timer for attack cooldown
	can_attack = true
	attack_timer = Timer.new()
	attack_timer.autostart = false
	attack_timer.wait_time = attack_cooldown
	attack_timer.one_shot = true

	attack_length = Timer.new()
	attack_length.autostart = false
	attack_length.wait_time = 0.5
	attack_length.one_shot = true
	attack_length.timeout.connect(end_attack)

	add_child(attack_timer)
	add_child(attack_length)
	attack_timer.timeout.connect(toggle_can_attack)

	# grabbing interface
	ui = get_node("Interface")
	connect("enemy_damage", take_damage,1)



func _physics_process(_delta):
	# Get players movement input and set velocity
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * move_speed

	# Swap between left and right facing sprites
	if direction.x > 0:
		player_sprite.flip_h = false
		rotationAmount = 45
		if weapon.scale.x < 0:
			weapon.scale.x *= -1
			#something about y needs to change weapon.scale.y = -weapon.scale.y
	elif direction.x < 0:
		player_sprite.flip_h = true
		rotationAmount = -45
		if weapon.scale.x > 0:
			weapon.scale.x *= -1




	# Handle Attacking
	if Input.is_action_just_pressed("attack") and can_attack:
		attack_timer.start() # Start cooldown timer
		attack_length.start()
		toggle_can_attack() # Toggle can attack
		weapon.rotate(rotationAmount)
		track_rotation = rotationAmount
		print("Attack")
		weapon.emit_signal("Attacking", true)
		background.emit_signal("summon_attack")

	if Input.is_action_just_pressed("dash"):
		print("dash")
		position = background.get_local_mouse_position()

	move_and_slide()

func end_attack():
	weapon.rotate(-track_rotation)

func toggle_can_attack():
	can_attack = !can_attack

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()
	ui.emit_signal("ealth_depleted", health)
