extends TileMap

@onready var visibility_notifier := $VisibleOnScreenNotifier2D




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_entered():
	print("entered")


func _on_visible_on_screen_notifier_2d_screen_exited():
	print("exited")
