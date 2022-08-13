extends Node2D

onready var size: Vector2 = get_parent().size
onready var cells: Vector2 = get_parent().cells

export var line_color : Color = Color.blue
export var strong_line_color : Color = Color.purple

export var strong_line_frequency : int = 5;
export var line_width : int = 1;
export var strong_line_width : int = 2;


func _draw():
	var cell_size = size / cells
	draw_grid(cell_size)
	draw_strong_grid(cell_size)


func draw_grid(cell_size: Vector2):
	# Horizontal lines
	for x in range(cells.x):
		var from : Vector2 = Vector2(x, 0) * cell_size
		var to : Vector2 = Vector2(x, cells.y) * cell_size
		
		draw_line(from, to, line_color, line_width)
	
	# Vertical lines
	for y in range(cells.y):
		var from : Vector2 = Vector2(0, y) * cell_size
		var to : Vector2 = Vector2(cells.x, y) * cell_size
		
		draw_line(from, to, line_color, line_width)


func draw_strong_grid(cell_size: Vector2):
	# Horizontal strong lines
	for x in range(strong_line_frequency, cells.x, strong_line_frequency):
		var from : Vector2 = Vector2(x, 0) * cell_size
		var to : Vector2 = Vector2(x, cells.y) * cell_size
		
		draw_line(from, to, strong_line_color, strong_line_width)
	
	# Vertical strong lines
	for y in range(strong_line_frequency, cells.y, strong_line_frequency):
		var from : Vector2 = Vector2(0, y) * cell_size
		var to : Vector2 = Vector2(cells.x, y) * cell_size
		
		draw_line(from, to, strong_line_color, strong_line_width)
