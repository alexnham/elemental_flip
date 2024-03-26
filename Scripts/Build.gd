extends Node2D

signal summon_attack

var slash: PackedScene
var sword: Sprite2D
var attack: CharacterBody2D

func _ready():
    slash = preload("res://Scenes/slash.tscn")
    sword = $Player/Weapon
    connect("summon_attack", spawn_attack)

func spawn_attack() -> void:
    print("hello")
    attack = slash.instantiate()
    attack.global_position = sword.global_position
    attack.scale = sword.scale
    add_child(attack)

func _process(delta: float) -> void:
    pass
