extends CanvasLayer

var full_heart: Texture = load("res://Textures/UI/heart.png")
var empty_heart: Texture = load("res://Textures/UI/heart_empty.png")

@onready var preview: AspectRatioContainer = $preview
@onready var budget_label: Label = $side_panel/MarginContainer/Control/budget_label
@onready var grid_container: GridContainer = $side_panel/MarginContainer/Control/shop_panel/ScrollContainer/GridContainer
@onready var hearts_group: Control = $side_panel/MarginContainer/Control/hearts

var shop_button_scene = load("res://UI/shop_button.tscn")


func _on_budget_changed(budget: int):
	budget_label.text = "Tax Dollars: " + str(budget)

# lose screen 
var lose_screen = preload("res://Levels/lose_screen.tscn").instantiate()
func _on_game_lost():
	get_tree().current_scene.add_child(lose_screen)

func _on_health_changed(health: int):

	for i in range(10, health, -1):
		if health == 0:
			#get_tree().change_scene_to_file("res://Levels/lose_screen.tscn")
			Globals.game_over.emit()
			get_tree().current_scene.add_child(lose_screen)
			return
		var heart = hearts_group.get_node(str(i - 1)).get_node("TextureRect")
		heart.texture = empty_heart
	
	#for i: int in range(10):
	#	var heart = hearts_group.get_node(str(i)).get_node("TextureRect")
	#	if i < health:
	#		heart.texture = full_heart
	#	else:
	#		heart.texture = empty_heart

func begin_preview_dragging(tower_id: String) -> void:
	pass

func _on_shop_button_pressed(tower_id: String):
	print(tower_id)
	TowerHandler.create_tower(tower_id, Vector2(400, 400))



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.budget_changed.connect(_on_budget_changed)
	Globals.health_changed.connect(_on_health_changed)
	
	_on_budget_changed(Globals.budget)
	_on_health_changed(Globals.health)
	
	for tower_information in Globals.tower_information:
		var this = shop_button_scene.instantiate()
		
		var name_label: Label = this.get_node("Button").get_node("Background").get_node("Name")
		var price_label: Label = this.get_node("Button").get_node("Background").get_node("Price")
		var preview_image: TextureRect = this.get_node("Button").get_node("Background").get_node("Preview")
		
		name_label.text = str(tower_information.name)
		price_label.text = str(tower_information.price) + 'k'
		preview_image.texture = tower_information.texture
		
		this.get_node("Button").connect("pressed", _on_shop_button_pressed.bind(tower_information.id))
		
		grid_container.add_child(this)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
