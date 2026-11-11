extends Node2D

@export var muzzle : Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Get vector from the center point to the mouse
	var direction = get_global_mouse_position() - global_position
	# Calculate angle and apply rotation to the object around the center
	global_rotation = direction.angle()
	# Flip sprite if rotation is greater than half Pi, indicating it's pointing leftward instead of rightward.
	$Sprite2D.flip_v = true if abs(global_rotation) > (PI/2) else false
