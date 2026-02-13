extends Node2D
class_name PlacementControl

@export var grid: Grid = null
@export var pending_building: BuildingData = null

signal building_placed()

func begin_place(card: Card, data: BuildingData) -> void:
	pending_building = data

func end_place() -> void:
	pending_building = null

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			handle_left_click()
	
func handle_left_click() -> void:
	print("Click")
	var cam := get_viewport().get_camera_2d()
	if cam == null:
		return
	
	var world_pos := cam.get_global_mouse_position()
	var cell_pos := grid.world_to_grid(world_pos)
	
	if not grid.grid.has(cell_pos):
		return
	
	var cell := grid.grid[cell_pos]
	
	if pending_building:
		try_place()
		return
	
	if cell.building:
		print(cell.building.data.building_name)
	
func try_place() -> void:
	if grid == null:
		push_error("GRID IS NULL")
		return
	
	var cam := get_viewport().get_camera_2d()
	var world_pos := cam.get_global_mouse_position()
	var cell_pos :=  grid.world_to_grid(world_pos)
	
	if grid.place_building(cell_pos, pending_building):
		end_place()
		building_placed.emit()
