extends Node2D

@export var camera: Camera2D
@export var time_between_spawns: float = 3.0
@export var enemy: PackedScene


var timer = Timer.new()


func _do_spawn():
	var spawn_angle = randf_range(0, 2*PI)
	# a = spawn_angle
	# adjacent = camera.width/2
	# hypotenuse = ?
	# cos(a) = adjacent / h
	# hypotenuse = (camera.width/2) / cos(a)
	var camera_size = camera.get_viewport_rect().size/camera.zoom
	var dist_to_left_right = (camera_size.x/2) / abs(cos(spawn_angle))
	var dist_to_top_bottom = (camera_size.y/2) / abs(sin(spawn_angle))

	# Add 16 to ensure it's offscreen
	var distance_to_spawn = (min(dist_to_left_right, dist_to_top_bottom) + 16)

	var offset = Vector2.from_angle(spawn_angle) * distance_to_spawn
	var e: Node2D = enemy.instantiate()
	e.position	= camera.get_screen_center_position() + offset
	get_node("/root/Node2D").add_child(e)
	

func _ready():
	self.add_child(timer)
	timer.timeout.connect(_do_spawn)
	timer.start(time_between_spawns)

