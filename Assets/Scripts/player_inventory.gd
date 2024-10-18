extends Node2D

var items : Array[String]

@export var itemButtonEntries : Dictionary

signal received_item(item_name)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for itemName in itemButtonEntries:
		var currNode = get_node(itemButtonEntries[itemName])
		currNode.pressed.connect(AddItem.bind(itemName))
		currNode.closed_dialogue_box.connect(currNode.get_parent().remove_child.bind(currNode))

func AddItem(itemName):
	items.append(itemName)
	received_item.emit(itemName)
	print("Received " + itemName)
