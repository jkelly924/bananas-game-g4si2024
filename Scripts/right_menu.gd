extends CanvasLayer

var full_heart: Texture = load("res://Textures/UI/heart.png")
var empty_heart: Texture = load("res://Textures/UI/heart_empty.png")

@onready var preview: AspectRatioContainer = $preview
@onready var budget_label: Label = $side_panel/MarginContainer/Control/budget_label
@onready var grid_container: GridContainer = $side_panel/MarginContainer/Control/shop_panel/ScrollContainer/GridContainer
@onready var hearts_group: Control = $side_panel/MarginContainer/Control/hearts

var shop_button_scene = load("res://UI/shop_button.tscn")


func _on_budget_changed(budget: int):
	budget_label.text = "Budget: $" + str(budget) + "k"


func _on_health_changed(health: int):
	
	for i: int in range(10):
		var heart = hearts_group.get_node(str(i)).get_node("TextureRect")
		if i < health:
			heart.texture = full_heart
		else:
			heart.texture = empty_heart

func begin_preview_dragging(tower_id: String) -> void:
	pass

func _on_shop_button_pressed(tower_id: String):
	var tower_information
	for info in Globals.tower_information:
		if info.id == tower_id:
			tower_information = info

	if Globals.budget >= tower_information.price:
		Globals.award_budget(-tower_information.price)
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
		price_label.text = '$' + str(tower_information.price) + 'k'
		preview_image.texture = tower_information.texture
		
		this.get_node("Button").connect("pressed", _on_shop_button_pressed.bind(tower_information.id))
		
		grid_container.add_child(this)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
