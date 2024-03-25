extends Area2D

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func _on_hit():
    #pass # Replace with function body.
    visible = false
    queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered():
    pass # Replace with function body.


