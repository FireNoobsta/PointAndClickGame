extends Node2D

@export var up := true
@onready var upButton := $UpButton
@export var right := true
@onready var rightButton := $RightButton
@export var down := true
@onready var downButton := $DownButton
@export var left := true
@onready var leftButton := $LeftButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not up:
		remove_child(upButton)
		
	if not right:
		remove_child(rightButton)
		
	if not down:
		remove_child(downButton)
		
	if not left:
		remove_child(leftButton)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
