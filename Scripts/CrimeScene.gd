extends Node2D

var item_picked = false
var can_start = false
var police_triggered = false
var rubber_duck_visible = false
var countdown_ended = false

signal start_truck
signal tire_picked_response
signal start_countdown
signal trigger_police_lights

signal rubber_duck_on
signal rubber_duck_off

func start_crime_scene():
	Dialogic.start("deadguy")
	await Dialogic.timeline_ended
	emit_signal("start_truck")
	
	await get_tree().create_timer(2).timeout 
	emit_signal("start_countdown")
	print("start countdown emitted")
