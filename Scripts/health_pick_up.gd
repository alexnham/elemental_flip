extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	#get_parent().get_node("Player").health += 1
	#queue_free()
	pass # Replace with function body.


func _on_body_entered(body):
	if(body.is_in_group("Player")):
		var player = get_tree().get_first_node_in_group("Player")
		if(player.health < 4):
			player.health += 1
		else:
			player.health = 5
		queue_free()
	#pass # Replace with function body.
