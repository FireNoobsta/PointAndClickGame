extends Node2D

@export var itemsNeeded : Array[String] = ["Key", "Gas", "Tire"]
@onready var plaInv := %PlayerInventory
@onready var buttonNode := $Interactable/TextureButton
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plaInv.received_item.connect(PlayerGotItem)
	UpdateInteractText()

func PlayerGotItem(itemName):
	if itemName in itemsNeeded:
		itemsNeeded.erase(itemName)
		UpdateInteractText()

func UpdateInteractText():
	var tempText = ""
	if itemsNeeded.size() > 0:
		tempText += "The car is inoperable. You need:\n"
		for item in itemsNeeded:
			tempText += "- " + item + "\n"
	else:
		tempText += "You have all the necessary parts! Now quickly get the car up and running!"
	var tempDia = []
	tempDia.append(tempText)
	buttonNode.ChangeDialogue(tempDia)
