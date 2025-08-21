extends Area2D

@export var pre_crash: Texture2D = preload("res://Assets/crime scene/PreCrash.PNG")
@export var post_crash: Texture2D = preload("res://Assets/crime scene/PostCrash.PNG")

@onready var collision: CollisionPolygon2D = $CollisionPolygon2D

var cursor_interact = preload("res://Assets/cursors/hand_thin_open.png")
var cursor_default = preload("res://Assets/cursors/pointer_b_shaded.png")
const cursor_closed = preload("res://Assets/cursors/hand_thin_closed.png")

func _ready() -> void:
	$"..".start_crime_scene()
	
	$Sprite.show()
	$"Blood Trail".hide()
	
	$Sprite.texture = pre_crash
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	connect("input_event", _on_input_event)

func ran_over() -> void:
	$Sprite.texture = post_crash

func _on_mouse_entered():
	if CrimeScene.item_picked == false and CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == false:
		Input.set_custom_mouse_cursor(cursor_interact, Input.CURSOR_ARROW, Vector2(16,16))

func _on_mouse_exited():
	if CrimeScene.can_start == true:
		Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW, Vector2(16,16))


func _on_input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		if CrimeScene.item_picked == false and CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == false:
			CrimeScene.item_picked = true
			$Sprite.hide()
			cursor_magic()
			
			$"Blood Trail".show()
			$"Blood Trail".modulate.a = 0.0
			var tween = get_tree().create_tween()
			tween.tween_property($"Blood Trail", "modulate:a", 1.0, 2)
			await tween.finished
			
			CrimeScene.police_triggered = true
			CrimeScene.emit_signal("trigger_police_lights")
			await get_tree().create_timer(1.5).timeout
			Dialogic.start("deadguy_moved")		
			await Dialogic.timeline_ended
			
			EndingsManager.paint_ending_found = true
			EndingsManager.ending_id = "paint"
			EndingsManager.emit_signal("transition_to_ending")

func cursor_magic():
	Input.set_custom_mouse_cursor(cursor_closed, Input.CURSOR_ARROW, Vector2(16,16))
	await get_tree().create_timer(0.3).timeout
	collision.disabled = true
