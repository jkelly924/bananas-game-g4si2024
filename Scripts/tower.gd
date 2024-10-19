extends Node2D

# The amount of damager per second, applied per-frame.
@export_range(0.0, 100.0) var damage_rate: float

# The distance in tiles that the damage will be applied. Increments in 1/16ths (one pixel).
@export_range(0.0, 10.0, 1.0/144) var damage_range: float

var last_fire_time: float = 0

var enemies: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemies = owner.get_node("Enemies")
	print("Rate: ", damage_rate)
	print("Range: ", damage_range)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Time.get_ticks_msec() / 1000 - last_fire_time < 1:
		return
	
	var fired: bool = false
	var last_enemy_index: int = -1
	while true:
		var enemy_index: int = enemies.get_furthest_enemy_index(last_enemy_index + 1)
		var enemy: Node2D = enemies.get_enemy_from_index(enemy_index)
		if enemy == null:
			break
		
		last_enemy_index = enemy_index
		print((enemy.position - position).length())
		if (enemy.position - position).length() < (damage_range * 144):
			fired = true
			print("BAM")
			enemy.take_damage(damage_rate * delta)
			break
	
	if fired:
		last_fire_time = Time.get_ticks_msec()
