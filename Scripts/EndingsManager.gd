extends Node

var hat_ending_found = false
var wig_ending_found = false
var gun_ending_found = false
var ducky_ending_found = false
var tire_ending_found = false
var paint_ending_found = false
var timeout_ending_found = false

var ending_id: String
var total_endings_found = 0

signal transition_to_ending
signal end_screen
