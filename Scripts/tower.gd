extends Node2D

# The amount of damager per second, applied per-frame.
@export_range(0.0, 100.0) var damage_rate: float

# The distance in tiles that the damage will be applied. Increments in 1/16ths (one pixel).
@export_range(0.0, 10.0, 1.0/144) var damage_range: float

@export var damage_cooldown: float = 1.0

var last_fire_time: float = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Time.get_ticks_msec() / 1000 - last_fire_time < damage_cooldown:
		return
	
	var fired: bool = false
	var last_enemy_index: int = -1
	while true:
		var enemy_index: int = EnemyHandler.get_furthest_enemy_index(last_enemy_index + 1)
		var enemy: Node2D = EnemyHandler.get_enemy_from_index(enemy_index)
		if enemy == null:
			break
		
		last_enemy_index = enemy_index
		if (enemy.position - position).length() < (damage_range * 144):
			fired = true
			enemy.take_damage(damage_rate)
			break
	
	if fired:
		last_fire_time = Time.get_ticks_msec() / 1000
