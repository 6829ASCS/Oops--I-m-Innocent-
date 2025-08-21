extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	color_rect.visible = false
	color_rect.color = Color(0, 0, 0, 0)

func fade_to_black():
	color_rect.visible = true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	

func fade_to_normal():
	color_rect.visible = true
	animation_player.play("fade_to_normal")
	await animation_player.animation_finished
	$ColorRect.hide()
