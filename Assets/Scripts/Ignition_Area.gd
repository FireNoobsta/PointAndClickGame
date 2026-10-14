extends Area2D
class_name IgnitionArea

@onready var joint : PinJoint2D = $PinJoint2D
@export var turnButton : BaseButton

var turnDuration : float = 0.0
#var isTight : bool = false
var isAttached : bool = false
var isTurningKey :bool = false
var numAttempts = 0
var lockoutProgress : bool = false
var key : RigidBody2D
var keySprite : Sprite2D
var keyNormalScale : Vector2
#signal gotAttached

func _process(delta: float) -> void:
	if isTurningKey and not lockoutProgress:
		turnDuration += delta
		if turnDuration >= 1.0:
			print("Ignition attempt addded")
			lockoutProgress = true
			numAttempts += 1
			if numAttempts >= 3:
				print("Engine started!")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.area_entered.connect(_on_key_enter)
	if turnButton == null:
		push_error("TurnButton is not set!")
	else:
		turnButton.hide()
		turnButton.button_down.connect(_on_turn_button_down)
		turnButton.button_up.connect(_on_turn_button_up)


func _on_turn_button_down():
	isTurningKey = true
	turnDuration = 0
	lockoutProgress = false
	if keySprite:
		keySprite.scale = Vector2(keyNormalScale.x * 0.7, keyNormalScale.y)
	
func _on_turn_button_up():
	isTurningKey = false
	turnDuration = 0
	if keySprite:
		keySprite.scale = keyNormalScale

func _on_key_enter(area: Area2D):
	print("On Enter Triggered on: " + str(area))
	key = area.get_parent() as RigidBody2D
	key.translate(self.global_position - key.global_position)
	keySprite = key.get_node("Sprite2D") as Sprite2D
	keyNormalScale = keySprite.transform.get_scale()
	joint.node_b = key.get_path()
	self.set_deferred("monitoring", false)
	isAttached = true
	turnButton.show()
	#gotAttached.emit()
