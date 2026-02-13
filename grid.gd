extends Node2D
class_name Grid

@export var column: int = 12 #X
@export var row: int = 12 #Y
@export var cell_size: int = 128
@export var show_debug: bool = false

@onready var buildings: Node2D = $"../Buildings"

@export var grid: Dictionary[Vector2i, CellData] = {}

func _ready() -> void:
	GameManager.day_ended.connect(on_day_ended)

func generate_grid() -> void:
	for x in column:
		for y in row:
			var cell := CellData.new()
			cell.coords = Vector2i(x,y)
			grid[cell.coords] = cell
			
			if show_debug:  #DEBUG
				var rect = ReferenceRect.new()
				rect.position = grid_to_world(Vector2(x,y))
				rect.size = Vector2(cell_size, cell_size)
				rect.editor_only = false
				add_child(rect)
				var label = Label.new()
				label.text = str(Vector2(x,y))
				rect.add_child(label)

func grid_to_world(pos: Vector2i) -> Vector2:
	return Vector2(pos) * cell_size

func world_to_grid(pos: Vector2) -> Vector2i:
	return Vector2i(floor(pos / cell_size))

func place_building(cell_pos: Vector2i, pending_building: BuildingData) -> bool:
	var cell := grid[cell_pos]
	if cell.building:
		return false
	else:
		var new_building : Building= pending_building.scene.instantiate()
		new_building.data = pending_building
		buildings.add_child(new_building)
		new_building.setup(grid_to_world(cell_pos))
		
		cell.building = new_building
		print("GRID (place):", self)
		return true

func on_day_ended(day: int) -> void:
	for cell: CellData in grid.values():
		if cell.building: 
			cell.building.on_day_end()
