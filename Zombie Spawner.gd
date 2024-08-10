extends Node2D


@export var enabled: bool = true
@export var wait_time_sec: float = 3.0
@export var zombie: PackedScene

var timer = Timer.new()

func _ready():
	if not self.enabled:
		return
	self.add_child(timer)
	timer.timeout.connect(self.spawn_zombie)
	timer.start(wait_time_sec)

func spawn_zombie():
	var z = zombie.instantiate()
	z.position = self.position + $SpawnLocation.position
	var world: Node2D = get_node("/root/Node2D")
	world.add_child(z)