extends Node2D

@onready var grid: Grid = $Grid

func _ready() -> void:
	grid.generate_grid()
