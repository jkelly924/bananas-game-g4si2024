extends Node2D

@export var health: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = 100.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(damage: float) -> void:
	health -= damage
	print(health);
	
	if health < 0:
		print("DIED!")
