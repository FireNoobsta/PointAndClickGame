extends Node2D

'''
Event is dictionary with ...
"trigger" -> BaseButton to trigger event
"songIndex" -> Int that indexes to new song
'''
@export var events : Array[Dictionary]
@onready var manager := $".."
const expectedKeys := [
	"trigger",
	"songIndex"
]
var temp : NodePath

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	for event  in events:
		if event.has_all(expectedKeys):
			var currButton = get_node(event["trigger"])
			var currIndex = event["songIndex"]
			currButton.pressed.connect(TriggerSongEvent.bind(currIndex, currButton))
			#event["trigger"].pressed.disconnect()

func TriggerSongEvent(songIndex  : int, button : Button):
	print("Triggered song " + str(songIndex))
	manager.SeamlessSwitchSong(songIndex)
	button.pressed.disconnect(TriggerSongEvent)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
