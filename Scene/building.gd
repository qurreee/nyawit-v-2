extends Node2D
class_name Building

@export var data: BuildingData
@export var growth:= 0
@onready var label: Label = $Label

func setup(cell_pos: Vector2) -> void:
	if data:
		label.text = data.building_name
	position = cell_pos

func on_day_end() -> void:
	if data.has_growth():
		if data.growth_needed > growth:
			growth += 1
			return
	
	GameManager.get_income(data.income)
