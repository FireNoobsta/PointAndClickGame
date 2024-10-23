extends Node2D

@onready var button := $InfoButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(get_tree().change_scene_to_file.bind("res://Assets/Scenes/TitleScreen.tscn"))
