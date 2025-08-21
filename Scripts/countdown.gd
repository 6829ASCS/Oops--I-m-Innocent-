extends Node

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

func _ready():
	label.text = "%02d:%02d" % time_left_to_pick()
	CrimeScene.connect("rubber_duck_off", Callable(self, "_rubber_duck_off"))
	
	label.hide()
	var CrimeScene = get_tree().get_current_scene()
	CrimeScene.connect("start_countdown", Callable(self, "_start_countdown"))
	timer.timeout.connect(_on_timer_finished)

func _start_countdown():
	print("start countdown recieved")
	timer.start()
	label.show()
	var tween1 = get_tree().create_tween()
	label.modulate.a = 0.0
	tween1.tween_property(label, "modulate:a", 1.0, 2.0)

func time_left_to_pick():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]
	
func _process(delta):
	label.text = "%02d:%02d" % time_left_to_pick()
	
	if CrimeScene.item_picked == true:
		_end_timer()
		set_process(false)

func _on_timer_finished():
	CrimeScene.countdown_ended = true
	
	if CrimeScene.rubber_duck_visible == true:
		CrimeScene.emit_signal("rubber_duck_off")
		
		CrimeScene.item_picked = true
		CrimeScene.police_triggered = true
		CrimeScene.emit_signal("trigger_police_lights")
		await get_tree().create_timer(1.5).timeout
		Dialogic.start("time_ran_out")
		
		await Dialogic.timeline_ended
		
		EndingsManager.timeout_ending_found = true
		EndingsManager.ending_id = "timeout"
		EndingsManager.emit_signal("transition_to_ending")

	else:
		CrimeScene.item_picked = true
		CrimeScene.police_triggered = true
		CrimeScene.emit_signal("trigger_police_lights")
		await get_tree().create_timer(1.5).timeout
		Dialogic.start("time_ran_out")	
		
		await Dialogic.timeline_ended
		
		EndingsManager.timeout_ending_found = true
		EndingsManager.ending_id = "timeout"
		EndingsManager.emit_signal("transition_to_ending")

func _end_timer():
	timer.paused = true
	
	var tween2 = get_tree().create_tween()
	label.modulate.a = 1.0
	tween2.tween_property(label, "modulate:a", 0.0, 1.0)
	await tween2.finished
	
	label.hide()
