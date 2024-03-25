extends Area2D

var _mainChar
var _bullet
var reloadTime

signal shot

func _ready():
    _mainChar = get_node("../Player")
    _bullet = get_node("Bullet")
    reloadTime = get_node("ReloadTime")
    reloadTime.start()


var speed = 1.0
func _physics_process(delta):
    # Shooting enemy move towards current position of main character
    global_position = global_position.move_toward(_mainChar.global_position, delta * speed)
    
    # Bullet move towards where main character was
    _bullet.global_position = global_position.move_toward(_mainChar.global_position, delta * speed * 2)
    #pass


func _on_visible_on_screen_notifier_2d_screen_entered():
    reloadTime.start()
    #pass # Replace with function body.


func _on_reload_time_timeout():
    emit_signal("shot")
    #pass # Replace with function body.


func _on_shot():
    if _bullet.global_position != global_position:
        pass
    _bullet.visible = true
    add_child(_bullet)
    print("Added bullet to enemy shooting")
    #pass # Replace with function body.
