extends Node2D

@export var sockets : Array[SocketArea]
@export var continueButton : CanvasItem
var numTightened = 0
var numSockets

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	continueButton.hide()
	numSockets = sockets.size()
	for socket in sockets:
		socket.gotTightened.connect(_increment_num_tightened)


func _increment_num_tightened():
	numTightened += 1
	if numTightened >= numSockets:
		_on_all_tightened()

func _on_all_tightened():
	print("Tire Successfully Installed!")
	continueButton.show()
