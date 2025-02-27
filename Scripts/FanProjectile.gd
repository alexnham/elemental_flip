extends CharacterBody2D

#signal hit
var bulletVelocity = Vector2(0, 0)
#var projectileVelocity = bulletVelocity
var speed = 100
var main_char: CharacterBody2D
var bulletTracking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	main_char = get_node("../../Player")
	
	$BulletDisappearTime.wait_time = 10
	$BulletDisappearTime.one_shot = true
	$BulletDisappearTime.autostart = false
	$BulletDisappearTime.start()
	
	#pass # Replace with function body.

func _physics_process(delta):
	
	if bulletTracking == true:
		bulletVelocity = main_char.global_position - global_position
	
	# If node type is changed to area2d, then change move and collide to move towards
	var collision_info = move_and_collide(bulletVelocity.normalized() * delta * speed)
	if collision_info:
		print("Projectile collided with ", collision_info.get_collider().name)
	#velocity = velocity.slide(bulletVelocity.normalized() * delta * speed)
	#global_position = global_position.move_toward(bulletVelocity, delta)
	#pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func _on_hit():
	##pass # Replace with function body.
	#visible = false
	#queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered():
	pass # Replace with function body.




func _on_body_2d_body_entered(body):
	if body.is_in_group("Player"):
		queue_free()
		print("ouch")
		main_char.take_damage(0.25)
	else:
		queue_free()
	#pass # Replace with function body.



func _on_area_2d_area_entered(area):
	pass # Replace with function body.


func _on_bullet_disappear_time_timeout():
	print("Bullet timeout")
	visible = false
	queue_free()
	
func take_damage(amount):
	queue_free()
	#pass # Replace with function body.
