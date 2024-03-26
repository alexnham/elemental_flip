extends Control

signal health_depleted

var health: float
var heart_size: int = 100
var initial_hearts: int = 5
var heart_texture: TextureRect
var main_char: CharacterBody2D

func _ready():
	health = get_parent().health
	heart_texture = $Heart
	heart_texture.set_size(Vector2(heart_size * health, heart_texture.size.y))
	main_char = get_node("../../Player")
	connect("health_depleted", set_hearts)

func set_hearts(health_value: float) -> void:
    print("Remaining Health: ", health_value)
    heart_texture.set_size(Vector2(heart_size * health_value, heart_texture.size.y))

func _process(_delta: float) -> void:
    pass
