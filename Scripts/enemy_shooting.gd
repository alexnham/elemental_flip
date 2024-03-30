extends CharacterBody2D
#var bullet
var _bulletScene
var _projectileScene
var normalBullet
var bossBullet
var reloadTime
var bulletTracking = false
var move_speed = 200
#var shot

var health: int = 3
signal die_event
signal shot
var ui: Control

var blood_particles = preload("res://Scenes/ParticleEffects/Blood.tscn")
@onready var _mainChar = get_tree().get_first_node_in_group("Player")

func _ready():
	#_bullet = get_node("Bullet")
	_bulletScene = preload("res://Scenes/bullets/bullet.tscn")
	reloadTime = get_node("ReloadTime")
	
	reloadTime.wait_time = 5
	reloadTime.start()
	#shot = false
	#reloadTime.stop()
	#ui = get_node("Interface")
	#reloadTime.start()
	#connect("die_event",die)

#func die(amount: int) -> void:
	#health -= amount
	#if health <= 0:
		#queue_free()
	#ui.emit_signal("health_depleted", health)


var speed = 1
func _physics_process(delta):
	var distance_to_player = global_position.distance_to(_mainChar.global_position)      

	# Shooting enemy move towards current position of main character
	if distance_to_player < 750:
		global_position = global_position.move_toward(_mainChar.global_position, speed)
		
	#var direction = global_position.direction_to(_mainChar.global_position)
	#velocity = direction * move_speed
	#move_and_slide()
	
	$AnimationPlayer.play("fire_down")
	
		#bulletTracking = false
	
	
	# Bullet move towards where main character was
	#if shot == true:
		#_bullet.global_position = global_position.move_toward(_mainChar.global_position, speed * 5)
		
	
	#pass
	
func _process(delta):
	get_node("Node2D").look_at(_mainChar.global_position)
	#$Node2D/BulletSpawn.look_at(_mainChar.global_position)
	#pass
	
#func shoot():
	#var bullet = _bulletScene.instantiate()
	#add_child(bullet)
	#bullet.global_position = $Node2D/BulletSpawn.global_position
	#bullet.bulletVelocity = $Node2D/BulletSpawn.global_position - bullet.position

func _on_visible_on_screen_notifier_2d_screen_entered():
	#reloadTime.start()
	pass
	#pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	#reloadTime.stop()
	pass # Replace with function body.


func _on_reload_time_timeout():
	#if _bullet.global_position != global_position:
	var distance_to_player = global_position.distance_to(_mainChar.global_position)     
	if distance_to_player < 750:
		emit_signal("shot")
	#print("Bullet global position = ", _bullet.global_position)

	#pass # Replace with function body.
	
func _on_body_entered(body: Node2D) -> void:
	take_damage(1)
	#if body.is_in_group("Slash"):
		#die_event.emit(1)

	
func _on_shot():
	#if _bullet.global_position != global_position:
	#_bullet.visible = true
	#shot = true
	#add_child(_bullet)
	#print("Added bullet to enemy shooting")
	var bullet
	bullet = _bulletScene.instantiate()
	
	add_child(bullet)
	bullet.scale = Vector2(0.3,0.3)
	bullet.global_position = $Node2D/BulletSpawn.global_position
	bullet.global_rotation = $Node2D/BulletSpawn.global_rotation
	bullet.bulletVelocity = _mainChar.global_position - bullet.global_position
		#bullet = _projectileScene.instantiate()
	print("My name is: ", bullet.name)
	
	#pass
#func take_damage(damage_amount):
	#health -= damage_amount
	#if health <= 0:
		#die(1)
func die():
	var heartScene = preload("res://Scenes/health_pick_up.tscn")
	var randomNumber = randi_range(1, 5)
	if randomNumber == 1:
		var heartNode = heartScene.instantiate()
		get_parent().add_child(heartNode)
		heartNode.global_position = global_position
	_mainChar.kills += 1
	queue_free()


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
