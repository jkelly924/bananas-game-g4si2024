extends CanvasLayer

var base_background_texture: Texture = load("res://Textures/MainMenu/base.jpeg")
var play_background_texture: Texture = load("res://Textures/MainMenu/play.jpeg")
var credits_background_texture: Texture = load("res://Textures/MainMenu/credits.jpeg")

@onready var play_button: Button = $play_button
@onready var credits_button: Button = $credits_button
@onready var background_image: TextureRect = $background_image


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/MenuTransition.tscn")


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Credits.tscn")


func _on_play_button_mouse_entered() -> void:
	background_image.texture = play_background_texture


func _on_credits_button_mouse_entered() -> void:
	background_image.texture = credits_background_texture


func _on_background_image_mouse_entered() -> void:
	background_image.texture = base_background_texture
