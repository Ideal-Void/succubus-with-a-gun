extends Node

var player
var stompable
var damage_cooldown = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	stompable = get_tree().get_first_node_in_group("stompable")

func player_damage(dmg):
	player.player_damage(dmg)

func stomp_damage(dmg):
	stompable.stomp_damage(dmg)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
