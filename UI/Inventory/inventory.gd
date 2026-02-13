extends Panel


@onready var grid_container: HBoxContainer = $MarginContainer/GridContainer
@onready var placement_control: PlacementControl = $"../../../PlacementControl"

const CARD = preload("uid://cncgvnhhytcrx")
var highlighted_card: Card = null

func _ready() -> void:
	
	placement_control.building_placed.connect(on_building_placed)
	#TODO
	for i in 7:
		var card = CARD.instantiate()
		card.selected.connect(self.select_card)
		grid_container.add_child(card)
	
func select_card(card: Card, building_data: BuildingData, is_selected: bool) -> void:
	if not is_selected:
		# unselect
		card.toggle_highlight()
		highlighted_card = null
		placement_control.end_place()
		print("unselect") 
		return

	# selecting a new card
	if highlighted_card:
		highlighted_card.toggle_highlight()

	highlighted_card = card
	highlighted_card.toggle_highlight()
	placement_control.begin_place(card, building_data)

func on_building_placed() -> void:
	if highlighted_card:
		highlighted_card.toggle_highlight()
		highlighted_card = null
