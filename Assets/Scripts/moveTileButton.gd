extends BaseButton

#export var destination := 
#@onready var Camera := $"../Camera2D"
@export var DestinationCamera :Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(self.MoveCamera)


func MoveCamera():
	if DestinationCamera:
		DestinationCamera.make_current()
	else:
		print(str(self) + " has no destination set!")
	
