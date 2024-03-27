extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready
var mainChar = get_node("../Player")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var normalBulletScene
var fanBulletScene
var trackingBulletScene
var meleeEnemyScene
var shootingEnemyScene

var attack1: Timer # a lot of 
var attack2: Timer # spawn goons
var attack3: Timer # waves user has to dash
var wait: Timer
var waveTimer
var animation
var numEnemies = 1
var waveCount = 0

func _ready():
    #mainChar = get_node("../Player")
    normalBulletScene = preload("res://Scenes/bullets/bullet.tscn")
    fanBulletScene = preload("res://Scenes/bullets/fan_projectile.tscn")
    trackingBulletScene = preload("res://Scenes/bullets/tracking_bullet.tscn")
    meleeEnemyScene = preload("res://Scenes/enemies/enemy_melee.tscn")
    shootingEnemyScene = preload("res://Scenes/enemies/enemy_shooting.tscn")
    
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
    
    
    wait.autostart = false
    wait.wait_time = 10
    wait.one_shot = true
    
     # Spawn enemies
    add_child(attack1)
    numEnemies = 2
    
    # Attacks: Tracking bullets
    add_child(attack2)
    
    # Attacks: swirling grow bullets
    add_child(attack3)
    
    $WaveTimer.start()
    
    
func _process(_delta):
    #$Node2D.look_at(mainChar.global_position)
    
    if Input.is_action_just_pressed("attack"):
        animation.play("shoot waves")
        
 

func _on_visible_on_screen_notifier_2d_screen_entered():
    #pass # Replace with function body.
    $WaveTimer.start()
    
    

func _on_wave_timer_timeout():
    var currentWave = waveCount % 3
    
    if currentWave == 0:
        print("Wave 1 started!")
        Wave1()
    elif currentWave == 1:
        Wave2()
    else:
        Wave3()
    
    waveCount = waveCount + 1
    
    #pass # Replace with function body.

func Wave1():
    for n in range(numEnemies):
        #var randomPositionSpawn = randi_range(1, 4)
        var randomEnemy = randi_range(1, 2)
        var enemyType = meleeEnemyScene.instantiate()
        if randomEnemy == 1:
            enemyType = meleeEnemyScene.instantiate()
        else:
            enemyType = shootingEnemyScene.instantiate()
        
        #enemyType.mainChar = mainChar
        
        get_parent().add_child(enemyType)
        enemyType.global_position = $Node2D/EnemySpawnPosition.global_position
        enemyType.global_rotation = $Node2D.global_rotation
        print("Enemy ", enemyType.name, " spawned from boss ", name)
    #pass

func Wave2():
    pass
    
func Wave3():
    pass
