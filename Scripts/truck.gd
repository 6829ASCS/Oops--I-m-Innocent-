extends Node2D

@onready var bone_crack: AudioStreamPlayer2D = $"../bone crack"
@onready var truck_horn: AudioStreamPlayer2D = $"truck horn"

func _ready() -> void:
	var CrimeScene = get_tree().get_current_scene()
	CrimeScene.connect("start_truck", Callable(self, "_on_start_truck"))


func _on_start_truck() -> void:
	position = Vector2(3500, 95)
	truck_horn.play()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(340, 95), 1.7)

	await get_tree().create_timer(0.9).timeout
	bone_crack.play()
	await get_tree().create_timer(0.4).timeout
	$"../../deadguy".ran_over()
	CrimeScene.can_start = true	
