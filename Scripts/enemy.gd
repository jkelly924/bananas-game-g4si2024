extends Node2D

@export_range(0,2) var starting_level: int = 0
@export var walk_speed: float = 25

@export var level_0_health: float = 50
@export var level_1_health: float = 100
@export var level_2_health: float = 200

var path: Path2D
var path_follow: PathFollow2D

var level_health: Array[int]
var current_level: int
var current_health: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# Setting up level-health array
	level_health = [level_0_health, level_1_health, level_2_health]

	current_level = starting_level
	current_health = level_health[current_level]

	# Adjusting animation
	get_node("AnimatedSprite2D").animation = str(current_level) + "_walk"
	
	path = get_tree().get_root().get_node("test_level").get_node("Path2D")
	path_follow = PathFollow2D.new()
	path.add_child(path_follow)

	get_node("AnimatedSprite2D").play()
	_process(0) # If we dont call this, they will be at the origin for one frame


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress += walk_speed * delta
	self.position = path_follow.position
	#print(path_follow.progress)


func take_damage(damage: float) -> void:
	current_health -= damage
	#print(current_level, " ", current_health);
	
	if current_health < 0:
		if(current_level > 0):
			current_level -= 1
			current_health = level_health[current_level] + current_health
			get_node("AnimatedSprite2D").animation = str(current_level) + "_walk"
		else:
			get_parent().remove_child(self) # Deletes itself when it dies
