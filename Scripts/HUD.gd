extends CanvasLayer

signal start_game
signal end_game

var Title
var startButton
var exitButton

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_start_button_pressed():
    hide()
    $StartButton.hide()
    start_game.emit()
    #pass # Replace with function body.


func _on_exit_button_pressed():
    get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
    get_tree().quit()
    #pass # Replace with function body.


