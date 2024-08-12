class_name Player extends CharacterBody2D


@export var speed: float = 10000.0
@export var dagger: PackedScene
@export var torch: PackedScene

var dagger_cooldown: float = 1.0
var dagger_timer = Timer.new()

const torch_cooldown: float = 5.0
var torch_timer = Timer.new()

func _ready():
	self.add_child(dagger_timer)
	dagger_timer.one_shot = true
	self.add_child(torch_timer)
	torch_timer.one_shot = true

func spawn_dagger():
	var d = self.dagger.instantiate()
	d.direction = (get_global_mouse_position() - self.global_position).normalized()
	d.position = self.position + 10*d.direction
	d.rotation = d.direction.angle()
	self.add_sibling(d)

func spawn_torch():
	var d = self.torch.instantiate()
	d.position = self.position
	self.add_sibling(d)

func _process(_delta):
	if not dagger_timer.is_stopped():
		var bar: ProgressBar = get_node("/root/Node2D/Hud/Weapon")
		bar.value = bar.max_value * (dagger_timer.time_left/dagger_cooldown)
	elif Input.is_action_just_pressed("shoot"):
		self.spawn_dagger()
		self.dagger_timer.start(dagger_cooldown)

	if not torch_timer.is_stopped():
		var bar: ProgressBar = get_node("/root/Node2D/Hud/Torch")
		bar.value = bar.max_value * (torch_timer.time_left/torch_cooldown)
	elif Input.is_action_just_pressed("torch"):
		self.spawn_torch()
		self.torch_timer.start(torch_cooldown)
		

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = direction*speed*delta
	move_and_slide()
