extends Node

export var minimum_readable_font_size = 16

export var title : String = 'None'
export var author : String = 'None'
export var width : int = 10
export var height : int = 10
export var puzzle = Array()
export var default_font_size : int = 16

onready var horizontal_hints_container = $"%HorizontalHints"
onready var vertical_hints_container = $"%VerticalHints"
onready var hint_margins = $"%HintMargins"
onready var board = $"%Board"
onready var hint_node = preload('res://picross/hint_label.tscn')


func _ready() -> void:
	parse_puzzle_file('res://boards/heart.gdpcross')
	build_border_hints()
	build_board()


func parse_puzzle_file(path: String) -> void:
	var file : File = File.new()
	file.open(path, File.READ)
	title = file.get_line()
	author = file.get_line()
	width = file.get_8()
	height = file.get_8()
	
	# Initialize puzzle array
	for x in range(width):
		puzzle.append(Array())
	
	var current_byte = file.get_8()
	var byte_ix = 0
	for x in range(width):
		for y in range(height):
			var value : int = (current_byte << byte_ix) & 0b10000000
			puzzle[x].append(value)
			byte_ix += 1
			
			if byte_ix >= 8:
				byte_ix = 0
				current_byte = file.get_8()


func build_border_hints() -> void:
	# Horizontal hints
	for y in range(height):
		var row_puzzle : Array = puzzle[y]
		var hint_node = create_hint_node(calculate_hint(row_puzzle, ' '), 'Row' + str(y))
		horizontal_hints_container.add_child(hint_node)
	
	# Vertical hints
	for x in range(width):
		var column_puzzle : Array = Array()
		for y in range(height):
			column_puzzle.append(puzzle[y][x])
		
		var hint_node = create_hint_node(calculate_hint(column_puzzle, '\n'), 'Column' + str(x))
		print(calculate_hint(column_puzzle, '\n'))
		vertical_hints_container.add_child(hint_node)
	
	set_font_size()
 

func set_font_size():
	var label := horizontal_hints_container.get_child(0) as RichTextLabel
	#label.theme.default_font.set('size', board.size.y / height) # Alters all resources using this theme (all hints)
	label.theme.default_font.set('size', minimum_readable_font_size)
	hint_margins.rect_min_size = Vector2(6, 6) * minimum_readable_font_size


func create_hint_node(text, _name):
	var new_hint : RichTextLabel = hint_node.instance() as RichTextLabel
	new_hint.name = 'Hint' + _name
	new_hint.bbcode_text = text
	
	return new_hint


func calculate_hint(elements : Array, delimiter : String) -> String:
	var hint : PoolStringArray = PoolStringArray()
	var current_block_size : int = 0
	
	for x in elements:
		if x != 0:
			current_block_size += 1
		else:
			if current_block_size > 0:
				hint.append(str(current_block_size))
				current_block_size = 0
	if current_block_size > 0:
		hint.append(str(current_block_size))
	
	if len(hint) == 0:
		return '0'
	return hint.join(delimiter)


func build_board() -> void:
	board.cells = Vector2(width, height)
	board.build_board()
