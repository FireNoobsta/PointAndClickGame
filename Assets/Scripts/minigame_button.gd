extends BaseButton
'''
Simple minigame system. Clicking the minigame button
first switches to the minigame camera. The minigame
has a goal buttton that completes the game. This goal 
button is binded to reveal given items and hide others.
Also returns to return camera.
'''
@export var minigameCamera : Camera2D
@export var returnCamera : Camera2D
@export var goalButton : BaseButton
@export var itemsToReveal : Array[CanvasItem]
@export var nodesToHide : Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not (minigameCamera and returnCamera and goalButton):
		print("ERROR with " + str(self) + ": Missing essential references.")
		return
	
	self.pressed.connect(MoveToCamera.bind(minigameCamera))
	goalButton.pressed.connect(MoveToCamera.bind(returnCamera))
	goalButton.pressed.connect(ShowItems)
	goalButton.pressed.connect(HideNodes)
	goalButton.pressed.connect(self.hide)

func MoveToCamera(cam):
	if cam:
		cam.make_current()

func ShowItems():
	for item in itemsToReveal:
		item.show()

func HideNodes():
	for node in nodesToHide:
		node.visible = false
