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
var engineStarted : bool = false
var key : RigidBody2D
var keySprite : Sprite2D
var keyNormalScale : Vector2
var selfNormalposition : Vector2
#signal gotAttached

func _process(delta: float) -> void:
	if engineStarted:
		turnDuration += delta
		if (fmod(turnDuration, 0.2) > 0.1):
			self.transform.origin = Vector2(selfNormalposition.x + 0.6, selfNormalposition.y)
		else:
			self.transform.origin = selfNormalposition
		return
	if isTurningKey and not lockoutProgress:
		turnDuration += delta
		if (fmod(turnDuration, 0.1)) > 0.05:
			self.transform.origin = Vector2(selfNormalposition.x, selfNormalposition.y + 1)
		else:
			self.transform.origin = selfNormalposition
		#self.translate()
		if turnDuration >= 1.0:
			print("Ignition attempt addded")
			lockoutProgress = true
			numAttempts += 1
			if numAttempts >= 3:
				print("Engine started!")
				engineStarted = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.area_entered.connect(_on_key_enter)
	selfNormalposition = self.transform.origin
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
