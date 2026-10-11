extends Area2D
class_name GasTankArea

@onready var joint : PinJoint2D = $PinJoint2D

var fillAmount : float = 0.0
var fillSpeed : float = 15.0
var isFull : bool = false
var isFilling : bool = false
var can : RigidBody2D
signal gotFilled

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.area_entered.connect(_on_gas_can_enter_area)
	self.area_exited.connect(_on_gas_can_exited_area)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isFilling:
		fillAmount += fillSpeed * delta
		if fillAmount >= 100.0:
			print("Gas Filled up!")
			isFull = true
			gotFilled.emit()
			self.set_deferred("monitoring", false)
			isFilling = false

func _on_gas_can_enter_area(area: Area2D):
	print("On Enter Triggered on: " + str(area))
	isFilling = true

func _on_gas_can_exited_area(area: Area2D):
	print("On Exit Triggered on: " + str(area))
	isFilling = false
