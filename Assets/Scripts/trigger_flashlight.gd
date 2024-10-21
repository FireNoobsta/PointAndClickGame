extends Node2D

@export var button : BaseButton
@export var flashlightNode : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(EnableNode)

func DisableNode():
	flashlightNode.modulate = Color(1.0, 1.0, 1.0, 0)

func EnableNode():
	flashlightNode.modulate = Color(1.0, 1.0, 1.0, 0.97)
