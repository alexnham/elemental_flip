extends Area2D

var _mainChar
#var _bullet
var _bulletScene
var reloadTime
#var shot

signal shot

func _ready():
	_mainChar = get_node("../Player")
	#_bullet = get_node("Bullet")
	_bulletScene = preload("res://Scenes/bullet.tscn")
	reloadTime = get_node("ReloadTime")
	
	reloadTime.wait_time = 1
	reloadTime.start()
	#shot = false
	#reloadTime.stop()
	#reloadTime.start()


var speed = 1.0
func _physics_process(delta):

	
	# Shooting enemy move towards current position of main character
	global_position = global_position.move_toward(_mainChar.global_position, speed)
	
	
	# Bullet move towards where main character was
	#if shot == true:
		#_bullet.global_position = global_position.move_toward(_mainChar.global_position, speed * 5)
		
	
	#pass
	
func _process(delta):
	get_node("Node2D").look_at(_mainChar.global_position)
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
	print("enemy_shooting global position = ", global_position)
	#pass # Replace with function body.


func _on_shot():
	#if _bullet.global_position != global_position:
	#_bullet.visible = true
	#shot = true
	#add_child(_bullet)
	#print("Added bullet to enemy shooting")
	#pass # Replace with function body.
	var bullet = _bulletScene.instantiate()
	add_child(bullet)
	bullet.global_position = $Node2D/BulletSpawn.global_position
	bullet.bulletVelocity = _mainChar.global_position - bullet.global_position
	#pass


