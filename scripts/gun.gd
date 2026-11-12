extends Node2D

@export var muzzle : Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Game.controller_active:
		# Get vector from right joystick
		Game.direction = Input.get_vector("player_aim_left", "player_aim_right", "player_aim_up", "player_aim_down")
	else:
		# Get vector from the center point to the mouse
		Game.direction = get_global_mouse_position() - global_position
	# Calculate angle and apply rotation to the object around the center
	global_rotation = Game.direction.angle()
	# Flip sprite if rotation is greater than half Pi, indicating it's pointing leftward instead of rightward.
	$Sprite2D.flip_v = true if abs(global_rotation) > (PI/2) else false
