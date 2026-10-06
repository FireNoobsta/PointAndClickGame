extends Area2D
class_name SocketArea

@onready var joint : PinJoint2D = $PinJoint2D

var turnAmount : float = 0.0
var isTight : bool = false
var isWrenchAttached : bool = false
var wrench : RigidBody2D
signal gotTightened

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.area_entered.connect(_on_wrench_enter_socket)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isWrenchAttached:
		turnAmount += clampf(wrench.angular_velocity * delta, 0.0, wrench.angular_velocity * delta)
		#print(turnAmount)
		#Socket tightens after 3 rotations
		if (turnAmount >= PI * 6):
			print("Socket Tightened!")
			isWrenchAttached = false
			joint.node_b = ""
			isTight = true
			gotTightened.emit()

func _on_wrench_enter_socket(area: Area2D):
	pass
	print("On Enter Triggered on: " + str(area))
	wrench = area.get_parent() as RigidBody2D
	wrench.translate(self.global_position - wrench.global_position)
	#wrench.transform.origin = self.transform.origin
	joint.node_b = wrench.get_path()
	#self.monitoring = false
	self.set_deferred("monitoring", false)
	isWrenchAttached = true
