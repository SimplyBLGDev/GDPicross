extends Node2D

onready var size: Vector2 = get_parent().size
onready var cells: Vector2 = get_parent().cells

export var bg_color : Color = Color.white

func _draw():
	var cell_size = size / cells
	
	var top_left : Vector2 = Vector2(0, 0)
	var bottom_right : Vector2 = Vector2(cells.y, cells.x) * cell_size
	
	# Draw BG
	draw_rect(Rect2(top_left, bottom_right), bg_color)
