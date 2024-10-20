extends Node2D

@export var disabled: bool = false

@export var tower_name: String = "speaker"

@export var slowing_modifier: float = 0.5
@export var slowing_range: float = 0.5
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var damage: float = 10
var range: float = 2
var cooldown: float = 3

var last_fire_time: float = 0

# Here we can load the animation and whatever hoopla
func _ready() -> void:
	sprite.play("blare")
	_process(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if disabled:
		return

	if Time.get_ticks_msec() / 1000 - last_fire_time < cooldown:
		return
	
	var enemies: Array[Node] = EnemyHandler.get_enemies_in_range(position, range)
	for enemy: Node in enemies:
		enemy.take_damage(damage)
	
	if len(enemies) != 0:
		last_fire_time = Time.get_ticks_msec() / 1000
	
	# var enemy: Node = EnemyHandler.get_first_valid_enemy(position, range)
	# if enemy:
	# 	enemy.take_damage(damage)
	# 	last_fire_time = Time.get_ticks_msec() / 1000
