extends Node2D

@export var disabled: bool = false

@export var tower_name: String = "sprinkler"

var damage: float = 10
var range: float = 20
var cooldown: float = 0.1

var last_fire_time: float = 0


# Here we can load the animation and whatever hoopla
func _ready() -> void:
	get_node("AnimatedSprite2D").play()
	get_node("GPUParticles2D").restart()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if disabled:
		return
	
	if Time.get_ticks_msec() / 1000 - last_fire_time < cooldown:
		return
	
	var enemy: Node = EnemyHandler.get_first_valid_enemy(position, range)
	if enemy:
		enemy.take_damage(damage)
		last_fire_time = Time.get_ticks_msec() / 1000
