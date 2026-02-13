extends Resource
class_name BuildingData

@export var building_name: String
@export var cost: int = 10

@export var scene: PackedScene = preload("uid://bltq02waum6x1")


func has_growth() -> bool:
	return false
