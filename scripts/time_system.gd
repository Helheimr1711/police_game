extends Node
class_name TimeSystem

@export var date_time: DateTime
@export var ticks_per_second: int = 6

var is_paused: bool = false

func _process(delta: float) -> void:
	handle_input()
	
	if is_paused: return
	
	date_time.increase_by_secs(delta * ticks_per_second)

func handle_input() -> void:
	if Input.is_action_just_pressed("pause"):
		is_paused = !is_paused
