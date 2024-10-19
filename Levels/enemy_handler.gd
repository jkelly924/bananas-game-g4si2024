extends Node2D


var enemies: Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_farthest_enemy() -> Node2D:
	for i: int in enemies.size():
		var enemy: Node2D = enemies[i]
		if enemy != null:
			return enemy
	
	return null


func _on_child_entered_tree(node: Node) -> void:
	enemies.append(node)
