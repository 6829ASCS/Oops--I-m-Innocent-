extends Node2D

@onready var background: Sprite2D = $Background

var behind_bars = preload("res://Assets/CGs/BehindBars_Cinematic.png")
var dead = preload("res://Assets/CGs/Dead_Cinematic.png")
var mob_boss = preload("res://Assets/CGs/MafiaBoss_Cinematic.png")
var black = preload("res://Assets/CGs/black_CG.png")

func _ready():
	background.texture = black
	Dialogic.signal_event.connect(_on_dialogic_signal)

	if EndingsManager.ending_id == "gun":
		Dialogic.start("gun_ending")

	if EndingsManager.ending_id == "hat":
		Dialogic.start("hat_ending")

	if EndingsManager.ending_id == "wig":
		Dialogic.start("wig_ending")

	if EndingsManager.ending_id == "ducky":
		Dialogic.start("ducky_ending")

	if EndingsManager.ending_id == "tire":
		Dialogic.start("tire_ending")

	if EndingsManager.ending_id == "paint":
		Dialogic.start("paint_ending")

	if EndingsManager.ending_id == "timeout":
		Dialogic.start("timeout_ending")


func _on_dialogic_signal(argument:String):
	if argument == "black":
		background.texture = black
		
	if argument == "jail":
		$Transition.fade_to_normal()
		background.texture = behind_bars
		
	if argument == "dead":
		$Transition.fade_to_normal()
		background.texture = dead
		
	if argument == "mob_boss":
		$Transition.fade_to_normal()
		background.texture = mob_boss
		
	if argument == "end_transition":
		$Transition.fade_to_black()
		await get_tree().create_timer(1.5).timeout
		background.hide()
		EndingsManager.emit_signal("end_screen")
		$Transition.fade_to_normal()
