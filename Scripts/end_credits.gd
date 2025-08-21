extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim.play("End Credits")
	anim.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "End Credits":
		get_tree().quit()
