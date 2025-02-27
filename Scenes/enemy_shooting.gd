extends CharacterBody2D

var _mainChar
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

func _ready():
	_mainChar = get_node("../Player")
	#_bullet = get_node("Bullet")
	_bulletScene = preload("res://Scenes/bullets/bullet.tscn")
	reloadTime = get_node("ReloadTime")
	
	reloadTime.wait_time = 1
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
	if distance_to_player <= 200:
		speed = 0
	else:
		speed = 1        
	# Shooting enemy move towards current position of main character
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
	queue_free()


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


