extends Control
class_name Card

@export var building_data: BuildingData
@export var amount: int = 1
@onready var texture_rect: TextureRect = $TextureRect

signal selected(card: Card, building_data: BuildingData, is_selected: bool)
var highlighted: bool = false


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:
		selected.emit(self, building_data, !highlighted)
		accept_event()
		
func toggle_highlight() -> void:
	highlighted = !highlighted
	if highlighted:
		texture_rect.self_modulate = Color(1.1, 1.1, 1.1)
		scale = Vector2(1.05, 1.05)
	else:
		texture_rect.self_modulate = Color.WHITE
		scale = Vector2.ONE
