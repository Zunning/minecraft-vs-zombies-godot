extends Node

const ROWS = 5
const COLS = 9  # 根据关卡可以变

var grid = {}  # 用 Vector2i 作 key：grid[Vector2i(row, col)]

func _ready():
	_init_grid()

func _init_grid():
	for row in range(ROWS):
		for col in range(COLS):
			grid[Vector2i(row, col)] = {
		  "row": row,
		  "col": col,
		  "terrain": "grass",       # 地形类型
		  "device": null,            # 当前放置的器械节点（或null）
		  "is_occupied": false,      # 是否被占用
		  "is_placeable": true       # 是否可放置
		}

func get_cell(row: int, col: int) -> Dictionary:
	if row >=0 and col >= 0 and row < ROWS and col < COLS:
		return grid[Vector2i(row, col)]
	else:
		return {}

func is_occupied(row: int, col: int) -> bool:
	var cell = get_cell(row, col)
	if cell.is_empty():
		return false
	return cell["device"] != null

func place_device(row: int, col: int, device: Node) -> bool:
	if not is_occupied(row, col):
		grid[Vector2i(row, col)]["device"] = device
		grid[Vector2i(row, col)]["is_occupied"] = true
		return true
	else:
		return false

func remove_device(row: int, col: int) -> bool:
	if is_occupied(row, col):
		grid[Vector2i(row, col)]["device"] = null
		grid[Vector2i(row, col)]["is_occupied"] = false
		return true
	else:
		return false
