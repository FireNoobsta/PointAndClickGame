extends Node2D

@export var itemsNeeded : Array[String] = ["Key", "Gas", "Tire"]
@onready var plaInv := %PlayerInventory
@onready var buttonNode := $Interactable/TextureButton
@export var audioManager : Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plaInv.received_item.connect(PlayerGotItem)
	get_node("Interactable/TextureButton").closed_dialogue_box.connect(UpdateInteractText)

func PlayerGotItem(itemName):
	if itemName in itemsNeeded:
		itemsNeeded.erase(itemName)
		UpdateInteractText()
	
	if itemsNeeded.is_empty():
		get_node("Interactable/TextureButton").closed_dialogue_box.connect(StartFixingCar)

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

#TODO: have function lead to sequence of minigames fixing up the car
#Right now it ends game
func StartFixingCar():
	pass
	var tween = get_tree().create_tween()
	audioManager.FadeMusic(1.0)
	var gameNode = get_tree().root.get_node("Game")
	tween.tween_property(gameNode, "modulate", Color.BLACK, 1.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind("res://Assets/Scenes/EndScreen.tscn"))
	
