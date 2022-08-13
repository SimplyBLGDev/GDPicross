extends Control

export var cells: Vector2 = Vector2(0, 0)

var pressed = false

onready var cells_manager = $Cells
onready var grid_manager = $Grid


func build_board() -> void:
	cells_manager.build_board()
	grid_manager.build_board()


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
	var relative_position : Vector2 = screen_position - get_global_rect().position
	var cell_position : Vector2 = relative_position / (rect_size / cells)
	cell_position.x = floor(cell_position.x)
	cell_position.y = floor(cell_position.y)
	
	if cell_position.x >= 0 and cell_position.x < cells.x:
		if cell_position.y >= 0 and cell_position.y < cells.y:
			$Cells.fill_cell(cell_position)
