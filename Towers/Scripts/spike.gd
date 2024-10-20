extends Node2D

@export var disabled: bool = false

@export var tower_name: String = "Spikes"

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


var damage: float = 10
var dist_range: float = 2
var cooldown: float = 1

var last_fire_time: float = 0


# Here we can load the animation and whatever hoopla
func _ready() -> void:
	#sprite.play("blare")
	_process(0)
	Globals.round_started.connect(rearm)

var health: int = 10

func rearm():
	damage = 10
	health = 10

func harmless():
	damage = 0
	#queue_free

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if disabled:
		return
		
	if Time.get_ticks_msec() / 1000 - last_fire_time < cooldown:
		return
	
	var enemy: Node = EnemyHandler.get_first_valid_enemy(position, dist_range)
	if enemy:
		enemy.take_damage(damage)
		last_fire_time = Time.get_ticks_msec() / 1000
		
		# spike health
		health -= 1
		if health == 0:
			print("spike is now harmless")
			harmless()
			sprite.play()