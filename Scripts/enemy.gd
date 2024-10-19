extends Node2D

@export_range(0,2) var starting_level: int = 0
@export var walk_speed: float = 25

@export var level_0_health: float = 50
@export var level_1_health: float = 100
@export var level_2_health: float = 200

var sprite: AnimatedSprite2D
var progress_bar: ProgressBar
var progress_bar_offset: Vector2

var path: Path2D
var path_follow: PathFollow2D

var sprite_variant: int
var level_health: Array[int]
var current_level: int
var current_health: float
var dead: bool

# Adjust level-related stuff
func adjust_to_level(new_level: int):
	current_level = new_level
	current_health = level_health[current_level] + current_health
	sprite.animation = str(sprite_variant) + str(current_level) + "_walk"
	progress_bar.max_value = level_health[current_level]
	progress_bar.value = current_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# Getting random number for variant
	sprite_variant = randi_range(0, 1)

	# Initializing object variables
	sprite = get_node("AnimatedSprite2D")
	progress_bar = get_node("CanvasLayer").get_node("ProgressBar")
	progress_bar_offset = progress_bar.position
	path = get_tree().get_root().get_node("test_level").get_node("Path2D")
	path_follow = PathFollow2D.new()
	path.add_child(path_follow)

	# Setting up level-health array
	level_health = [level_0_health, level_1_health, level_2_health]
	dead = false

	adjust_to_level(starting_level)

	# Starting animation
	sprite.play()
	_process(0) # If we dont call this, they will be at the origin for one frame


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress += walk_speed * delta
	z_index = int(position.y)
	sprite.flip_h = !path_follow.position.x - position.x > 0
	self.position = path_follow.position
	progress_bar.position = get_global_transform_with_canvas().get_origin() + progress_bar_offset
	#print(path_follow.progress)

func handle_death():
	get_parent().remove_child(self) # Deletes itself when it dies

func take_damage(damage: float) -> void:
	current_health -= damage
	progress_bar.value = current_health
	
	if current_health < 0:
		if(current_level > 0):
			adjust_to_level(current_level - 1)
		elif(!dead):
			sprite.animation = str(sprite_variant) + "0_death"
			walk_speed = 0
			sprite.play()
			sprite.animation_finished.connect(handle_death)
			dead = true
