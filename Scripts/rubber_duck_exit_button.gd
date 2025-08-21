extends Area2D

@onready var exit_button: Sprite2D = $Sprite2D

var cursor_info = preload("res://Assets/cursors/mark_question_pointer_b.png")
var cursor_default = preload("res://Assets/cursors/pointer_b_shaded.png")

func _ready():	
	$CollisionShape2D.disabled = true
	exit_button.hide()
	
	CrimeScene.connect("rubber_duck_on", Callable(self, "_rubber_duck_on"))
	CrimeScene.connect("rubber_duck_off", Callable(self, "_rubber_duck_off"))
	
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	connect("input_event", _on_input_event)

func _on_mouse_entered():
	if CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == true:
			Input.set_custom_mouse_cursor(cursor_info, Input.CURSOR_ARROW, Vector2(16,16))

func _on_mouse_exited():
	if CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == true:
		Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW, Vector2(16,16))

func _on_input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		if CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == true:
			CrimeScene.emit_signal("rubber_duck_off")

func _rubber_duck_off():
	Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW, Vector2(16,16))
	$CollisionShape2D.disabled = true
	exit_button.hide()

func _rubber_duck_on():
	$CollisionShape2D.disabled = false
	exit_button.show()
