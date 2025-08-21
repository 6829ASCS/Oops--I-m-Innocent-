extends Area2D

@onready var button: Sprite2D = $Sprite2D

var cursor_point = preload("res://Assets/cursors/hand_thin_point.png")
var cursor_default = preload("res://Assets/cursors/pointer_b_shaded.png")

var original_scale: Vector2

func _ready():
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	connect("input_event", _on_input_event)

func _on_mouse_entered():
	Input.set_custom_mouse_cursor(cursor_point, Input.CURSOR_ARROW, Vector2(16,16))

func _on_mouse_exited():
	Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW, Vector2(16,16))


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		disconnect("mouse_entered", _on_mouse_entered)
		disconnect("mouse_exited", _on_mouse_exited)
		Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW, Vector2(16,16))
		$"../Transition".fade_to_black()
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://Scenes/Intro.tscn")
