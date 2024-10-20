extends Node2D

var range: float = 2
var target: Vector2

func create(begin: Vector2, r: float)-> void:
	position = begin
	range = r 
	target = EnemyHandler.return_enemy_position(begin, r)

 #Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position == target:
		self.queue_free()
	if (position.x != target.x):
		if position.x > target.x:
			position.x -= 8
		else: 
			position.x += 8
	if (position.y != target.x):
		if position.y > target.y:
			position.y -= 8
		else: 
			position.y += 8
			
	
