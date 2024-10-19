extends Node2D

# The amount of damager per second, applied per-frame.
@export_range(0.0, 100.0) var damage_rate: float

# The distance in tiles that the damage will be applied. Increments in 1/16ths (one pixel).
@export_range(0.0, 10.0, 1.0/16) var damage_range: float

var last_fire_time: float = 0

var enemies: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemies = owner.get_node("Enemies")
	print(owner.get_node("Enemies").get_children())
	print("Rate: ", damage_rate)
	print("Range: ", damage_range)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if last_fire_time - Time.get_ticks_msec() / 1000 < 1:
		return
	
	var fired: bool = false
	while true:
		var enemy: Node2D = enemies.get_furthest_enemy()
		if enemy == null:
			break
		
		if (enemy.position - position).length() < (damage_range * 16):
			fired = true
			print("BAM")
			enemy.take_damage(damage_rate * delta)
			break
	
	if fired:
		last_fire_time = Time.get_ticks_msec()
