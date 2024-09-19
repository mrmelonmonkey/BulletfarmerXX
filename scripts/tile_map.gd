extends Node2D

@export var camera : Camera2D

@onready var true_grid: TileMapLayer = $TerrainLayer/trueGrid
@onready var terrain_layer : Array = [$TerrainLayer]
@onready var sprite : Sprite2D = $TerrainLayer/trueGrid/Sprite2D
#my_cells will hold a string for every cell encoding wich neighbour of the Visual contains which terrain
#for Example: my_cells[0] = "0010" going clockwise starting in the upper left corner 
var my_cells = {} 
var tile_dictionary = {	4:Vector2i(28,12), 3:Vector2i(29,12), 13:Vector2i(30,12), 5:Vector2i(31,12),
						9:Vector2i(28,13), 7:Vector2i(29,13), 15:Vector2i(30,13), 14:Vector2i(31,13),
						2:Vector2i(28,14), 10:Vector2i(29,14), 11:Vector2i(30,14), 12:Vector2i(31,14),
						0:Vector2i(28,15), 1:Vector2i(29,15), 6:Vector2i(30,15), 8:Vector2i(31,15),}
var hovered_over : Vector2i
var mouse_coords : Vector2

func _ready() -> void:
	load_true_grid_cells()
	assign_tiles_to_terrainlayer()

func _process(_delta):
	mouse_coords = camera.get_global_mouse_position()
	hovered_over = true_grid.local_to_map(mouse_coords - true_grid.global_position)
	hovered_over = true_grid.map_to_local(hovered_over)
	sprite.position = hovered_over

func _on_cell_updated(cell:Vector2i):
	print("cell: " + str(cell) + " has been clicked!")
	pass

func update_neighbors(cell:Vector2i):
	pass

func load_true_grid_cells():
	var true_grid_cells = true_grid.get_used_cells()
	if not true_grid_cells:
		print("ERROR: no used Cells in true_grid")
		return
	for cell in true_grid_cells:
		#to prevent the no_terrain index (-1) from indexing the back of the array
		var terrain = true_grid.get_cell_tile_data(cell).terrain + 1
		var i = 0
		for x in 2:
			for y in 2:
				var neighbor_key = [[]]
				if my_cells.has(cell+Vector2i(x,y)):
					neighbor_key = my_cells.get(cell+Vector2i(x,y))
				neighbor_key[terrain+1][i] = 0 if terrain == -1 else 1
				my_cells.get_or_add(cell,neighbor_key)

func assign_tiles_to_terrainlayer():
	for i in terrain_layer.size():
		var layer :TileMapLayer = terrain_layer[i]
		var terrain_name = layer.tile_set.t
		var terrain = layer.terrain
		for cell in my_cells.keys():
			var neighbor_key = my_cells.get(cell)
			var specific_neighbor_key = bytes_to_var(PackedByteArray(neighbor_key[terrain]))
		
		

	
	var keys = my_cells.keys()
	for cell in keys:
		var neighbor_key = my_cells.get(cell)
		var tile_dict_has_neighbor_key = tile_dictionary.has(neighbor_key)
		if !tile_dict_has_neighbor_key:
			generate_new_neighbor_key(cell)
			neighbor_key = my_cells.get(cell)
		terrain_layer.set_cell(cell,6,tile_dictionary.get(neighbor_key))
		
func generate_new_neighbor_key(cell):
	var neighbors : String
	for x in 2:
		for y in 2:
			if true_grid.get_cell_tile_data(cell+Vector2i(x-1,y-1)):
				neighbors = neighbors + "+" + str(true_grid.get_cell_tile_data(cell+Vector2i(x-1,y-1)).terrain)
			else:
				neighbors = neighbors + str(-1)
	my_cells.erase(cell)
	my_cells.get_or_add(cell,neighbors)
	print("...")
	
