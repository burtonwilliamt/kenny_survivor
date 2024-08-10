extends CharacterBody2D


@export var speed: float = 10000.0
@export var dagger: PackedScene

const dagger_speed_sec: float = 1.0
var dagger_timer = Timer.new()
var direction_facing = Vector2.RIGHT

func _ready():
	dagger_timer.timeout.connect(self.spawn_dagger)
	self.add_child(dagger_timer)
	dagger_timer.start(dagger_speed_sec)

func spawn_dagger():
	var d = self.dagger.instantiate()
	d.position = self.position
	d.direction = self.direction_facing
	d.rotation = self.direction_facing.angle()
	self.get_parent().add_child(d)

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = direction*speed*delta
	if velocity.length() > 0.0:
		direction_facing = direction

	move_and_slide()
