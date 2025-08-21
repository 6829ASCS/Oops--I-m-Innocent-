extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	$"../CanvasLayer/ColorRect".material.set_shader_parameter("amplitude", 4.5)
	anim.play("Intro")
	anim.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(name: String) -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
