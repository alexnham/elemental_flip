extends Area2D

var SPEED: float = 1.0
var main_char: CharacterBody2D
var destination: Vector2
var target_position
var player_position

signal die_event

func _ready():
	main_char = get_node("../Player")
	connect("die_event",die)

func die() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	if(position != main_char.position):
		position = position.move_toward(main_char.position,SPEED);


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Slash"):
		die_event.emit()
	if body.is_in_group("Player"):
		print("ouch")
		main_char.emit_signal("enemy_damage", .1)
