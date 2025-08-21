extends Area2D

var cursor_info = preload("res://Assets/cursors/mark_question_pointer_b.png")
var cursor_default = preload("res://Assets/cursors/pointer_b_shaded.png")
@export var poster_id: String

func _ready():
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	connect("input_event", _on_input_event)

func _on_mouse_entered():
	if CrimeScene.item_picked == false and CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == false:
		Input.set_custom_mouse_cursor(cursor_info, Input.CURSOR_ARROW, Vector2(16,16))

func _on_mouse_exited():
	if CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == false:
		Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW, Vector2(16,16))


func _on_input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		if CrimeScene.item_picked == false and CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == false:
			
				if poster_id == "wanted":	
					Dialogic.start("wanted_poster")		
					await Dialogic.timeline_ended
				
				if poster_id == "missing":	
					Dialogic.start("missing_poster")		
					await Dialogic.timeline_ended
	
				if poster_id == "car":	
					Dialogic.start("car_fail")		
					await Dialogic.timeline_ended
