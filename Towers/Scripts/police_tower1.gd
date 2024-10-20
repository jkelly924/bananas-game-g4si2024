extends Node2D

@export var tower_name: String = "police_tower1"

#@export var slowing_modifier: float = 0.5
#@export var slowing_range: float = 0.5
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var damage: float = 15
var range: float = 5
var cooldown: float = 2

var last_fire_time: float = 0


# Here we can load the animation and whatever hoopla
func _ready() -> void:
	#sprite.play("blare")
	_process(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Time.get_ticks_msec() / 1000 - last_fire_time < cooldown:
		return
	
	var enemy: Node = EnemyHandler.get_first_valid_enemy(position, range)
	if enemy:
		enemy.take_damage(damage)
		last_fire_time = Time.get_ticks_msec() / 1000
