extends CharacterBody2D

# Signal declaration
signal attacking_event

# Called when the node enters the scene tree for the first time.
var root: Node2D
var enemy: Area2D
var weapon: CollisionObject2D
var timer: Timer
var attacking: bool = false

func _ready():
	await get_tree().create_timer(.1).timeout
	queue_free()
	


	
