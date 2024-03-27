extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var attack1: Timer #a lot of 
var attack2: Timer #spawn goons
var attack3: Timer #waves user has to dash
var wait: Timer
var animation

func _ready():
	animation = $AnimationPlayer
	animation.play("RESET")
	attack1 = Timer.new()
	attack1.autostart = false
	attack1.wait_time = 10
	attack1.one_shot = true
	
	attack2 = Timer.new()
	attack2.autostart = false
	attack2.wait_time = 10
	attack2.one_shot = true
	
	attack3 = Timer.new()
	attack3.autostart = false
	attack3.wait_time = 10
	attack3.one_shot = true
	
	wait = Timer.new()
	wait.autostart = false
	wait.wait_time = 10
	wait.one_shot = true
	add_child(attack1)
	add_child(attack2)
	add_child(attack3)
func _process(_delta):
	if Input.is_action_just_pressed("attack"):
		animation.play("shoot waves")
	
	


	

