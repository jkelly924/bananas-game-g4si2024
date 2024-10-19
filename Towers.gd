extends Node

var enemies
var towers
var game_data


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent: Node2D = self.get_parent()
	enemies = parent.get_node('Enemies')
	towers = parent.get_node('Towers')
	game_data = parent.get_node('GameDataScript')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for tower: Sprite2D in towers.get_children():
		var tower_type: String = tower.get_meta('Type')
		var tower_data = game_data.tower_data[tower_type]
		for enemy: AnimatedSprite2D in enemies.get_children():
			var distance: float = (tower.position - enemy.position).length()
			if distance < tower_data.range:
				enemy.take_damage(tower_data.damage)
				print(enemy.get_meta('Health'))
	
