extends Node2D


var current_level = 0
var meat_collected: Array[Meat] = []
var fire: AnimatedSprite2D
var light: PointLight2D

const MEAT_MAGNETISM = 100.0
const MEAT_PER_LEVEL = 3


var levels = [
	["small", 1.5],
	["medium", 2.25],
	["large", 3.0],
	["very_large", 3.75],
	["huge", 5.0]
]

func set_level(i: int):
	current_level = i
	fire.play(levels[i][0])
	light.texture_scale = levels[i][1]

func increment_level():
	current_level = (current_level + 1) % levels.size()
	set_level(current_level)
	$CPUParticles2D.restart()

func _ready():
	fire = $Fire
	light = $PointLight2D
	set_level(0)
	$Area2D.body_entered.connect(self.body_entered)

func consume_meat():
	if current_level >= levels.size() - 1:
		return
	if meat_collected.size() < MEAT_PER_LEVEL:
		return
	for i in range(MEAT_PER_LEVEL):
		meat_collected.pop_back().queue_free()
	self.increment_level()

func body_entered(b: Node2D):
	if b is Meat:
		if not (b in meat_collected):
			meat_collected.append(b)
	if b is Player and current_level == levels.size() - 1:
		self.set_level(0)
		b.dagger_cooldown *= 0.75

		
func _process(_delta):
	if meat_collected.size() >= MEAT_PER_LEVEL:
		self.consume_meat()

func _physics_process(_delta):
	var meat_collection: Node2D = get_node("/root/Node2D/Meat")
	for m: RigidBody2D in meat_collection.get_children():
		var dir =(fire.global_position - m.global_position).normalized()
		m.apply_force(dir * MEAT_MAGNETISM)
