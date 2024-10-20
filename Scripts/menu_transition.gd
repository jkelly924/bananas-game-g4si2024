extends CanvasLayer

@export var fade_speed: int = 2
@export var stay_duration: int = 3

@onready var timer: Timer = $Timer

var labels: Array
var current_label: int = 0
var fade_direction: int = 1

func on_timeout():
	if fade_direction == -1:
		current_label += 1
		if current_label > len(labels) - 1:
			get_tree().change_scene_to_file("res://Levels/test_level.tscn")
			return
		else:
			fade_direction = 2
	
	fade_direction -= 1

	if fade_direction == 0:
		timer.wait_time = stay_duration
	else:
		timer.wait_time = fade_speed
	
	timer.start()
	
	
		
func _ready() -> void:
	labels = get_node("ColorRect").get_children()
	timer.one_shot = true
	timer.wait_time = fade_speed
	timer.start()
	timer.timeout.connect(on_timeout)


func _process(delta: float) -> void:
	if fade_direction == 1:
		labels[current_label].modulate = Color.from_hsv(0, 0, 1, (timer.wait_time - timer.time_left) / timer.wait_time)
	elif fade_direction == -1:
		labels[current_label].modulate = Color.from_hsv(0, 0, 1, timer.time_left / timer.wait_time)
