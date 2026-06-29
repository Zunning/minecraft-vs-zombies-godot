class_name DeviceBase
extends Node2D

var device_id: String = ""
var device_name: String = ""
var device_type: String = ""
var max_health: int = 500
var current_health: int = 500
var row: int = 0
var col: int = 0
var can_be_activated: bool = false
var attack_damage: int = 20
var attack_speed: float = 1

func damage(value: int):
	current_health -= value
	if current_health <= 0:
		die()
	
func die():
	GridManager.remove_device(row, col)
	queue_free()
