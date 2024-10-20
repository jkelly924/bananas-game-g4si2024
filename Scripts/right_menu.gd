extends CanvasLayer

var full_heart: Texture = load("res://Textures/UI/heart.png")
var empty_heart: Texture = load("res://Textures/UI/heart_empty.png")

@onready var preview: AspectRatioContainer = $preview
@onready var budget_label: Label = $side_panel/MarginContainer/Control/budget_label
@onready var grid_container: GridContainer = $side_panel/MarginContainer/Control/shop_panel/ScrollContainer/GridContainer
@onready var hearts_group: Control = $side_panel/MarginContainer/Control/hearts
@onready var exit_button: Button = $exit_button

var shop_button_scene = load("res://UI/shop_button.tscn")


func _on_budget_changed(budget: int):
	budget_label.text = "Tax Dollars: " + str(budget)


func _on_health_changed(health: int):
	for i: int in range(10):
		var heart = hearts_group.get_node(str(i)).get_node("TextureRect")
		if i < health:
			heart.texture = full_heart
		else:
			heart.texture = empty_heart


func _on_shop_button_pressed(tower_id: String):
	print(tower_id)
	TowerHandler.create_ghost(tower_id)


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


func _on_exit_button_pressed() -> void:
	get_tree().quit()
