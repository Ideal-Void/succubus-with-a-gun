extends Node

var player
var shootable
var damage_cooldown = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	shootable = get_tree().get_first_node_in_group("shootable")

func player_damage(dmg):
	player.player_damage(dmg)

func enemy_damage(dmg):
	shootable.enemy_damage(dmg)
