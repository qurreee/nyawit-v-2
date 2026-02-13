extends Panel

@onready var cash_label: Label = %CashLabel

func _ready() -> void:
	GameManager.money_changed.connect(on_money_changed)

func _on_end_day_button_pressed() -> void:
	GameManager.end_day()

func on_money_changed(amount: int) -> void:
	cash_label.text = str(amount)
