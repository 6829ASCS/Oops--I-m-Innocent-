extends Area2D

@export var item_name: String
@onready var sprite = $Sprite2D
@onready var collision = $CollisionPolygon2D

var cursor_interact = preload("res://Assets/cursors/hand_thin_open.png")
var cursor_default = preload("res://Assets/cursors/pointer_b_shaded.png")
const cursor_closed = preload("res://Assets/cursors/hand_thin_closed.png")

func _ready():
	$"../Hat on head".hide()
	
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	connect("input_event", _on_input_event)
	
	CrimeScene.connect("tire_picked_response", Callable(self, "_on_tire_picked"))


func _on_mouse_entered():
	if CrimeScene.item_picked == false and CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == false:
		Input.set_custom_mouse_cursor(cursor_interact, Input.CURSOR_ARROW, Vector2(16,16))

func _on_mouse_exited():
	if CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == false:
		Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW, Vector2(16,16))


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		if CrimeScene.item_picked == false and CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == false:
			
			cursor_magic()
			CrimeScene.item_picked = true
			
			if item_name == "gun":
				sprite.hide()
				
				CrimeScene.police_triggered = true
				CrimeScene.emit_signal("trigger_police_lights")
				await get_tree().create_timer(1.5).timeout
				Dialogic.start("gun_picked")
				await Dialogic.timeline_ended
				
				EndingsManager.gun_ending_found = true
				EndingsManager.ending_id = "gun"
				EndingsManager.emit_signal("transition_to_ending")
				
			if item_name == "hat":
				sprite.hide()
				$"../Hat on head".show()
				$"../Hat on head".modulate.a = 0.0
				var tween = get_tree().create_tween()
				tween.tween_property($"../Hat on head", "modulate:a", 1.0, 0.5)
				await tween.finished
				
				CrimeScene.police_triggered = true
				CrimeScene.emit_signal("trigger_police_lights")
				await get_tree().create_timer(1.5).timeout
				Dialogic.start("hat_picked")
				await Dialogic.timeline_ended
				
				EndingsManager.hat_ending_found = true
				EndingsManager.ending_id = "hat"
				EndingsManager.emit_signal("transition_to_ending")

			if item_name == "wig":
				sprite.hide()
				
				CrimeScene.police_triggered = true
				CrimeScene.emit_signal("trigger_police_lights")
				await get_tree().create_timer(1.5).timeout
				Dialogic.start("wig_picked")
				await Dialogic.timeline_ended
				
				EndingsManager.wig_ending_found = true
				EndingsManager.ending_id = "wig"
				EndingsManager.emit_signal("transition_to_ending")

			if item_name == "tire":
				sprite.hide()
				CrimeScene.emit_signal("tire_picked_response")

func _on_tire_picked():
	
	if item_name == "hat":
			var tween1 = get_tree().create_tween()
			sprite.modulate.a = 1.0
			tween1.tween_property(sprite, "modulate:a", 0.0, 1.0)
	
	await get_tree().create_timer(1).timeout
	
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, "position", Vector2(-5, 0), 0.04)
	tween2.tween_property(self, "position", Vector2(5, 0), 0.08)
	tween2.tween_property(self, "position", Vector2(-5, 0), 0.08)
	tween2.tween_property(self, "position", Vector2(5, 0), 0.08)
	tween2.tween_property(self, "position", Vector2(-5, 0), 0.08)
	tween2.tween_property(self, "position", Vector2(5, 0), 0.08)
	tween2.tween_property(self, "position", Vector2(0, 0), 0.04)
	
	position = Vector2(0, 0)
	tween2.tween_property(self, "position", Vector2(0, -700), 0.5)

func cursor_magic():
	Input.set_custom_mouse_cursor(cursor_closed, Input.CURSOR_ARROW, Vector2(16,16))
	await get_tree().create_timer(0.3).timeout
	collision.disabled = true
