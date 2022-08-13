extends Control

enum CELL_VALUE {
	FREE, FILLED, CROSSED, MARK1, MARK2
}

export var filled_color : Color = Color.black

var size: Vector2 = Vector2.ZERO
var cells: Vector2 = Vector2.ZERO

var cell_values = Array(Array())

onready var crossed = preload('res://picross/cells/cell_crossed.tscn')
onready var mark1 = preload('res://picross/cells/cell_mark1.tscn')
onready var mark2 = preload('res://picross/cells/cell_mark2.tscn')


func build_board() -> void:
	size = get_parent().rect_size
	cells = get_parent().cells
	print(cells)
	print(size)
	
	for x in range(cells.x):
		cell_values.append(Array())
		for y in range(cells.y):
			cell_values[x].append(CELL_VALUE.FREE)
	
	update_cells()


func update_cells() -> void:
	clear_special_cells()
	
	var cell_size = size / cells
	
	for y in range(cells.y):
		for x in range(cells.x):
			if cell_values[x][y] != CELL_VALUE.FREE and cell_values[x][y] != CELL_VALUE.FILLED:
				var new_node
				
				match cell_values[x][y]:
					CELL_VALUE.CROSSED:
						new_node = crossed.instance()
					CELL_VALUE.MARK1:
						new_node = mark1.instance()
					CELL_VALUE.MARK2:
						new_node = mark2.instance()
				
				if new_node:
					new_node.name = 'Cell ' + str(x) + ', ' + str(y)
					new_node.position = cell_size * Vector2(x, y)
					new_node.scale = cell_size
					add_child(new_node)
	
	update()


func clear_special_cells() -> void:
	for cell in get_children():
		cell.queue_free()


func fill_cell(position: Vector2) -> void:
	if cell_values[position.x][position.y] != CELL_VALUE.FILLED:
		cell_values[position.x][position.y] = CELL_VALUE.FILLED
		update()


func _draw() -> void:
	var cell_size = size / cells
	
	for y in range(cells.y):
		for x in range(cells.x):
			if cell_values[x][y] == CELL_VALUE.FILLED:
				var from : Vector2 = cell_size * Vector2(x, y)
				draw_rect(Rect2(from, cell_size), filled_color)
