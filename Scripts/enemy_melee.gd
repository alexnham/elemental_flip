extends Area2D

var SPEED: float = 1.0
var main_char: CharacterBody2D
var destination: Vector2
var target_position
var player_position
var health: int = 2
var ui: Control

signal die_event

func _ready():
<<<<<<< HEAD
    main_char = get_node("../Player")
    connect("die_event",die)

func die() -> void:
    queue_free()
=======
	main_char = get_node("../Player")
	connect("die_event",die)
	ui = get_node("Interface")

func die(amount: int) -> void:
	health -= amount
	if health <= 0:
		queue_free()
	ui.emit_signal("health_depleted", health)

>>>>>>> 36d313d110882f87cb2410f5807a43104bc32f90

func _physics_process(delta: float) -> void:
    if(position != main_char.position):
        position = position.move_toward(main_char.position,SPEED);

func _on_body_entered(body: Node2D) -> void:
<<<<<<< HEAD
    if body.is_in_group("Slash"):
        die_event.emit()
    if body.is_in_group("Player"):
        print("ouch")
        main_char.emit_signal("enemy_damage", .1)
=======
	if body.is_in_group("Slash"):
		die_event.emit(1)
	if body.is_in_group("Player"):
		print("ouch")
		main_char.emit_signal("enemy_damage", .5)

	

>>>>>>> 36d313d110882f87cb2410f5807a43104bc32f90
