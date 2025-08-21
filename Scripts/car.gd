extends Node2D

@onready var player_mini: Sprite2D = $"../Item - hat/player mini"

@onready var engine_start: AudioStreamPlayer2D = $"Engine Start"
@onready var bone_crack: AudioStreamPlayer2D = $"bone crack"

func _ready():
	player_mini.hide()
	CrimeScene.connect("tire_picked_response", Callable(self, "_on_tire_picked"))

func _on_tire_picked():
	var tween1 = get_tree().create_tween()
	
	player_mini.show()
	player_mini.modulate.a = 0.0
	tween1.tween_property(player_mini, "modulate:a", 1.0, 1.0)
	await tween1.finished
	
	var tween2 = get_tree().create_tween()
	engine_start.play()
	position = Vector2(0, 0)
	tween2.tween_property(self, "position", Vector2(-5, 0), 0.04)
	tween2.tween_property(self, "position", Vector2(5, 0), 0.08)
	tween2.tween_property(self, "position", Vector2(-5, 0), 0.08)
	tween2.tween_property(self, "position", Vector2(5, 0), 0.08)
	tween2.tween_property(self, "position", Vector2(-5, 0), 0.08)
	tween2.tween_property(self, "position", Vector2(5, 0), 0.08)
	tween2.tween_property(self, "position", Vector2(0, 0), 0.04)
		
	position = Vector2(0, 0)
	tween2.tween_property(self, "position", Vector2(0, -700), 0.5)
	
	await get_tree().create_timer(0.6).timeout
	bone_crack.play()
	await get_tree().create_timer(0.5).timeout
	
	EndingsManager.tire_ending_found = true
	EndingsManager.ending_id = "tire"
	EndingsManager.emit_signal("transition_to_ending")
