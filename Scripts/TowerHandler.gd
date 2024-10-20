extends Node2D
class_name TowerHandler

@export var can_place_color: Color = Color.from_hsv(0.4, 1, 1, 0.5)
@export var cannot_place_color: Color = Color.from_hsv(0, 1, 1, 0.5)

var tile_map: TileMapLayer

static var towers_node: Node2D

static var slowing_towers: Array[Node]

static var positive_towers: int =0

static var current_ghost: Node2D
static var current_ghost_name: String

func _ready() -> void:
	tile_map = get_parent().get_node("TileMapLayer")
	towers_node = self

func is_point_on_path(position: Vector2) -> bool:
	return tile_map.get_cell_source_id(tile_map.local_to_map(position)) != -1 and tile_map.get_cell_atlas_coords(tile_map.local_to_map(position)).x != 0

static func create_ghost(tower_name: String):
	current_ghost_name = tower_name
	current_ghost = load("res://Towers/Scenes/" + tower_name + ".tscn").instantiate()
	towers_node.add_child(current_ghost)
	current_ghost.z_index = 9999
	current_ghost.disabled = true

static func create_tower(tower_name: String, tower_position: Vector2) -> void:
	var tower: Node = load("res://Towers/Scenes/" + tower_name + ".tscn").instantiate()
	towers_node.add_child(tower)
	tower.global_position = tower_position
	tower.z_index = tower_position.y / 128
	
	if tower_name == "speaker" or tower_name == "bench":
		slowing_towers.append(tower)
		
	if tower_name == "house":
		positive_towers +=10;
	if tower_name == "shelter":
		positive_towers +=5;
		
	if tower_name == "food":
		positive_towers +=3;
	if tower_name == "tent":
		positive_towers +=1;
		
func _process(delta: float) -> void:
	if current_ghost:
		current_ghost.global_position = get_global_mouse_position()
		if is_point_on_path(tile_map.to_local(current_ghost.global_position)):
			if current_ghost_name == "spike":
				current_ghost.modulate = can_place_color
				current_ghost.global_position = tile_map.to_global(tile_map.map_to_local(tile_map.local_to_map(tile_map.to_local(current_ghost.global_position))))
			else:
				current_ghost.modulate = cannot_place_color
		else:
			if current_ghost_name == "spike":
				current_ghost.modulate = cannot_place_color
			else:
				current_ghost.modulate = can_place_color
		
func _unhandled_input(event: InputEvent) -> void:
	if current_ghost:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if is_point_on_path(tile_map.to_local(current_ghost.global_position)):
				if current_ghost_name == "spike":
					create_tower(current_ghost_name, current_ghost.global_position)
					towers_node.remove_child(current_ghost)
					current_ghost = null
					current_ghost_name = ""
			else:
				if current_ghost_name != "spike":
					create_tower(current_ghost_name, current_ghost.global_position)
					towers_node.remove_child(current_ghost)
					current_ghost = null
					current_ghost_name = ""
		elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
			towers_node.remove_child(current_ghost)
			current_ghost = null
			current_ghost_name = ""
