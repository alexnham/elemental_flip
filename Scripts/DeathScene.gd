extends TileMap

signal begin

var timer
var timer2

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("begin",intro)
	timer = Timer.new()
	timer.autostart = false
	timer.wait_time = 2
	timer.one_shot = true
	
	timer2 = Timer.new()
	timer2.autostart = false
	timer2.wait_time = 4
	timer2.one_shot = true
	add_child(timer)
	add_child(timer2)
	
func intro():
	$ColorRect.visible = true
	$ColorRect/Line1.visible = true
	timer.start()
	timer2.start()
	timer.timeout.connect(func():$ColorRect/Line2.visible = true)
	timer2.timeout.connect(func():$ColorRect/Continue.visible = true)
	

func _on_continue_pressed():
	get_tree().change_scene_to_file("res://Scenes/Landscape/StartingScene.tscn")
	
