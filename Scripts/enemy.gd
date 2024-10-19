extends Node2D

@export var health: float
@export var speed: float

var path: Path2D
var path_follow: PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = 100.0
	speed = 50
	
	var root_node: Node2D = get_tree().get_root().get_node("test_level")
	
	path = root_node.get_node("Path2D")
	path_follow = PathFollow2D.new()
	path.add_child(path_follow)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress += speed * delta
	self.position = path_follow.position
	#print(path_follow.progress)
	


func take_damage(damage: float) -> void:
	health -= damage
	
	if health < 0:
		print("DIED!")
