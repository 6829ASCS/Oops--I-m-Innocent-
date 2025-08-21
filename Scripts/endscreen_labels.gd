extends Node2D

@onready var one_liner: Label = $"One Liner"
@onready var endings_label: Label = $"Endings Found"

func _ready():
	EndingsManager.connect("end_screen", Callable(self, "_end_screen"))

func _end_screen():
	EndingsManager.total_endings_found = int(EndingsManager.hat_ending_found) +  int(EndingsManager.wig_ending_found) +  int(EndingsManager.gun_ending_found) + int(EndingsManager.ducky_ending_found) + int(EndingsManager.tire_ending_found) +  int(EndingsManager.paint_ending_found) +  int(EndingsManager.timeout_ending_found)
	endings_label.text = "%d/7 endings found" % EndingsManager.total_endings_found
	
	if EndingsManager.total_endings_found == 7:
		$"../Play Again".hide()
		$"../Play Again/CollisionShape2D".disabled = true
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://Scenes/End Credits.tscn")
	
	if EndingsManager.ending_id == "gun":
		one_liner.text = "Master Cop Killer"

	if EndingsManager.ending_id == "paint":
		one_liner.text = "Taken out with the trash"

	if EndingsManager.ending_id == "wig":
		one_liner.text = "Snitches get stitches"

	if EndingsManager.ending_id == "hat":
		one_liner.text = "Ridin' free"

	if EndingsManager.ending_id == "ducky":
		one_liner.text = "Novice Cop Killer"

	if EndingsManager.ending_id == "tire":
		one_liner.text = "Dead End"

	if EndingsManager.ending_id == "timeout":
		one_liner.text = "You snooze you lose"
