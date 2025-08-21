extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	$ColorRect.color = Color(0, 0, 0, 1)
	EndingsManager.connect("transition_to_ending", Callable(self, "_transition_to_ending"))
	fade_to_normal()


func fade_to_black():
	color_rect.visible = true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	

func fade_to_normal():
	color_rect.visible = true
	animation_player.play("fade_to_normal")
	await animation_player.animation_finished
	$ColorRect.hide()

func _transition_to_ending():
	fade_to_black()
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Endings.tscn")
