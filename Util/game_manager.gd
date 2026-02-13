extends Node

var cash: int = 100
var day:= 1



signal day_ended(day: int)
signal money_changed(amount: int)

func _ready() -> void:
	print("GameManager instance:", self)
	
func get_income(income: int)-> void:
	cash += income
	money_changed.emit(cash)

func end_day()-> void:
	print("=== END DAY", day, "===")
	day += 1
	#cash_label.text = str(cash)
	day_ended.emit(day)
	
