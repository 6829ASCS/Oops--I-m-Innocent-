extends Area2D

@onready var playagain: Sprite2D = $Sprite2D

func _ready():
	playagain.hide()

	connect("input_event", _on_input_event)
	EndingsManager.connect("end_screen", Callable(self, "_end_screen"))

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:

		CrimeScene.item_picked = false
		CrimeScene.can_start = false
		CrimeScene.police_triggered = false
		CrimeScene.rubber_duck_visible = false
		CrimeScene.countdown_ended = false
		$"../Transition".fade_to_black()
		get_tree().change_scene_to_file("res://Scenes/Intro.tscn")


func _end_screen():
	playagain.show()
