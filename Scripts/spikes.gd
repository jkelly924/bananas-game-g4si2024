extends Node2D

@export var tower_name: String = "Spikes"

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


var damage: float = 10
var range: float = 2
var cooldown: float = 2

var last_fire_time: float = 0


# Here we can load the animation and whatever hoopla
func _ready() -> void:
	#sprite.play("blare")
	_process(0)

var health: int = 5

func harmless():
	damage = 0
	#queue_free

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Time.get_ticks_msec() / 1000 - last_fire_time < cooldown:
		return
	
	var enemy: Node = EnemyHandler.get_first_valid_enemy(position, range)
	if enemy:
		enemy.take_damage(damage)
		last_fire_time = Time.get_ticks_msec() / 1000
		
		# spike health
		health -= 1
		if health < 0:
			print("spike is now harmless")
			harmless()
			sprite.play()
			
