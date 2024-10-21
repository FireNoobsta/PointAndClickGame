extends Node2D

@export var itemsToReveal : Array[CanvasItem]
@export var button : BaseButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if button and (itemsToReveal.size() > 0):
		button.pressed.connect(ShowItem.bind(itemsToReveal))


func ShowItem(items : Array[CanvasItem]):
	for item in items:
		item.show()
