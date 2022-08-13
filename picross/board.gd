extends Node2D

export var size: Vector2 = Vector2(50, 50)
export var cells: Vector2 = Vector2(15, 15)

var pressed = false


func _input(event) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			pressed = true
			fill_cell(event.position)
		else:
			pressed = false
	
	elif event is InputEventMouseMotion:
		if pressed:
			fill_cell(event.position)


func fill_cell(screen_position: Vector2) -> void:
	print(screen_position)
	var relative_position : Vector2 = screen_position - global_position
	var cell_position : Vector2 = relative_position / (size / cells)
	cell_position.x = floor(cell_position.x)
	cell_position.y = floor(cell_position.y)
	
	if cell_position.x >= 0 and cell_position.x < cells.x:
		if cell_position.y >= 0 and cell_position.y < cells.y:
			$Cells.fill_cell(cell_position)
