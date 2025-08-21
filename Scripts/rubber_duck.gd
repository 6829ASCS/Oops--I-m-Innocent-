extends Area2D

@onready var ducky: Sprite2D = $Ducky
@onready var grass: Sprite2D = $Grass
@onready var collision: CollisionShape2D = $CollisionShape2D



var cursor_interact = preload("res://Assets/cursors/hand_thin_open.png")
var cursor_default = preload("res://Assets/cursors/pointer_b_shaded.png")
const cursor_closed = preload("res://Assets/cursors/hand_thin_closed.png")

var rubber_duck_picked = false

func _ready():	
	ducky.hide()
	grass.hide()

	CrimeScene.connect("rubber_duck_on", Callable(self, "_rubber_duck_on"))
	CrimeScene.connect("rubber_duck_off", Callable(self, "_rubber_duck_off"))
	
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	connect("input_event", _on_input_event)

func _on_mouse_entered():
	if CrimeScene.item_picked == false and CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == true:
			Input.set_custom_mouse_cursor(cursor_interact, Input.CURSOR_ARROW, Vector2(16,16))

func _on_mouse_exited():
	if CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == true:
		Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW, Vector2(16,16))


func _on_input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		if CrimeScene.item_picked == false and CrimeScene.can_start == true and CrimeScene.rubber_duck_visible == true and rubber_duck_picked == false:
			rubber_duck_picked = true
			Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW, Vector2(16,16))
			cursor_magic()
			var tween = get_tree().create_tween()
			ducky.modulate.a = 1.0
			tween.tween_property(ducky, "modulate:a", 0.0, 0.5)
			await tween.finished
			ducky.hide()

func _transition_to_ending():
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://Scenes/endings.tscn")

func _rubber_duck_on():
	ducky.show()
	grass.show()

func _rubber_duck_off():
	CrimeScene.rubber_duck_visible = false
	
	ducky.hide()
	grass.hide()
	
	if rubber_duck_picked == true and CrimeScene.countdown_ended == false:
		CrimeScene.item_picked = true
		await get_tree().create_timer(0.5).timeout
		CrimeScene.police_triggered = true
		CrimeScene.emit_signal("trigger_police_lights")
		await get_tree().create_timer(1.5).timeout
		
		Dialogic.start("rubber_duck_picked")					
		await Dialogic.timeline_ended
			
		EndingsManager.ducky_ending_found = true
		EndingsManager.ending_id = "ducky"
		EndingsManager.emit_signal("transition_to_ending")

func cursor_magic():
	Input.set_custom_mouse_cursor(cursor_closed, Input.CURSOR_ARROW, Vector2(16,16))
	await get_tree().create_timer(0.3).timeout
	collision.disabled = true
