extends Node2D

func _ready() -> void:
	CrimeScene.connect("trigger_police_lights", Callable(self, "_trigger_police_lights"))
	$AnimatedSprite2D.hide()

	
func _trigger_police_lights():
	if CrimeScene.police_triggered == true:
		$AnimatedSprite2D.show()
		position = Vector2(640, 900)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(640, 360), 1)
		$AudioStreamPlayer2D.play()
		print("this works....")
		set_process(false)
