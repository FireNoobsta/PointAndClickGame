extends Node2D

@export var itemToReveal : CanvasItem
@export var button : BaseButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if button and itemToReveal:
		button.pressed.connect(ShowItem.bind(itemToReveal))


func ShowItem(item : CanvasItem):
	item.show()
