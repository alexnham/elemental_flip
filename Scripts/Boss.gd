extends CharacterBody2D


@onready
#var mainChar = get_node("../Player")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var normalBulletScene
var fanBulletScene
var trackingBulletScene
var meleeEnemyScene
var shootingEnemyScene

var trackingBulletCounts = 5
var waveTimer
var animation
@export var numEnemies = 5
var waveCount = 0
var timeCount = 1
var health = 5
var player
var knockback = false
var player_dir
var knockback_dir
var knockback_wait

var bossActivated

func _ready():
    player = get_node("../Player")
    normalBulletScene = preload("res://Scenes/bullets/bullet.tscn")
    fanBulletScene = preload("res://Scenes/bullets/fan_projectile.tscn")
    trackingBulletScene = preload("res://Scenes/bullets/tracking_bullet.tscn")
    meleeEnemyScene = preload("res://Scenes/enemies/enemy_melee.tscn")
    shootingEnemyScene = preload("res://Scenes/enemies/enemy_shooting.tscn")
    
    animation = $AnimationPlayer
    animation.play("RESET")


    #$WaveTimer.start()
    bossActivated = false


func _physics_process(delta):
    if(knockback):
        if player.direction == "down":
            player.velocity = Vector2(0, -1).normalized() * 1000
        elif player.direction == "up":				
            player.velocity = Vector2(0, 1).normalized() * 1000
        elif player.direction == "left":
            player.velocity = Vector2(1, 0).normalized() * 1000
        elif player.direction == "right":
            player.velocity = Vector2(-1, 0).normalized() * 1000
        player.move_and_slide()
        get_tree().create_timer(2).timeout.connect(func(): knockback = false)
            



func knockback_player():
    if((player.global_position-global_position).length() < 200):
        knockback = true

    


 

func _on_visible_on_screen_notifier_2d_screen_entered():
    #pass # Replace with function body.
    if bossActivated == false:
        $WaveTimer.wait_time = 2
        $WaveTimer.start()
        print("Boss Wave Started!")
        bossActivated = true
        $WaveTimer.wait_time = 10
    
    

func _on_wave_timer_timeout():
    var currentWave = waveCount % 3
    knockback_player()
    if currentWave == 0:
        print("Wave 1 started!")
        Wave1()
    elif currentWave == 1:
        print("Wave 2 started!")
        Wave2()
    else:
        print("Wave 3 started!")
        Wave3()
    
    waveCount = waveCount + 1
    
    #pass # Replace with function body.

func Wave1():

    for n in range(numEnemies):
        print("n = ", n)
        #var randomPositionSpawn = randi_range(1, 4)
        var randomEnemy = randi_range(1, 2)
        var enemyType = meleeEnemyScene.instantiate()
        if randomEnemy == 1:
            enemyType = meleeEnemyScene.instantiate()
        else:
            enemyType = shootingEnemyScene.instantiate()
        
        get_parent().add_child(enemyType)
        var randomSpawnPosition = randi_range(1, 4)
        if randomSpawnPosition == 1:
            enemyType.global_position = $Node2D/BulletSpawnUp.global_position
        elif randomSpawnPosition == 2:
            enemyType.global_position = $Node2D/BulletSpawnDown.global_position
        elif randomSpawnPosition == 3:
            enemyType.global_position = $Node2D/BulletSpawnLeft.global_position
        elif randomSpawnPosition == 4:
            enemyType.global_position = $Node2D/BulletSpawnRight.global_position
            
        enemyType.global_rotation = $Node2D.global_rotation
        print("Enemy ", enemyType.name, " spawned from boss ", name)
    #pass

func Wave2():
    var bulletScene = preload("res://Scenes/bullets/tracking_bullet.tscn")

    for i in range(4):
        animation.play("shoot_tracking_bullet")
        var bullet = bulletScene.instantiate()
        add_child(bullet)
        
        if i == 0:
            bullet.global_position = $Node2D/BulletSpawnUp.global_position
        elif i == 1:
            bullet.global_position = $Node2D/BulletSpawnDown.global_position
        elif i == 2:
            bullet.global_position = $Node2D/BulletSpawnLeft.global_position
        elif i == 3:
            bullet.global_position = $Node2D/BulletSpawnRight.global_position
        
        bullet.scale = Vector2(0.3, 0.3)
        bullet.global_rotation = $Node2D/GeneralSpawnPosition.global_rotation
        bullet.bulletTracking = true
        bullet.bulletVelocity = get_parent().get_node("Player").global_position - bullet.global_position       
    
    #pass
    
func Wave3():
    var bulletScene = preload("res://Scenes/bullets/swirling_projectile.tscn")
    for i in range(4):
        animation.play("shoot waves")
        var bullet = bulletScene.instantiate()
        add_child(bullet)
        
        if i == 0:
            bullet.global_position = $Node2D/BulletSpawnUp.global_position
        elif i == 1:
            bullet.global_position = $Node2D/BulletSpawnDown.global_position
        elif i == 2:
            bullet.global_position = $Node2D/BulletSpawnLeft.global_position
        elif i == 3:
            bullet.global_position = $Node2D/BulletSpawnRight.global_position
        
        bullet.scale = Vector2(0.3, 0.3)
        #bullet.global_rotation = $Node2D/GeneralSpawnPosition.global_rotation
        bullet.bulletTracking = false
        bullet.bulletVelocity = get_parent().get_node("Player").global_position - bullet.global_position   
        bullet.speed = 500 
    
    #pass
func take_damage(damage_amount):

    health -= damage_amount
    $Interface.set_hearts(health)
    if health <= 0:
        die()

# Method to kill the enemy
func die():
    queue_free()
