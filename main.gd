extends Node2D

@export var common_maptiles: Array[PackedScene]
@export var uncommon_maptiles: Array[PackedScene]

const TILE_WIDTH = 27 * 8
const TILE_HEIGHT = 17 * 8
const MAP_WIDTH = 5
const MAP_HEIGHT = 7

const UNCOMMON_CHANCE = 0.1


func _make_tile() -> Node2D:
	if randf() < UNCOMMON_CHANCE:
		return self.uncommon_maptiles[randi() % uncommon_maptiles.size()].instantiate()
	else:
		return self.common_maptiles[randi() % common_maptiles.size()].instantiate()

func _ready():
	seed(12345)
	for x in range(-MAP_WIDTH, MAP_WIDTH + 1):
		for y in range(-MAP_HEIGHT, MAP_HEIGHT + 1):
			if x == 0 and y == 0:
				continue
			var tile = _make_tile()
			tile.position.x = x*TILE_WIDTH
			tile.position.y = y*TILE_HEIGHT
			self.add_child(tile)
