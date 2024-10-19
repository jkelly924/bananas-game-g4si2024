extends Node

var enemies
var towers


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemies = self.get_parent().get_node("Enemies")
	towers = self.get_parent().get_node("Towers")
	print("Ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for tower: Sprite2D in towers.get_children():
		var tower_type: String = tower.get_meta("Type")
		for enemy: AnimatedSprite2D in enemies.get_children():
			var distance: float = (tower.position - enemy.position).length()
			var enemy_health: float = enemy.get_meta("Health")
			enemy.set_meta("Health", enemy_health - 1)
			#print(enemy_health)
	
