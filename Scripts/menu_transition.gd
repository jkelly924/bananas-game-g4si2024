extends CanvasLayer

const speed: int = 100
const spacing: int = 150

@onready var rolling: Node = $rolling
@onready var RollingDone: Timer = $RollingDone

var labels: Array[Node]

func _ready() -> void:
	labels = rolling.get_children()
	for i: int in labels.size():
		labels[i].position = Vector2(0, 1080 + spacing * i)
	
	RollingDone.wait_time = (1080 + len(labels) * spacing - 75 - 540) / speed
	RollingDone.start()


func _process(delta: float) -> void:
	for label: Label in labels:
		label.position -= Vector2(0, speed * delta)


func _on_rolling_done_timeout() -> void:
	get_tree().change_scene_to_file("res://Levels/test_level.tscn")
